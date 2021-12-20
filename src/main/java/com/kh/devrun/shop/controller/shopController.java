package com.kh.devrun.shop.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/shop")
public class shopController {
	
	@GetMapping("/shopMain.do")
	public String shopMain() {
		
		return "shop/shopMain";
		
	}
	
	/**
	 * 혜진 작업 시작
	 */
	@GetMapping("/search.do")
	public void search() {}
	
	@GetMapping("/category.do")
	public void category() {}
	
	/**
	 * 혜진 작업 끝
	 */
	

}
