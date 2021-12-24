package com.kh.devrun.shop.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.kh.devrun.common.DevrunUtils;
import com.kh.devrun.promotion.model.service.PromotionService;
import com.kh.devrun.promotion.model.vo.Promotion;
import com.kh.devrun.shop.model.Review;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/shop")
public class shopController {
	
	@Autowired
	private PromotionService promotionService;
	
	@Autowired
	ServletContext application;
	
	
//--------------------주입-------------------------------------	
	
	
	
	
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
			Map<String, List<Promotion>> map = promotionService.selectDevidedPromotionList();
			
			model.addAttribute("currentPromotionList", map.get("currentPromotionList"));
			model.addAttribute("endPromotionList", map.get("endPromotionList"));
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
	 * @throws IOException 
	 * @throws IllegalStateException 
	 */
	
	
	
	@PostMapping("/review.do")
	public void review (Review review, MultipartFile upFile) throws IllegalStateException, IOException {
		log.debug("{}", review);
		log.debug("{}", upFile);
		
		String saveDirectory = application.getRealPath("/resources/upload/review");
		log.debug("saveDirectory = {}", saveDirectory);
		
		if(!upFile.isEmpty() && upFile.getSize()!= 0) {
			String originalFilename = upFile.getOriginalFilename();
			String renamedFilename = DevrunUtils.getRenamedFilename(originalFilename);
			log.debug("원래이름 : {} / 리네임 : {} ", originalFilename, renamedFilename);
			
			//1.서버 컴퓨터에 저장
			File dest = new File(saveDirectory, renamedFilename);//여기에다가 파일 저장해주세요임.
			upFile.transferTo(dest);
			
		}
		
		
	}

}
