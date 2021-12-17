package com.kh.devrun.community.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.devrun.community.model.service.CommunityService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/community")
public class CommunityController {

	@Autowired
	private CommunityService communityService;
	
	// 커뮤니티 메인
	@GetMapping("/communityMain.do")
	public String communityMain() {
		
		return "community/communityMain";
	}	
	
	// 커뮤니티-칼럼
	@GetMapping("communityColumn.do")
	public String communityColumn() {
		
		return "community/communityColumn";
	}
	
	// 커뮤니티-Q&A
	@GetMapping("/communityQnA.do")
	public String communityQnA() {
		
		return "community/communityQnA";
	}
	
	// 커뮤니티-스터디
	@GetMapping("/communityStudy.do")
	public String communityStudy() {
		
		return "community/communityStudy";
	}
	
	// 커뮤니티-자유게시판
	@GetMapping("/communityBoard.do")
	public String communityBoard() {
		
		return "community/communityBoard";
	}
	
	
}
