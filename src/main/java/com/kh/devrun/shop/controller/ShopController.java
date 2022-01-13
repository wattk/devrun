package com.kh.devrun.shop.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
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
import com.kh.devrun.common.ShopUtils;
import com.kh.devrun.member.model.vo.Member;
import com.kh.devrun.order.model.service.OrderService;
import com.kh.devrun.product.model.service.ProductService;
import com.kh.devrun.product.model.vo.Product;
import com.kh.devrun.product.model.vo.ProductDetail;
import com.kh.devrun.product.model.vo.ProductEntity;
import com.kh.devrun.product.model.vo.ProductEx;
import com.kh.devrun.promotion.model.service.PromotionService;
import com.kh.devrun.promotion.model.vo.Promotion;
import com.kh.devrun.questionProductCus.model.service.CusQuestionProductService;
import com.kh.devrun.questionProductCus.model.vo.QuestionProductId;
import com.kh.devrun.report.model.service.ReportService;
import com.kh.devrun.report.model.vo.Report;
import com.kh.devrun.shop.model.service.ShopService;
import com.kh.devrun.shop.model.vo.Attachment;
import com.kh.devrun.shop.model.vo.Cart;
import com.kh.devrun.shop.model.vo.Review;
import com.kh.devrun.shop.model.vo.Wishlist;
import com.kh.devrun.shop.model.vo.WishlistProduct;

import lombok.extern.slf4j.Slf4j;
import net.nurigo.java_sdk.api.Message;

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
	private OrderService orderService;

	@Autowired
	ServletContext application;

	@Autowired
	ReportService reportService;

	@Autowired
	ShopUtils shopUtils;

	// SMS api 주입
	@Autowired
	Message message;

	// 태영
	@Autowired
	CusQuestionProductService cusQuestionProductService;
	
	
	
	
