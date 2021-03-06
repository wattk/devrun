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
		
		//?????? cnt??? ????????????
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
		
		// 1.????????? ?????? : ????????? ??????
		int limit = 10;
		int offset = (cPage - 1) * limit;
		
		// ????????? ????????? ????????????
		List<ProductEntity> list = productService.selectAllProductList(offset,limit);
		log.debug("list = {}" ,list);	
		model.addAttribute("list",list);
		
		// 2. ?????????????????? totalContent
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
	
	// ?????? ?????? ?????? ?????? && ?????????
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
		// ?????? ????????? ?????? ??? searchType??? all ???????????? ?????? ???
		if(searchType == "" || searchType == null) {
			searchType = "all";
		}
		
		log.debug("searchType = {}",searchType);
		log.debug("searchKeyword ={}",searchKeyword);
		log.debug("???????????? = {}",startDate);
		log.debug("???????????? = {}",endDate);
		
		// jsp?????? ?????? ????????? undefind??? ?????? ????????? ????????? ?????? mapper?????? ????????? ??? ????????? ?????? null??? ?????? 
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
		
		
		// 1.????????? ????????? ????????????
		String url = request.getRequestURI()+"?searchType="+searchType+"&searchKeyword="+searchKeyword;
		
		List<ProductEntity>productList = productService.searchProductList(param);
		String productStr = DevrunUtils.getProductListByAdmin(productList,request);
		
		// 2.????????? ????????? ???

		int totalContent = productService.searchProductListCount(param);
		
		// 3.????????? ???

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

	// ?????? ?????? && ??????-???????????? ??????
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
		// ????????? ?????????
		log.debug("product = {}", product);
		log.debug("childCategoryCode = {}", childCategoryCode);
		log.debug("parentCategoryCode = {}", parentCategoryCode);
			
		log.debug("sku = {}", sku);
		log.debug("option = {}", option);
		log.debug("optionContent = {}", optionContent);
		log.debug("quantity = {}", quantity);
		
		
		// ??????????????? + ?????????????????? ??????????????? ???????????? ??? pruduct??? set
		String productCode = parentCategoryCode+"-"+childCategoryCode;
		product.setProductCode(productCode);
		
		// ???????????? ????????? ?????? ??????		
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
		
		// Map<String,Object>param??? ????????? ??????
		Map<String,Object>param = new HashMap<>();
		param.put("productCode", productCode);
		param.put("childCategoryCode", childCategoryCode);
		param.put("productDetailList", productDetailList);
		param.put("product", product);
		
		log.debug("param = {}",param);
				
		
		log.debug("upFile = {}",upFile);
		String productImg = product.getProductCode();
		log.debug("productImg = {}",productImg);
				
			
		// ?????? ??????
		int result = productService.insertProduct(param);
				
		// nextval ???????????? ?????? thumbnail ??? ???????????? (?????? ?????????)
		String realProductImg = productService.selectRealProductImg()+".png";
				
//		???????????? : ????????????
		String saveDirectory  = application.getRealPath("/resources/upload/product");
		log.debug("saveDirectory = {}",saveDirectory);
		
