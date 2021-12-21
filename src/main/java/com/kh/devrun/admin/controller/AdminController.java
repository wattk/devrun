package com.kh.devrun.admin.controller;

import java.beans.PropertyEditor;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.devrun.admin.model.service.AdminService;
import com.kh.devrun.category.model.vo.ProductChildCategory;
import com.kh.devrun.common.DevrunUtils;
import com.kh.devrun.product.Product;
import com.kh.devrun.promotion.model.vo.Promotion;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	AdminService adminService;
	
	@Autowired
	ServletContext application;
	
	// 태영시작
	@GetMapping("/adminMain.do")
	public void adminMain() {}
	
	@GetMapping("/productManage.do")
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

	@PostMapping("/insertProduct.do")
	public String insertProduct(
			Product product,
			@RequestParam String childCategoryCode ) {
		
		log.debug("product = {}", product);
		
		int result = adminService.insertProduct(product,childCategoryCode);
		
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
	
	@PostMapping("/promotionEnroll.do")
	public String promotionEnroll(Promotion promotion, MultipartFile upFile, @RequestParam String[] productCode, RedirectAttributes redirectAttr) {
		try {
			log.debug("promotion = {}, productCode = {}", promotion, productCode);
			//promotion_code 생성
			String promotionCode = "PROMO_" + DevrunUtils.getRandomNo();
			promotion.setPromotionCode(promotionCode);
			
			//application 객체(ServletContext)
			String saveDirectory = application.getRealPath("/resources/upload/promotion");
			
			if(!upFile.isEmpty()) {
				String banner = promotionCode + ".png";
				promotion.setBanner(banner);
				
				// 서버 컴퓨터 저장
				File dest = new File(saveDirectory, banner);
				upFile.transferTo(dest);
			}
			
			List<Map<String, Object>> list = new ArrayList<>();
			for(int i = 0; i < productCode.length; i++) {
				Map<String, Object> map = new HashMap<>();
				map.put("promotionCode", promotionCode);
				map.put("productCode", productCode[i]);
				list.add(map);
			}
			log.debug("list = {}", list);
			
			//db에 이벤트 등록
			Map<String, Object> param = new HashMap<>();
			param.put("promotion", promotion);
			param.put("list", list);
			int result = adminService.insertPromotion(param);
			log.debug("result = {}", result);
			
			redirectAttr.addAttribute("msg", "이벤트 등록이 완료되었습니다.");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		
		return "/admin/promotion/promotionDetail";
	}
	
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		// 형식객체, 빈값허용여부("" -> null)
		PropertyEditor editor = new CustomDateEditor(sdf, true);
		binder.registerCustomEditor(Date.class, editor);
	}
	
	@GetMapping("/promotionAutocomplete")
	@ResponseBody
	public List<Product> promotionAutocomplete(@RequestParam String searchCode) {
		List<Product> list = adminService.selectProductListByProductCode(searchCode);
		return list;
	}
	/**
	 * 혜진 끝
	 */
	
}
