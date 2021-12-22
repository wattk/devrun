package com.kh.devrun.admin.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.devrun.admin.model.service.AdminService;
import com.kh.devrun.category.model.vo.ProductChildCategory;
import com.kh.devrun.product.Product;
import com.kh.devrun.product.ProductDetail;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	AdminService adminService;
	
	// 태영시작
	@GetMapping("/adminMain.do")
	public void adminMain() {}
	
	@GetMapping("/productMain.do")
	public String productManage() {
				
		return "/admin/product/productMain";
	}
	
	@ResponseBody
	@GetMapping("/selectCategory")
	public Map<String, Object>selectCategory(@RequestParam Map<String, Object> param){
		Map<String, Object> map = new HashMap<>();
		
		log.debug("param = {}", param);
		List<ProductChildCategory> list = adminService.selectChildCategory(param);
		log.debug("list = {}" ,list);
		
		map.put("list",list);
		map.put("date", new Date());
		
		return map;
	}
	
	
	@GetMapping("/insertProduct.do")
	public String insertProduct() {
				
		return "/admin/product/insertProduct";
	}

	// 상품 등록 && 상품-카테고리 등록
	@PostMapping("/insertProduct.do")
	public String insertProduct(
			Product product,
			@RequestParam String childCategoryCode,
			@RequestParam int optionNo,
			@RequestParam String optionContent,
			@RequestParam String sku,
			@RequestParam int quantity,
			RedirectAttributes redirectAttr) {
		
		ProductDetail productDetail = new ProductDetail();
		log.debug("optionNo = {}", optionNo);
		log.debug("optionContent = {}", optionContent);
		log.debug("sku = {}", sku);
		log.debug("quantity = {}", quantity);
		
		log.debug("product = {}", product);
		log.debug("childCategoryCode = {}", childCategoryCode);
		
				
//		int result = adminService.insertProduct(product,childCategoryCode);
//		String msg = result > 0 ? "상품등록을 성공했습니다!":"상품등록에 실패했습니다!!!!!!";  
//		redirectAttr.addFlashAttribute("msg",msg);
		
		return "redirect:/admin/productMain.do";
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
