package com.writestar.mapper;

import com.writestar.domain.Criteria;
import com.writestar.domain.UserVO;
import com.writestar.domain.loginDTO;

public interface UserMapper {
	// 로그인
	public UserVO login(loginDTO loginDTO);
	// 회원 가입 처리
	public void register(UserVO userVO);
	// 아이디 중복 확인
	public int emailCheck(UserVO userVO);
	// 닉네임 중복 확인
	public int nicknameCheck(UserVO userVO);	
	// 회원 프로필 조회
	public UserVO selectUserInfo(Criteria cri);
	//비밀번호 변경
	public void pwUpdate(loginDTO loginDTO);
	//회원 정보 변경
	public void userUpdate(UserVO userVO);
}
