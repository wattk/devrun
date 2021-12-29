package com.kh.devrun.order.controller;

import java.util.List;

import javax.mail.Address;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.devrun.member.model.service.MemberService;
import com.kh.devrun.member.model.vo.Member;
import com.kh.devrun.product.model.service.ProductService;
import com.kh.devrun.product.model.vo.Product;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/order")
public class OrderController {
	
	@Autowired
	private ProductService productService;
	
	@Autowired
	private MemberService memberService;

	
	@GetMapping("/order/{productCode}")
	public String order(@PathVariable String productCode, Model model, Authentication authentication) {
		log.debug("productCode = {}", productCode);
		Member member = (Member)authentication.getPrincipal();
		Product product = productService.selectOneItem(productCode);
		List<Address> addressList = memberService.selectAddressListByMemberNo(member.getMemberNo());
		log.debug("AddressList = {}", addressList);
		model.addAttribute("product", product);
		model.addAttribute("addressList", addressList);
		
		return "/order/order";
	}
}
