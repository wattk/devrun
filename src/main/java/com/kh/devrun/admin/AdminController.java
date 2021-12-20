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
		
		
		return "/admin/product/productMain";
	}
	@GetMapping("/insertProduct.do")
	public String insertProduct() {
		
		
		return "/admin/product/insertProduct";
	}
	
	/**
	 * 혜진 시작 
	 */
	@GetMapping("/orderManage.do")
	public void orderManage() {}
	
	@GetMapping("/shipmentManage.do")
	public void shipmentManage() {}
	
	@GetMapping("/reviewReport.do")
	public String reviewReport() {
		
		return "/admin/report/reviewReport";
	}
	
	@GetMapping("/boardReport.do")
	public String boardReport() {
		
		return "/admin/report/boardReport";
	}
	
	@GetMapping("/blacklistReport.do")
	public String blacklistReport() {
		
		return "/admin/report/blacklistReport";
	}
	/**
	 * 혜진 끝
	 */
	
}
