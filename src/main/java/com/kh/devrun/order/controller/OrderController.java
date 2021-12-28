package com.kh.devrun.order.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/order")
public class OrderController {

	
	@GetMapping("/order/{productCode}")
	public void order(@PathVariable String productCode) {
		log.debug("productCode = {}", productCode);
	}
}
