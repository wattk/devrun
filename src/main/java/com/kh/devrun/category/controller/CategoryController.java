package com.kh.devrun.category.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.devrun.category.model.service.CategoryService;
import com.kh.devrun.category.model.vo.ProductChildCategory;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class CategoryController {
	
	@Autowired
	private CategoryService categoryService;

	@ResponseBody
	@GetMapping("/admin/selectCategory")
	public Map<String, Object>selectCategory(@RequestParam Map<String, Object> param){
		Map<String, Object> map = new HashMap<>();
		
		log.debug("param = {}", param);
		List<ProductChildCategory> list = categoryService.selectChildCategory(param);
		log.debug("list = {}" ,list);
		
		map.put("list",list);
		map.put("date", new Date());
		
		return map;
	}
	
}
