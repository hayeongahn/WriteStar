package com.writestar.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.writestar.domain.AttachFileDTO;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@Log4j
public class UploadController {
	@GetMapping("/uploadForm")
	public void uploadForm() {}
	
	@PostMapping("/uploadFormAction")
	public void uploadFormPost(MultipartFile[] uploadFile, Model model) {
		String uploadFolder="c:\\upload";
		for(MultipartFile multipartFile:uploadFile) {
			File saveFile=new File(uploadFolder, multipartFile.getOriginalFilename());
			try {
				multipartFile.transferTo(saveFile);
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	@GetMapping("/uploadAjax")
	public void uploadAjax() {}
	
	//@PreAuthorize("isAuthenticated()")
	@PostMapping(value="/uploadAjaxAction",produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<AttachFileDTO>> uploadAjaxPost(MultipartFile[] uploadFile, Model model) {
		//업로드된 파일 정보 AttachFileDTO를 저장할 list
		List<AttachFileDTO> list=new ArrayList<>();		
		
		String uploadFolder="c:\\upload";
		
		//오늘날짜와 같은 디렉토리 만들기
		String uploadFolderPath=getFolder();
		File uploadPath=new File(uploadFolder,uploadFolderPath);
		if(uploadPath.exists()==false) {
			uploadPath.mkdirs(); // c:\\upload\\2021\\11\\26 디렉토리 생성
		}		
		
		for(MultipartFile multipartFile:uploadFile) {
			//업로드된 파일정보를 저장할 attachDTO생성
			AttachFileDTO attachDTO=new AttachFileDTO();			
			
			String uploadFileName=multipartFile.getOriginalFilename();
			//ie에서는 path와 filename이 같이 구해지므로 path를 제외하고 파일명만 구한다
			uploadFileName=uploadFileName.substring(uploadFileName.lastIndexOf("\\")+1);
			//attachDTO에 파일명 저장
			attachDTO.setFileName(uploadFileName);
						
			//파일명에 uuid를 붙인다
			UUID uuid=UUID.randomUUID();
			uploadFileName=uuid.toString()+"_"+uploadFileName;			
				
			try {
				File saveFile=new File(uploadPath, uploadFileName);
				multipartFile.transferTo(saveFile);
				
				//attachDTO에 uuid, uploadPath저장
				attachDTO.setUuid(uuid.toString());
				attachDTO.setUploadPath(uploadFolderPath);				
				
				//첨부파일이 이미지이면 썸네일 생성. 파일명이 's_'로 시작됨.
				if(checkImageType(saveFile)) {					
					//attachDTO에 image값을 true로 저장
					attachDTO.setImage(true);
					
					FileOutputStream thumbnail=new FileOutputStream(new File(uploadPath,"s_"+uploadFileName));
					Thumbnailator.createThumbnail(multipartFile.getInputStream(),thumbnail,100,100);
					thumbnail.close();
				}
				list.add(attachDTO);
			}catch(Exception e) {
				e.printStackTrace();
			}		
		}
		//브라우저로 전송
		log.info(list);
		return new ResponseEntity<>(list,HttpStatus.OK);
	}
	
	//썸네일이미지를 읽어서 클라이언트로 보냄
	@GetMapping("/display")
	@ResponseBody
	public ResponseEntity<byte[]> getFile(String fileName) {
		File file = new File("c:\\upload\\" + fileName);

		ResponseEntity<byte[]> result = null;
		try {
			HttpHeaders header = new HttpHeaders();
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			//이미지데이터를 byte배열로 변환해서 전달
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
		} catch (IOException e) {			
			e.printStackTrace();
		}
		return result;
	}
	
	//현재날짜와 같은 이름의 디렉토리 생성을 위해서 path구하기
	private String getFolder() {
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		Date date=new Date();
		String str=sdf.format(date);
		return str.replace("-", File.separator); // 2021\\11\\26 형식으로 변환
	}
	
	//업로드파일의 이미지 여부 확인하기
	private boolean checkImageType(File file) {
		try {
			String contentType=Files.probeContentType(file.toPath());
			log.info(contentType);
			return contentType.startsWith("image");
		}catch(Exception e){
			e.printStackTrace();
		}
		return false;
	}
	
	@GetMapping(value="/download",produces=MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody
	public ResponseEntity<Resource> downloadFile(@RequestHeader("User-Agent") String userAgent,String fileName){
		log.info("User-Agent : "+userAgent);
		Resource resource=new FileSystemResource("c:\\upload\\"+fileName);
		if(resource.exists()==false) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);//파일이 없으면 not found
		}
		String resourceName=resource.getFilename();
		//UUID제거
		String resourceOriginalName=resourceName.substring(resourceName.indexOf("_")+1); // "_"다음부터 끝까지 가져오기.
		HttpHeaders headers=new HttpHeaders();
		try {
			String downloadName=null;
			if(userAgent.contains("Trident")) {
				downloadName=URLEncoder.encode(resourceOriginalName,"UTF-8").replaceAll("\\+", " "); //IE
			}else {
				downloadName=new String(resourceOriginalName.getBytes("UTF-8"),"ISO-8859-1"); //기타.chrome등등
			}
			headers.add("Content-Disposition", "attachment; fileName=" + downloadName);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return new ResponseEntity<Resource>(resource,headers,HttpStatus.OK);
	};
	
	//@PreAuthorize("isAuthenticated()")
	@PostMapping("/deleteFile")
	@ResponseBody
	public ResponseEntity<String> deleteFile(String fileName,String type){
		File file;
		try {
			file=new File("c:\\upload\\"+URLDecoder.decode(fileName,"UTF-8"));
			file.delete();
			if(type.equals("image")) {
				String largeFileName=file.getAbsolutePath().replace("s_", "");
				file=new File(largeFileName);
				file.delete();
			}
		}catch(Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		return new ResponseEntity<String>("deleted", HttpStatus.OK);
	}
}
