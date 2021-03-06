package com.kh.devrun.questionProductCus.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.devrun.common.ShopUtils;
import com.kh.devrun.member.model.vo.Member;
import com.kh.devrun.order.model.service.OrderService;
import com.kh.devrun.product.model.service.ProductService;
import com.kh.devrun.product.model.vo.ProductDetail;
import com.kh.devrun.product.model.vo.ProductEx;
import com.kh.devrun.promotion.model.service.PromotionService;
import com.kh.devrun.questionProduct.model.vo.QuestionProduct;
import com.kh.devrun.questionProductCus.model.service.CusQuestionProductService;
import com.kh.devrun.questionProductCus.model.vo.QuestionProductId;
import com.kh.devrun.report.model.service.ReportService;
import com.kh.devrun.shop.model.service.ShopService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class QuestionProductController {
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
	//----------------------------------------------------
	
	@Autowired
	CusQuestionProductService cusQuestionProductService;
	
	
	@GetMapping("shop/itemDetail/ty/{productCode}")
	private String questionProduct(
			@PathVariable String productCode,
			Model model,
			Authentication authentication,
			QuestionProduct questionProduct,
			RedirectAttributes redirectAttr
			
			) {
			
		
		// ?????? ?????? ======================================================================================
			Member loginMember = null;
			String loginMemberId = null;
			String authority = null;
			if(authentication != null){
				loginMember = (Member)authentication.getPrincipal();
				loginMemberId = loginMember.getId();
				log.debug("loginMemberId = {}",loginMemberId);				
				authority = loginMember.getAuthorities().toString();
				log.debug("????????? ????????? ?????? = {}",authority);
			}
				
			// ?????? ??????
			ProductEx product = productService.selectOneItem(productCode);
			model.addAttribute("product", product);
	
			// ?????? ????????? ??????
			List<ProductDetail> pDetail = productService.selectProductDetail(productCode);
			model.addAttribute("pDetail", pDetail);
			

			// ?????? ????????? ?????? ?????? ?????? 
			List<QuestionProductId>questionList = cusQuestionProductService.selectQuestionList(productCode); 
			log.debug("questionList = {}",questionList);
			
			model.addAttribute("loginMemberId",loginMemberId);
			model.addAttribute("authority",authority);
			model.addAttribute("productCode",productCode);
			model.addAttribute("questionList",questionList);
			
			// ?????? ?????? ========================================================================================================	
			
		return "/shop/itemDetailTaeYoung";
	}
	
	
	//  ?????? ?????? ??????
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
		// ?????? ????????? ?????? ??????????????? ???????????? member_no
		Member member = (Member)authentication.getPrincipal();
		log.debug("member = {}",member);
		
		// ??????????????? ????????? ????????? 1
		param.put("questionLevel",1);
		param.put("questionRefNo",null);
		param.put("productCode", productCode);
		param.put("memberNo", member.getMemberNo());
		param.put("title", title);
		param.put("content", content);
		param.put("privateYn", cprivateYn);
		
		log.debug("param = {}",param);
		
		int result = cusQuestionProductService.insertQuestionProduct(param);		
		
		
		redirectAttr.addFlashAttribute("msg","?????? ?????? ?????? ??????!");
		return "redirect:/shop/itemDetail/ty/"+productCode;
	}

	// ??? ?????? ??????
	@ResponseBody
	@GetMapping("/shop/checkMyQuestionProduct")
	public Map<String,Object>checkMyQuestionProduct(
				@RequestParam String productCode,
				Authentication authentication
			){
		Map<String,Object>map = new HashMap<>();
		
		// ?????? ????????? ?????? ??????????????? ???????????? member_no
		Member member = (Member)authentication.getPrincipal();
		
		int memberNo = member.getMemberNo();
		log.debug("member = {}",member);
		
		Map<String,Object>param = new HashMap<>();
		
		param.put("productCode", productCode);
		param.put("memberNo", memberNo);
		
		 List<QuestionProduct>  myQuestionList = cusQuestionProductService.checkMyQuestionProduct(param);
		log.debug("myQuestionList",myQuestionList);
		
		
		map.put("myQuestionList", myQuestionList);
		return map;
	}
	
	
	
}
