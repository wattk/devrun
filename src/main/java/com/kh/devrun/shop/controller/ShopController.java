package com.kh.devrun.shop.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.devrun.common.DevrunUtils;
import com.kh.devrun.product.model.service.ProductService;
import com.kh.devrun.product.model.vo.Product;
import com.kh.devrun.product.model.vo.ProductEx;
import com.kh.devrun.promotion.model.service.PromotionService;
import com.kh.devrun.promotion.model.vo.Promotion;
import com.kh.devrun.shop.model.service.ShopService;
import com.kh.devrun.shop.model.vo.Attachment;
import com.kh.devrun.shop.model.vo.Review;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/shop")
public class ShopController {
	
	@Autowired
	private PromotionService promotionService;
	
	@Autowired
	private ShopService shopService;
	
	@Autowired
	private ProductService productService;
	
	@Autowired
	ServletContext application;
//--------------------주입-------------------------------------	
	

	@GetMapping("/shopMain.do")
	public void shopMain() {
	}
	
	//상품 사이드 메뉴 바에서 전체보기 클릭 시 
	@GetMapping("/CategoryItemAll")
	public String CategoryItemAll(@RequestParam String parentCate, Model model) {
		
		List<Product>itemList = shopService.CategoryItemAll(parentCate);
		log.debug("{}",itemList);
		model.addAttribute("itemList", itemList);
		
		return "shop/shopCategory";
	}
	
	
	//사진 리뷰만 모아보기 기능
	@ResponseBody
	@GetMapping("picReviewOnly")
	public List<Review> picReviewOnly() {
		
		List<Review> picReviewList = shopService.picReviewOnly();
		return picReviewList;
	}
	
	
	// 상세페이지를 위한 상품 하나 받아오기!
	@GetMapping("/itemDetail/{productCode}")
	public String selectOneItem(@PathVariable String productCode, Model model) {
		//상품 조회
		ProductEx product = productService.selectOneItem(productCode);
		log.debug("product 받아왔나요? : {}",product);
		model.addAttribute("product", product);
		
		//해당 상품 리뷰들 조회
		List<Review> reviewList = shopService.selectAllReview();
		int reviewTotal = shopService.countAllList();
		log.debug("리뷰 리스트 조회! : {}", reviewList);
		model.addAttribute("reviewList", reviewList);
		model.addAttribute("reviewTotal", reviewTotal);
		
		return "shop/itemDetail";
	}

	
	
	@GetMapping("/shopSearch.do")
	public void shopSearch() {}
	

