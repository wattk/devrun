package com.kh.devrun.member.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;


@Controller
@RequestMapping("/member")
public class MemberController{
	
	@GetMapping("/memberLogin.do")
	public void memberLogin() {}
	
	
	
	

}

