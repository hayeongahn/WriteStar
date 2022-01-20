package com.writestar.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.writestar.domain.UserVO;
import com.writestar.domain.loginDTO;
import com.writestar.service.UserService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller // 컨트롤러역할
@Log4j
@RequestMapping("/user/*")
@AllArgsConstructor // 자동주입
public class UserLoginController {
	private UserService userService;
	
	// 로그인 화면
	@GetMapping("/login")
	public String loginGET(loginDTO loginDTO) {
		return "/user/login";
	}
		
	// 로그인 처리
	@PostMapping("/loginPost")
	public void loginPOST(loginDTO loginDTO, HttpSession httpSession, Model model) {
		// 화면으로부터 받은 데이터(회원아이디, 비밀번호)중 아이디를 통해 select한 회원정보를 userVO에 담는다.
		UserVO userVO = userService.login(loginDTO);
		log.info(userVO);
		// userVO가 null이거나 비밀번호가 맞지 않으면 메서드를 종료
		// BCrypt.checkpw()를 통해 검증 진행 
		if (userVO == null || !BCrypt.checkpw(loginDTO.getPassword(), userVO.getPassword())) {
			return;
		}
		// 비밀번호가 일치하면 model에 userVO를 user란 이름의 변수에 저장한다.
		model.addAttribute("user", userVO);
	}
	
	//로그아웃 페이지 테스트
	@GetMapping("/logout_test")
	public void logout_test() {}
	
	
	// 로그아웃 처리
	@GetMapping("/logout")
	public String logout(HttpServletRequest request, HttpServletResponse response, HttpSession httpSession) {
		Object object = httpSession.getAttribute("login");
		if (object != null) {
			UserVO userVO = (UserVO) object;
			httpSession.removeAttribute("login");
			httpSession.invalidate();
		}
		return "/user/logout";
	}
}
