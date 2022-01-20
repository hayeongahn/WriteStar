package com.writestar.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ReplyVO {
	private long rno;
	private long bno;
	private String content;
	private Date replyDate;
	private String email;
	
	private UserVO userVO;
}
