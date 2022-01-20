package com.writestar.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.writestar.domain.BoardAttachVO;
import com.writestar.domain.Criteria;
import com.writestar.domain.UserVO;
import com.writestar.domain.loginDTO;
import com.writestar.mapper.BoardAttachMapper;
import com.writestar.mapper.UserMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class UserServiceImpl implements UserService {
	
	@Setter(onMethod_=@Autowired) // UserMapper 주입
	private UserMapper mapper;

	@Setter(onMethod_=@Autowired)
	private BoardAttachMapper attachMapper;
	
	@Override 
	// 회원 가입 처리
	public void register(UserVO userVO) {
		mapper.register(userVO);
	}

	@Override
	// 아이디 중복 확인
	public int emailCheck(UserVO userVO) {
		int result = mapper.emailCheck(userVO);
		return result;
	}

	@Override
	// 닉네임 중복 확인
	public int nicknameCheck(UserVO userVO) {
		int result = mapper.nicknameCheck(userVO);
		return result;
	}

	@Override
	// 로그인 처리
	public UserVO login(loginDTO loginDTO) {
		return mapper.login(loginDTO);
	}

	// 회원 프로필 조회
	@Override
	public UserVO getUserInfo(Criteria cri) {
		return mapper.selectUserInfo(cri);
	}

	@Transactional
	@Override
	public void userUpdate(UserVO userVO) {
		mapper.userUpdate(userVO);
		log.info(userVO);
		if(userVO.getAttachList() == null || userVO.getAttachList().size() <= 0) {
			return;
		}
		// 첨부 파일 폴더에 추가 정보 입력
		userVO.getAttachList().forEach(attach -> {
			attach.setEmail(userVO.getEmail());		// 프로필 유저(email)
			log.info(attach);
			attachMapper.insert(attach);
		});
	}

	@Override
	public List<BoardAttachVO> getAttachList(String email) {
		return attachMapper.findByEmail(email);
	}

	@Override
	public void removeProfile(UserVO userVO) {
		attachMapper.deleteProfile(userVO.getEmail());
	}

	@Override
	public void pwUpdate(loginDTO loginDTO) {
		mapper.pwUpdate(loginDTO);
	}
}