//--------------------주입-------------------------------------	

	// 검색페이지 정렬
	@ResponseBody
	@GetMapping("/shopSearchSort")
	public Map<String, Object> shopSearchSort(@RequestParam String searchKeyword, @RequestParam String keyword,
			HttpServletRequest request, @RequestParam int total, @RequestParam(defaultValue = "1") int cPage,
			Authentication authentication) {
		Member member = null;
		if (authentication != null) {
			member = (Member) authentication.getPrincipal();
		}

		int limit = 12;
		int offset = (cPage - 1) * limit;

		Map<String, Object> resultMap = new HashMap<>();

		// sort에 따른 리스트 불러오기
		Map<String, Object> param = new HashMap<>();
		param.put("keyword", keyword);
		param.put("searchKeyword", searchKeyword);

		List<ProductEntity> searchList = shopService.shopSearchSort(offset, limit, param);
		log.debug("sortItemList : {}", searchList);

		String url = request.getContextPath();

		String productStr = shopUtils.getProductList(searchList, member, url);
		resultMap.put("productStr", productStr);

		// 2. 전체 게시물 수 totalContent
		url = "/devrun/shop/shopSearch";

		url += "?searchKeyword=" + searchKeyword;

		if (keyword != null) {
			url += "&keyword=" + keyword;
		}

		// 3. pagebar
		String pagebar = DevrunUtils.getProductPagebar(cPage, limit, total, url);
		log.debug("pagebar = {}", pagebar);
		resultMap.put("pagebar", pagebar);

		return resultMap;

	}

	// 검색 페이지로 이동
	@GetMapping("/shopSearch")
	public String shopSearch(@RequestParam String searchKeyword, @RequestParam(defaultValue = "1") int cPage,
			Model model, HttpServletRequest request) {
		log.debug("searchKeyword : {}", searchKeyword);
		model.addAttribute("searchKeyword", searchKeyword);

		int limit = 12;
		int offset = (cPage - 1) * limit;

		List<ProductEntity> searchList = shopService.shopSearch(offset, limit, searchKeyword);
		log.debug("searchList : {}", searchList);
		model.addAttribute("searchList", searchList);

		// count
		int total = shopService.countShopSearch(searchKeyword);
		log.debug("total : {}", total);
		model.addAttribute("total", total);

		// 3. pagebar
		String url = request.getRequestURI(); // /spring/board/boardList.do
		if (searchKeyword != null) {
			url += "?searchKeyword=" + searchKeyword;
		}

		String pagebar = DevrunUtils.getPagebar(cPage, limit, total, url);
		log.debug("pagebar = {}", pagebar);
		model.addAttribute("pagebar", pagebar);

		// 인기상품10위
		List<ProductEntity> tenList = shopService.topTenItems();
		List<String> tenArr = new ArrayList<String>();

		for (ProductEntity p : tenList) {
			String productName = p.getName();
			if (productName.length() > 38) {
				productName = productName.substring(0, 37);
				log.debug("sub:{}", productName);
			}
			tenArr.add(productName);
			tenArr.add(p.getProductCode());
		}

		model.addAttribute("tenArr", tenArr);

		return "/shop/shopSearch";

	}

	// 소분류카테고리정렬
	@ResponseBody
	@GetMapping("/childCatePageSort")
	public Map<String, Object> childCatePageSort(@RequestParam String childCateCode, @RequestParam String keyword,
			HttpServletRequest request, @RequestParam int total, @RequestParam(defaultValue = "1") int cPage,
			Authentication authentication) {
		log.debug("keyword : {}", keyword);

		Member member = null;
		if (authentication != null) {
			member = (Member) authentication.getPrincipal();
		}

		int limit = 12;
		int offset = (cPage - 1) * limit;

		Map<String, Object> resultMap = new HashMap<>();

		// sort에 따른 리스트 불러오기
		Map<String, Object> param = new HashMap<>();
		param.put("keyword", keyword);
		param.put("childCateCode", childCateCode);

		List<ProductEntity> sortItemList = shopService.selectItemsByChildCateBySort(offset, limit, param);

		String url = request.getContextPath();
		String productStr = shopUtils.getProductList(sortItemList, member, url);

		resultMap.put("productStr", productStr);

		// 2. 전체 게시물 수 totalContent
		url = "/devrun/shop/childCatePageSort";

		url += "?childCategoryCode=" + childCateCode;

		if (keyword != null) {
			url += "&keyword=" + keyword;
		}

		// 3. pagebar
		String pagebar = DevrunUtils.getProductPagebar(cPage, limit, total, url);
		resultMap.put("pagebar", pagebar);

		return resultMap;
	}

	// 상세페이지를 이동 시
	@GetMapping("/itemDetail/{productCode}")
	public String selectOneItem(@PathVariable String productCode, Model model, Authentication authentication,
			HttpServletRequest request, HttpServletResponse response) {

		// 상품 조회
		ProductEx product = productService.selectOneItem(productCode);
		model.addAttribute("product", product);

		// 상품 옵션도 조회
		List<ProductDetail> pDetail = productService.selectProductDetail(productCode);
		model.addAttribute("pDetail", pDetail);

		// 소분류 카테고리 추출
		String childCate = productCode.substring(3, 6);

		Map<String, Object> param = new HashMap<>();
		param.put("childCate", childCate);
		param.put("productCode", productCode);

		// 소분류로 리스트 가져오기
		List<Product> recommendation = shopService.selectRecommendation(param);
		log.debug("recommendation 몇 개? :{}", recommendation);

		Collections.shuffle(recommendation);
		log.debug("recommendation 몇 개? :{}", recommendation);
		model.addAttribute("recommendation", recommendation);

		// 품절상품 정보
		List<ProductDetail> outOfStock = productService.selectOutOfStock(productCode);
		model.addAttribute("outOfStock", outOfStock);

		// 오늘본상품
		model.addAttribute("todayItemCode", productCode);

		// 장바구니 좋아요 여부
		if (authentication != null) {

			int memberNo = ((Member) authentication.getPrincipal()).getMemberNo();
			Map<String, Object> cartParam = new HashMap<>();
			cartParam.put("memberNo", memberNo);
			cartParam.put("productCode", productCode);

			List<Integer> cartValidList = productService.selectCartValidList(cartParam);
			String cartValid = "";
			for (int i : cartValidList) {
				cartValid += i + ",";
			}
			model.addAttribute("cartValid", cartValid);

		}

		// 조회수 처리 시작

		// 일단 쿠키 가져오기
		Cookie[] cookies = request.getCookies();

		// 읽음여부 확인(cookie)
		boolean hasRead = false;
		String productValue = "";

		if (cookies != null) {
			for (Cookie c : cookies) {
				String name = c.getName();
				String value = c.getValue();
				log.debug("쿠키 이름 : {}", name);
				log.debug("쿠키 값 : {}", value);

				if ("productCode".equals(name)) {
					productValue = value;

					if (value.contains("|" + productCode + "|")) {
						hasRead = true;
						log.debug("조회수를 증가시키지 않습니다.");
					}
					break;
				}
			}

		}

		// 기존 쿠키 없을 시 새 쿠키!
		if (!hasRead) {
			Cookie cookie = new Cookie("productCode", "|" + productCode + "|");
			cookie.setMaxAge(24 * 60 * 60);
			// 쿠키의 경로는 지정한 경로 포함 이하는 다 처리된다. '/' 경로 구분자이다.
			cookie.setPath(request.getContextPath() + "/shop/itemDetail");
			response.addCookie(cookie);

			// 조회수 증가
			log.debug("조회수를 1 증가시킵니다.");
			int result = shopService.updateViewCount(productCode);
			ProductEx product2 = productService.selectOneItem(productCode);
			log.debug("조회수 증가 후 조회수는 : {}", product2.getViewCount());
		}

		// 인기상품10위
		List<ProductEntity> tenList = shopService.topTenItems();
		List<String> tenArr = new ArrayList<String>();

		for (ProductEntity p : tenList) {
			String productName = p.getName();
			if (productName.length() > 38) {
				productName = productName.substring(0, 37);
				log.debug("sub:{}", productName);
			}
			tenArr.add(productName);
			tenArr.add(p.getProductCode());
		}

		model.addAttribute("tenArr", tenArr);

		
		
	// 태영 코드 ======================================================================================
		Member loginMember = null;
		String loginMemberId = null;
		String authority = null;
		if(authentication != null){
			loginMember = (Member)authentication.getPrincipal();
			loginMemberId = loginMember.getId();
			log.debug("loginMemberId = {}",loginMemberId);				
			authority = loginMember.getAuthorities().toString();
			log.debug("로그인 회원의 권한 = {}",authority);
		}
			

		// 해당 상품의 문의 내역 조회 
		List<QuestionProductId>questionList = shopService.selectQuestionList(productCode); 
		log.debug("questionList = {}",questionList);
		
		model.addAttribute("loginMemberId",loginMemberId);
		model.addAttribute("authority",authority);
		model.addAttribute("productCode",productCode);
		model.addAttribute("questionList",questionList);
		
		// 태영 코드 ==================================================================================================
		

		
		return "shop/itemDetail";
	}

	//  상품 문의 등록
	@PostMapping("/shop/insertQuestionProduct.do")
	public String insertQuestionProduct(
				@RequestParam String productCode,
				@RequestParam String title,
				@RequestParam String content,
				@RequestParam String privateYn,
				RedirectAttributes redirectAttr,
				Authentication authentication
			) {
		Map<String,Object>param = new HashMap<>();
		
		char cprivateYn = privateYn.charAt(0);
		// 회원 번호는 현재 로그인중인 사용자의 member_no
		Member member = (Member)authentication.getPrincipal();
		log.debug("member = {}",member);
		
		// 질문이므로 레벨은 무조건 1
		param.put("questionLevel",1);
		param.put("questionRefNo",null);
		param.put("productCode", productCode);
		param.put("memberNo", member.getMemberNo());
		param.put("title", title);
		param.put("content", content);
		param.put("privateYn", cprivateYn);
		
		log.debug("param = {}",param);
		
		int result = cusQuestionProductService.insertQuestionProduct(param);		
		
		
		redirectAttr.addFlashAttribute("msg","상품 문의 등록 완료!");
		return "redirect:/shop/itemDetail/"+productCode;
	}
	
	

	// 헤더에서 Shop 눌렀을 시
	@GetMapping("/shopMain.do")
	public String shopMain(Model model) {

		// 베스트리뷰
		List<Review> reviewList = shopService.topFourReview();
		model.addAttribute("reviewList", reviewList);

		// 인기상품10위
		List<ProductEntity> tenList = shopService.topTenItems();
		List<String> tenArr = new ArrayList<String>();

		for (ProductEntity p : tenList) {
			String productName = p.getName();
			if (productName.length() > 38) {
				productName = productName.substring(0, 37);
				log.debug("sub:{}", productName);
			}
			tenArr.add(productName);
			tenArr.add(p.getProductCode());
		}
		model.addAttribute("tenArr", tenArr);

		try {
			// 카테고리별 상품 12개씩 조회(신상품, top12, 만원의 행복)
			List<ProductEntity> latestProductList = productService.selectLatestProductList();
			List<ProductEntity> top12ProductList = productService.selectTop12ProductList();
			List<ProductEntity> tenThousandWonProductList = productService.selectTenThousandWonProductList();

			model.addAttribute("latestProductList", latestProductList);
			model.addAttribute("top12ProductList", top12ProductList);
			model.addAttribute("tenThousandWonProductList", tenThousandWonProductList);

			// 이벤트 상품 조회
			List<Promotion> currentPromotion = promotionService.selectThreeCurrentPromotion();
			model.addAttribute("currentPromotion", currentPromotion);

			Promotion currentPromotion1 = currentPromotion.get(0);
			Promotion currentPromotion2 = currentPromotion.get(1);
			Promotion currentPromotion3 = currentPromotion.get(2);
			String promotionCode1 = currentPromotion1.getPromotionCode();
			String promotionCode2 = currentPromotion2.getPromotionCode();
			String promotionCode3 = currentPromotion3.getPromotionCode();

			List<ProductEntity> promotionProductList1 = promotionService.selectPromotionProductList1(promotionCode1);
			List<ProductEntity> promotionProductList2 = promotionService.selectPromotionProductList2(promotionCode2);
			List<ProductEntity> promotionProductList3 = promotionService.selectPromotionProductList3(promotionCode3);
			model.addAttribute("promotionProductList1", promotionProductList1);
			model.addAttribute("promotionProductList2", promotionProductList2);
			model.addAttribute("promotionProductList3", promotionProductList3);

			log.debug("promotionProductList1 = {}", promotionProductList1);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return "shop/shopMain";
	}

	@GetMapping("wishlist")
	public String wishlist(Authentication authentication, Model model) {

		Member loginMember = (Member) authentication.getPrincipal();
		int memberNo = loginMember.getMemberNo();

		// 위시리스트 조회해오기
		List<WishlistProduct> wishlist = shopService.selectAllWishlist(memberNo);

		model.addAttribute("wishlist", wishlist);
		model.addAttribute("loginMember", loginMember);
		return "shop/wishlist";
	}

	// 상품 사이드 메뉴에서 전체보기 클릭 시
	@GetMapping("/categoryItemAll")
	public String categoryItemAll(@RequestParam String parentCate, Model model,
			@RequestParam(defaultValue = "1") int cPage, HttpServletRequest request) {

		// 소분류 카테고리 이름 불러오기
		// List<String> ChildCateNames =
		// shopService.selectAllChildCateNames(parentCate);
		List<Map<String, String>> childCategoryList = shopService.selectAllChildCateNames(parentCate);
		model.addAttribute("parentCategory", parentCate);
		model.addAttribute("childCategoryList", childCategoryList);

		// 페이징 처리
		log.debug("cPage : {} ", cPage);
		int limit = 12;
		int offset = (cPage - 1) * limit;

		List<ProductEx> itemList = shopService.CategoryItemAll(offset, limit, parentCate);
		model.addAttribute("itemList", itemList);

		// 갯수세기
		int total = shopService.countItemsByParentCode(parentCate);
		model.addAttribute("total", total);

		// 3.pagebar
		String url = request.getRequestURI();
		String pagebar = shopUtils.getPagebar(cPage, limit, total, url);
		model.addAttribute("pagebar", pagebar);

		// 인기상품10위
		List<ProductEntity> tenList = shopService.topTenItems();
		List<String> tenArr = new ArrayList<String>();

		for (ProductEntity p : tenList) {
			String productName = p.getName();
			if (productName.length() > 38) {
				productName = productName.substring(0, 37);
				log.debug("sub:{}", productName);
			}
			tenArr.add(productName);
			tenArr.add(p.getProductCode());
		}
		model.addAttribute("parentCategoryCode", parentCate);
		model.addAttribute("tenArr", tenArr);

		return "shop/shopCategory";
	}

	// 상품 사이드 메뉴에서 소분류 카테고리 클릭 시
	@GetMapping("shopChildCate")
	public String shopChildCate(@RequestParam String childCategoryCode, Model model, Authentication authentication) {

		String thisCateName = shopService.thisCateName(childCategoryCode);
		model.addAttribute("thisCateName", thisCateName);
		model.addAttribute("childCategoryCode", childCategoryCode);

		// 소분류 카테고리 이름 불러오기
		/*
		 * String parentCate = childCategoryCode.substring(1); List<String>
		 * ChildCateNames = shopService.selectAllChildCateNames(parentCate);
		 * log.debug("ChildCateNames : {}", ChildCateNames);
		 * model.addAttribute("ChildCateNames", ChildCateNames);
		 */

		// 갯수세기
		int total = shopService.countItemsByChildCode(childCategoryCode);
		model.addAttribute("total", total);

		// 인기상품10위
		List<ProductEntity> tenList = shopService.topTenItems();
		List<String> tenArr = new ArrayList<String>();

		for (ProductEntity p : tenList) {
			String productName = p.getName();
			if (productName.length() > 38) {
				productName = productName.substring(0, 37);
				log.debug("sub:{}", productName);
			}
			tenArr.add(productName);
			tenArr.add(p.getProductCode());
		}

		model.addAttribute("tenArr", tenArr);

		return "shop/shopChildCate";
	}

	// 사진 리뷰만 모아보기 기능
	@ResponseBody
	@GetMapping("picReviewOnly")
	public Map<String, Object> picReviewOnly(@RequestParam String productCode, Authentication authentication,
			HttpServletRequest request) {
		String reviewSb = null;
		Member member = null;

		// getReivew 메소드 인자들
		String url = request.getContextPath();
		if (authentication != null) {
			member = (Member) authentication.getPrincipal();
		}
		List<Review> picReviewList = shopService.picReviewOnly(productCode);

		reviewSb = shopUtils.getReview(picReviewList, member, url);

		int reviewTotal = shopService.countPicReviewList(productCode);
		Map<String, Object> map = new HashMap<>();
		map.put("reviewTotal", reviewTotal);
		map.put("reviewSb", reviewSb);

		return map;
	}

	// 리뷰 전체조회
	@ResponseBody
	@GetMapping("/review")
	public Map<String, Object> review(@RequestParam String productCode, @RequestParam int orderBy,
			Authentication authentication, HttpServletRequest request) {
		// 이게 -1일때 desc 줘야 함 (최신순보기)
		log.debug("orderBy 값 체크: {}", orderBy);
		String reviewSb = null;
		Member member = null;
		int memberNo = -1;

		// getReivew 메소드 인자들
		String url = request.getContextPath();
		if (authentication != null) {
			member = (Member) authentication.getPrincipal();
		}

		Map<String, Object> param = new HashMap<>();
		param.put("productCode", productCode);
		param.put("orderBy", orderBy);

		List<Review> reviewList = shopService.selectAllReview(param);

		reviewSb = shopUtils.getReview(reviewList, member, url);

		int reviewTotal = shopService.countAllList(productCode);
		Map<String, Object> map = new HashMap<>();
		map.put("reviewTotal", reviewTotal);
		map.put("reviewSb", reviewSb);

		// 위시리스트 체크
		int wishCheckYn = 0;
		if (authentication != null) {
			memberNo = member.getMemberNo();
		}
		Map<String, Object> param2 = new HashMap<>();
		param2.put("productCode", productCode);
		param2.put("memberNo", memberNo);

		wishCheckYn = shopService.didIHitWishlist(param2);
		map.put("wishCheckYn", wishCheckYn);

		return map;
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

	// 리뷰 신고 등록
	@PostMapping("/insertReport")
	public String insertReport(Report report, RedirectAttributes redirectAttr, HttpServletRequest request) {

		int result = reportService.insertReport(report);
		log.debug("신고가 잘 등록? : {}", result);

		String msg = (result > 0) ? "신고 등록 성공" : "신고 등록 실패";
		redirectAttr.addFlashAttribute("msg", msg);

		String referer = request.getHeader("Referer");
		return "redirect:" + referer;
	}

	// 리뷰 좋아요 추가
	@ResponseBody
	@GetMapping("/reviewLikeAdd")
	public Map<String, Object> reviewLikeAdd(@RequestParam int reviewNo, @RequestParam int memberNo,
			@RequestParam String productCode) {

		Map<String, Object> param = new HashMap<>();
		param.put("reviewNo", reviewNo);
		param.put("memberNo", memberNo);
		param.put("productCode", productCode);

		int result = shopService.reviewLikeAdd(param);
		log.debug("리뷰 좋아요 잘 추가? : {}", result);

		// 좋아요 추가하고 새로 추가된 좋아요 갯수 받아오기
		int newCountLikes = shopService.refreshCountLikes(reviewNo);

		Map<String, Object> map = new HashMap<>();
		map.put("result", result);
		map.put("newCountLikes", newCountLikes);

		return map;
	}

	// 리뷰 좋아요 삭제
	@ResponseBody
	@GetMapping("/reviewLikeDelete")
	public Map<String, Object> reviewLikeDelete(@RequestParam int reviewNo, @RequestParam int memberNo,
			@RequestParam String productCode) {

		Map<String, Object> param = new HashMap<>();
		param.put("reviewNo", reviewNo);
		param.put("memberNo", memberNo);
		param.put("productCode", productCode);

		int result = shopService.reviewLikeDelete(param);
		log.debug("리뷰 좋아요 잘 삭제? : {}", result);

		// 좋아요 삭제하고 새로 추가된 좋아요 갯수 받아오기
		int newCountLikes = shopService.refreshCountLikes(reviewNo);

		Map<String, Object> map = new HashMap<>();
		map.put("result", result);
		map.put("newCountLikes", newCountLikes);

		return map;
	}

	// 위시리스트 추가
	@ResponseBody
	@GetMapping("/wishlistAdd")
	public int wishlistAdd(Wishlist wishlist, @RequestParam int memberNo) {
		int result = shopService.wishlistAdd(wishlist, memberNo);
		log.debug("위시리스트 잘 추가? : {}", result);
		return result;
	}

	// 위시리스트 삭제
	@ResponseBody
	@GetMapping("/wishlistDelete")
	public int wishlistDelete(@RequestParam String productCode, @RequestParam int memberNo) {

		Map<String, Object> param = new HashMap<>();
		param.put("productCode", productCode);
		param.put("memberNo", memberNo);

		int result = shopService.wishlistDelete(param);
		log.debug("위시리스트 잘 삭제? : {}", result);

		return result;
	}

	// SMS api 핸들러
	@ResponseBody
	@PostMapping("/restock")
	public int sms(@RequestParam String phoneNumber, @RequestParam int detailNo, @RequestParam String productName,
			@RequestParam String productCode, Authentication authentication) {
		int result = 0;
		String memberName = null;
		int memberNo = -1;
		String id = "nonMember";

		if (authentication != null) {
			Member member = (Member) authentication.getPrincipal();
			memberName = member.getName();
			memberNo = member.getMemberNo();
			id = member.getId();
		}

		// 메세지를 위한 디테일 불러오기
		ProductDetail pDetail = shopService.selectOneProductDetail(detailNo);

		String option1 = pDetail.getOptionNo();
		String option2 = pDetail.getOptionContent();

		StringBuilder sb = new StringBuilder();
		sb.append(option1);
		if (option2 != null) {
			sb.append(", ");
			sb.append(option2);
		}

		log.debug("옵션 정보는? : {}", sb.toString());

		StringBuilder smsContent = new StringBuilder();
		smsContent.append(System.lineSeparator() + "(DevRun 알림)" + System.lineSeparator() + System.lineSeparator());
		if (memberName != null) {
			smsContent.append(memberName + " ");
		}
		smsContent.append("고객님 <" + productName + "> 상품의 <" + sb.toString() + "> 옵션의 재입고 시 문자로 알려드리겠습니다."
				+ System.lineSeparator() + System.lineSeparator() + "쇼핑몰을 이용해주셔서 감사합니다.");

		// 문자 내용 확인해보기
		log.debug("-----------------------------------------------------------");
		log.debug(smsContent.toString());
		log.debug("-----------------------------------------------------------");

		// 주석 풀지 말 것 - 문자 제한 때문에 주석 처리 해놓음 - 다현 -
		HashMap<String, String> params = new HashMap<String, String>();
//		params.put("to", phoneNumber);
//		params.put("from", "01074003717");
//		params.put("type", "LMS");
//		params.put("text", smsContent.toString());
//		params.put("app_version", "test app 1.2"); // application name and version
//
//		try {
//			JSONObject obj = (JSONObject) message.send(params);
//			System.out.println(obj.toString());
//			result = 1;
//		} catch (CoolsmsException e) {
//			System.out.println(e.getMessage());
//			System.out.println(e.getCode());
//		}

		result = 1;
		// 대기목록테이블에 insert
		if (result > 0) {
			Map<String, Object> param = new HashMap<>();
			param.put("memberNo", memberNo);
			param.put("id", id);
			param.put("productCode", productCode);
			param.put("detailNo", detailNo);
			param.put("phone", phoneNumber);
			int insertYn = shopService.insertSmsWatinglist(param);
			log.debug("waitinglist 잘 insert? : {}", insertYn);
		}

		return 1;
	}

//----------------------------------------------------------구분선---------------------------------------------------------------

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

		// 인기상품10위
		List<ProductEntity> tenList = shopService.topTenItems();
		List<String> tenArr = new ArrayList<String>();

		for (ProductEntity p : tenList) {
			String productName = p.getName();
			if (productName.length() > 38) {
				productName = productName.substring(0, 37);
				log.debug("sub:{}", productName);
			}
			tenArr.add(productName);
			tenArr.add(p.getProductCode());
		}

		model.addAttribute("tenArr", tenArr);

		return "/shop/promotionDetail";
	}

	@GetMapping("/childCategorySearchFromPromotion.do")
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
		if (keyword != null) {
			url += "&keyword=" + keyword;
		}

		if (childCategoryCode != null && !childCategoryCode.isEmpty()) {
			for (String code : childCategoryCode) {
				url += "&childCategoryCode=" + code;
			}
		}

		int totalContent = promotionService.selectProductTotalCount(param);
		log.debug("url = {}", url);
		// 3. pagebar
		String pagebar = DevrunUtils.getProductPagebar(cPage, limit, totalContent, url);
		log.debug("pagebar = {}", pagebar);

		resultMap.put("productStr", productStr);
		resultMap.put("totalContent", totalContent);
		resultMap.put("pagebar", pagebar);

		return resultMap;
	}

	/* 장바구니 추가 */
	@PostMapping("/cartEnroll")
	@ResponseBody
	public int cartEnroll(Cart cart) {
		log.debug("cart = {}", cart);

		int result = shopService.insertCart(cart);
		log.debug("result = {}", result);

		return result;
	}

	@PostMapping("/cartDelete")
	@ResponseBody
	public List<Cart> cartDelete(@RequestParam(value = "cartNoArr[]") List<Integer> cartNoArr,
			Authentication authentication) {
		log.debug("cartNoArr = {}", cartNoArr);
		int result = shopService.deleteCart(cartNoArr);
		List<Cart> list = new ArrayList<>();

		if (result > 0) {
			Member member = (Member) authentication.getPrincipal();
			list = orderService.selectCartList(member.getMemberNo());
		}

		return list;
	}

	@GetMapping("/childCategorySearch.do")
	@ResponseBody
	public Map<String, Object> childCategorySearch(@RequestParam(defaultValue = "1") int cPage,
			@RequestParam(value = "parentCategoryCode") String parentCategoryCode,
			@RequestParam(value = "childCategoryCode[]", required = false) List<String> childCategoryCode,
			@RequestParam(value = "keyword", required = false) String keyword, HttpServletRequest request,
			HttpServletResponse response, Authentication authentication) {
		Member member = null;
		if (authentication != null) {
			member = (Member) authentication.getPrincipal();
		}

		Map<String, Object> resultMap = new HashMap<>();
		log.debug("cPage = {}", cPage);

		int limit = 12;
		int offset = (cPage - 1) * limit;

		log.debug("{}", keyword);
		Map<String, Object> param = new HashMap<>();
		param.put("parentCategoryCode", parentCategoryCode);
		param.put("childCategoryCode", childCategoryCode);
		param.put("keyword", keyword);
		log.debug("{}", param);

		// 1. 전체 상품 목록
		String url = request.getContextPath();

		List<ProductEntity> productList = shopService.selectProductListByChildCategory(param, offset, limit);
		String productStr = shopUtils.getProductList(productList, member, url);

		// 2. 전체 게시물 수 totalContent
//		url = request.getRequestURI();
		url = "/devrun/shop/childCategorySearch.do";

		url += "?parentCategoryCode=" + parentCategoryCode;

		if (keyword != null) {
			url += "&keyword=" + keyword;
		}

		if (childCategoryCode != null && !childCategoryCode.isEmpty()) {
			for (String code : childCategoryCode) {
				url += "&childCategoryCode=" + code;
			}
		}

		int totalContent = shopService.selectProductTotalCount(param);
		log.debug("url = {}", url);
		// 3. pagebar
		String pagebar = DevrunUtils.getProductPagebar(cPage, limit, totalContent, url);
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
