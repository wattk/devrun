package com.kh.devrun.community.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.devrun.common.DevrunUtils;
import com.kh.devrun.community.common.CommunityUtils;
import com.kh.devrun.community.model.service.CommunityService;
import com.kh.devrun.community.model.vo.Community;
import com.kh.devrun.community.model.vo.CommunityComment;
import com.kh.devrun.community.model.vo.CommunityCommentEntity;
import com.kh.devrun.community.model.vo.CommunityEntity;
import com.kh.devrun.member.model.vo.Member;
import com.kh.devrun.report.model.vo.Report;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/community")
public class CommunityController {

	@Autowired
	private CommunityService communityService;
	
	/* ---------------------------------------- 컬럼 리스트 시작 ---------------------------------------- */
	
	@GetMapping("/communityColumnList.do")
	public String communityColumnList(@RequestParam(defaultValue = "1") int cPage, Model model, HttpServletRequest request) {
		int limit = 10;
		int offset = (cPage - 1) * limit;
		// 전체 게시물 목록
		// Community의 인자들을 List 형식으로 받아와 list에 담는다.
		List<CommunityEntity> list = communityService.selectColumnList(offset, limit);
		List<CommunityEntity> bestList = communityService.columnBestList();
		
		model.addAttribute("list", list);
		model.addAttribute("bestList", bestList);
		
		// 2. 칼럼 전체 게시물 수
		int totalContent = communityService.selectColumnCount();
		model.addAttribute("totalContent", totalContent);
		
		// 3. pagebar
		String url = request.getRequestURI();
		String pagebar = CommunityUtils.getPagebar(cPage, limit, totalContent, url);
		log.debug("pagebar = {}", pagebar);
		model.addAttribute("pagebar", pagebar);
		return "community/communityColumnList";
	}
	
	/* ---------------------------------------- 컬럼 리스트 종료 ---------------------------------------- */
	
	/* ---------------------------------------- 컬럼 글쓰기 시작 ---------------------------------------- */
	
	@GetMapping("/communityColumnForm.do")
	public void communityColumnForm(){}
	
	/* ---------------------------------------- 컬럼 글쓰기 종료 ---------------------------------------- */
	
