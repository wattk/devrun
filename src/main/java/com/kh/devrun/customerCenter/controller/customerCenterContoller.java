package com.kh.devrun.customerCenter.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/customerCenter")
public class customerCenterContoller {
	
	@GetMapping("/noticeList.do")
	public void noticeList() {}
	
	@GetMapping("/noticeDetail.do")
	public void noticeDetail() {}
	
	@GetMapping("/faq.do")
	public void faq() {}

}
