package com.kh.devrun.member.controller;

import java.beans.PropertyEditor;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.devrun.member.model.service.MemberService;
import com.kh.devrun.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;


@Slf4j
@Controller
@RequestMapping("/member")
public class MemberController{
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
	
	@GetMapping("/memberLogin.do")
	public void memberLogin() {}
	
	/**
	 * 혜진 회원가입 시작
	 */
	@GetMapping("/memberEnroll")
	public void memberEnroll() {}
	
	@ResponseBody
	@GetMapping("/checkEnrollDuplicate")
	public Map<String, Object> checkIdDuplicate(@RequestParam Map<String, Object> param){
		log.debug("param = {}", param);
		Map<String, Object> map = new HashMap<>();
		Member member = memberService.selectOneMember(param);
		log.debug("member = {}", member);
		map.put("available", member == null);
		
		return map;
	}
	
	@PostMapping("/memberEnroll")
	public String memberEnroll(Member member, RedirectAttributes redirectAttr) {
		log.debug("member = {}", member);
		
		try {
			String rawPassword = member.getPassword();
			String encryptedPassword = passwordEncoder.encode(rawPassword);
			member.setPassword(encryptedPassword);
			if(member.getSmsYn() == null) {
				member.setSmsYn("N");
			}
			
			int result = memberService.insertMember(member);
			
			redirectAttr.addFlashAttribute("msg", "데브런 회원가입을 축하합니다.");
		} catch (Exception e) {
			log.error("회원가입 실패", e);
			throw e;
		}
		
		return "redirect:/";
	}
	
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		// 형식객체, 빈값허용여부("" -> null)
		PropertyEditor editor = new CustomDateEditor(sdf, true);
		binder.registerCustomEditor(Date.class, editor);
	}
	
	/**
	 * 혜진 회원가입 끝
	 */
	
	/**
	 * 지영 아이디/비밀번호 찾기 시작
	 */
	
	@GetMapping("/memberFindIdPassword.do")
	public void memberFindIdPassword() {}
	
	/**
	 * 아이디 찾기
	 */
	@GetMapping("/{name}/{email}/findId.do")
	public String findId(@PathVariable String name, @PathVariable String email, Model model) {
		
		Map<String, Object> param = new HashMap<>();
		param.put("name", name);
		param.put("email", email);
		
		// 이름과 이메일로 아이디 조회
		String id = memberService.findId(param);
		log.debug("id = {}", id);
		
		model.addAttribute("id", id);
		
		return "member/memberFindIdPopup";
		
	}
	
	/**
	 * 지영 아이디/비밀번호 찾기 끝
	 */
}

