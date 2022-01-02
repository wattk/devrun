package com.kh.devrun.order.controller;

import java.util.List;

import javax.mail.Address;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.devrun.member.model.service.MemberService;
import com.kh.devrun.member.model.vo.Member;
import com.kh.devrun.order.model.service.OrderService;
import com.kh.devrun.order.model.vo.Imp;
import com.kh.devrun.order.model.vo.Merchant;
import com.kh.devrun.product.model.service.ProductService;
import com.kh.devrun.product.model.vo.Product;
import com.kh.devrun.shop.model.vo.Cart;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/order")
public class OrderController {
	
	@Autowired
	private ProductService productService;
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private OrderService orderService;

	@GetMapping("/cart.do")
	public void cart(Authentication authentication, Model model) {
		Member member = (Member) authentication.getPrincipal();
		
		List<Cart> list = orderService.selectCartList(member.getMemberNo());
		
		model.addAttribute("list", list);
		
	}
	
	@GetMapping("/order")
	public String order(@RequestParam(value="detailNo") int[] detailNo, Model model, Authentication authentication) {
		log.debug("productCode = {}", detailNo);
		Member member = (Member)authentication.getPrincipal();
		List<Product> productList = productService.selectProductByDetailNo(detailNo);
		List<Address> addressList = memberService.selectAddressListByMemberNo(member.getMemberNo());
		log.debug("product = {}", productList);
		model.addAttribute("productList", productList);
		model.addAttribute("addressList", addressList);
		model.addAttribute("detailNo", detailNo);
		
		return "/order/order";
	}
	
	@PostMapping("/orderEnroll")
	@ResponseBody
	public Merchant orderEnroll(@RequestBody Merchant merchant) {
		log.debug("orderData = {}", merchant);
		int result = orderService.insertOrder(merchant);
		
		return merchant;
	}
	
	@PostMapping("/impEnroll")
	@ResponseBody
	public String impEnroll(@RequestBody Imp imp) {
		log.debug("imp = {}", imp);
		int result = orderService.insertImp(imp);
		log.debug("imp result = {}", result);
		String url = "/mypage/orderDetail/"+imp.getMerchantUid();
		
		return url;
	}
}
