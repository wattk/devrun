package com.kh.devrun.mypage.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.devrun.member.model.vo.Member;
import com.kh.devrun.mypage.model.service.MypageService;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/mypage")
@Slf4j
public class MypageController {

	@Autowired
	private MypageService mypageService;
	
	/**
	 * 지원 마이페이지 메인 시작
	 */
	@GetMapping("/mypage.do")
	public String mypage(Model model, Authentication authentication) {
		Member member = (Member) authentication.getPrincipal();
		log.debug("[principal] member = {}", member);
//		Object credentials = authentication.getCredentials();
//		log.debug("[credentials] credentials = {}", credentials);
//		Collection<? extends GrantedAuthority> authorities = authentication.getAuthorities();
//		log.debug("[authorities] authorities = {}", authorities);		
		//읽지 않은 총 쪽지 개수 totalMessage
//		if(member != null) {
//			int memberNo2 = member.getMemberNo();
//			int totalMessage = mypageService.selectMessageTotalCount(memberNo2);
//			log.debug("totalMessage = {}", totalMessage);
//			model.addAttribute("totalMessage", totalMessage);
//			return "mypage/mypage";
//		} else {
//			return "redirect:error.do";
//		}
		return "mypage/mypage";
	}
	/**
	 * 지원 마이페이지 메인 끝
	 */
	
	/**
	 * 지원 나의 정보 메인 시작
	 */
	@GetMapping("/myinfo.do")
	public String myinfo() {
		return "mypage/myinfo";
	}
	/**
	 * 지원 나의 정보 메인 끝
	 */
	
	/**
	 * 지원 나의 커뮤니티 메인 시작
	 */
	@GetMapping("/mycommunity.do")
	public String mycommunity() {
		return "mypage/mycommunity";
	}
	/**
	 * 지원 나의 커뮤니티 메인 끝
	 */
	
	/**
	 * 지원 나의 정보 > 활동 배지 시작
	 */
	@GetMapping("/myinfo/activityBadge.do")
	public String activityBagde() {

		return "mypage/activityBadge";
		
	}
	/**
	 * 지원 나의 정보 > 활동 배지 끝
	 */
	
	/**
	 * 지원 나의 정보 > 프로필 수정 시작
	 */
	@GetMapping("/myinfo/profileUpdate.do")
	public String profileUpdate() {

		return "mypage/profileUpdate";
		
	}
	/**
	 * 지원 나의 정보 > 프로필 수정 끝
	 */
	
	/**
	 * 지원 나의 정보 > 배송지 관리 시작
	 */
	@GetMapping("/myinfo/shippingAddress.do")
	public String shippingAddress() {

		return "mypage/shippingAddress";
		
	}
	/**
	 * 지원 나의 정보 > 배송지 관리 끝
	 */
	
	/**
	 * 지원 나의 정보 > 신고 내역 시작
	 */
	@GetMapping("/myinfo/reportHistory.do")
	public String reportHistory() {

		return "mypage/reportHistory";
		
	}
	/**
	 * 지원 나의 정보 > 신고 내역 끝
	 */
	
	/**
	 * 혜진 나의 쇼핑 시작
	 */
	
	@GetMapping("/myshopping.do")
	public void myshopping() {}
	
	/**
	 * 혜진 나의 쇼핑 끝
	 */
	/**
	 * 혜진 교환/환불/취소 시작
	 */
	
	@GetMapping("/claim.do")
	public void claim() {}
	
	/**
	 * 혜진 교환/환불/취소 끝
	 */
	/**
	 * 혜진 주문 내역 시작
	 */
	
	@GetMapping("/orderList.do")
	public void orderList() {}
	
	/**
	 * 혜진 주문 내역 끝
	 */
	/**
	 * 혜진 나의 리뷰 시작
	 */
	
	@GetMapping("/myReview.do")
	public void myReview() {}
	
	/**
	 * 혜진 나의 리뷰 끝
	 */
	/**
	 * 혜진 나의 문의 시작
	 */
	
	@GetMapping("/myQuestion.do")
	public void myQuestion() {}
	
	/**
	 * 혜진 나의 문의 끝
	 */
	/**
	 * 혜진 나의 포인트 조회 시작
	 */
	
	@GetMapping("/myPoint.do")
	public void myPoint() {}
	
	/**
	 * 혜진 나의 포인트 조회 끝
	 */
}