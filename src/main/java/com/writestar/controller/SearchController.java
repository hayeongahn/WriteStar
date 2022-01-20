package com.writestar.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.writestar.domain.Criteria;
import com.writestar.service.SearchService;

import lombok.AllArgsConstructor;

@Controller
@RequestMapping("/search/*")
@AllArgsConstructor
public class SearchController {
	private SearchService service;
	
	//검색
	@GetMapping("/searchResult")
	public void searchList(@RequestParam("keyword") String keyword, Criteria cri, Model model) {
		System.out.println(">>>>>>>>>>>>>>>> Search Controller >>>>>>>>>>>>>>>>");
		System.out.println(keyword);
		
		model.addAttribute("searchList", service.searchList(keyword));
	}
}
