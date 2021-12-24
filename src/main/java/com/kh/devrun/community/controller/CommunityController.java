package com.kh.devrun.community.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.devrun.community.model.service.CommunityService;
import com.kh.devrun.community.model.vo.Community;
import com.kh.devrun.community.model.vo.CommunityEntity;

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
		// 전체 게시물 목록
		// Community의 인자들을 List 형식으로 받아와 list에 담는다.
		List<Community> list = communityService.selectColumnList();
		return "community/communityColumnList";
	}
	
	// 커뮤니티-칼럼-베스트인기글(좋아요순)
	@GetMapping("/columnBestList.do")
	public ModelAndView columnBestList() {
		
		List<Community> list = communityService.columnBestList();
		
		ModelAndView mav = new ModelAndView();
		//넘길 데이터가 많기 때문에 HashMap에 저장한 후에 ModelAndView로 값을 넣고 페이지를 지정
		Map<String, Object> map = new HashMap<>(); 
		// map에 list(게시글 목록)을 list라는 이름의 변수로 자료를 저장함.
		map.put("list", list);
		// ModelAndView에 map을 저장
		mav.addObject("map", map);
		// 자료를 넘길 뷰의 이름
		mav.setViewName("community/communityColumnList");
		// 게시판 페이지로 이동
		return mav;
		
	}
	
	
	
	// 칼럼 - 상세보기
	// @RequestParam("가져올 데이터의 이름")[데이터의 타입][가져온 데이터를 담을 변수]
	// 그리고 Model 객체를 이용해서, 뷰로 값을 넘겨준다.
	@GetMapping("/communityColumnDetail.do")
	public void communityColumnDetail(@RequestParam int communityNo, Model model) {
		log.debug("communityNo = {}", communityNo);
		
		// 업무로직
		
	}
	
	// 칼럼-글쓰기
	@GetMapping("/communityColumnForm.do")
	public void communityColumnForm(){}
	
	// 칼럼-글등록
	@PostMapping("/communityColumnEnroll.do")
	public String communityColumnEnroll(Community community, RedirectAttributes redirectAttributes) {
		log.debug("{}", "/communityColumnEnroll.do 요청!");
		log.debug("community = {}", community);
		// jmg 데이터를 잘라오기 위한 Index 선언
		int startIndex = 0;
		int endIndex = 0;
		String content = community.getContent();
		// "startindex는 "<img" 전 부터를 의미한다.
		startIndex = content.indexOf("<img");
		
		// 문자열은 -1이 나올 수 없다.
		if(startIndex != -1) {
			// endIndex는 ">" 전까지이다. \ : escaping
			endIndex = content.substring(startIndex).indexOf("\">");
			// ">"까지 포함해서 읽어와야 하므로 endIndex+2로 설정한다.
			log.debug("startIndex : {} ~ endIndex : {}", startIndex, endIndex+2);
			
			// thumbnail에 img 데이터를 담는다.
			String thumbnail = content.substring(startIndex, startIndex + endIndex+2);
			log.debug("thumbnail = {}", thumbnail);
			System.out.println(thumbnail);
			// community에 tumbnail을 보낸다.
			community.setThumbnail(thumbnail);
		}
		
	  try { 
		  int result = communityService.insertColumn(community); 
		  String msg = result > 0 ? "컬럼 등록 성공!" : "컬럼 등록 실패!";
		  redirectAttributes.addFlashAttribute("msg", msg); 
	  } 
	  catch (Exception e) {
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
	
	// 자유게시판-리스트
	@GetMapping("/communityFreeboardList.do")
	public String communityFreeboardList(Model model) {
		List<CommunityEntity> list = communityService.selectFreeboardList();
		log.debug("communityFreeboardList = {}, list");
		model.addAttribute("list", list);
		return "community/communityFreeboardList";
	}
	
	// 자유게시판-글쓰기
	@GetMapping("/communityFreeboardForm.do")
	public void communityFreeboardForm() {}
	
	// 자유게시판-글등록
	@PostMapping("/communityFreeboardEnroll.do")
	public String communityFreeboardEnroll(Community community, RedirectAttributes redirectAttributes) {
		log.debug("{}", "/communityFreeboardEnroll.do 요청!");
		log.debug("community = {}", community);
		// jmg 데이터를 잘라오기 위한 Index 선언
		int startIndex = 0;
		int endIndex = 0;
		String content = community.getContent();
		// "startindex는 "<img" 전 부터를 의미한다.
		startIndex = content.indexOf("<img");
		
		// 문자열은 -1이 나올 수 없다.
		if(startIndex != -1) {
			// endIndex는 ">" 전까지이다. \ : escaping
			endIndex = content.substring(startIndex).indexOf("\">");
			// ">"까지 포함해서 읽어와야 하므로 endIndex+2로 설정한다.
			log.debug("startIndex : {} ~ endIndex : {}", startIndex, endIndex+2);
			
			// thumbnail에 img 데이터를 담는다.
			String thumbnail = content.substring(startIndex, startIndex + endIndex+2);
			log.debug("thumbnail = {}", thumbnail);
			System.out.println(thumbnail);
			// community에 tumbnail을 보낸다.
			community.setThumbnail(thumbnail);
		}
		
		  try { 
			  int result = communityService.insertFreeboard(community); 
			  String msg = result > 0 ? "게시글 등록 성공!" : "게시글 등록 실패!";
			  redirectAttributes.addFlashAttribute("msg", msg); 
		  } 
		  catch (Exception e) {
			  log.error("게시글 등록 오류", e); 
		  throw e; 
		  } 
		  return "redirect:/community/communityFreeboardList.do";
	}
	
	
	
}
