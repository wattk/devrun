package com.kh.devrun.community.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.UUID;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.devrun.community.model.service.CommunityService;
import com.kh.devrun.community.model.vo.Community;

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
	@GetMapping("/communityColumnList.do")
	public String communityColumnList() {
		
		return "community/communityColumnList";
	}
	
	// 커뮤니티-칼럼-글쓰기
	@GetMapping("/communityColumnForm.do")
	public void communityColumnForm(){}
	
	@PostMapping("/communityColumnEnroll.do")
	public String communityColumnEnroll(Community community, RedirectAttributes redirectAttributes) {
		try {
			int result = communityService.insertColumn(community);
			String msg = result > 0 ? "컬럼 등록 성공!" : "컬럼 등록 실패!";
			redirectAttributes.addFlashAttribute("msg", msg);
		} catch (Exception e) {
			log.error("컬럼 등록 오류", e);
			throw e;
		}
		return "redirect:/community/communityColumnList.do";
	}
	
	// 커뮤니티 - Q&A
	@GetMapping("/communityQnAList.do")
	public String communityQnAList() {
		
		return "community/communityQnAList";
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
