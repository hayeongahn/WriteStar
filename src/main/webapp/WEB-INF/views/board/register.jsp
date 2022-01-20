<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>    
    
<%@ include file="../includes/header.jsp" %>    
			<style>
				.uploadResult {width: 100%; }						
		        .uploadResult ul li img {width: 100%; height: 100%; position:relative; border-radius: 20px;}
		        .cancle_btn {width: 30px; height: 30px; background-color: #000; border-radius: 50%;}
		
		        .bigPictureWrapper {position: absolute; display: none; justify-content: center; align-items: center;
		                             top:0%; width:100%; height:100%; background-color: gray; z-index: 100;}				
		        .bigPicture {position: relative; display:flex; justify-content: center; align-items: center;}
		        #new_star {display:none;}
		        #friend_request {display:none;}
			</style>
			
		    <script src="https://code.iconify.design/2/2.1.0/iconify.min.js"></script>
            
            
		        <div id="profile">
		            <ul id="user">
		                <li id="user_photo">
		                    
		                </li>
				        <li id="nickname">
							<input name="nickname" value='<c:out value="${login.nickname}"/>'readonly>
						</li>
						<li id="user_info">
							<input name="user_info" value='<c:out value="${login.user_info}"/>'readonly>
						</li>
						<li id="modi_icon">
							<span class="iconify" data-icon="entypo:pencil"></span>
						</li>
		                <li id="new_star">
		                    <button>새별쓰기</button>
		                </li>
		                <li id="friend_request">
		                    <button>친구 요청하기</button>
		                </li>
		            </ul>
		        </div>
		        <form role="form" action="/board/register" method="post">
		            
		            <div id="board">
		                <ul id="main">
		                    <li><h2>새 별 쓰기</h2></li>
		                    <li id="con_title">
		                        <input type="text" name="title" id="" placeholder="새로운 별 자리 제목을 입력하세요." >
		                    </li>
		                    <li id="email_hidden">
		                        <input type="text" name="email" id="" value='<c:out value="${login.email}"/>' readonly>
		                    </li>
		                    <li id="con_text">
		                        <textarea name="content" id="" cols="30" rows="8" placeholder="내 별 자리에 대한 내용을 입력해 주세요."></textarea>
		                    </li>
		                    <li id="address">
		                        <input type="text" name="address" id="" placeholder="별을 본 곳의 주소를 입력해 주세요.">
		                    </li>
		                    <li id="attach_title">별 사진 첨부하기  
		                    	<input type="file" id="file_btn" name='uploadFile' multiple>
		                    </li>
		                    <li id="attach">
		                        <div class='uploadResult'>
		                        	<ul>
		                        	</ul>
		                        </div>
		                    </li>
		                    <li id="share_title">공개설정</li>
		                    <li id="share">
		                        <input type="radio" name="post_type" id="" value="1" checked="checked"> 전체공개  
		                        <input type="radio" name="post_type" id="" value="2"> 친구공개  
		                        <input type="radio" name="post_type" id="" value="3"> 비공개 
		                    </li>
		                    <li id="board_btn">
		                        <button type="submit">새 별 쓰기</button>
				                <button type="reset">다시 쓰기</button>
		                    </li>
		                </ul>
		            </div>
		        </form>
		   
			<script>
            	 $(document).ready(function(){   
            		 
            		 $("#modi_icon").on("click", function(){
                     	self.location="/user/userUpdateView";
                     });
      
             		var formObj = $("form[role='form']");            		  
             	    $("button[type='submit']").on("click", function(e){            		    
             		    e.preventDefault();  //전송을 막는다  
             		    var str="";
             		    //첨부파일미리보기 데이터를 사용해서 form태그에 hidden태그를 추가한 후 전송
             		    $(".uploadResult ul li").each(function(i,obj){
             		    	var jobj=$(obj);
             	
             		    	str+="<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
             		    	str+="<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
             		    	str+="<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
             		    	str+="<input type='hidden' name='attachList["+i+"].fileType' value='"+jobj.data("type")+"'>";
             		    });
             		    formObj.append(str).submit();
             		   		    
             		  }); 
            		  
            		  var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$"); // 파일 정규표현식
            		  var maxSize = 5242880; //5MB
            		  
            		  function checkExtension(fileName, fileSize){            		    
            		    if(fileSize >= maxSize){
            		      alert("파일 사이즈 초과");
            		      return false;
            		    }
            		    
            		    if(regex.test(fileName)){
            		      alert("해당 종류의 파일은 업로드할 수 없습니다.");
            		      return false;
            		    }
            		    return true;
            		  }
            		  
            		  // 파일 업로드 
            		  $("input[type='file']").change(function(e){
            		    var formData = new FormData();            		    
            		    var inputFile = $("input[name='uploadFile']");            		    
            		    var files = inputFile[0].files;
            		    
            		    for(var i = 0; i < files.length; i++){
            		      if(!checkExtension(files[i].name, files[i].size) ){
            		        return false;
            		      }
            		      formData.append("uploadFile", files[i]);            		      
            		    }
            		    
            		    $.ajax({
            		      url: '/uploadAjaxAction',
            		      processData: false, 
            		      contentType: false,
            		      data: formData,
            		      type: 'POST',
            		      dataType:'json',
            		      success: function(result){ 
            		    	console.log(result);           		    	
            			    showUploadResult(result); 
            		      }
            		    });            		    
            		  });
            		  
            		  // 업로드 결과를 화면에 섬네일로 표시
            		  function showUploadResult(uploadResultArr){
            			    //업로드파일이 없으면 중지
            			    if(!uploadResultArr || uploadResultArr.length == 0){ 
            			    	return; 
            			    }            			    
            			    
            			    var uploadUL = $(".uploadResult ul");            			    
            			    var str ="";
            			    
            			    $(uploadResultArr).each(function(i, obj){            			    
            			        //이미지이면 썸네일을 보여준다.
            			        if(obj.image){
            			          var fileCallPath =  encodeURIComponent( obj.uploadPath+ "/"+obj.uuid +"_"+obj.fileName);
            			          str += "<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'><div>";
            			          str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' class='cancle_btn'>x</button>";
            			          str += "<img src='/display?fileName="+fileCallPath+"'>";
            			          str += "</div>";
            			          str +"</li>";
            			        }else{
            			          //파일이면 파일명과 attach.png를 보여준다
            			          var fileCallPath =  encodeURIComponent( obj.uploadPath+"/"+ obj.uuid +"_"+obj.fileName);            
            			          var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
            			              
            			          str += "<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'><div>";
            			          str += "<span> "+ obj.fileName+"</span>";
            			          str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' class='cancle_btn'>x</button>";
            			          str += "<img src='/resources/img/attach.png'></a>";
            			          str += "</div>";
            			          str +"</li>"; 
            			        } 
            			    });
            			    uploadUL.append(str);
            			  }
            		  
            			// 'x' 아이콘 클릭시 삭제 이벤트 처리
            		  $(".uploadResult").on("click", "button", function(e){             			      
            			    var targetFile = $(this).data("file");
            			    var type = $(this).data("type");
            			    
            			    var targetLi = $(this).closest("li");
            			    
            			    $.ajax({
            			      url: '/deleteFile',
            			      data: {fileName: targetFile, type:type},
            			      dataType:'text',
            			      type: 'POST',
            			        success: function(result){
            			           alert(result);            			           
            			           targetLi.remove();
            			         }
            			    });
            		});
            			
            		/* 프로필 사진 출력 ************************************************************************/
           		   (function(){	                            		   
           				var email = "${login.email}";	                            		   
           				$.getJSON("/user/getAttachList", {email: email}, function(arr){	                            		     
           				   var str = "";	                            		       
           				   $(arr).each(function(i, attach){	                            		       
           					 //image type
           					 if(attach.bno == null){
           					   var fileCallPath =  encodeURIComponent( attach.uploadPath+ "/"+attach.uuid +"_"+attach.fileName);
           					   str += "<img src='/display?fileName="+fileCallPath+"'>";
           					 }
           				   });
           				   if(str.length == 0) {
           					   str += "<img src='/resources/img/userPhoto.png'>";
           					   $("#user_photo").html(str);
           				   }else {
           					   $("#user_photo").html(str);
           				   }
           				 });
           			  })(); 
           			/* 프로필 사진 출력 */
            		
            	});
          
  </script>
			
        
 <%@include file="../includes/footer.jsp" %>