	/* 나중에 삭제할 것
	 * @GetMapping("/itemDetail.do") public void itemDetail(Model model) {
	 * 
	 * List<Review> reviewList = shopService.selectAllReview(); int reviewTotal =
	 * shopService.countAllList(); log.debug("리뷰 리스트 조회! : {}", reviewList);
	 * model.addAttribute("reviewList", reviewList);
	 * model.addAttribute("reviewTotal", reviewTotal);
	 * 
	 * }
	 */
	
	
	//리뷰 삭제하기
	@GetMapping("/reviewDelete.do")
	public String reviewDelete(@RequestParam int reviewNo, RedirectAttributes redirectAttr) {
		log.debug("삭제할 리뷰의 아이디 : {}", reviewNo);
		
		int result = shopService.reviewDelete(reviewNo);
		
		String msg = (result>0)?"리뷰 삭제 성공" : "리뷰 등록 삭제";
		redirectAttr.addFlashAttribute("msg", msg);
		
		return "redirect:/shop/itemDetail.do";
	}
	
	
	// 리뷰 등록하기
	@PostMapping("/review.do")
	public String review (Review review, MultipartFile upFile, RedirectAttributes redirectAttr) throws IllegalStateException, IOException {
		log.debug("{}", review);
	
		String saveDirectory = application.getRealPath("/resources/upload/review");
		
		if(!upFile.isEmpty() && upFile.getSize()!= 0) {
			String originalFilename = upFile.getOriginalFilename();
			String renamedFilename = DevrunUtils.getRenamedFilename(originalFilename);
		
			//1.서버 컴퓨터에 저장
			File dest = new File(saveDirectory, renamedFilename);//여기에다가 파일 저장해주세요임.
			upFile.transferTo(dest);
			
			// 2.DB에 attachment 레코드 등록
			Attachment attach = new Attachment();
			attach.setOriginalFilename(originalFilename);
			attach.setRenamedFilename(renamedFilename);
			review.setAttach(attach);
		}
		
		//업무로직
		int result = shopService.insertReview(review);
		String msg = (result>0)?"리뷰 등록 성공" : "리뷰 등록 실패";
		redirectAttr.addFlashAttribute("msg", msg);
		
		return "redirect:/shop/itemDetail.do";
	}
	
	
	/**
	 * 혜진 작업 시작 
	 */
	@GetMapping("/promotion.do")
	public void promotion(Model model) {
		try {
			Map<String, List<Promotion>> map = promotionService.selectDevidedPromotionList();
			
			model.addAttribute("currentPromotionList", map.get("currentPromotionList"));
			model.addAttribute("endPromotionList", map.get("endPromotionList"));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@GetMapping("/promotionDetail/{promotionCode}")
	public String promotionDetail(
				@RequestParam(defaultValue = "1") int cPage,
				@PathVariable String promotionCode, 
				HttpServletRequest request,
				HttpServletResponse response,
				Model model) 
	{
		int limit = 12;
		int offset = (cPage - 1)*limit;
		
		try {
			boolean hasRead = DevrunUtils.hasRead(request, response, promotionCode, "promotion");
			
			if(!hasRead) {
				int result = promotionService.updateViewCount(promotionCode);
			}
			
			
			Promotion promotion = promotionService.selectPromotionByPromotionCode(promotionCode);
			List<Map<String, String>> productCategory = promotionService.selectProductPromotionByPromotionCode(promotionCode);
			
			Map<String, Object> param = new HashMap<>();
			param.put("promotionCode", promotionCode);
			
			//1. 전체 상품 목록
			List<Product> productList = promotionService.selectProductListByPromotionCode(param, offset, limit);
			model.addAttribute("promotion", promotion);
			model.addAttribute("productCategory", productCategory);
			model.addAttribute("productList", productList);
			log.debug("promotion = {}, productCategory = {}", promotion, productCategory);
			
			//2. 전체 게시물 수 totalContent
			int totalContent = promotionService.selectProductTotalCount(param);
			model.addAttribute("totalContent", totalContent);
			
			//3. pagebar
			String url = request.getRequestURI(); // /spring/board/boardList.do
			String pagebar = DevrunUtils.getPagebar(cPage, limit, totalContent, url);
			log.debug("pagebar = {}", pagebar);
			model.addAttribute("pagebar", pagebar);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "/shop/promotionDetail";
	}
	
	@GetMapping("/childCategorySearch.do")
	@ResponseBody
	public Map<String, Object> childCategorySearch(
			@RequestParam(defaultValue = "1") int cPage,
			@RequestParam(value="childCategoryCode[]", required = false) List<String> childCategoryCode, 
			@RequestParam(value="keyword", required = false) String keyword, 
			@RequestParam(value = "promotionCode") String promotionCode,
			HttpServletRequest request,
			HttpServletResponse response)
	{
		Map<String, Object> resultMap = new HashMap<>();

		int limit = 12;
		int offset = (cPage - 1)*limit;
		
		boolean hasRead = DevrunUtils.hasRead(request, response, promotionCode, "promotion");
		
		if(!hasRead) {
			int result = promotionService.updateViewCount(promotionCode);
		}
		log.debug("{}",keyword);
		Map<String, Object> param = new HashMap<>();
		param.put("promotionCode", promotionCode);
		param.put("childCategoryCode", childCategoryCode);
		param.put("keyword", keyword);
		log.debug("{}",param);
		
		//1. 전체 상품 목록
		String url = request.getContextPath(); 
		
		List<Product> productList = promotionService.selectProductListByPromotionCode(param, offset, limit);
		String productStr = DevrunUtils.getProductList(productList, url);
		
		//2. 전체 게시물 수 totalContent
		url = request.getRequestURI(); 
		int totalContent = promotionService.selectProductTotalCount(param);
		
		//3. pagebar
		String pagebar = DevrunUtils.getPagebar(cPage, limit, totalContent, url);
		log.debug("pagebar = {}", pagebar);
		
		resultMap.put("productStr", productStr);
		resultMap.put("totalContent", totalContent);
		resultMap.put("pagebar", pagebar);
		
		return resultMap;
	}
	
	/**
	 * 혜진 작업 끝
	 * @throws IOException 
	 * @throws IllegalStateException 
	 */

}

