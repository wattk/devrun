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
	
	
	
	@GetMapping("/shopSearch.do")
	public void shopSearch() {}
	
	@GetMapping("/shopCategory.do")
	public void shopCategory() {}

	@GetMapping("/itemDetail.do")
	public void itemDetail() {}

}
