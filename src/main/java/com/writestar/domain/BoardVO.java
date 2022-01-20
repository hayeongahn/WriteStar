package com.writestar.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class BoardVO {
	private Long bno;
	private String title;
	private String content;
	private Date regdate;
	private String address;
	private String post_type;
	private String email;
	private Long hits;
	
	private UserVO userVO;
	private List<BoardAttachVO> attachList;
	private BoardAttachVO thumbnail; 
}
