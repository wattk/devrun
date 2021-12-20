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
	
	@GetMapping("")
	public String mypage(Model model, Authentication authentication) {
		Member member = (Member) authentication.getPrincipal();
		log.debug("[principal] member = {}", member);
//		Object credentials = authentication.getCredentials();
//		log.debug("[credentials] credentials = {}", credentials);
//		Collection<? extends GrantedAuthority> authorities = authentication.getAuthorities();
//		log.debug("[authorities] authorities = {}", authorities);		
		//읽지 않은 총 쪽지 개수 totalMessage
		if(member != null) {
			int memberNo2 = member.getMemberNo();
			int totalMessage = mypageService.selectMessageTotalCount(memberNo2);
			log.debug("totalMessage = {}", totalMessage);
			model.addAttribute("totalMessage", totalMessage);
			return "mypage/mypage";
		} else {
			return "redirect:error.do";
		}
	}
	
	/**
	 * 혜진 교환/환불/취소 시작
	 */
	
	@GetMapping("/claim.do")
	public void claim() {}
	
	/**
	 * 혜진 교환/환불/취소 끝
	 */
}