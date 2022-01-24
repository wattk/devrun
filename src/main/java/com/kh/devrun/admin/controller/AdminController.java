package com.kh.devrun.admin.controller;

import java.beans.PropertyEditor;
import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.ArrayUtils;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.kh.devrun.category.model.service.ProductCategoryService;
import com.kh.devrun.category.model.vo.ProductChildCategory;
import com.kh.devrun.category.model.vo.ProductParentCategory;
import com.kh.devrun.chart.model.service.ChartService;
import com.kh.devrun.common.AdminUtils;
import com.kh.devrun.common.DevrunUtils;
import com.kh.devrun.member.model.vo.Member;
import com.kh.devrun.memberManage.model.service.MemberManageService;
import com.kh.devrun.order.model.service.OrderService;
import com.kh.devrun.order.model.vo.Merchant;
import com.kh.devrun.order.model.vo.OrderLog;
import com.kh.devrun.order.model.vo.Shipment;
import com.kh.devrun.product.model.service.ProductService;
import com.kh.devrun.product.model.vo.ProductDetail;
import com.kh.devrun.product.model.vo.ProductEntity;
import com.kh.devrun.product.model.vo.ProductEx;
import com.kh.devrun.promotion.model.service.PromotionService;
import com.kh.devrun.promotion.model.vo.Promotion;
import com.kh.devrun.questionProduct.model.service.QuestionProductService;
import com.kh.devrun.questionProduct.model.vo.QuestionProduct;
import com.kh.devrun.questionProduct.model.vo.QuestionProductEx;
import com.kh.devrun.questionProduct.utils.QuestionProductUtils;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	ProductService productService;
	
	@Autowired
	PromotionService promotionService;
	
	@Autowired
	OrderService orderService;
	
	@Autowired
	ServletContext application;
	
	@Autowired
	MemberManageService memberManageService;
	
	@Autowired
	QuestionProductService questionProductService;
	
	@Autowired
	ProductCategoryService productCategoryService;
	
	@Autowired
	ChartService chartService;
	

	@GetMapping("/adminMain.do")
	public void adminMain(Model model) {
		
		//매출 cnt값 가져오기
		Map<String, Integer> cntList = chartService.findMainCnt();
		log.debug("cntList={}", cntList);
		
		model.addAttribute("cntList", cntList);
	}

	
	@GetMapping("/product/productMain.do")
	public String productManage(
			Model model,
			@RequestParam(defaultValue = "1") int cPage,
			HttpServletRequest request
			) {
		
		// 1.페이징 처리 : 페이지 설정
		int limit = 10;
		int offset = (cPage - 1) * limit;
		
		// 게시물 리스트 가져오기
		List<ProductEntity> list = productService.selectAllProductList(offset,limit);
		log.debug("list = {}" ,list);	
		model.addAttribute("list",list);
		
		// 2. 전체게시물수 totalContent
		int totalContent = productService.selectTotalBoardCount();	
		log.debug("totalContent = {}", totalContent);
		model.addAttribute("totalContent", totalContent);
		
		// 3. pagebar
		String url = request.getRequestURI(); // /spring/board/boardList.do
		String pagebar = DevrunUtils.getPagebar(cPage, limit, totalContent, url);
		log.debug("pagebar = {}", pagebar);
		model.addAttribute("pagebar", pagebar);
		
		return "/admin/product/productMain";
	}
	
	// 상품 검색 결과 처리 && 페이징
	@ResponseBody
	@GetMapping("/product/searchProduct.do")
	public Map<String,Object> searchProduct(
				@RequestParam String searchType,
				@RequestParam String searchKeyword,
				@RequestParam(required = false) String startDate,
				@RequestParam(required = false) String endDate,
				@RequestParam(defaultValue = "1") int cPage,
				HttpServletRequest request
			) {
		// 검색 타입이 없을 때 searchType에 all 대입하여 오류 방
		if(searchType == "" || searchType == null) {
			searchType = "all";
		}
		
		log.debug("searchType = {}",searchType);
		log.debug("searchKeyword ={}",searchKeyword);
		log.debug("시작날짜 = {}",startDate);
		log.debug("종료날짜 = {}",endDate);
		
		// jsp에서 날짜 초기화 undefind가 아닌 공백이 들어갈 경우 mapper에서 오류가 나 공백을 경우 null을 대입 
		if(startDate == "" || startDate == "") {
			startDate = null;
			endDate = null;
		}

	
		Map<String,Object> map = new HashMap<>();

		int limit = 10;
		int offset = (cPage - 1) * limit;
		

		Map<String,Object>param = new HashMap<>();
		
		
		
		param.put("limit",limit);
		param.put("offset",offset);
		param.put("startDate",startDate);
		param.put("endDate",endDate);		
		param.put("searchType",searchType);
		param.put("searchKeyword", searchKeyword);
		
		
		// 1.조회한 리스트 가져오기
		String url = request.getRequestURI()+"?searchType="+searchType+"&searchKeyword="+searchKeyword;
		
		List<ProductEntity>productList = productService.searchProductList(param);
		String productStr = DevrunUtils.getProductListByAdmin(productList,request);
		
		// 2.조회한 게시물 수

		int totalContent = productService.searchProductListCount(param);
		
		// 3.페이지 바

		log.debug("pagebarUrl = {}",url);
		String pagebar = DevrunUtils.getPagebar2(cPage, limit, totalContent, url);
		log.debug("pagebar = {}", pagebar);
				
	
		map.put("productList",productList);
		map.put("totalContent",totalContent);
		map.put("pagebar",pagebar);
		map.put("productStr",productStr);

		
		return map;
	}
	
	
	@ResponseBody
	@GetMapping("/selectCategory")
	public Map<String, Object>selectCategory(@RequestParam Map<String, Object> param){
		Map<String, Object> map = new HashMap<>();
		
		log.debug("param = {}", param);
		List<ProductChildCategory> list = productService.selectChildCategory(param);
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
			ProductEntity product,
			@RequestParam(value = "parentCategoryCode") String parentCategoryCode,
			@RequestParam(value = "childCategoryCode")  String childCategoryCode,
			@RequestParam(value = "optionContent")  String[]optionContent,
			@RequestParam(value = "sku")  String sku,
			@RequestParam(value = "quantity")  int[]quantity,
			@RequestParam(value = "option")  String[]option,
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
		
		
		// 대분류코드 + 소분류코드로 상품코드를 만둘어준 뒤 pruduct에 set
		String productCode = parentCategoryCode+"-"+childCategoryCode;
		product.setProductCode(productCode);
		
		// 상품상세 객체로 묶어 전달		
		List<ProductDetail> productDetailList = new ArrayList<>();
		
		for(int i = 0; i < option.length; i++) {
			ProductDetail productDetail = new ProductDetail();
			
			productDetail.setOptionNo(option[i]);
			if(!ArrayUtils.isEmpty(optionContent)) {
				productDetail.setOptionContent(optionContent[i]);
			}
			productDetail.setSku(sku);
			productDetail.setQuantity(quantity[i]);
			
			productDetailList.add(productDetail);
		}
		
		// Map<String,Object>param에 담아서 전달
		Map<String,Object>param = new HashMap<>();
		param.put("productCode", productCode);
		param.put("childCategoryCode", childCategoryCode);
		param.put("productDetailList", productDetailList);
		param.put("product", product);
		
		log.debug("param = {}",param);
				
		
		log.debug("upFile = {}",upFile);
		String productImg = product.getProductCode();
		log.debug("productImg = {}",productImg);
				
			
		// 상품 등록
		int result = productService.insertProduct(param);
				
		// nextval 번호까지 붙은 thumbnail 값 가져오기 (최근 등록된)
		String realProductImg = productService.selectRealProductImg()+".png";
				
//		파일저장 : 절대경로
		String saveDirectory  = application.getRealPath("/resources/upload/product");
		log.debug("saveDirectory = {}",saveDirectory);
		
//		 업무로직 : thumbnail값 세팅 && 서버 pc저장 		
		if(!upFile.isEmpty()) {		
			try {					
				// prduct thumbnail값 세팅
				product.setThumbnail(productImg);	
				
				// 서버 컴퓨터 저장
				File dest = new File(saveDirectory, realProductImg);
				upFile.transferTo(dest);			
			} catch (Exception e) {
				e.printStackTrace();
			}
					 
		}
		else {
			
		}
			
		String msg = result > 0 ? "상품등록을 성공했습니다!":"상품등록에 실패했습니다!!!!!!";  
		redirectAttr.addFlashAttribute("msg",msg);
		
																					
		return "redirect:/admin/product/productMain.do";
	}
	
	// 상품 삭제
	@PostMapping("/deleteProduct.do")
	public String deleteProduct(@RequestParam String productCodes, RedirectAttributes redirectAttr) {
		log.debug("productCode = {}",productCodes);
		String[] productCode = productCodes.split(",");
		int result = 0;
		
		for(int i = 0; i < productCode.length; i++) {
			log.debug("productCode"+i+productCode[i]);
			result = productService.deleteProduct(productCode[i]);
			
			// 서버의 이미지 삭제
			String saveDirectory  = application.getRealPath("/resources/upload/product/")+productCodes+".png"; 
			log.debug("saveDirectory = {}",saveDirectory);
			
			File file = new File(saveDirectory);
			boolean fileDelete = file.delete();
			log.debug("fileDelete = {}", fileDelete);
			
			
		}
		
		redirectAttr.addFlashAttribute("msg","선택하신 상품을 삭제했습니다");	
		return "redirect:/admin/product/productMain.do";
	}
	
	
	
	@GetMapping("/findProductOption")
	public ResponseEntity<?> optionList(
			@RequestParam(required = false) String productCode
			){
		
		List<ProductDetail> productDetailList;
		try {
			productDetailList = productService.selectProductDetail(productCode);
			log.debug("productDetailList = {}",productDetailList);
		} catch (Exception e) {
			log.error(e.getMessage());
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
		}
					
		return ResponseEntity.ok(productDetailList);
	}
	
	// 상품 상세 페이지 이동
	@GetMapping("/productDetail.do")
	public String productDetail(@RequestParam String productCode, Model model) {
		
		// 상품정보 가져오기
		ProductEx productEx = productService.selectProductOne(productCode);
		
		// 상품 Detail 정보 가져오기
		List<ProductDetail> productDetail = productService.selectProductDetail(productCode);

		log.debug("ProductEx ={}",productEx);
		log.debug("productDetail ={}",productDetail);
				
		model.addAttribute("productCode",productCode);
		model.addAttribute("productInfo",productEx);
		model.addAttribute("productDetail",productDetail);
		return "/admin/product/productDetail";
	}
	
	// 상품 && 상품 옵션 수정
	@PostMapping("/updateProduct.do")
	public String productUpdate(
			ProductEntity product,
			
			@RequestParam String productCode, // 상품 리스트에서 넘어온 productCode
			@RequestParam String parentCategoryCode,
			@RequestParam String childCategoryCode,			
			@RequestParam (required=false)int[]detailNo,
			@RequestParam (required=false)int[]deleteDetailNo, // 삭제할 detailNo
//			@RequestParam (required=false)int[]insertDetailNo, // 추가할 detailNo
			@RequestParam (required=false)String[]insertOption, // 추가할 option
			@RequestParam (required=false)String[]insertOptionContent, // 추가할 optionContent
			@RequestParam (required=false)int[]insertQuantity, // 추가할 quantity			
			@RequestParam String[]optionContent,
			@RequestParam String[]option,
			@RequestParam int[]quantity,
			@RequestParam String sku,
			MultipartFile upFile,
			RedirectAttributes redirectAttr
			) {
		int result = 0;
		
		Map<String,Object>param = new HashMap<>();
		List<ProductDetail>insertProductDetailList = new ArrayList<>();
		
		if(insertOption != null) {			
			for(int i = 0; i < insertOption.length; i++) {
				ProductDetail insertProductDetail = new ProductDetail();
				insertProductDetail.setProductCode(productCode);
//				insertProductDetail.setDetailNo(insertDetailNo[i]);
				insertProductDetail.setOptionNo(insertOption[i]);
				if(!ArrayUtils.isEmpty(insertOptionContent)) {
					insertProductDetail.setOptionContent(insertOptionContent[i]);
				}
				insertProductDetail.setQuantity(insertQuantity[i]) ;
							
				insertProductDetailList.add(insertProductDetail);
			}
		}
		
		
		log.debug("deleteDetailNo = {}",deleteDetailNo);
		log.debug("insertProductDetailList = {}",insertProductDetailList);
		
		param.put("deleteDetailNo", deleteDetailNo);
		param.put("insertProductDetailList", insertProductDetailList);
		
		
		// 상품 List에 뿌려준 productCode를 상품detail 페이지로 넘긴 뒤 update 페이지까지 넘겨줌
		product.setProductCode(productCode);
		// thumbnail set
		String productImg = productCode+".png";
		product.setThumbnail(productImg);
		
		// 상품상세 객체로 묶어 전달		
		List<ProductDetail> productDetailList = new ArrayList<>();
		
		for(int i = 0; i < option.length; i++) {
			ProductDetail productDetail = new ProductDetail();
						
			productDetail.setDetailNo(detailNo[i]) ;
			productDetail.setOptionNo(option[i]);
			if(!ArrayUtils.isEmpty(optionContent)) {
				productDetail.setOptionContent(optionContent[i]);
			}
			productDetail.setSku(sku);
			productDetail.setQuantity(quantity[i]);
			
			productDetailList.add(productDetail);
		}
		
		// prodcut Map에 저장
		param.put("productDetailList", productDetailList);
				
		log.debug("product = {}",product); 
					
		
		String fileDirectory = application.getRealPath("/resources/upload/product/")+productCode+".png";
		String saveDirectory = application.getRealPath("/resources/upload/product");
		log.debug("saveDirectory = {}",saveDirectory);
		
		// 바뀐 이미지 파일 서버에 저장
		String newProductImg="";
		if(!upFile.isEmpty()) {		
			try {		
				// 서버의 기존이미지 삭제
				File delFile = new File(fileDirectory);
				boolean fileDelete = delFile.delete();
				log.debug("fileDelete = {}", fileDelete);
		
				// 서버 컴퓨터 저장
				File dest = new File(saveDirectory, productImg);
				upFile.transferTo(dest);			
				
				// 바뀐 이미지 파일 명 set한 뒤 update
				// 상품 정보 수정(첨부파일도 같이 수정)
				product.setThumbnail(productImg);
			} catch (Exception e) {
				e.printStackTrace();
			}
					 
		}
			
		
		param.put("product", product);
		
		result = productService.updateProduct(param);
		
		
		String msg = "상품 수정 성공 !!";
		redirectAttr.addFlashAttribute("msg",msg);
		return "redirect:/admin/product/productMain.do";
	}
	
	// 상품 카테고리 관리
	@GetMapping("/product/productCategory.do")
	public void productCategory(Model model) {
		List<ProductParentCategory> list = productCategoryService.selectAllParentCategory();
		List<ProductChildCategory> cList = productCategoryService.selectAllChildCategory();
		
		log.debug("list = {}", list);
		log.debug("cList = {}", cList);
		
		model.addAttribute("cList",cList);
		model.addAttribute("list",list);
	}
	

		
	// 비동기로 소분류 이름 & 코드 가져오기.
	@GetMapping("/productCategory/searchChildCategory.do")
	@ResponseBody
	public Map<String,Object>searchChildCategory(@RequestParam String code){
		Map<String,Object>map = new HashMap<>();
		log.debug("code",code);
		List<ProductChildCategory>childCategoryList = productCategoryService.searchChildCategory(code);
		log.debug("childCategoryList",childCategoryList);
		
		
		map.put("childCategoryList", childCategoryList);
		return map;
	}
	
	// 상품 카테고리 등록
	@PostMapping("/product/insertCategory.do")
	public String insertCategory(
			@RequestParam String selectCategory,
			@RequestParam(required = false) String selectParentCategory,
			@RequestParam String categoryTitle,
			@RequestParam String categoryCode,
			
			RedirectAttributes redirectAttr
			
			) {
		log.debug("selectCategory = {}",selectCategory);
		log.debug("selectParentCategory = {}",selectParentCategory);
		log.debug("categoryTitle = {}",categoryTitle);
		log.debug("categoryCode = {}",categoryCode);
		
		Map<String,String>param = new HashMap<>();
		param.put("selectCategory", selectCategory);
		param.put("selectParentCategory", selectParentCategory);
		param.put("categoryTitle", categoryTitle);
		param.put("categoryCode", categoryCode);
		
		int result = productCategoryService.insertCategory(param);
		
		redirectAttr.addFlashAttribute("msg","상품 카테고리 등록 성공.");
		
		return "redirect:/admin/product/productCategory.do";
	}
		
	// 비동기로 대분류 값 가져오기
	@GetMapping("/productCategory/selectParentCategory.do")
	@ResponseBody
	public Map<String,Object>selectParentCategory(){
		Map<String,Object>map = new HashMap<>();
		List<ProductParentCategory>parentCategoryList = productCategoryService.selectParentCategory();
		
		log.debug("parentCategoryList = {}",parentCategoryList);
		
		map.put("parentCategoryList", parentCategoryList);
		return map;
	}
	
	// 상품 카테고리 삭제
	@PostMapping("/product/deleteCategory.do")
	public String deleteCategory(
				@RequestParam(required = false) String deleteChildCategoryCode,
				@RequestParam(required = false) String deleteParentCategoryCode,
				RedirectAttributes redirectAttr
			) {
		
		log.debug("deleteChildCategoryCode = {}",deleteChildCategoryCode);
		log.debug("deleteParentCategoryCode = {}",deleteParentCategoryCode);
		
		Map<String,String>param = new HashMap<>();
		param.put("deleteParentCategoryCode", deleteParentCategoryCode);
		param.put("deleteChildCategoryCode", deleteChildCategoryCode);
		
		int result = productCategoryService.deleteProductCategory(param);
		
		redirectAttr.addFlashAttribute("msg","상품 카테고리 삭제 성공");
		return "redirect:/admin/product/productCategory.do";
	}
	
	// 상품 카테고리 코드 중복검사
	@ResponseBody
	@GetMapping("/productCategory/checkCategoryCode.do")
	public Map<String,Object> checkCategoryCode(
				@RequestParam(required = false) String afterUpdateCategoryCode
			) {
		Map<String,Object>map = new HashMap<>(); 
		
		log.debug("afterUpdateCategoryCode = {}",afterUpdateCategoryCode);
		
		
		// 대분류, 소분류 두 테이블을 조회한 뒤 같은 값이 있다면 true를 리턴
		List<ProductParentCategory> productCategoryList  = productCategoryService.selectCategoryCode(afterUpdateCategoryCode);		
		
		log.debug("productCategory = {}",productCategoryList);
		
		if(productCategoryList.isEmpty()) {
			log.debug("사용가능");
			map.put("result", true);
		}
		else {
			log.debug("사용 불가능-------------");
			map.put("result", false);
		}
		
		
		map.put("afterUpdateCategoryCode", "["+afterUpdateCategoryCode+"]");
		return map;
	};
	
	// 상품 카테고리 이름 중복검사
	@ResponseBody
	@GetMapping("/productCategory/checkCategoryTitle.do")
	public Map<String,Object> checkCategoryTitle(
			@RequestParam(required = false) String afterUpdateCategoryTitle
			) {
		Map<String,Object>map = new HashMap<>(); 
		
		log.debug("afterUpdateCategoryTitle = {}",afterUpdateCategoryTitle);
		
		
		// 대분류, 소분류 두 테이블을 조회한 뒤 같은 값이 있다면 true를 리턴
		List<ProductParentCategory> productTitleList = productCategoryService.selectCategoryTitle(afterUpdateCategoryTitle);			
		
		
		log.debug("productTitle = {}",productTitleList);

		
		if(productTitleList.isEmpty()) {
			log.debug("사용가능한 이름");
			map.put("result", true);
		}
		else {
			log.debug("사용 불가능 이-------------");
			map.put("result", false);
		}
		
		
		
		map.put("afterUpdateCategoryTitle", "["+afterUpdateCategoryTitle+"]");
		return map;
	};
	
	// 상품 카테고리 업데이트
	@PostMapping("/product/updateCategory.do")
	public String updateCategory(
				@RequestParam String updateKind,
				@RequestParam(required = false) String beforeTitle,
				@RequestParam(required = false) String updateCategoryTitle,
				@RequestParam(required = false) String beforeCode,
				@RequestParam(required = false) String updateCategoryCode,
				RedirectAttributes redirectAttr
			) {
		int result = 0;
		
		log.debug("updateKind = {}",updateKind);
		log.debug("beforeTitle = {}",beforeTitle);
		log.debug("updateCategoryTitle ={}",updateCategoryTitle);
		log.debug("beforeCode = {}",beforeCode);
		log.debug("updateCategoryCode = {}",updateCategoryCode);
		
		Map<String,String>param = new HashMap<>();
		
		param.put("updateKind", updateKind);
		param.put("beforeTitle", beforeTitle);
		param.put("updateCategoryTitle", updateCategoryTitle);
		param.put("beforeCode", beforeCode);
		param.put("updateCategoryCode", updateCategoryCode);
		
		result = productCategoryService.updateCategory(param);
		
		redirectAttr.addFlashAttribute("msg","업데이트 완료.");
		
		return "redirect:/admin/product/productCategory.do";
	}
	
	
	
	
	
	
	
	
	/**
	 * -------------------------------- 회원
	 * 
	 */
	
	
	// 회원 등급 관리
	@GetMapping("/memberManage/memberLevel.do")
	public void memberLevel(	
			Model model,
			@RequestParam(defaultValue = "1") int cPage,
			HttpServletRequest request
			) {
		// 1.페이징 처리 : 페이지 설정
		int limit = 5;
		int offset = (cPage - 1) * limit;
		
		// 게시물 리스트 가져오기
		List<Member>memberList = memberManageService.selectAllMember(offset,limit);

		log.debug("list = {}" ,memberList);	
		model.addAttribute("list",memberList);
		
		// 2. 전체게시물수 totalContent
		int totalMemberCount =  memberManageService.selectTotalMemberCount();
		log.debug("totalContent = {}", totalMemberCount);
		model.addAttribute("totalContent", totalMemberCount);
		
		// 3. pagebar
		String url = request.getRequestURI(); 
		String pagebar = DevrunUtils.getPagebar(cPage, limit, totalMemberCount, url);
				
		log.debug("pagebar = {}", pagebar);
		
		
		model.addAttribute("pagebar", pagebar);		
		model.addAttribute("memberList",memberList);
	};
	

	// 검색결과 페이징처리
	@ResponseBody
	@GetMapping("/memberManage/searchMember.do")
	public Map<String,Object>searchMember(
			@RequestParam String searchType,
			@RequestParam String searchKeyword,
			@RequestParam(defaultValue = "1") int cPage,
			HttpServletRequest request
			){
		// 검색 타입이 없을 때 searchType에 all 대입하여 오류 방
		if(searchType == "" || searchType == null) {
			searchType = "all";
		}
		
		Map<String,Object>map = new HashMap<>();
		
		int limit = 10;
		int offset = (cPage - 1) * limit;
		
		
		log.debug("searchType = {}",searchType);
		log.debug("searchKeyword = {}",searchKeyword);
		log.debug("cPage = {}",cPage);
		Map<String,Object>param = new HashMap<>();
		
		
		param.put("limit",limit);
		param.put("offset",offset);
		
		param.put("searchType", "m."+searchType);
		param.put("searchKeyword", searchKeyword);
		
		// 1.조회한 리스트 가져오기
		String url = request.getRequestURI()+"?searchType="+searchType+"&searchKeyword="+searchKeyword;
		log.debug("url = {}", url);
		
		List<Member>memberList = memberManageService.searchMemberList(param);
		String memberStr = DevrunUtils.getMemberList(memberList);
		
		// 2.조회한 게시물 수
		int totalContent = memberManageService.searchMemberListCount(param);
		
		// 3.페이지 바
		log.debug("pagebarUrl = {}",url);
		String pagebar = DevrunUtils.getPagebar2(cPage, limit, totalContent, url);
		log.debug("pagebar = {}", pagebar);
				
		
		map.put("memberList",memberList);
		map.put("totalContent",totalContent);
		map.put("pagebar",pagebar);
		map.put("memberStr",memberStr);
		return map;
	}
	
	// 회원 권한 업데이트
	@PostMapping("/memberManage/updateAuthority.do")
	public String updateAuthority(
			@RequestParam int memberNo,
			@RequestParam String authority,
			RedirectAttributes redirectAttr
			) {
		Map<String,Object> param = new HashMap<>();
		param.put("memberNo",memberNo);
		param.put("authority",authority);
		
		int result = memberManageService.updateAuthority(param);
		String msg = "권한 업데이트 완료!";
		
		redirectAttr.addFlashAttribute("msg",msg);
		return "redirect:/admin/memberManage/memberLevel.do";
	}
	
	//=======================================================
	
	// 회원 문의 내역
	@GetMapping("/memberManage/questionProduct.do")
	public void memberInquiry(
			Model model,
			@RequestParam(defaultValue = "1") int cPage,
			HttpServletRequest request
			) {
	
		// 1.페이징 처리 : 페이지 설정
		int limit = 5;
		int offset = (cPage - 1) * limit;
		
		// 게시물 리스트 가져오기
		List<QuestionProduct> questionList = questionProductService.selectAllQuestionList(limit,offset);
		log.debug("questionList = {}" ,questionList);	

		
		// 2. 전체게시물수 totalContent(답변은 제외)
		int totalQuestionCount =  questionProductService.selectTotalQuestionCount();
		log.debug("totalContent = {}", totalQuestionCount);
		model.addAttribute("totalQuestionCount", totalQuestionCount);
		
		// 3. pagebar
		String url = request.getRequestURI(); 
		String pagebar = DevrunUtils.getPagebar(cPage, limit, totalQuestionCount, url);
				
		log.debug("pagebar = {}", pagebar);
		
		
		model.addAttribute("pagebar", pagebar);		
		model.addAttribute("questionList",questionList);
	};	
	
	// 상품 문의 답변 수정하기
	@PostMapping("/questionProduct/updateQuestionProduct.do")
	public String updateQuestionProduct(
				@RequestParam int questionRefNo,
				@RequestParam String updateAnswer,
				RedirectAttributes redirectAttr
			) {
		
		log.debug("updateAnswer  ={}",updateAnswer);
		Map<String,Object>param = new HashMap<>();
		param.put("questionRefNo", questionRefNo);
		param.put("updateAnswer", updateAnswer);
		
		int result = questionProductService.updateAnswer(param);		
		
		redirectAttr.addFlashAttribute("msg","답변 수정 완료.");
		return "redirect:/admin/memberManage/questionProduct.do";
	}
	
	// 문의사항 답변 추가하기
	@PostMapping("/questionProduct/insertQuestionProduct.do")
	public String insertQuestionProduct(
			QuestionProduct questionProduct,
			RedirectAttributes redirectAttr,
			Authentication authentication,
			@RequestParam String answer
			
			) {
		// 입력받은 답변을 content에 저장
		questionProduct.setContent(answer);
		// 회원 번호는 현재 로그인중인 사용자의 member_no
		Member member = (Member)authentication.getPrincipal();
		log.debug("member = {}",member);
		// 답변글의 title은 answer로 고정시킨다.
		questionProduct.setTitle("answer");
		// 대상의 문의 번호를 현재 답변의 참조 문의 번호에 넣어준다
		questionProduct.setQuestionRefNo(questionProduct.getQuestionNo());
		// 답변이므로 레벨은 무조건 2 
		questionProduct.setQuestionLevel(2);
		// 비공개 체크 값이 없다면 'N'로 채우기
		if(questionProduct.getPrivateYn() == '\u0000') {
			questionProduct.setPrivateYn('N');
		}
		log.debug("questionProduct = {}",questionProduct);
		
		int reuslt = questionProductService.insertQuestionProduct(questionProduct);
		String msg = "답변을 달았습니다."; redirectAttr.addFlashAttribute("msg",msg);
		return "redirect:/admin/memberManage/questionProduct.do";
	}
	
		// 문의 정보 & 상품 정보 비동기로 가져옥
		@ResponseBody
		@GetMapping("/questionProduct/selectQuestion.do")
		public Map<String,Object>selectQuestionProductInfo(
					@RequestParam int questionNo,
					@RequestParam String productCode
					
				){		
			Map<String,Object> map = new HashMap<>();
			log.debug("productCode={}",productCode);
			log.debug("questionNo = {}",questionNo);
			Map<String,Object> param = new HashMap<>();
			param.put("productCode", productCode);
			param.put("questionNo", questionNo);
			
			// 선택한 문의와 상품 정보 가져오기
			QuestionProductEx questionProductInfo = questionProductService.selectOneQuestionProductInfo(param);
			log.debug("questionProductInfo = {}",questionProductInfo);
			
			// 선택한 문의 번호에 대한 참조 문의 번호가 존재한다면 가져오기
			QuestionProduct questionProduct = questionProductService.selectQuestionByRefNo(questionNo);
			
			String answer = "no";
			
			if(questionProduct != null) {
				answer = questionProduct.getContent();
				log.debug("답변이 있습니다~~~~~");
			}
			else {
				log.debug("답변이 없습니다.");
			}
					
			map.put("answer",answer);
			map.put("questionProductInfo",questionProductInfo);
			return map;	
		}
		
		// 비동기 검색 & 페이징 처리
		@ResponseBody
		@GetMapping("/qustionProduct/searchQuestion.do")
		public Map<String,Object> searchQuestionProduct(
				@RequestParam String searchType,
				@RequestParam String searchKeyword,
				@RequestParam(defaultValue = "1") int cPage,
				@RequestParam(required = false) String startDate,
				@RequestParam(required = false) String endDate,
				HttpServletRequest request
				){
			// 검색 타입이 없을 때 searchType에 all 대입하여 오류 방
			if(searchType == "" || searchType == null) {
				searchType = "all";
			}
			
			// jsp에서 날짜 초기화 undefind가 아닌 공백이 들어갈 경우 mapper에서 오류가 나 공백을 경우 null을 대입 
			if(startDate == "" || startDate == "") {
				startDate = null;
				endDate = null;
			}

			Map<String,Object>map = new HashMap<>();
			
			int limit = 5;
			int offset = (cPage - 1) * limit;
			
			
			log.debug("searchType = {}",searchType);
			log.debug("searchKeyword = {}",searchKeyword);
			log.debug("cPage = {}",cPage);
			log.debug("startDate = {}",startDate);
			log.debug("endDate = {}",endDate);
			
			Map<String,Object>param = new HashMap<>();
			
			if(searchKeyword.contains(",")) {
				log.debug(searchKeyword);
			}
			
			param.put("limit",limit);
			param.put("offset",offset);
			
			param.put("searchType", searchType);
			param.put("searchKeyword", searchKeyword);
			
			param.put("startDate", startDate);
			param.put("endDate", endDate);
			
			// 1.조회한 리스트 가져오기
			String url = request.getRequestURI()+"?searchType="+searchType+"&searchKeyword="+searchKeyword;
			log.debug("url = {}", url);
			
			List<QuestionProduct>questionList = questionProductService.searchQuestionList(param);
			log.debug("questionList  = {}",questionList );
			
			String questionStr = QuestionProductUtils.getQuestionList(questionList);
			log.debug("questionStr = {}",questionStr);
			
			
			// 2.조회한 게시물 수					
			int totalContent = questionProductService.searchQuestionListCount(param);				
					
				
			// 3.페이지 바
			log.debug("pagebarUrl = {}",url);
			String pagebar = QuestionProductUtils.getPagebarQuestion(cPage, limit, totalContent, url);
			log.debug("pagebar = {}", pagebar);
					
			
			map.put("questionList",questionList);
			map.put("totalContent",totalContent);
			map.put("pagebar",pagebar);
			map.put("questionStr",questionStr);
			
			return map;
		}
	
	
				
		

	//--------------------태영 끝-----------------------------

	
		
		


	/**
	 * 혜진 시작 
	 */
	@GetMapping("/orderManage.do")
	public String orderManage(Model model) {
		List<Merchant> list = orderService.selectAllMerchant();
		List<Merchant> orList = new ArrayList<>();
		for(Merchant m : list) {
			if("OR".equals(m.getOrderStatus()) && "COM".equals(m.getCsStatus()))
				orList.add(m);
		}
		
		model.addAttribute("list", list);
		model.addAttribute("orList", orList);
		
		//일간, 주간, 월간 판매 데이터 가져오기
		Map<String, Object> merchantCntList = orderService.countMerchant();
		log.debug("merchantCntList = {}", merchantCntList);
		Map<String, Object> todayCnt = (Map<String, Object>)merchantCntList.get("todayCnt");
		Map<String, Object> weekCnt = (Map<String, Object>)merchantCntList.get("weekCnt");
		Map<String, Object> monthCnt = (Map<String, Object>)merchantCntList.get("monthCnt");
		model.addAttribute("todayCnt", todayCnt);
		model.addAttribute("weekCnt", weekCnt);
		model.addAttribute("monthCnt", monthCnt);
		
		return "/admin/order/orderManage";
	}
	
	@GetMapping("/orderSearch")
	@ResponseBody
	public Map<String, Object> orderSearch(
			@RequestParam(required = false) String orderStatus,
			@RequestParam(required = false) String csStatus,
			@RequestParam(required = false) String searchType,
			@RequestParam(required = false) String searchKeyword,
			@RequestParam(required = false) Date startDate,
			@RequestParam(required = false) Date endDate,
			HttpServletRequest request){
		Map<String, Object> resultMap = new HashMap<>();
		
		Map<String, Object> param = new HashMap<>();
		param.put("orderStatus", orderStatus);
		param.put("csStatus", csStatus);
		param.put("searchType", searchType);
		param.put("searchKeyword", searchKeyword);
		param.put("startDate", startDate);
		if(endDate != null) {
			Calendar cal = Calendar.getInstance();	 //날짜 계산을 위해 Calendar 추상클래스 선언 getInstance()메소드 사용	
			cal.setTime(endDate);	
			cal.add(Calendar.DATE, 1);	//하루 더하기
			Date date = cal.getTime();
			param.put("endDate", date);
		}
		log.debug("param = {}", param);
		
		String url = request.getContextPath();
		
		List<Merchant> list = orderService.selectMerchantList(param);
		log.debug("list = {}", list);
		String merchantStr = AdminUtils.getMerchantList(list, url);
		log.debug("merchantStr = {}", merchantStr);
		
		resultMap.put("merchantStr", merchantStr);
		
		return resultMap;
	}
	
	@GetMapping("/findMerchantDetail")
	@ResponseBody
	public Map<String, Object> findMerchantDetail(@RequestParam(value = "merchantUid") String merchantUid) {
		log.debug("merchantUid = {}", merchantUid);
		Map<String, Object> merchant = orderService.selectOneMerchant(merchantUid);
		return merchant;
	}
	
	@PostMapping("/orderUpdate")
	@ResponseBody
	public Map<String, Object> orderUpdate(@RequestBody String jsonStr) {
		Map<String, Object> param = new HashMap<>();
		Map<String, Object> resultMap = new HashMap<>();
		try {
			param = new ObjectMapper().readValue(jsonStr, Map.class);
			log.debug("map = {}", param);
			
			int result = orderService.updateMerchant(param);
			log.debug("result = {}", result);
			
			
			resultMap.put("result", result);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return resultMap;
	}
	
	@GetMapping("/shipmentManage.do")
	public String shipmentManage(Model model) {
		List<Shipment> shipmentList = orderService.selectAllShipment();
		List<Merchant> merchantList = orderService.selectSomeMerchant("PP");
		List<OrderLog> orderLogList = orderService.selectSomeOrderLog("EXC");
		model.addAttribute("shipmentList", shipmentList);
		model.addAttribute("merchantList", merchantList);
		model.addAttribute("orderLogList", orderLogList);
		
		return "/admin/order/shipmentManage";
		
	}
	
	@PostMapping("/enrollShipmentNo")
	@ResponseBody
	public Map<String, Object> enrollShipmentNo(@RequestBody String jsonStr) {
		Map<String, Object> param = new HashMap<>();
		Map<String, Object> returnVal = new HashMap<>();
		try {
			param = new ObjectMapper().readValue(jsonStr, Map.class);
			log.debug("map = {}", param);
			
			int result = orderService.insertShipment(param);
			returnVal.put("msg", "송장 번호 입력이 완료되었습니다.");
			returnVal.put("inputValid", 1);
			
		} catch (IOException e) {
			e.printStackTrace();
			returnVal.put("inputValid", 0);
		}
		return returnVal;
	}
	
	@GetMapping("/orderLogManage.do")
	public String orderLogManage(Model model) {
		List<OrderLog> list = orderService.selectAllOrderLog();
		log.debug("list = {}", list);
		List<OrderLog> manageList = new ArrayList<>();
		for(OrderLog ol : list) {
			if(("REF".equals(ol.getCsStatus())||"RET".equals(ol.getCsStatus())||"EXC".equals(ol.getCsStatus())) && ol.getEndDate() == null) {
				manageList.add(ol);
			}
		}
		model.addAttribute("list", list);
		model.addAttribute("manageList", manageList);
		
		return "/admin/order/orderLogManage";
	}
	
	@GetMapping("/findOrderLogDetail")
	@ResponseBody
	public Map<String, Object> findOrderLogDetail(@RequestParam(value="orderLogUid") String orderLogUid) {
		log.debug("orderLogUid = {}", orderLogUid);
		Map<String, Object> orderLog = orderService.selectOneOrderLog(orderLogUid);
		log.debug("orderLog = {}", orderLog);
		return orderLog;
	}
	
	@PostMapping("/orderLogUpdate")
	@ResponseBody
	public Map<String, Object> orderLogUpdate(@RequestBody String jsonStr, 
												HttpServletRequest request, 
												HttpServletResponse response,
												RedirectAttributes redirectAttr){
		Map<String, Object> param = new HashMap<>();
		Map<String, Object> resultMap = new HashMap<>();
		int result = 0;
		try {
			param = new ObjectMapper().readValue(jsonStr, Map.class);
			log.debug("param = {}", param);
			int isValid = (int)param.get("valid");
			log.debug("valid = {}, {}", isValid);
			Map<String, Object> imp = (Map<String, Object>) param.get("imp");
			
			if(isValid == 0) {
				param.put("keyword", "PROCESS_DATE");
				result = orderService.updateOrderLog(param);
				resultMap.put("msg", "요청이 접수되었습니다.");
			}
			else if(isValid == 1){
				
				if(!"EXC".equals((String)param.get("csStatus"))) {
					
					// 아임포트 토큰생성 
					String requestUrl = "https://api.iamport.kr/users/getToken";
					String imp_key = URLEncoder.encode("8343794553669375", "UTF-8");
					String imp_secret = URLEncoder.encode("3ecaf2db93a1bded8267d09318b5d6ba441c1c412e19686b81ec859a6ffafc90abe92a15af22b138", "UTF-8");
					
					JSONObject json = new JSONObject();
					json.put("imp_key", imp_key);
					json.put("imp_secret", imp_secret);
					String _token = AdminUtils.getToken(request, response, json, requestUrl);
					log.debug("token = {}", _token);
					
					JSONObject json2 = new JSONObject();
					
					String reasonDetail = (String)param.get("reasonDetail");
					String impUid = (String)imp.get("impUid");
					int amount = (int)imp.get("amount");
					log.debug("reason = {}", reasonDetail);
					log.debug("imp = {}", imp);
					log.debug("amount = {}", amount);
					
					json2.put("reason", reasonDetail);
					json2.put("imp_uid", impUid);
					json2.put("amount", amount);
					
					Map<String, Object> map = AdminUtils.getRefund(request, response, json2, _token);
					log.debug("cancelResult = {}", map);
					String receipt = (String)map.get("receipt");
					
					resultMap.put("msg", (String)map.get("message"));
					
					if(receipt != null) {
						Map<String, Object> updateParam = new HashMap<>();
						updateParam.put("keyword", "END_DATE");
						updateParam.put("orderLogUid", param.get("orderLogUid"));
						updateParam.put("receiptUrl", receipt);
						updateParam.put("costStatus", "Y");
						updateParam.put("detailList", (List<Map<String, Object>>)param.get("detailList"));
						log.debug("updateParam = {}", updateParam);
						result = orderService.updateOrderLog(updateParam);
						resultMap.put("msg", "정상처리되었습니다");
					}
						
				}else {
					Map<String, Object> exchangeParam = new HashMap<>();
					exchangeParam.put("keyword", "END_DATE");
					exchangeParam.put("orderLogUid", param.get("orderLogUid"));
					exchangeParam.put("costStatus", "Y");
					exchangeParam.put("detailList", (List<Map<String, Object>>)param.get("detailList"));
					log.debug("updateParam = {}", exchangeParam);
					result = orderService.updateOrderLog(exchangeParam);
					resultMap.put("msg", "정상처리되었습니다");
				}
			
			log.debug("result = {}", result);
			
			
			resultMap.put("result", result);
			}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultMap;
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
		Promotion promotion = promotionService.selectPromotionWithProductByPromotionCode(promotionCode);
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
	public List<ProductEntity> promotionAutocomplete(@RequestParam String searchCode) {
		List<ProductEntity> list = promotionService.selectProductListByProductCode(searchCode);
		return list;
	}
	
	@GetMapping("/findProductList")
	@ResponseBody
	public List<Map<String, Object>> findProductList(@RequestParam String promotionCode){
		List<Map<String, Object>> list = promotionService.selectProductNameAndCodeByPromotionCode(promotionCode);
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
	
	
}
