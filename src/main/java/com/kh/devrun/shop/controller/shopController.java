package com.kh.devrun.shop.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.devrun.promotion.model.service.PromotionService;
import com.kh.devrun.promotion.model.vo.Promotion;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/shop")
public class shopController {
	
	@Autowired
	private PromotionService promotionService;
	
	@GetMapping("/shopMain.do")
	public String shopMain() {
		
		return "shop/shopMain";
		
	}
	
	
	
	@GetMapping("/shopSearch.do")
	public void shopSearch() {}
	
	@GetMapping("/shopCategory.do")
	public void shopCategory() {}

	@GetMapping("/itemDetail.do")
	public void itemDetail() {}
	
	/**
	 * 혜진 작업 시작 
	 */
	@GetMapping("/promotion.do")
	public void promotion(Model model) {
		try {
			List<Promotion> currentPromotionList = promotionService.selectCurrentPromotionList();
			List<Promotion> endPromotionList = promotionService.selectEndPromotionList();
			
			model.addAttribute("currentPromotionList", currentPromotionList);
			model.addAttribute("endPromotionList", endPromotionList);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@GetMapping("/promotionDetail.do")
	public void promotionDetail(@RequestParam String promotionCode, Model model) {
		log.debug("promotionCode = {}", promotionCode);
		
		try {
			Promotion promotion = promotionService.selectPromotionByPromotionCode(promotionCode);
			model.addAttribute("promotion", promotion);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	/**
	 * 혜진 작업 끝
	 */

}
