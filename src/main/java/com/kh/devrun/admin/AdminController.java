package com.kh.devrun.admin;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.model;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.devrun.product.Product;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/admin")
public class AdminController {
	
	// 태영시작
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

	@PostMapping("/insertProduct.do")
	public String insertProduct(Product product) {
		log.debug("product = {}", product);
	
		return "/admin/product/productMain";
	}
	//--------------------태영 끝-----------------------------

	
	

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
