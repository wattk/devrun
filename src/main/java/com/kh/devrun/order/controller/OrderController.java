package com.kh.devrun.order.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.devrun.address.model.vo.Address;
import com.kh.devrun.common.AdminUtils;
import com.kh.devrun.member.model.service.MemberService;
import com.kh.devrun.member.model.vo.Member;
import com.kh.devrun.order.model.service.OrderService;
import com.kh.devrun.order.model.vo.Imp;
import com.kh.devrun.order.model.vo.Merchant;
import com.kh.devrun.order.model.vo.OrderLog;
import com.kh.devrun.shop.model.vo.Cart;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/order")
public class OrderController {
	
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private OrderService orderService;

	@GetMapping("/cart.do")
	public void cart(Authentication authentication, Model model) {
		Member member = (Member) authentication.getPrincipal();
		
		List<Cart> list = orderService.selectCartList(member.getMemberNo());
		log.debug("cartList = {}", list);
		model.addAttribute("list", list);
		
	}
	
	@GetMapping("/order")
	public String order(Model model, Authentication authentication) {
		Member member = (Member)authentication.getPrincipal();
		List<Address> addressList = memberService.selectAddressListByMemberNo(member.getMemberNo());
		log.debug("addresssList = {}", addressList);
		model.addAttribute("addressList", addressList);
		
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
	
	@PostMapping("/orderLogEnroll")
	public String orderLogEnroll(OrderLog orderLog, HttpServletRequest request, HttpServletResponse response) {
		log.debug("orderLog = {}", orderLog);
			try {
				int result = orderService.insertOrderLog(orderLog);
				if(result > 0 ) {
					//주문 취소 건의 경우 곧바로 환불 가능한 access token 발급
					//보안상의 문제로 서버 사이드에서 요청 보낼 것
					if("CAN".equals(orderLog.getCsStatus())){
						Imp imp = orderService.selectOneImp(orderLog.getMerchantUid());
						// 아임포트 토큰생성 
						String requestUrl = "https://api.iamport.kr/users/getToken";
						String imp_key = URLEncoder.encode("8343794553669375", "UTF-8");
						String imp_secret = URLEncoder.encode("3ecaf2db93a1bded8267d09318b5d6ba441c1c412e19686b81ec859a6ffafc90abe92a15af22b138", "UTF-8");

						JSONObject json = new JSONObject();
						json.put("imp_key", imp_key);
						json.put("imp_secret", imp_secret);
						String _token = AdminUtils.getToken(request, response, json, requestUrl);
						log.debug("token = {}", _token);
						
						JSONObject json2 = new JSONObject();
						json2.put("reason", orderLog.getReasonDetail());
						json2.put("imp_uid", imp.getImpUid());
						json2.put("amount", imp.getAmount());
						
						String receipt = AdminUtils.getRefund(request, response, json2, _token);
						log.debug("cancelResult = {}", receipt);
						if(receipt != null) {
							Map<String, Object> param = new HashMap<>();
							param.put("keyword", "endDate");
							param.put("orderLogUid", orderLog.getOrderLogUid());
							result = orderService.updateOrderLog(param);
						}
					}
				}
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			} catch (Exception e) {
				e.printStackTrace();
			}
		return "redirect:/mypage/changeOrderList.do";
	}


}
