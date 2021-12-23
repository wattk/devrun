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
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
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
import com.kh.devrun.promotion.model.service.PromotionService;
import com.kh.devrun.promotion.model.vo.Promotion;


import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	AdminService adminService;
	
	@Autowired
	PromotionService promotionService;
	
	@Autowired
	ServletContext application;
	
	// 태영시작
	@GetMapping("/adminMain.do")
	public void adminMain() {}

	
	@GetMapping("/productMain.do")
	public String productManage(
			Model model,
			@RequestParam(defaultValue = "1") int cPage,
			HttpServletRequest request
			) {
		
		// 1.페이징 처리 : 페이지 설정
		int limit = 10;
		int offset = (cPage - 1) * limit;
		
		// 게시물 리스트 가져오기
		List<ProductExtends> list = adminService.selectAllProductList(offset,limit);
		log.debug("list = {}" ,list);	
		model.addAttribute("list",list);
		
		// 2. 전체게시물수 totalContent
		int totalContent = adminService.selectTotalBoardCount();	
		log.debug("totalContent = {}", totalContent);
		model.addAttribute("totalContent", totalContent);
		
		// 3. pagebar
		String url = request.getRequestURI(); // /spring/board/boardList.do
		String pagebar = DevrunUtils.getPagebar(cPage, limit, totalContent, url);
		log.debug("pagebar = {}", pagebar);
		model.addAttribute("pagebar", pagebar);
		
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
			@RequestParam String parentCategoryCode,
			@RequestParam String childCategoryCode,
			@RequestParam String[]optionContent,
			@RequestParam String sku,
			@RequestParam int[]quantity,
			@RequestParam String[]option,
			MultipartFile upFile,
			
			RedirectAttributes redirectAttr) {
		// 사용자 입력값
		log.debug("product = {}", product);
		log.debug("childCategoryCode = {}", childCategoryCode);
		log.debug("parentCategoryCode = {}", parentCategoryCode);
			
		log.debug("sku = {}", sku);
		log.debug("option = {}", option);
		log.debug("optionContent = {}", optionContent);
		log.debug("quantity = {}", quantity);
	
		String categoryCode = parentCategoryCode + childCategoryCode;
		
		// 소분류 코드 + 옵션 + seq.no 으로 상품코드를 만둘어준 뒤 pruduct에 set
		String productCode = parentCategoryCode+"-"+childCategoryCode;
		product.setProductCode(productCode);
		
		// 상품상세 객체로 묶어 전달		
		List<ProductDetail> productDetailList = new ArrayList<>();
		
		for(int i = 0; i < option.length; i++) {
			ProductDetail productDetail = new ProductDetail();
			
			productDetail.setOptionNo(option[i]);
			productDetail.setOptionContent(optionContent[i]);
			productDetail.setSku(sku);
			productDetail.setQuantity(quantity[i]);
			
			productDetailList.add(productDetail);
		}
		
		// prodcut 객체에 저장
		product.setProductDetailList(productDetailList);
		
		// Map<String,Object>param에 담아서 전달
		Map<String,Object>param = new HashMap<>();
		param.put("productCode", productCode);
		param.put("childCategoryCode", childCategoryCode);
		param.put("productDetailList", productDetailList);
		param.put("product", product);
		
		log.debug("param = {}",param);
		
		
		
		log.debug("upFile = {}",upFile);
		String productImg = product.getProductCode() +".png";
		log.debug("productImg = {}",productImg);
		
//		파일저장 : 절대경로
		String saveDirectory  = application.getRealPath("/resources/upload/product");
		log.debug("saveDirectory = {}",saveDirectory);
		
//		prduct thumbnail값 세팅
		product.setThumbnail(productImg);
		
//		 업무로직 : db저장 		
		if(!upFile.isEmpty()) {		
			try {									
				// 서버 컴퓨터 저장
				File dest = new File(saveDirectory, productImg);
				upFile.transferTo(dest);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
					
		}
		
		int result = adminService.insertProduct(param);
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
		List<Promotion> list = promotionService.selectAllPromotionList();
		log.debug("list = {}", list);
		model.addAttribute("promotionList", list);
		return "/admin/promotion/promotionManage";
	}
	
	
	//이벤트 상세 페이지 관련 메소드
	@GetMapping("/promotionDetail.do")
	public String promotionDetail(@RequestParam String promotionCode, Model model) {
		log.debug("promotionCode = {}", promotionCode);
		Promotion promotion = promotionService.selectPromotionByPromotionCode(promotionCode);
		log.debug("promotion = {}", promotion);
		model.addAttribute("promotion", promotion);
		return "/admin/promotion/promotionDetail";
	}
	
	//이벤트 업데이트 메소드
	@PostMapping("/promotionUpdate.do")
	public String promotionUpdate(
			Promotion promotion, 
			MultipartFile upFile,
			@RequestParam(required=false) String[] productCode,
			@RequestParam(required=false) String[] deleteProductCode,
			@ModelAttribute("promotion") Promotion newPromotion,
			RedirectAttributes redirectAttr) {
		log.debug("deleteProductCode={}", deleteProductCode);
		String promotionCode = promotion.getPromotionCode();
		
		try {
			//application 객체(ServletContext)
			String saveDirectory = application.getRealPath("/resources/upload/promotion");
			List<Map<String, Object>> changeProductList = new ArrayList<>();
			List<Map<String, Object>> deleteProductList = new ArrayList<>();
			
			if(!upFile.isEmpty()) {
				saveBanner(promotion, upFile, promotionCode, saveDirectory);
			}
			
			if(productCode != null) {
				for(int i = 0; i < productCode.length; i++) {
					Map<String, Object> map = new HashMap<>();
					map.put("promotionCode", promotionCode);
					map.put("productCode", productCode[i]);
					changeProductList.add(map);
				}
			}
			
			if(deleteProductCode != null) {
				for(int i = 0; i < deleteProductCode.length; i++) {
					Map<String, Object> map = new HashMap<>();
					map.put("promotionCode", promotionCode);
					map.put("productCode", deleteProductCode[i]);
					deleteProductList.add(map);
				}
				
			}
			log.debug("changeProductList = {}", changeProductList);
			log.debug("deleteProductList = {}", deleteProductList);
			
			//db에 이벤트 등록
			Map<String, Object> param = new HashMap<>();
			param.put("promotion", promotion);
			param.put("changeProductList", changeProductList);
			param.put("deleteProductList", deleteProductList);
			int result = promotionService.updatePromotion(param);
			log.debug("result = {}", result);
			
			redirectAttr.addFlashAttribute("msg", "이벤트 등록이 완료되었습니다.");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		
		return "redirect:/admin/promotionDetail.do?promotionCode="+promotionCode;	
	}
	
	//이벤트 삭제 메소드
	@PostMapping("/promotionDelete.do")
	public String promotionDelete(@RequestParam String[] promotionCode, RedirectAttributes redirectAttr) {
		log.debug("promotionCode = {}", promotionCode);
		try {
			//서버 파일 삭제
			String saveDirectory = application.getRealPath("/resources/upload/promotion/");
			File banner = new File(saveDirectory+promotionCode+".png");
			
			if(banner.exists()) banner.delete();
			
			int result = promotionService.deletePromotion(promotionCode);
			log.debug("result = {}", result);
			
			redirectAttr.addFlashAttribute("msg", "이벤트가 삭제되었습니다.");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/admin/promotionManage.do";
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
				saveBanner(promotion, upFile, promotionCode, saveDirectory);
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
			int result = promotionService.insertPromotion(param);
			log.debug("result = {}", result);
			
			redirectAttr.addFlashAttribute("msg", "이벤트 등록이 완료되었습니다.");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		
		return "redirect:/admin/promotionDetail.do?promotionCode="+promotionCode;
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
		List<Product> list = promotionService.selectProductListByProductCode(searchCode);
		return list;
	}
	
	@GetMapping("/findProductList")
	@ResponseBody
	public List<Product> findProductList(@RequestParam String promotionCode){
		List<Product> list = promotionService.selectProductListByPromotionCode(promotionCode);
		return list;
	}
	
	private void saveBanner(Promotion promotion, MultipartFile upFile, String promotionCode, String saveDirectory)
			throws IOException {
		String banner = promotionCode + ".png";
		promotion.setBanner(banner);
		
		// 서버 컴퓨터 저장
		File dest = new File(saveDirectory, banner);
		upFile.transferTo(dest);
	}
	/**
	 * 혜진 끝
	 */
	
}
