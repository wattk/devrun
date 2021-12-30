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
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.devrun.common.DevrunUtils;
import com.kh.devrun.member.model.vo.Member;
import com.kh.devrun.product.model.service.ProductService;
import com.kh.devrun.product.model.vo.ProductEntity;
import com.kh.devrun.product.model.vo.ProductDetail;
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

	// 헤더에서 Shop 눌렀을 시
	@GetMapping("/shopMain.do")
	public void shopMain() {
	}

	// 검색 페이지로 이동
	@GetMapping("/shopSearch.do")
	public void shopSearch() {
	}

	// 상품 사이드 메뉴에서 전체보기 클릭 시
	@GetMapping("/categoryItemAll")
	public String categoryItemAll(@RequestParam String parentCate, Model model) {

		List<ProductEntity> itemList = shopService.CategoryItemAll(parentCate);
		model.addAttribute("itemList", itemList);

		return "shop/shopCategory";
	}

	// 사진 리뷰만 모아보기 기능
	@ResponseBody
	@GetMapping("picReviewOnly")
	public Map<String, Object> picReviewOnly(@RequestParam String productCode, Authentication authentication,
			HttpServletRequest request) {
		String reviewSb = null;
		Member member = null;

		//getReivew 메소드 인자들
		String url = request.getContextPath();
		if(authentication != null) {
			member = (Member) authentication.getPrincipal();			
		}
		List<Review> picReviewList = shopService.picReviewOnly(productCode);

			reviewSb = DevrunUtils.getReview(picReviewList, member, url);
			
		int reviewTotal = shopService.countPicReviewList(productCode);
		Map<String, Object> map = new HashMap<>();
		map.put("reviewTotal", reviewTotal);
		map.put("reviewSb", reviewSb);

		return map;
	}

	// 리뷰 전체조회
	@ResponseBody
	@GetMapping("/review")
	public Map<String, Object> review(@RequestParam String productCode,@RequestParam int orderBy, Authentication authentication,
			HttpServletRequest request) {
		// 이게 -1일때 desc 줘야 함 (최신순보기) 
		log.debug("orderBy 값 체크: {}", orderBy);
		String reviewSb = null;
		Member member = null;
		
		//getReivew 메소드 인자들
		String url = request.getContextPath();
		if(authentication != null) {
			member = (Member) authentication.getPrincipal();			
		}
		
		Map<String,Object>param = new HashMap<>();
		param.put("productCode", productCode);
		param.put("orderBy", orderBy);
		
		List<Review> reviewList = shopService.selectAllReview(param);

			reviewSb = DevrunUtils.getReview(reviewList, member, url);

		int reviewTotal = shopService.countAllList(productCode);
		Map<String, Object> map = new HashMap<>();
		map.put("reviewTotal", reviewTotal);
		map.put("reviewSb", reviewSb);

		return map;
	}

	// 상세페이지를 위한 상품 하나 받아오기!
	@GetMapping("/itemDetail/{productCode}")
	public String selectOneItem(@PathVariable String productCode, Model model) {
		// 상품 조회
		ProductEx product = productService.selectOneItem(productCode);
		log.debug("product 받아왔나요? : {}", product);
		model.addAttribute("product", product);

		// 옵션도 조회
		List<ProductDetail> pDetail = productService.selectProductDetail(productCode);
		model.addAttribute("pDetail", pDetail);

		return "shop/itemDetail";
	}

	// 리뷰 삭제하기
	@GetMapping("/reviewDelete.do")
	public String reviewDelete(@RequestParam int reviewNo, HttpServletRequest request) {

		// 서버에서 파일 삭제 위한 review 객체 가져오기
		Attachment attach = shopService.selectOneAttach(reviewNo);

		if (attach != null) {
			String reanmedFilename = attach.getRenamedFilename();
			String path = application.getRealPath("/resources/upload/review/" + reanmedFilename);
			// 서버에서 파일 삭제
			File file = new File(path);
			if (file.exists() == true) {
				log.debug("{} 해당 파일 서버에서 삭제합니다.", path);
				file.delete();
			}
		}

		int result = shopService.reviewDelete(reviewNo);

		String referer = request.getHeader("Referer");
		return "redirect:" + referer;
	}

	// 리뷰 등록하기
	@PostMapping("/insertReview")
	public String review(Review review, MultipartFile upFile, RedirectAttributes redirectAttr,
			HttpServletRequest request) throws IllegalStateException, IOException {
		log.debug("리뷰를 봅시다. : {}", review);

		String saveDirectory = application.getRealPath("/resources/upload/review");

		if (!upFile.isEmpty() && upFile.getSize() != 0) {
			String originalFilename = upFile.getOriginalFilename();
			String renamedFilename = DevrunUtils.getRenamedFilename(originalFilename);

			// 1.서버 컴퓨터에 저장
			File dest = new File(saveDirectory, renamedFilename);// 여기에다가 파일 저장해주세요임.
			upFile.transferTo(dest);

			// 2.DB에 attachment 레코드 등록
			Attachment attach = new Attachment();
			attach.setOriginalFilename(originalFilename);
			attach.setRenamedFilename(renamedFilename);
			review.setAttach(attach);
		}

		// 업무로직
		int result = shopService.insertReview(review);
//		String msg = (result > 0) ? "리뷰 등록 성공" : "리뷰 등록 실패";
//		redirectAttr.addFlashAttribute("msg", msg);

		String referer = request.getHeader("Referer");
		return "redirect:" + referer;
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
	public String promotionDetail(@RequestParam(defaultValue = "1") int cPage, @PathVariable String promotionCode,
			HttpServletRequest request, HttpServletResponse response, Model model) {
		int limit = 12;
		int offset = (cPage - 1) * limit;

		try {
			boolean hasRead = DevrunUtils.hasRead(request, response, promotionCode, "promotion");

			if (!hasRead) {
				int result = promotionService.updateViewCount(promotionCode);
			}

			Promotion promotion = promotionService.selectPromotionByPromotionCode(promotionCode);
			List<Map<String, String>> productCategory = promotionService
					.selectProductPromotionByPromotionCode(promotionCode);

			Map<String, Object> param = new HashMap<>();
			param.put("promotionCode", promotionCode);

			// 1. 전체 상품 목록
			List<ProductEntity> productList = promotionService.selectProductListByPromotionCode(param, offset, limit);
			model.addAttribute("promotion", promotion);
			model.addAttribute("productCategory", productCategory);
			model.addAttribute("productList", productList);
			log.debug("promotion = {}, productCategory = {}", promotion, productCategory);

			// 2. 전체 게시물 수 totalContent
			int totalContent = promotionService.selectProductTotalCount(param);
			model.addAttribute("totalContent", totalContent);

			// 3. pagebar
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
	public Map<String, Object> childCategorySearch(@RequestParam(defaultValue = "1") int cPage,
			@RequestParam(value = "childCategoryCode[]", required = false) List<String> childCategoryCode,
			@RequestParam(value = "keyword", required = false) String keyword,
			@RequestParam(value = "promotionCode") String promotionCode, HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, Object> resultMap = new HashMap<>();

		int limit = 12;
		int offset = (cPage - 1) * limit;

		boolean hasRead = DevrunUtils.hasRead(request, response, promotionCode, "promotion");

		if (!hasRead) {
			int result = promotionService.updateViewCount(promotionCode);
		}
		log.debug("{}", keyword);
		Map<String, Object> param = new HashMap<>();
		param.put("promotionCode", promotionCode);
		param.put("childCategoryCode", childCategoryCode);
		param.put("keyword", keyword);
		log.debug("{}", param);

		// 1. 전체 상품 목록
		String url = request.getContextPath();

		List<ProductEntity> productList = promotionService.selectProductListByPromotionCode(param, offset, limit);
		String productStr = DevrunUtils.getProductList(productList, url);

		// 2. 전체 게시물 수 totalContent
		url = request.getRequestURI();
		int totalContent = promotionService.selectProductTotalCount(param);

		// 3. pagebar
		String pagebar = DevrunUtils.getPagebar(cPage, limit, totalContent, url);
		log.debug("pagebar = {}", pagebar);

		resultMap.put("productStr", productStr);
		resultMap.put("totalContent", totalContent);
		resultMap.put("pagebar", pagebar);

		return resultMap;
	}

	/**
	 * 혜진 작업 끝
	 * 
	 * @throws IOException
	 * @throws IllegalStateException
	 */

}