	/* ---------------------------------------- 컬럼 글쓰기 시작 ---------------------------------------- */
	
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
		  int result = communityService.insertCommunityWriteEnroll(community); 
		  String msg = result > 0 ? "컬럼 등록 성공!" : "컬럼 등록 실패!";
		  redirectAttributes.addFlashAttribute("msg", msg); 
	  } 
	  catch (Exception e) {
	  log.error("컬럼 등록 오류", e); 
	  throw e; 
	  } 
	  return "redirect:/community/communityColumnList.do";
		 
	}
	
	/* ---------------------------------------- 컬럼 글쓰기 종료 ---------------------------------------- */

	/* ---------------------------------------- Q&A 리스트 시작 ---------------------------------------- */
	
	// 커뮤니티 - Q&A
	@GetMapping("/communityQnAList.do")
	public String communityQnAList(@RequestParam(defaultValue = "1") int cPage, Model model, HttpServletRequest request) {
		
		int limit = 10;
		int offset = (cPage - 1) * limit;
		
		// 1. 전체 게시물 목록
		List<CommunityEntity> list = communityService.selectQnAList(offset, limit);
		log.debug("selectStudyList = {}", list);
		// jsp에 전달할 수 있도록 model에 담아준다.
		model.addAttribute("list", list);
		
		// 2. 스터디리스트 전체 게시물 수
		int totalContent = communityService.selectOneQnACount();
		log.debug("selectOneStudyCount = {}", totalContent);
		model.addAttribute("totalContent", totalContent);
		
		// 3. pagebar
		String url = request.getRequestURI(); // /devrun/community/communityStudyList.do
		String pagebar = CommunityUtils.getPagebar(cPage, limit, totalContent, url);
		log.debug("pagebar = {}", pagebar);
		model.addAttribute("pagebar", pagebar);
		
		return "community/communityQnAList";
	}
	
	/* ---------------------------------------- Q&A 리스트 종료 ---------------------------------------- */
	
	/* ---------------------------------------- 스터디 리스트 시작 ---------------------------------------- */
	
	@GetMapping("/communityStudyList.do")
	public String communityStudy(@RequestParam(defaultValue = "1") int cPage, Model model, HttpServletRequest request ) {
		
		int limit = 10;
		int offset = (cPage - 1) * limit;
		
		// 1. 전체 게시물 목록
		List<CommunityEntity> list = communityService.selectStudyList(offset, limit);
		log.debug("selectStudyList = {}", list);
		// jsp에 전달할 수 있도록 model에 담아준다.
		model.addAttribute("list", list);
		
		// 2. 스터디리스트 전체 게시물 수
		int totalContent = communityService.selectOneStudyCount();
		log.debug("selectOneStudyCount = {}", totalContent);
		model.addAttribute("totalContent", totalContent);
		
		// 3. pagebar
		String url = request.getRequestURI(); // /devrun/community/communityStudyList.do
		String pagebar = CommunityUtils.getPagebar(cPage, limit, totalContent, url);
		log.debug("pagebar = {}", pagebar);
		model.addAttribute("pagebar", pagebar);
		
		return "community/communityStudyList";
	}
	
	/* ---------------------------------------- 스터디 리스트 종료 ---------------------------------------- */

	/* ---------------------------------------- 자유게시판 리스트 시작 ---------------------------------------- */
	
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
		String pagebar = DevrunUtils.getPagebar(cPage, limit, totalContent, url);
		log.debug("pagebar = {}", pagebar);
		model.addAttribute("pagebar", pagebar);

		return "community/communityFreeboardList";
	}
	
	/* ---------------------------------------- 자유게시판 리스트 종료 ---------------------------------------- */
	
	/* ---------------------------------------- 타입별 검색 시작 ---------------------------------------- */
	
	// @ResponseBody : Http 요청 body를 Java 객체로 전달받을 수 있다.
	@GetMapping("/communityFinder.do")
	@ResponseBody
	public Map<String, Object> communityFinder(
			@RequestParam(defaultValue = "1") int cPage,
			@RequestParam String searchType,
			@RequestParam int pageCode,
			@RequestParam String searchKeyword,
			HttpServletRequest request){
		log.debug("{}", "타입별 검색 시작");
		
		Map<String, Object> resultMap = new HashMap<>();
		
		int limit = 10;
		int offset = (cPage - 1) * limit;
		
		log.debug("searchType = {}", searchType);
		log.debug("pageCode = {}", pageCode);
		log.debug("searchKeyword = {}", searchKeyword);
		
		Map<String, Object> param = new HashMap<>();
		param.put("searchType", searchType);
		param.put("pageCode", pageCode);
		param.put("searchKeyword", searchKeyword);
		log.debug("param = {}", param);
		
		// 1. 전체 상품 목록채
		String url = request.getContextPath();
		
		List<CommunityEntity> freeboardList = communityService.selectBoardListByType(param, offset, limit);
		String freeboardStr = CommunityUtils.getFreeboardList(freeboardList, url);
		log.debug("freeboard = {}", freeboardStr);
		
		// 2. 전체 게시물 수 totalCount
		url = request.getRequestURI();
		int totalContent = communityService.selectCommunityTotalCountByType(param);
		
		// 3. pagebar
		String pagebar = CommunityUtils.getPagebar2(cPage, limit, totalContent, url);
		log.debug("pagebar = {}", pagebar);
		
		resultMap.put("freeboardStr", freeboardStr);
		resultMap.put("totalContent", totalContent);
		resultMap.put("pagebar", pagebar);
		
		return resultMap;
	}
	
	/* ---------------------------------------- 타입별 검색 종료 ---------------------------------------- */
	
	/* ---------------------------------------- 좋아요순 리스트 시작 ---------------------------------------- */
	
	@GetMapping("/likeBoard.do")
	@ResponseBody
	public Map<String, Object> likeBoard(
			@RequestParam(defaultValue = "1") int cPage,
			@RequestParam int pageCode,
			HttpServletRequest request,
			Model model){
		
		Map<String, Object> resultMap = new HashMap<>();
		
		int limit = 10;
		int offset = (cPage - 1) * limit;
		
		log.debug("pageCode = {}", pageCode);
		
		Map<String, Object> param = new HashMap<>();
		param.put("pageCode", pageCode);
		log.debug("param = {}", param);
		
		String url = request.getContextPath();
		
		List<CommunityEntity> likeBoardList = communityService.selectLikeBoardList(param, offset, limit);
		log.debug("likeBoardList = {}", likeBoardList);
		String likeBoardStr = CommunityUtils.getlikeBoardList(likeBoardList, url);
		
		// 2. 자유게시판 총 게시물 수 
		int totalContent = communityService.selectCommentTotalCountByBoard(pageCode);
		log.debug("selectCommentTotalCountByBoard = {}", totalContent);
		model.addAttribute("totalContent", totalContent);
		
		// 3. pagebar
		String pagebar = CommunityUtils.getPagebar3(cPage, limit, totalContent, url);
		log.debug("pagebar = {}", pagebar);
		
		resultMap.put("likeBoardStr", likeBoardStr);
		resultMap.put("totalContent", totalContent);
		resultMap.put("pagebar", pagebar);
		
		return resultMap;
	}
	
	/* ---------------------------------------- 좋아요순 리스트 종료 ---------------------------------------- */
	
	/* ---------------------------------------- 최근답변순 리스트 시작 ---------------------------------------- */
	
	@GetMapping("/currentCommentBoard.do")
	@ResponseBody
	public Map<String, Object> currentCommentBoard(
			@RequestParam(defaultValue = "1") int cPage,
			@RequestParam int pageCode,
			HttpServletRequest request,
			Model model){
		
		Map<String, Object> resultMap = new HashMap<>();
		
		int limit = 10;
		int offset = (cPage - 1) * limit;
		
		log.debug("pageCode = {}", pageCode);
		
		Map<String, Object> param = new HashMap<>();
		param.put("pageCode", pageCode);
		log.debug("param = {}", param);
		
		String url = request.getContextPath();
		
		List<CommunityEntity> currentCommentBoardList = communityService.selectcurrentCommentBoardList(param, offset, limit);
		log.debug("likeBoardList = {}", currentCommentBoardList);
		String currentCommentBoardStr = CommunityUtils.getCurrentCommentBoardList(currentCommentBoardList, url);
		
		// 2. 자유게시판 총 게시물 수 
		int totalContent = communityService.selectCommentTotalCountByBoard(pageCode);
		log.debug("selectCommentTotalCountByBoard = {}", totalContent);
		model.addAttribute("totalContent", totalContent);
		
		// 3. pagebar
		String pagebar = CommunityUtils.getPagebar7(cPage, limit, totalContent, url);
		log.debug("pagebar = {}", pagebar);
		
		resultMap.put("likeBoardStr", currentCommentBoardStr);
		resultMap.put("totalContent", totalContent);
		resultMap.put("pagebar", pagebar);
		
		return resultMap;
	}
	
	/* ---------------------------------------- 최근답변순 리스트 종료 ---------------------------------------- */
	
	/* ---------------------------------------- 답변순 리스트 시작 ---------------------------------------- */
	
	@GetMapping("/commentBoard.do")
	@ResponseBody
	public Map<String, Object> commentBoard(
			@RequestParam(defaultValue = "1") int cPage,
			@RequestParam int pageCode,
			HttpServletRequest request,
			Model model){
		
		Map<String, Object> resultMap = new HashMap<>();
		
		int limit = 10;
		int offset = (cPage - 1) * limit;
		
		log.debug("pageCode = {}", pageCode);
		
		Map<String, Object> param = new HashMap<>();
		param.put("pageCode", pageCode);
		log.debug("param = {}", param);
		
		String url = request.getContextPath();
		
		List<CommunityEntity> commentBoardList = communityService.selectCommentBoardList(param, offset, limit);
		log.debug("commentBoardList = {}", commentBoardList);
		String commentBoardStr = CommunityUtils.getCommentBoardList(commentBoardList, url);
		log.debug("commentBoardListStr = {}", commentBoardList);
		
		// 2. 자유게시판 총 게시물 수 
		int totalContent = communityService.selectCommentTotalCountByBoard(pageCode);
		log.debug("selectCommentTotalCountByBoard = {}", totalContent);
		model.addAttribute("totalContent", totalContent);
		
		// 3. pagebar
		String pagebar = CommunityUtils.getPagebar4(cPage, limit, totalContent, url);
		log.debug("pagebar = {}", pagebar);
		
		resultMap.put("commentBoardStr", commentBoardStr);
		resultMap.put("totalContent", totalContent);
		resultMap.put("pagebar", pagebar);
		
		return resultMap;
	}
	
	/* ---------------------------------------- 답변순 리스트 종료 ---------------------------------------- */
	
	/* ---------------------------------------- 모집진행순 리스트 시작 ---------------------------------------- */
	
	@GetMapping("/joinStartBoard.do")
	@ResponseBody
	public Map<String, Object> joinStartBoard(
			@RequestParam(defaultValue = "1") int cPage,
			@RequestParam int pageCode,
			HttpServletRequest request,
			Model model){
		
		Map<String, Object> resultMap = new HashMap<>();
		
		int limit = 10;
		int offset = (cPage - 1) * limit;
		
		log.debug("pageCode = {}", pageCode);
		
		Map<String, Object> param = new HashMap<>();
		param.put("pageCode", pageCode);
		log.debug("param = {}", param);
		
		String url = request.getContextPath();
		
		List<CommunityEntity> joinStartBoardList = communityService.selectJoinStartBoardList(param, offset, limit);
		log.debug("likeBoardList = {}", joinStartBoardList);
		String joinStartBoardStr = CommunityUtils.getJoinStartBoardList(joinStartBoardList, url);
		
		// 2. 모집진행 게시물 수
		int totalContent = communityService.selectOneStudyJoinStartCount();
		log.debug("selectOneStudyCount = {}", totalContent);
		model.addAttribute("totalContent", totalContent);
		
		// 3. pagebar
		String pagebar = CommunityUtils.getPagebar5(cPage, limit, totalContent, url);
		log.debug("pagebar = {}", pagebar);
		
		resultMap.put("joinStartBoardStr", joinStartBoardStr);
		resultMap.put("totalContent", totalContent);
		resultMap.put("pagebar", pagebar);
		
		return resultMap;
	}
	
	/* ---------------------------------------- 모집진행순 리스트 종료 ---------------------------------------- */
	
	/* ---------------------------------------- 모집완료순 리스트 시작 ---------------------------------------- */
	
	@GetMapping("/joinEndBoard.do")
	@ResponseBody
	public Map<String, Object> joinEndBoard(
			@RequestParam(defaultValue = "1") int cPage,
			@RequestParam int pageCode,
			HttpServletRequest request,
			Model model){
		
		Map<String, Object> resultMap = new HashMap<>();
		
		int limit = 10;
		int offset = (cPage - 1) * limit;
		
		log.debug("pageCode = {}", pageCode);
		
		Map<String, Object> param = new HashMap<>();
		param.put("pageCode", pageCode);
		log.debug("param = {}", param);
		
		String url = request.getContextPath();
		
		List<CommunityEntity> joinEndBoardList = communityService.selectJoinEndBoardList(param, offset, limit);
		log.debug("joinEndBoardList = {}", joinEndBoardList);
		String joinEndBoardStr = CommunityUtils.getJoinEndBoardList(joinEndBoardList, url);
		
		// 2. 모집완료 게시물 수
		int totalContent = communityService.selectOneStudyJoinEndCount();
		log.debug("selectOneStudyCount = {}", totalContent);
		model.addAttribute("totalContent", totalContent);
		
		// 3. pagebar
		String pagebar = CommunityUtils.getPagebar6(cPage, limit, totalContent, url);
		log.debug("pagebar = {}", pagebar);
		
		resultMap.put("joinEndBoardStr", joinEndBoardStr);
		resultMap.put("totalContent", totalContent);
		resultMap.put("pagebar", pagebar);
		
		return resultMap;
	}
	
	/* ---------------------------------------- 모집완료순 리스트 종료 ---------------------------------------- */
	
	/* ---------------------------------------- 커뮤니티 상세보기 시작 ---------------------------------------- */	
	
	// @RequestParam("가져올 데이터의 이름")[데이터 타입][가져온 데이터를 담을 변수]
	// 그리고 Model 객체를 이용해서, 뷰로 값을 넘겨준다.
	@GetMapping("/communityDetail/{communityNo}")
	public String communityDetail(
								@PathVariable int communityNo, 
								Model model, HttpServletRequest request,
								HttpServletResponse response,
								Authentication authentication) {
		log.debug("communityNo = {}", communityNo);
		Member member = null;
		
		// memberNo를 가져오기 위해 authentication을 활용
		if(authentication != null) {
			member = (Member) authentication.getPrincipal();
		}
		
		// 조회 중복 방지
		boolean hasRead = CommunityUtils.hasRead(request, response, communityNo, "community");
		
		// 읽음 여부
		if (!hasRead) {
			// 조회수 증가
			int result = communityService.viewCount(communityNo);
			log.debug("viewCount = {}", result);
		}
			
		// 업무로직
		CommunityEntity communityEntity = communityService.selectOneCommunity(communityNo);
		log.debug("communityEntity = {}", communityEntity);
		model.addAttribute("communityEntity", communityEntity);
		
		// 좋아요 클릭 유무 확인
		Map<String, Object> param = new HashMap<>();
		if(authentication != null) {
			param.put("memberNo", member.getMemberNo());
		}
		param.put("communityNo", communityNo);
		
		// 좋아요 여부 확인(누름 = 1, 안누름 = 0)
		int likeYesNo = communityService.didIHitLikes(param);
		log.debug("좋아요 여부확인, param = {}", param);
		log.debug("좋아요 여부확인, likeYesNo = {}", likeYesNo);
		model.addAttribute(likeYesNo);
		
		// 댓글
		List<CommunityCommentEntity> commentList = communityService.selectCommentList(communityNo);
		log.debug("freeboardCommentList = {}", commentList);
		model.addAttribute("freeboardCommentList", commentList);

		
		return "community/communityDetail";
	}
	/* ---------------------------------------- 커뮤니티 상세보기 종료 ---------------------------------------- */
	
	/* ---------------------------------------- 커뮤니티 좋아요 추가 시작 ---------------------------------------- */
	
	@ResponseBody
	@GetMapping("/freeboardLikeAdd")
	public Map<String, Object> freeboardLikeAdd(@RequestParam int communityNo, @RequestParam int memberNo){
		
		Map<String, Object> param = new HashMap<>();
		param.put("communityNo", communityNo);
		param.put("memberNo", memberNo);

		int result = communityService.freeboardLikeAdd(param);
		log.debug("좋아요 추가성공(result) : {}", result);
		
		// 좋아요 추가하고 새로 추가된 좋아요 갯수 받아오기
		int newCountLikes = communityService.refreshCountLikes(communityNo); 
		
		Map<String, Object> map = new HashMap<>();
		map.put("result", result);
		map.put("newCountLikes", newCountLikes);
		
		return map;
	}
	
	/* ---------------------------------------- 커뮤니티 좋아요 추가 종료 ---------------------------------------- */
	
	/* ---------------------------------------- 커뮤니티 좋아요 삭제 시작 ---------------------------------------- */
	
	@ResponseBody
	@GetMapping("/freeboardLikeDelete")
	public Map<String, Object> freeboardLikeDelete(@RequestParam int communityNo, @RequestParam int memberNo){
		
		Map<String, Object> param = new HashMap<>();
		param.put("communityNo", communityNo);
		param.put("memberNo", memberNo);
		
		int result = communityService.freeboardLikeDelete(param);
		log.debug("좋아요 삭제성공(result) : {}", result);
		
		// 좋아요 삭제하고 새로 추가된 좋아요 갯수 받아오기
		int newCountLikes = communityService.refreshCountLikes(communityNo);
		log.debug("좋아요 삭제해서 0이어야함 : {}", newCountLikes);
		
		Map<String, Object> map = new HashMap<>();
		map.put("result", result);
		map.put("newCountLikes", newCountLikes);
		
		return map;
	}
	
	/* ---------------------------------------- 커뮤니티 좋아요 삭제 종료 ---------------------------------------- */
	
	/* ---------------------------------------- 커뮤니티 수정하기 페이지 시작 ---------------------------------------- */

	@GetMapping("/communityUpdate.do")
	public void communityUpdate(@RequestParam(value="communityNo") int communityNo, Model model) {
		log.debug("{}", "/communityUpdate.do 요청!");
		log.debug("communityNo = {}", communityNo);
		
		CommunityEntity communityEntity = communityService.selectOneCommunity(communityNo);
		log.debug("communityEntity", communityEntity);
		model.addAttribute("communityEntity", communityEntity);
	}
	
	/* ---------------------------------------- 커뮤니티 수정하기 페이지 종료 ---------------------------------------- */
	
	/* ---------------------------------------- 커뮤니티 수정하기 시작 ---------------------------------------- */
	
	@PostMapping("/communityUpdateEnroll.do")
	public String communityUpdateEnroll(CommunityEntity communityEntity, RedirectAttributes redirectAttributes) {
		log.debug("{}", "communityUpdateEnroll.do 요청!");
		log.debug("community = {}", communityEntity);
		int startIndex = 0;
		int endIndex = 0;
		String content = communityEntity.getContent();
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
			// communityEntity에 tumbnail을 보낸다.
			communityEntity.setThumbnail(thumbnail);
		}
		
		int result = communityService.updateCommunity(communityEntity);
		String msg = result > 0 ? "게시글 수정 성공!" : "게시글 수정 실패!";
		redirectAttributes.addFlashAttribute("msg", msg);
		
		return "redirect:/community/communityDetail/" + communityEntity.getCommunityNo();
	}
	
	/* ---------------------------------------- 커뮤니티 수정하기 종료 ---------------------------------------- */
	
	/* ---------------------------------------- 커뮤니티 삭제하기 시작 ---------------------------------------- */
	
	@GetMapping("/communityDelete.do")
	public String communityDelete(@RequestParam int communityNo, @RequestParam int pageCode, RedirectAttributes redirectAttributes) {
		
		log.debug("{}", "/communityDelete.do 요청!");
		log.debug("communityNo = {}", communityNo);
		log.debug("pageCode = {}", pageCode);
		
		int result = communityService.communityDelete(communityNo);
		String msg = result > 0 ? "게시글 삭제 성공!" : "게시글 삭제 실패!";
		redirectAttributes.addFlashAttribute("msg", msg);
		
		if(pageCode == 2) {
			return "redirect:/community/communityQnAList.do";
		} else if (pageCode == 3) {
			return "redirect:/community/communityStudyList.do";
		}

		return "redirect:/community/communityFreeboardList.do";
	}
	
	/* ---------------------------------------- 커뮤니티 삭제하기 종료 ---------------------------------------- */
	
	/* ---------------------------------------- 모집중 --> 모집완료 시작 ---------------------------------------- */
	
	@ResponseBody
	@GetMapping("/joinNo.do")
	public Map<String, Object> joinNo(@RequestParam int communityNo, @RequestParam String studyJoinYn){
		log.debug("{}", "/joinNo.do 요청!");
		
		Map<String, Object> param = new HashMap<>();
		param.put("studyJoinYn", studyJoinYn);
		param.put("communityNo", communityNo);
		
		int result = communityService.updateJoinNo(param);
		log.debug("모집중에서 모집완료로 변경? = {}", result);
		
		Map<String, Object> map = new HashMap<>();
		map.put("result", result);
		
		return map;
	}
	
	/* ---------------------------------------- 모집중 --> 모집완료 종료 ---------------------------------------- */
		
	/* ---------------------------------------- 답변완료 --> 답변중 시작 ---------------------------------------- */
		
		@ResponseBody
		@GetMapping("/answerNo.do")
		public Map<String, Object> answerNo(@RequestParam int communityNo, @RequestParam String answerYn){
			log.debug("{}", "/answerNo.do 요청!");
			
			Map<String, Object> param = new HashMap<>();
			param.put("studyJoinYn", answerYn);
			param.put("communityNo", communityNo);
			
			int result = communityService.updateAnswerNo(param);
			log.debug("답변완료에서 답변중으로 변경? = {}", result);
			
			Map<String, Object> map = new HashMap<>();
			map.put("result", result);
			
			return map;
		}
	
	/* ---------------------------------------- 답변완료 --> 답변중 종료 ---------------------------------------- */
		
	/* ---------------------------------------- 모집완료 --> 모집중 시작 ---------------------------------------- */
		
		@ResponseBody
		@GetMapping("/joinYes.do")
		public Map<String, Object> joinYes(@RequestParam int communityNo, @RequestParam String studyJoinYn){
			log.debug("{}", "/joinyes.do 요청!");
			
			Map<String, Object> param = new HashMap<>();
			param.put("studyJoinYn", studyJoinYn);
			param.put("communityNo", communityNo);
			
			int result = communityService.updateJoinYes(param);
			log.debug("모집완료에서 모집중로 변경 = {}", result);
			
			Map<String, Object> map = new HashMap<>();
			map.put("result", result);
			
			return map;
		}
		
	/* ---------------------------------------- 모집완료 --> 모집중 종료 ---------------------------------------- */
		
	/* ---------------------------------------- 답변중 --> 답변완료 시작 ---------------------------------------- */
		
		@ResponseBody
		@GetMapping("/answerYes.do")
		public Map<String, Object> answerYes(@RequestParam int communityNo, @RequestParam String answerYn){
			log.debug("{}", "/answeryes.do 요청!");
			
			Map<String, Object> param = new HashMap<>();
			param.put("studyJoinYn", answerYn);
			param.put("communityNo", communityNo);
			
			int result = communityService.updateAnswerYes(param);
			log.debug("모집완료에서 모집중로 변경 = {}", result);
			
			Map<String, Object> map = new HashMap<>();
			map.put("result", result);
			
			return map;
		}
		
	/* ---------------------------------------- 답변중 --> 답변완료 종료 ---------------------------------------- */
		
	/* ---------------------------------------- 커뮤니티 댓글 등록 시작 ---------------------------------------- */
		
	@PostMapping("/communityCommentEnroll.do")
	public String commentEnroll(CommunityComment communityComment, RedirectAttributes redirectAttributes) {
		log.debug("{}", "/communityCommentEnroll.do 요청!");
		log.debug("communityComment = {}", communityComment);
		
		// 업무로직
		int result = communityService.insertCommentEnroll(communityComment); 
		String msg = result > 0 ? "댓글 등록 성공!" : "댓글 등록 실패!";
		redirectAttributes.addFlashAttribute("msg", msg); 
		
		return "redirect:/community/communityDetail/" + communityComment.getCommunityNo();
	}
	
	/* ---------------------------------------- 커뮤니티 댓글 등록 종료 ---------------------------------------- */
	
	/* ---------------------------------------- 커뮤니티 댓글 삭제 시작 ---------------------------------------- */
	
	@GetMapping("/commentDelete.do")
	public String commentDelete(@RequestParam(value="commentNo") int commentNo, @RequestParam(value="communityNo") int communityNo, RedirectAttributes redirectAttributes) {
		log.debug("{}", "/commentDelete.do 요청!");
		log.debug("commentNo = {}", commentNo);
		log.debug("{}", communityNo);
		
		int result = communityService.commentDelete(commentNo);
		String msg = result > 0 ? "댓글 삭제 성공!" : "댓글 삭제 실패!";
		redirectAttributes.addFlashAttribute("msg", msg); 
		
		return "redirect:/community/communityDetail/" + communityNo; 
	}

	/* ---------------------------------------- 커뮤니티 댓글 삭제 종료 ---------------------------------------- */
	
	/* ---------------------------------------- 커뮤니티 글쓰기 시작 ---------------------------------------- */
	
	@PostMapping("/communityWriteEnroll.do")
	public String communityWriteEnroll(Community community, RedirectAttributes redirectAttributes) {
		log.debug("{}", "/communityWriteEnroll.do 요청!");
		log.debug("community = {}", community);
		
		// img 데이터를 잘라오기 위한 Index 선언
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
		
		int result = communityService.insertCommunityWriteEnroll(community);
		String msg = result > 0 ? "게시글 등록 성공!" : "게시글 등록 실패!";
		redirectAttributes.addFlashAttribute("msg", msg);
		
		if(community.getPageCode() == 2) {
			return "redirect:/community/communityQnAList.do";
		} else if (community.getPageCode() == 3) {
			return "redirect:/community/communityStudyList.do";
		}

		return "redirect:/community/communityFreeboardList.do";
	}
	
	/* ---------------------------------------- 커뮤니티 글쓰기 종료 ---------------------------------------- */
	
	/* ---------------------------------------- 커뮤니티 신고하기 시작 ---------------------------------------- */
	
	@PostMapping("/insertCommunityReport.do")
	public String insertCommunityReport(Report report, @RequestParam int pageCode, RedirectAttributes redirectAttributes) {
		log.debug("{}", "/insertCommunityReport.do 요청!");
		log.debug("report = {}", report);
		
		int result = communityService.insertCommunityReport(report);
		String msg = result > 0 ? "게시글 신고 성공!" : "게시글 신고 실패!";
		redirectAttributes.addFlashAttribute("msg", msg);
		
		if(pageCode == 2) {
			return "redirect:/community/communityQnAList.do";
		} else if (pageCode == 3) {
			return "redirect:/community/communityStudyList.do";
		}

		return "redirect:/community/communityFreeboardList.do";
	}
	
	/* ---------------------------------------- 커뮤니티 신고하기 종료 ---------------------------------------- */
	


}
