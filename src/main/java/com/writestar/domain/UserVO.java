package com.writestar.domain;

import java.util.List;

import lombok.Data;

@Data
public class UserVO {
	private String email;
	private String password;
	private String nickname;
	private String user_info;
	
	private List<BoardAttachVO> attachList;
}
