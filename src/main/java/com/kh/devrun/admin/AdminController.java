package com.kh.devrun.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/admin")
public class AdminController {
	
	@GetMapping("/adminMain.do")
	public void adminMain() {}
	
	@GetMapping("/productManage.do")
	public String productManage() {
		
		
		return "/admin/product/product";
	}
	
	
}
