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

import org.apache.commons.lang.ArrayUtils;
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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.devrun.category.model.vo.ProductChildCategory;
import com.kh.devrun.common.DevrunUtils;
import com.kh.devrun.member.model.vo.Member;
import com.kh.devrun.memberManage.model.service.MemberManageService;
import com.kh.devrun.product.model.service.ProductService;
import com.kh.devrun.product.model.vo.Product;
import com.kh.devrun.product.model.vo.ProductDetail;
import com.kh.devrun.product.model.vo.ProductExtends;
import com.kh.devrun.promotion.model.service.PromotionService;
import com.kh.devrun.promotion.model.vo.Promotion;
import com.kh.devrun.questionProduct.model.service.QuestionProductService;
import com.kh.devrun.questionProduct.model.vo.QuestionProduct;
import com.kh.devrun.questionProduct.model.vo.QuestionProductEx;

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
	ServletContext application;
	
	@Autowired
	MemberManageService memberManageService;
	
	@Autowired
	QuestionProductService questionProductService;
	
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
//		List<ProductExtends> list = productService.selectAllProductList(offset,limit);
		List<Product> list = productService.selectAllProductList(offset,limit);
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
			Product product,
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
		
																					
		return "redirect:/admin/productMain.do";
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
		return "redirect:/admin/productMain.do";
	}
	
	
	
	@GetMapping("/findProductOption")
	public ResponseEntity<?> optionList(
			@RequestParam(required = false) String productCode
			){
		
		List<ProductDetail> productDetailList;
		try {
			productDetailList = productService.findProductOption(productCode);
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
		ProductExtends productExtends = productService.selectProductOne(productCode);
		
		// 상품 Detail 정보 가져오기
		List<ProductDetail> productDetail = productService.selectProductDetail(productCode);

		log.debug("ProductExtends ={}",productExtends);
		log.debug("productDetail ={}",productDetail);
				
		model.addAttribute("productCode",productCode);
		model.addAttribute("productInfo",productExtends);
		model.addAttribute("productDetail",productDetail);
		return "/admin/product/productDetail";
	}
	
	// 상품 && 상품 옵션 수정
	@PostMapping("/updateProduct.do")
	public String productUpdate(
			Product product,
			
			@RequestParam String productCode, // 상품 리스트에서 넘어온 productCode
			@RequestParam String parentCategoryCode,
			@RequestParam String childCategoryCode,			
			@RequestParam int[]detailNo,
			@RequestParam (required=false)int[]deleteDetailNo, // 삭제할 detailNo
			@RequestParam (required=false)int[]insertDetailNo, // 추가할 detailNo
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
			for(int i = 0; i < insertDetailNo.length; i++) {
				ProductDetail insertProductDetail = new ProductDetail();
				insertProductDetail.setProductCode(productCode);
				insertProductDetail.setDetailNo(insertDetailNo[i]);
				insertProductDetail.setOptionNo(insertOption[i]);
				insertProductDetail.setOptionContent(insertOptionContent[i]);
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
		product.setThumbnail(productCode +".png");
		
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
		
		// prodcut 객체에 저장
		product.setProductDetailList(productDetailList);
				
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
				log.debug("첨부파일 있음~~~~~~~");
				newProductImg = productCode+"-1.png";
				File dest = new File(saveDirectory, newProductImg);
				upFile.transferTo(dest);			
			} catch (Exception e) {
				e.printStackTrace();
			}
					 
		}
			
		// 바뀐 이미지 파일 명 set한 뒤 update
		// 상품 정보 수정(첨부파일도 같이 수정)
		product.setThumbnail(newProductImg);
		
		param.put("product", product);
		
		result = productService.updateProduct(param);
		
		
		String msg = "상품 수정 성공 !!";
		redirectAttr.addFlashAttribute("msg",msg);
		return "redirect:/admin/productMain.do";
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
		int limit = 11;
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
	
	
	// 회원 문의 내역
	@GetMapping("/memberManage/questionProduct.do")
	public void memberInquiry(Model model) {
		List<QuestionProduct> list = questionProductService.selectAllQuestionList();
		
		model.addAttribute("questionList",list);
	};
	
	

	@ResponseBody
	@GetMapping("/memberManage/searchMember.do")
	public Map<String,Object>searchMember(
			@RequestParam String searchType,
			@RequestParam String searchKeyword,
			@RequestParam(defaultValue = "1") int cPage,
			HttpServletRequest request
			){
		
		Map<String,Object>map = new HashMap<>();
		
		int limit = 11;
		int offset = (cPage - 1) * limit;
		
		log.debug("searchType = {}",searchType);
		log.debug("searchKeyword = {}",searchKeyword);
		Map<String,Object>param = new HashMap<>();
		
		if(searchKeyword.contains(",")) {
			log.debug(searchKeyword);
		}
		
		param.put("limit",limit);
		param.put("offset",offset);
		
		param.put("searchType", "m."+searchType);
		param.put("searchKeyword", searchKeyword);
			
		List<Member>memberList = memberManageService.searchMemberList(param);
		
		
		map.put("memberList",memberList);
		map.put("date",new Date());
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
		
		String answer = "";
		
		if(questionProduct != null) {
			answer = questionProduct.getContent();
			log.debug("답변이 있습니다~~~~~");
		}
		else {
//			answer = "답변 대기 중.";
			log.debug("답변이 없습니다.");
		}
				
		map.put("answer",answer);
		map.put("questionProductInfo",questionProductInfo);
		return map;	
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
		questionProduct.setMemberNo(member.getMemberNo());
		
		// 대상의 문의 번호를 현재 답변의 참조 문의 번호에 넣어준다
		questionProduct.setQuestionRefNo(questionProduct.getQuestionNo());
		
		// 답변이므로 레벨은 무조건 2 
		questionProduct.setQLevel(2);
		
		// 비공개 체크 값이 없다면 'N'로 채우기
		if(questionProduct.getPrivateYn() == '\u0000') {
			questionProduct.setPrivateYn('N');
		}
				
		
		log.debug("questionProduct = {}",questionProduct);
		
		
		
		int reuslt = questionProductService.insertQuestionProduct(questionProduct);
		  
		String msg = "답변을 달았습니다."; redirectAttr.addFlashAttribute("msg",msg);
		 
		return "redirect:/admin/memberManage/questionProduct.do";
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
	public List<Product> promotionAutocomplete(@RequestParam String searchCode) {
		List<Product> list = promotionService.selectProductListByProductCode(searchCode);
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
