package com.kh.devrun.admin.controller;

import java.beans.PropertyEditor;
import java.io.File;
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
import org.springframework.ui.Model;
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
import com.kh.devrun.product.ProductDetail;
import com.kh.devrun.product.ProductExtends;
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

	
	@GetMapping("/productMain.do")
	public String productManage(Model model) {
		List<ProductExtends> list = adminService.selectAllProductList();
		log.debug("list = {}" ,list);	
		
		model.addAttribute("list",list);
		
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
			@RequestParam String optionContent,
			@RequestParam String sku,
			@RequestParam int quantity,
			@RequestParam String option1,
			@RequestParam String option2,
			MultipartFile upFile,
			
			RedirectAttributes redirectAttr) {
		// 사용자 입력값
		log.debug("product = {}", product);
		log.debug("childCategoryCode = {}", childCategoryCode);
			
		log.debug("optionContent = {}", optionContent);
		log.debug("sku = {}", sku);
		log.debug("quantity = {}", quantity);
		log.debug("option1 = {}", option1);
		log.debug("option2= {}", option2);
		
		// 받아온 옵션값 합쳐주기
		String option = option1+"-"+option2;
		
		// 소분류 코드 + 옵션 + seq.no 으로 상품코드를 만둘어준 뒤 pruduct에 set
		String product_code = childCategoryCode+"-"+option; 
		product.setProductCode(product_code);
		
		// 상품상세 객체로 묶어 전달
		ProductDetail productDetail = new ProductDetail();
		productDetail.setOptionNo(option);
		productDetail.setOptionContent(optionContent);
		productDetail.setSku(sku);
		productDetail.setQuantity(quantity);
		
		log.debug("upFile = {}",upFile);
		String productImg = product.getProductCode() +".png";
		log.debug("productImg = {}",productImg);
		
		// 파일저장 : 절대경로
		String saveDirectory  = application.getRealPath("/resources/upload/product");
		log.debug("saveDirectory = {}",saveDirectory);
		
		//prduct thumbnail값 세팅
		product.setThumbnail(productImg);
		
		// 업무로직 : db저장 		
		if(!upFile.isEmpty()) {		
			try {									
				// 서버 컴퓨터 저장
				File dest = new File(saveDirectory, productImg);
				upFile.transferTo(dest);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
					
		}
		
		int result = adminService.insertProduct(product,childCategoryCode,productDetail);
		String msg = result > 0 ? "상품등록을 성공했습니다!":"상품등록에 실패했습니다!!!!!!";  
		redirectAttr.addFlashAttribute("msg",msg);
		
																					
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
	
	//이벤트 메인 페이지 관련 메소드
	@GetMapping("/promotionManage.do")
	public String promotionManage(Model model) {
		List<Promotion> list = adminService.selectAllPromotionList();
		log.debug("list = {}", list);
		model.addAttribute("promotionList", list);
		return "/admin/promotion/promotionManage";
	}
	
	
	//이벤트 상세 페이지 관련 메소드
	@GetMapping("/promotionDetail.do")
	public String promotionDetail(@RequestParam String promotionCode, Model model) {
		log.debug("promotionCode = {}", promotionCode);
		Promotion promotion = adminService.selectPromotionByPromotionCode(promotionCode);
		log.debug("promotion = {}", promotion);
		model.addAttribute("promotion", promotion);
		return "/admin/promotion/promotionDetail";
	}
	
	//이벤트 업데이트 메소드
	@PostMapping("/promotionUpdate.do")
	public String promotionUpdate(Promotion promotion, MultipartFile upFile, RedirectAttributes redirectAttr) {
		
		return "";
	}
	
	
	//이벤트 등록 관련 메소드
	@GetMapping("/promotionEnroll.do")
	public String promotionEnroll() {
		return "/admin/promotion/promotionEnroll";
	}
	
	@PostMapping("/promotionEnroll.do")
	public String promotionEnroll(
			Promotion promotion, 
			MultipartFile upFile, 
			@RequestParam String[] productCode, 
			RedirectAttributes redirectAttr) 
	{
		String promotionCode = "";
		try {
			log.debug("promotion = {}, productCode = {}", promotion, productCode);
			//promotion_code 생성
			promotionCode = "PROMO_" + DevrunUtils.getRandomNo();
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
		
		return "redirect:/admin/promotion/promotionDetail.do?promotionCode="+promotionCode;
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
