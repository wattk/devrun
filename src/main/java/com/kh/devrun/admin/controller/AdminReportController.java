package com.kh.devrun.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.devrun.member.model.vo.Member;
import com.kh.devrun.report.model.service.ReportService;
import com.kh.devrun.report.model.vo.Blacklist;
import com.kh.devrun.report.model.vo.Report;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/admin/report")
public class AdminReportController {
	
	@Autowired
	private ReportService reportService;
	
	@GetMapping("/memberReport.do")
	public String memberReport(Model model) {
		
		// 회원 신고 리스트 조회
		List<Report> memberList = reportService.selectMemberReportList();
		log.debug("memberList = {}", memberList);
		model.addAttribute("memberList", memberList);
		
		return "/admin/report/memberReport";
	}
	
	/**
	 * 리뷰/메시지 신고 리스트 조회
	 */
	@GetMapping("/reviewReport.do")
	public String reviewReport(Model model) { // model은 MVC의 M이 아니다. View단의 데이터를 전달하기 위한 스프링만의 객체이다. 
		
		// 리뷰 신고 리스트 조회
		List<Report> reviewList = reportService.selectReviewReportList();
		log.debug("reviewList = {}", reviewList);
		model.addAttribute("reviewList", reviewList);
		
		// 메시지 신고 리스트 조회
		List<Report> messageList = reportService.selectMessageReportList();
		log.debug("messageList = {}", messageList);
		model.addAttribute("messageList", messageList);
		
		return "/admin/report/reviewReport";
	}
	
	/**
	 * 비동기
	 * 상품 코드 찾기 - 바로가기 새창 띄우기를 위함
	 */
	@ResponseBody
	@GetMapping("/searchProductCode.do")
	public String searchProductCode(@RequestParam(required = false) String no) {
		//log.debug("no = {}", no);
		
		String productCode = reportService.searchProductCode(no);
		//log.debug("productCode = {}", productCode);
		
		return productCode;
	}
	
	/**
	 * 처리상태 업데이트
	 */
	@PostMapping("/reportStatusUpdate.do")
	public String reportStatusUpdate(
			@RequestParam(required = false) int reportNo,
			@RequestParam(required = false) String status,
			@RequestParam(required = false) int targetNo,
			Model model,
			RedirectAttributes redirectAttr,
			Authentication authentication,
			HttpServletRequest request) {
		
		Member loginMember = (Member) authentication.getPrincipal();
		int adminNo = loginMember.getMemberNo();
		
		// 처리상태, 처리한 관리자, 신고대상 경고부여, 블랙 등록(조건 달성할 시)을 위한 파라미터
		Map<String, Object> param = new HashMap<>();
		param.put("reportNo", reportNo);
		param.put("status", status);
		param.put("targetNo", targetNo);
		param.put("adminNo", adminNo);
		
		try {
			int result = reportService.reportStatusUpdate(param);
			redirectAttr.addFlashAttribute("msg", "처리상태 변경 완료");
		} catch (Exception e) {
			log.error("처리상태 변경 실패", e);
			throw e; // spring container에게 예외상황 알림
		} 

		String referer = request.getHeader("Referer");
		log.debug("referer = {}", referer);

		return "redirect:" + referer;
	}
	
	/**
	 * 게시물/댓글 신고 리스트 조회
	 * @return
	 */
	@GetMapping("/boardReport.do")
	public String boardReport(Model model) {
		
		// 게시물 신고 리스트 조회
		List<Report> boardList = reportService.selectBoardReportList();
		log.debug("boardList = {}", boardList);
		model.addAttribute("boardList", boardList);
		
		// 댓글 신고 리스트 조회
		List<Report> commentList = reportService.selectCommentReportList();
		log.debug("commentList = {}", commentList);
		model.addAttribute("commentList", commentList);
		
		return "/admin/report/boardReport";
	}
	
	/**
	 * 비동기
	 * 커뮤니티 게시글 번호 찾기 - 바로가기 새창 띄우기를 위함
	 */
	@ResponseBody
	@GetMapping("/searchCommunityNo.do")
	public int searchCommunityNo(@RequestParam(required = false) int no) {
		//log.debug("no = {}", no);
		
		int communityNo = reportService.searchCommunityNo(no);
		log.debug("communityNo = {}", communityNo);
		
		return communityNo;
	}
	
	/**
	 * 블랙리스트 조회
	 */
	@GetMapping("/blacklistReport.do")
	public String blacklistReport(Model model) {
		
		List<Blacklist> blacklist =  reportService.selectAllBlacklist();
		log.debug("blacklist = {}", blacklist);
		
		model.addAttribute("blacklist", blacklist);
		
		return "/admin/report/blacklistReport";
	}
	
	/**
	 * 블랙리스트 해제
	 */
	@PostMapping("/BlacklistRelease.do")
	public String BlacklistRelease(
			@RequestParam(required = false) int memberNo,
			@RequestParam(required = false) int blacklistNo,
			Model model,
			RedirectAttributes redirectAttr,
			Authentication authentication) {
		
		Member loginMember = (Member) authentication.getPrincipal();
		int adminNo = loginMember.getMemberNo();
		
		Map<String, Object> param = new HashMap<>();
		param.put("memberNo", memberNo);
		param.put("blacklistNo", blacklistNo);
		param.put("adminNo", adminNo);
		
		try {
			int result = reportService.blacklistRelease(param);
			redirectAttr.addFlashAttribute("msg", "블랙리스트 해제 완료");
		} catch (Exception e) {
			log.error("블랙리스트 해제 실패", e);
			throw e; // spring container에게 예외상황 알림
		} 
		
		return "redirect:/admin/report/blacklistReport.do";
	}
	
	
	/**
	 * 노트 수정
	 */
	@PostMapping("/noteUpdate.do")
	public String noteUpdate(
			@RequestParam(required = false) int blacklistNo,
			@RequestParam(required = false) String note,
			Model model,
			RedirectAttributes redirectAttr,
			Authentication authentication,
			HttpServletRequest request) {
		
		Member loginMember = (Member) authentication.getPrincipal();
		int adminNo = loginMember.getMemberNo();
		
		// 비고 수정 시 내용과 처리자 변경하기 위함
		Map<String, Object> param = new HashMap<>();
		param.put("blacklistNo", blacklistNo);
		param.put("note", note);
		param.put("adminNo", adminNo);
		
		try {
			int result = reportService.noteUpdate(param);
			redirectAttr.addFlashAttribute("msg", "비고 수정 완료");
		} catch (Exception e) {
			log.error("비고 수정 실패", e);
			throw e; // spring container에게 예외상황 알림
		} 
		
		String referer = request.getHeader("Referer");
		log.debug("referer = {}", referer);

		return "redirect:" + referer;
	}
}
