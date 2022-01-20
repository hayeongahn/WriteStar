package com.writestar.domain;

import lombok.Data;

@Data
public class loginDTO {			//로그인 화면으로부터 전달되는 회원의 데이터
	private String email;		//로그인 화면으로부터 전달되는 이메일
	private String password;	//로그인 화면으로부터 전달되는 비밀번호
	//private boolean useCookie;
}
