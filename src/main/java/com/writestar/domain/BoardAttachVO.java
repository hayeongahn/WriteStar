package com.writestar.domain;

import lombok.Data;

@Data
public class BoardAttachVO {
	private String uuid;
	private boolean fileType;
	private String uploadPath;
	private String fileName;
	
	private Long bno;
	private String email; 
}
