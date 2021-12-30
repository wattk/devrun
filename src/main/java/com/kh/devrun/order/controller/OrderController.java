package com.kh.devrun.order.controller;

import java.util.ArrayList;
import java.util.List;

import javax.mail.Address;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.devrun.member.model.service.MemberService;
import com.kh.devrun.member.model.vo.Member;
import com.kh.devrun.order.model.service.OrderService;
import com.kh.devrun.order.model.vo.Imp;
import com.kh.devrun.order.model.vo.Merchant;
import com.kh.devrun.order.model.vo.MerchantDetail;
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
	
	@Autowired
	private OrderService orderService;

	
	@GetMapping("/order/{detailNo}")
	public String order(@PathVariable int detailNo, Model model, Authentication authentication) {
		log.debug("productCode = {}", detailNo);
		Member member = (Member)authentication.getPrincipal();
		Product product = productService.selectOneProductByDetailNo(detailNo);
		List<Address> addressList = memberService.selectAddressListByMemberNo(member.getMemberNo());
		log.debug("product = {}", product);
		model.addAttribute("product", product);
		model.addAttribute("addressList", addressList);
		
		return "/order/order";
	}
	
	@PostMapping("/orderEnroll")
	@ResponseBody
	public Merchant orderEnroll(Merchant merchant, @RequestParam("detailNo")int detailNo) {
		log.debug("order = {}", merchant);
		
		List<MerchantDetail> list = new ArrayList<>(); 
		list.add(new MerchantDetail(merchant.getMerchantUid(), detailNo, 1)) ;
		int result = orderService.insertDirectOrder(merchant, list);
		
		return merchant;
	}
	
	@PostMapping("/impEnroll")
	public String impEnroll(Imp imp) {
		log.debug("imp = {}", imp);
		int result = orderService.insertImp(imp);
		log.debug("imp result = {}", result);
		
		return "redirect:/mypage/orderDetail.do";
	}
}
