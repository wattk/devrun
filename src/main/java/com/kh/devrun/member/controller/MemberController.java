package com.kh.devrun.member.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/member")
public class MemberController{
	
	@RequestMapping("/memberLogin")
	public void memberLogin() {}
	
	
}