//		 ???????????? : thumbnail??? ?????? && ?????? pc?????? 		
		if(!upFile.isEmpty()) {		
			try {					
				// prduct thumbnail??? ??????
				product.setThumbnail(productImg);	
				
				// ?????? ????????? ??????
				File dest = new File(saveDirectory, realProductImg);
				upFile.transferTo(dest);			
			} catch (Exception e) {
				e.printStackTrace();
			}
					 
		}
		else {
			
		}
			
		String msg = result > 0 ? "??????????????? ??????????????????!":"??????????????? ??????????????????!!!!!!";  
		redirectAttr.addFlashAttribute("msg",msg);
		
																					
		return "redirect:/admin/product/productMain.do";
	}
	
	// ?????? ??????
	@PostMapping("/deleteProduct.do")
	public String deleteProduct(@RequestParam String productCodes, RedirectAttributes redirectAttr) {
		log.debug("productCode = {}",productCodes);
		String[] productCode = productCodes.split(",");
		int result = 0;
		
		for(int i = 0; i < productCode.length; i++) {
			log.debug("productCode"+i+productCode[i]);
			result = productService.deleteProduct(productCode[i]);
			
			// ????????? ????????? ??????
			String saveDirectory  = application.getRealPath("/resources/upload/product/")+productCodes+".png"; 
			log.debug("saveDirectory = {}",saveDirectory);
			
			File file = new File(saveDirectory);
			boolean fileDelete = file.delete();
			log.debug("fileDelete = {}", fileDelete);
			
			
		}
		
		redirectAttr.addFlashAttribute("msg","???????????? ????????? ??????????????????");	
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
	
	// ?????? ?????? ????????? ??????
	@GetMapping("/productDetail.do")
	public String productDetail(@RequestParam String productCode, Model model) {
		
		// ???????????? ????????????
		ProductEx productEx = productService.selectProductOne(productCode);
		
		// ?????? Detail ?????? ????????????
		List<ProductDetail> productDetail = productService.selectProductDetail(productCode);

		log.debug("ProductEx ={}",productEx);
		log.debug("productDetail ={}",productDetail);
				
		model.addAttribute("productCode",productCode);
		model.addAttribute("productInfo",productEx);
		model.addAttribute("productDetail",productDetail);
		return "/admin/product/productDetail";
	}
	
	// ?????? && ?????? ?????? ??????
	@PostMapping("/updateProduct.do")
	public String productUpdate(
			ProductEntity product,
			
			@RequestParam String productCode, // ?????? ??????????????? ????????? productCode
			@RequestParam String parentCategoryCode,
			@RequestParam String childCategoryCode,			
			@RequestParam (required=false)int[]detailNo,
			@RequestParam (required=false)int[]deleteDetailNo, // ????????? detailNo
//			@RequestParam (required=false)int[]insertDetailNo, // ????????? detailNo
			@RequestParam (required=false)String[]insertOption, // ????????? option
			@RequestParam (required=false)String[]insertOptionContent, // ????????? optionContent
			@RequestParam (required=false)int[]insertQuantity, // ????????? quantity			
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
		
		log.debug("quantity = {}", quantity[0]);
		
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
		
		
		// ?????? List??? ????????? productCode??? ??????detail ???????????? ?????? ??? update ??????????????? ?????????
		product.setProductCode(productCode);
		// thumbnail set
		String productImg = productCode+".png";
		product.setThumbnail(productImg);
		
		// ???????????? ????????? ?????? ??????		
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
		
		// prodcut Map??? ??????
		param.put("productDetailList", productDetailList);
				
		log.debug("product = {}",product); 
		log.debug("productDetailList = {}",productDetailList); 
					
		
		String fileDirectory = application.getRealPath("/resources/upload/product/")+productCode+".png";
		String saveDirectory = application.getRealPath("/resources/upload/product");
		log.debug("saveDirectory = {}",saveDirectory);
		
		// ?????? ????????? ?????? ????????? ??????
		String newProductImg="";
		if(!upFile.isEmpty()) {		
			try {		
				// ????????? ??????????????? ??????
				File delFile = new File(fileDirectory);
				boolean fileDelete = delFile.delete();
				log.debug("fileDelete = {}", fileDelete);
		
				// ?????? ????????? ??????
				File dest = new File(saveDirectory, productImg);
				upFile.transferTo(dest);			
				
				// ?????? ????????? ?????? ??? set??? ??? update
				// ?????? ?????? ??????(??????????????? ?????? ??????)
				product.setThumbnail(productImg);
			} catch (Exception e) {
				e.printStackTrace();
			}
					 
		}
			
		
		param.put("product", product);
		
		result = productService.updateProduct(param);
		
		
		String msg = "?????? ?????? ?????? !!";
		redirectAttr.addFlashAttribute("msg",msg);
		return "redirect:/admin/product/productMain.do";
	}
	
	// ?????? ???????????? ??????
	@GetMapping("/product/productCategory.do")
	public void productCategory(Model model) {
		List<ProductParentCategory> list = productCategoryService.selectAllParentCategory();
		List<ProductChildCategory> cList = productCategoryService.selectAllChildCategory();
		
		log.debug("list = {}", list);
		log.debug("cList = {}", cList);
		
		model.addAttribute("cList",cList);
		model.addAttribute("list",list);
	}
	

		
	// ???????????? ????????? ?????? & ?????? ????????????.
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
	
	// ?????? ???????????? ??????
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
		
		redirectAttr.addFlashAttribute("msg","?????? ???????????? ?????? ??????.");
		
		return "redirect:/admin/product/productCategory.do";
	}
		
	// ???????????? ????????? ??? ????????????
	@GetMapping("/productCategory/selectParentCategory.do")
	@ResponseBody
	public Map<String,Object>selectParentCategory(){
		Map<String,Object>map = new HashMap<>();
		List<ProductParentCategory>parentCategoryList = productCategoryService.selectParentCategory();
		
		log.debug("parentCategoryList = {}",parentCategoryList);
		
		map.put("parentCategoryList", parentCategoryList);
		return map;
	}
	
	// ?????? ???????????? ??????
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
		
		redirectAttr.addFlashAttribute("msg","?????? ???????????? ?????? ??????");
		return "redirect:/admin/product/productCategory.do";
	}
	
	// ?????? ???????????? ?????? ????????????
	@ResponseBody
	@GetMapping("/productCategory/checkCategoryCode.do")
	public Map<String,Object> checkCategoryCode(
				@RequestParam(required = false) String afterUpdateCategoryCode
			) {
		Map<String,Object>map = new HashMap<>(); 
		
		log.debug("afterUpdateCategoryCode = {}",afterUpdateCategoryCode);
		
		
		// ?????????, ????????? ??? ???????????? ????????? ??? ?????? ?????? ????????? true??? ??????
		List<ProductParentCategory> productCategoryList  = productCategoryService.selectCategoryCode(afterUpdateCategoryCode);		
		
		log.debug("productCategory = {}",productCategoryList);
		
		if(productCategoryList.isEmpty()) {
			log.debug("????????????");
			map.put("result", true);
		}
		else {
			log.debug("?????? ?????????-------------");
			map.put("result", false);
		}
		
		
		map.put("afterUpdateCategoryCode", "["+afterUpdateCategoryCode+"]");
		return map;
	};
	
	// ?????? ???????????? ?????? ????????????
	@ResponseBody
	@GetMapping("/productCategory/checkCategoryTitle.do")
	public Map<String,Object> checkCategoryTitle(
			@RequestParam(required = false) String afterUpdateCategoryTitle
			) {
		Map<String,Object>map = new HashMap<>(); 
		
		log.debug("afterUpdateCategoryTitle = {}",afterUpdateCategoryTitle);
		
		
		// ?????????, ????????? ??? ???????????? ????????? ??? ?????? ?????? ????????? true??? ??????
		List<ProductParentCategory> productTitleList = productCategoryService.selectCategoryTitle(afterUpdateCategoryTitle);			
		
		
		log.debug("productTitle = {}",productTitleList);

		
		if(productTitleList.isEmpty()) {
			log.debug("??????????????? ??????");
			map.put("result", true);
		}
		else {
			log.debug("?????? ????????? ???-------------");
			map.put("result", false);
		}
		
		
		
		map.put("afterUpdateCategoryTitle", "["+afterUpdateCategoryTitle+"]");
		return map;
	};
	
	// ?????? ???????????? ????????????
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
		
		redirectAttr.addFlashAttribute("msg","???????????? ??????.");
		
		return "redirect:/admin/product/productCategory.do";
	}
	
	
	
	
	
	
	
	
	/**
	 * -------------------------------- ??????
	 * 
	 */
	
	
	// ?????? ?????? ??????
	@GetMapping("/memberManage/memberLevel.do")
	public void memberLevel(	
			Model model,
			@RequestParam(defaultValue = "1") int cPage,
			HttpServletRequest request
			) {
		// 1.????????? ?????? : ????????? ??????
		int limit = 5;
		int offset = (cPage - 1) * limit;
		
		// ????????? ????????? ????????????
		List<Member>memberList = memberManageService.selectAllMember(offset,limit);

		log.debug("list = {}" ,memberList);	
		model.addAttribute("list",memberList);
		
		// 2. ?????????????????? totalContent
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
	

	// ???????????? ???????????????
	@ResponseBody
	@GetMapping("/memberManage/searchMember.do")
	public Map<String,Object>searchMember(
			@RequestParam String searchType,
			@RequestParam String searchKeyword,
			@RequestParam(defaultValue = "1") int cPage,
			HttpServletRequest request
			){
		// ?????? ????????? ?????? ??? searchType??? all ???????????? ?????? ???
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
		
		// 1.????????? ????????? ????????????
		String url = request.getRequestURI()+"?searchType="+searchType+"&searchKeyword="+searchKeyword;
		log.debug("url = {}", url);
		
		List<Member>memberList = memberManageService.searchMemberList(param);
		String memberStr = DevrunUtils.getMemberList(memberList);
		
		// 2.????????? ????????? ???
		int totalContent = memberManageService.searchMemberListCount(param);
		
		// 3.????????? ???
		log.debug("pagebarUrl = {}",url);
		String pagebar = DevrunUtils.getPagebar2(cPage, limit, totalContent, url);
		log.debug("pagebar = {}", pagebar);
				
		
		map.put("memberList",memberList);
		map.put("totalContent",totalContent);
		map.put("pagebar",pagebar);
		map.put("memberStr",memberStr);
		return map;
	}
	
	// ?????? ?????? ????????????
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
		String msg = "?????? ???????????? ??????!";
		
		redirectAttr.addFlashAttribute("msg",msg);
		return "redirect:/admin/memberManage/memberLevel.do";
	}
	
	//=======================================================
	
	// ?????? ?????? ??????
	@GetMapping("/memberManage/questionProduct.do")
	public void memberInquiry(
			Model model,
			@RequestParam(defaultValue = "1") int cPage,
			HttpServletRequest request
			) {
	
		// 1.????????? ?????? : ????????? ??????
		int limit = 5;
		int offset = (cPage - 1) * limit;
		
		// ????????? ????????? ????????????
		List<QuestionProduct> questionList = questionProductService.selectAllQuestionList(limit,offset);
		log.debug("questionList = {}" ,questionList);	

		
		// 2. ?????????????????? totalContent(????????? ??????)
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
	
	// ?????? ?????? ?????? ????????????
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
		
		redirectAttr.addFlashAttribute("msg","?????? ?????? ??????.");
		return "redirect:/admin/memberManage/questionProduct.do";
	}
	
	// ???????????? ?????? ????????????
	@PostMapping("/questionProduct/insertQuestionProduct.do")
	public String insertQuestionProduct(
			QuestionProduct questionProduct,
			RedirectAttributes redirectAttr,
			Authentication authentication,
			@RequestParam String answer
			
			) {
		// ???????????? ????????? content??? ??????
		questionProduct.setContent(answer);
		// ?????? ????????? ?????? ??????????????? ???????????? member_no
		Member member = (Member)authentication.getPrincipal();
		log.debug("member = {}",member);

		// ???????????? title??? answer??? ???????????????.
		questionProduct.setTitle("answer");
		
		// ????????? ?????? ????????? ?????? ????????? ?????? ?????? ????????? ????????????
		questionProduct.setQuestionRefNo(questionProduct.getQuestionNo());
		
		// ??????????????? ????????? ????????? 2 
		questionProduct.setQuestionLevel(2);
		
		// ????????? ?????? ?????? ????????? 'N'??? ?????????
		if(questionProduct.getPrivateYn() == '\u0000') {
			questionProduct.setPrivateYn('N');
		}
				
		
		log.debug("questionProduct = {}",questionProduct);
		
		
		
		int reuslt = questionProductService.insertQuestionProduct(questionProduct);
		  
		String msg = "????????? ???????????????."; redirectAttr.addFlashAttribute("msg",msg);
		 
		return "redirect:/admin/memberManage/questionProduct.do";
	}
	
		// ?????? ?????? & ?????? ?????? ???????????? ?????????
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
			
			// ????????? ????????? ?????? ?????? ????????????
			QuestionProductEx questionProductInfo = questionProductService.selectOneQuestionProductInfo(param);
			log.debug("questionProductInfo = {}",questionProductInfo);
			
			// ????????? ?????? ????????? ?????? ?????? ?????? ????????? ??????????????? ????????????
			QuestionProduct questionProduct = questionProductService.selectQuestionByRefNo(questionNo);
			
			String answer = "no";
			
			if(questionProduct != null) {
				answer = questionProduct.getContent();
				log.debug("????????? ????????????~~~~~");
			}
			else {
				log.debug("????????? ????????????.");
			}
					
			map.put("answer",answer);
			map.put("questionProductInfo",questionProductInfo);
			return map;	
		}
		
		// ????????? ?????? & ????????? ??????
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
			// ?????? ????????? ?????? ??? searchType??? all ???????????? ?????? ???
			if(searchType == "" || searchType == null) {
				searchType = "all";
			}
			
			// jsp?????? ?????? ????????? undefind??? ?????? ????????? ????????? ?????? mapper?????? ????????? ??? ????????? ?????? null??? ?????? 
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
			
			// 1.????????? ????????? ????????????
			String url = request.getRequestURI()+"?searchType="+searchType+"&searchKeyword="+searchKeyword;
			log.debug("url = {}", url);
			
			List<QuestionProduct>questionList = questionProductService.searchQuestionList(param);
			log.debug("questionList  = {}",questionList );
			
			String questionStr = QuestionProductUtils.getQuestionList(questionList);
			log.debug("questionStr = {}",questionStr);
			
			
			// 2.????????? ????????? ???					
			int totalContent = questionProductService.searchQuestionListCount(param);				
					
				
			// 3.????????? ???
			log.debug("pagebarUrl = {}",url);
			String pagebar = QuestionProductUtils.getPagebarQuestion(cPage, limit, totalContent, url);
			log.debug("pagebar = {}", pagebar);
					
			
			map.put("questionList",questionList);
			map.put("totalContent",totalContent);
			map.put("pagebar",pagebar);
			map.put("questionStr",questionStr);
			
			return map;
		}
	
	
				
		

	//--------------------?????? ???-----------------------------

	
		
		


	/**
	 * ?????? ?????? 
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
		
		//??????, ??????, ?????? ?????? ????????? ????????????
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
			Calendar cal = Calendar.getInstance();	 //?????? ????????? ?????? Calendar ??????????????? ?????? getInstance()????????? ??????	
			cal.setTime(endDate);	
			cal.add(Calendar.DATE, 1);	//?????? ?????????
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
			returnVal.put("msg", "?????? ?????? ????????? ?????????????????????.");
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
				resultMap.put("msg", "????????? ?????????????????????.");
			}
			else if(isValid == 1){
				
				if(!"EXC".equals((String)param.get("csStatus"))) {
					
					// ???????????? ???????????? 
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
						resultMap.put("msg", "???????????????????????????");
					}
						
				}else {
					Map<String, Object> exchangeParam = new HashMap<>();
					exchangeParam.put("keyword", "END_DATE");
					exchangeParam.put("orderLogUid", param.get("orderLogUid"));
					exchangeParam.put("costStatus", "Y");
					exchangeParam.put("detailList", (List<Map<String, Object>>)param.get("detailList"));
					log.debug("updateParam = {}", exchangeParam);
					result = orderService.updateOrderLog(exchangeParam);
					resultMap.put("msg", "???????????????????????????");
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
	
	
	//????????? ?????? ????????? ?????? ?????????
	@GetMapping("/promotionManage.do")
	public String promotionManage(Model model) {
		List<Promotion> list = promotionService.selectAllPromotionList();
		log.debug("list = {}", list);
		model.addAttribute("promotionList", list);
		return "/admin/promotion/promotionManage";
	}
	
	
	//????????? ?????? ????????? ?????? ?????????
	@GetMapping("/promotionDetail.do")
	public String promotionDetail(@RequestParam String promotionCode, Model model) {
		log.debug("promotionCode = {}", promotionCode);
		Promotion promotion = promotionService.selectPromotionWithProductByPromotionCode(promotionCode);
		log.debug("promotion = {}", promotion);
		model.addAttribute("promotion", promotion);
		return "/admin/promotion/promotionDetail";
	}
	
	//????????? ???????????? ?????????
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
			//application ??????(ServletContext)
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
			
			//db??? ????????? ??????
			Map<String, Object> param = new HashMap<>();
			param.put("promotion", promotion);
			param.put("changeProductList", changeProductList);
			param.put("deleteProductList", deleteProductList);
			int result = promotionService.updatePromotion(param);
			log.debug("result = {}", result);
			
			redirectAttr.addFlashAttribute("msg", "????????? ????????? ?????????????????????.");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		
		return "redirect:/admin/promotionDetail.do?promotionCode="+promotionCode;	
	}
	
	//????????? ?????? ?????????
	@PostMapping("/promotionDelete.do")
	public String promotionDelete(@RequestParam String[] promotionCode, RedirectAttributes redirectAttr) {
		log.debug("promotionCode = {}", promotionCode);
		try {
			//?????? ?????? ??????
			String saveDirectory = application.getRealPath("/resources/upload/promotion/");
			for(String str : promotionCode) {
				File banner = new File(saveDirectory+str+".png");
				log.debug("banner = {}", banner);
				if(banner.exists()) banner.delete();
			}
			
			int result = promotionService.deletePromotion(promotionCode);
			log.debug("result = {}", result);
			
			redirectAttr.addFlashAttribute("msg", "???????????? ?????????????????????.");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/admin/promotionManage.do";
	}
	
	//????????? ?????? ?????? ?????????
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
			//promotion_code ??????
			promotionCode = "PROMO_" + DevrunUtils.getRandomNo();
			promotion.setPromotionCode(promotionCode);
			
			//application ??????(ServletContext)
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
			
			//db??? ????????? ??????
			Map<String, Object> param = new HashMap<>();
			param.put("promotion", promotion);
			param.put("list", list);
			int result = promotionService.insertPromotion(param);
			log.debug("result = {}", result);
			
			redirectAttr.addFlashAttribute("msg", "????????? ????????? ?????????????????????.");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		
		return "redirect:/admin/promotionDetail.do?promotionCode="+promotionCode;
	}
	
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		// ????????????, ??????????????????("" -> null)
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
		
		// ?????? ????????? ??????
		File dest = new File(saveDirectory, banner);
		upFile.transferTo(dest);
	}
	
	
}
