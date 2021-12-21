package com.kh.devrun.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.devrun.promotion.model.service.PromotionService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	private PromotionService promotionService;
	
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
	
	@GetMapping("/promotionManage.do")
	public String promotionManage() {
		
		return "/admin/promotion/promotionManage";
	}
	
	@GetMapping("/promotionDetail.do")
	public String promotionDetail() {
		return "/admin/promotion/promotionDetail";
	}
	
	@GetMapping("/promotionEnroll.do")
	public String promotionEnroll() {
		return "/admin/promotion/promotionEnroll";
	}
	
	@GetMapping("/promotionAutocomplete")
	@ResponseBody
	public void promotionAutocomplete(@RequestParam String searchCode) {
		//List<String> list = promotionService.selectProductListByProductCode(searchCode);
	}

	/**
	 * 혜진 끝
	 */
	
}
