package com.kh.devrun.community.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.devrun.community.common.CommunityUtils;
import com.kh.devrun.community.model.service.CommunityService;
import com.kh.devrun.community.model.vo.Community;
import com.kh.devrun.community.model.vo.CommunityComment;
import com.kh.devrun.community.model.vo.CommunityCommentEntity;
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
	// @RequestParam int cPage : 현재 페이지 변수를 하나 받아온다.
	// communityFreeboardList의 인자값으로 @RequestParam() 어노테이션을 넣어서 값을 받아온다.
	// @RequestParam("가져올 데이터의 이름")[데이터 타입][가져온 데이터를 담을 변수]
	/**
	 * @RequestParam은 필수인자(기본속성 : required = true) 이므로 cPage가 없으면 바로 오류가 난다.
	 * 따라서 기본값을 정해준다. --> (defaultValue = "1")
	 * cPage가 없다면 알아서 문자열을 정수형으로 반환해서 넘겨준다. 
	 */
	@GetMapping("/communityFreeboardList.do")
	public String communityFreeboardList(@RequestParam(defaultValue = "1") int cPage, Model model, HttpServletRequest request) {
		log.debug("cPage = {}", cPage);
		
		int limit = 10; // 한 페이지당 10으로 고정
		int offset = (cPage - 1) * limit;
		
		// 1. 전체 게시물 목록(nickname 추가)
		List<CommunityEntity> list = communityService.selectFreeboardList(offset, limit);
		log.debug("selectFreeboardList = {}, list");
		// jsp에 전달할 수 있도록 model에 담아준다.
		model.addAttribute("list", list);
		
		// 2. 전체 게시물 수 totalContent
		int totalContent = communityService.selectFreeboardTotalCount();
		log.debug("selectFreeboardTotalCount = {}, list");
		model.addAttribute("totalContent", totalContent);
		
		// 3. pagebar
		String url = request.getRequestURI(); // /devrun/community/communityFreeboardList.do
		String pagebar = CommunityUtils.getPagebar(cPage, limit, totalContent, url);
		log.debug("pagebar = {}", pagebar);
		model.addAttribute("pagebar", pagebar);
		
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
	
	// 자유게시판-상세보기
	// @RequestParam("가져올 데이터의 이름")[데이터 타입][가져온 데이터를 담을 변수]
	// 그리고 Model 객체를 이용해서, 뷰로 값을 넘겨준다.
	@GetMapping("/communityFreeboardDetail.do")
	public void communityFreeboardDetail(@RequestParam int communityNo, Model model) {
		log.debug("communityNo = {}", communityNo);
		
		// 업무로직
		CommunityEntity communityEntity = communityService.selectOneFreeBoard(communityNo);
		log.debug("communityEntity = {}", communityEntity);
		model.addAttribute("communityEntity", communityEntity);
		
		// 댓글
		List<CommunityCommentEntity> freeboardCommentList = communityService.selectFreeboardCommentList(communityNo);
		log.debug("freeboardCommentList = {}", freeboardCommentList);
		model.addAttribute("freeboardCommentList", freeboardCommentList);
	}
	
	// 자유게시판-댓글작성
	@PostMapping("/communityFreeboardCommentEnroll.do")
	public String freeboardCommentEnroll(CommunityComment communityComment, RedirectAttributes redirectAttributes) {
		log.debug("{}", "/communityFreeboardCommentEnroll.do 요청!");
		log.debug("communityComment = {}", communityComment);
	
		
		// 업무로직
		int result = communityService.insertFreeboardCommentEnroll(communityComment); 
		String msg = result > 0 ? "댓글 등록 성공!" : "댓글 등록 실패!";
		redirectAttributes.addFlashAttribute("msg", msg); 
		
		return "redirect:/community/communityFreeboardDetail.do?communityNo=" + communityComment.getCommunityNo();
	}
	
	
	
}
