package com.writestar.controller;

import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.writestar.domain.FriendVO;
import com.writestar.service.FriendService;

import lombok.AllArgsConstructor;

@Controller
@RequestMapping("/friend/*")
@AllArgsConstructor
public class FriendController {
	private FriendService service;
	
	// 친구(신청) 목록 조회
	@GetMapping("/friendRequestPage")
	public void list(@RequestParam("to_user") String to_user, Model model) {
		// 친구요청 목록 조회
		model.addAttribute("list", service.selectRequestList(to_user));
		// 친구 목록 조회
		model.addAttribute("friendList", service.selectFriendList(to_user));
		
		model.addAttribute("to_user", to_user);
	}
	
	// 친구신청 응답	
	@ResponseBody
	@RequestMapping(value="/response", method=RequestMethod.POST)
	public String response(@RequestParam Map<String, Object> map, RedirectAttributes rttr) {
		String fromUser = (String) map.get("fromUser");
		String toUser = (String) map.get("toUser");
		String hdnYN = (String) map.get("hdnYN");
		
		System.out.println(">>>>>>>>> FriendController >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
		System.out.println(">>>>>>>>> map : " + map);
		System.out.println(">>>>>>>>> hdnYN : " + hdnYN);
		
		service.response(map);
		
		return "redirect:/friend/friendRequestPage";
	 }
	
	// 친구신청
	@PostMapping("/addFriend")
	public String addFriend(@RequestParam Map<String, Object> map, RedirectAttributes rttr) {
		String from_user = (String) map.get("from_user");
		String email = (String) map.get("email");
		
		System.out.println(">>>>>>>>> FriendController >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
		System.out.println(">>>>>>>>> from_user : " + from_user);
		System.out.println(">>>>>>>>> email : " + email);
		
		try {
			service.addFriend(map);
			rttr.addAttribute("email", email);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/board/list";
	}
	
	// 친구 삭제
	@PostMapping("/removeFriend")
	public String removeFriend(FriendVO friend, RedirectAttributes rttr) {
		System.out.println(">>>>>>>>> FriendController >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
		System.out.println(">>>>>>>>> friend : " + friend);
		
		service.removeFriend(friend);

		rttr.addFlashAttribute("result","success");
		
		return "/friend/friendRequestPage";
	}
}
