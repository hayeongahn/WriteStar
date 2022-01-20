package com.writestar.service;

import java.util.List;

import com.writestar.domain.BoardAttachVO;
import com.writestar.domain.Criteria;
import com.writestar.domain.UserVO;
import com.writestar.domain.loginDTO;

public interface UserService {
	// 회원 가입 처리
	public void register(UserVO userVO);
	// 아이디 중복 확인
	public int emailCheck(UserVO userVO);
	// 닉네임 중복 확인
	public int nicknameCheck(UserVO userVO);
	// 로그인 처리
	public UserVO login(loginDTO loginDTO);
	// 회원 프로필 조회
	public UserVO getUserInfo(Criteria cri);
	//회원 정보 변경
	public void userUpdate(UserVO userVO);
	//프로필 사진 호출
	public List<BoardAttachVO> getAttachList(String email);
	//프로필 사진 삭제
	public void removeProfile(UserVO userVO);
	//비밀번호 변경
	public void pwUpdate(loginDTO loginDTO);	
}
