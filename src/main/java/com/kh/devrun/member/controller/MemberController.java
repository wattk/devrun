package com.kh.devrun.member.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.devrun.member.model.vo.Member;
import com.kh.devrun.member.service.MemberService;


@Controller
@RequestMapping("/member")
public class MemberController{
	
	@Autowired
	private MemberService memberService;
	
	
	@GetMapping("/memberLogin.do")
	public void memberLogin() {}
	
	/**
	 * 혜진 회원가입 시작
	 */
	@GetMapping("/memberEnroll")
	public void memberEnroll() {}
	
	@GetMapping("/checkIdDuplicate.do")
	public Map<String, Object> checkIdDuplicate(@RequestParam String id){
		Map<String, Object> map = new HashMap<>();
		//Member member = memberService.selectOneMember(id);
		//map.put("available", member == null);
		
		return map;
	}
	
	/**
	 * 혜진 회원가입 끝
	 */
}

