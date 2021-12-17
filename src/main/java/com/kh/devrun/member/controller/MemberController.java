package com.kh.devrun.member.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.devrun.member.model.service.MemberService;
import com.kh.devrun.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/member")
public class MemberController{
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
	
	@GetMapping("/memberLogin.do")
	public void memberLogin() {}
	
	/**
	 * 혜진 회원가입 시작
	 */
	@GetMapping("/memberEnroll")
	public void memberEnroll() {}
	
	@ResponseBody
	@GetMapping("/checkEnrollDuplicate")
	public Map<String, Object> checkIdDuplicate(@RequestParam Map<String, Object> param){
		log.debug("param = {}", param);
		Map<String, Object> map = new HashMap<>();
		Member member = memberService.selectOneMember(param);
		log.debug("member = {}", member);
		map.put("available", member == null);
		
		return map;
	}
	
	@PostMapping("/memberEnroll")
	public String memberEnroll(Member member, RedirectAttributes redirectAttr) {
		log.debug("member = {}", member);
		
		try {
			String rawPassword = member.getPassword();
			String encryptedPassword = passwordEncoder.encode(rawPassword);
			member.setPassword(encryptedPassword);
			
			int result = memberService.insertMember(member);
			
			redirectAttr.addFlashAttribute("msg", "데브런 회원가입을 축하합니다.");
		} catch (Exception e) {
			log.error("회원가입 실패", e);
			throw e;
		}
		
		return "redirect:/";
	}
	
	/**
	 * 혜진 회원가입 끝
	 */
	
	/**
	 * 지영 아이디/비밀번호 찾기 시작
	 */
	
	@GetMapping("/memberFindIdPassword.do")
	public void memberFindIdPassword() {}
	
	/**
	 * 지영 아이디/비밀번호 찾기 끝
	 */
}

