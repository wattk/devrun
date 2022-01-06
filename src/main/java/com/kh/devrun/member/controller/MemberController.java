package com.kh.devrun.member.controller;

import java.beans.PropertyEditor;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang.RandomStringUtils;
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
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.devrun.common.mail.MailUtils;
import com.kh.devrun.member.model.service.MemberService;
import com.kh.devrun.member.model.vo.Member;

import com.kh.devrun.security.model.service.SecurityService;

import com.kh.devrun.product.model.service.ProductService;
import com.kh.devrun.product.model.vo.ProductEntity;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/member")
@SessionAttributes({ "next" })
public class MemberController {

	@Autowired
	private MemberService memberService;

	@Autowired
	private SecurityService securityService;

	@Autowired
	private ProductService productService;

	@Autowired
	private BCryptPasswordEncoder passwordEncoder;

	@GetMapping("/memberLogin.do")
	public void memberLogin(@RequestHeader("Referer") String referer, Model model) {
		log.debug("referer = {}", referer);
		model.addAttribute("next", referer);
	}

	/**
	 * 혜진 회원가입 시작
	 */

	@GetMapping("/memberEnroll")
	public void memberEnroll() {
	}

	@ResponseBody
	@GetMapping("/checkEnrollDuplicate")
	public Map<String, Object> checkIdDuplicate(@RequestParam Map<String, Object> param) {
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
			log.debug("{} -> {}", rawPassword, encryptedPassword);
			if (member.getSmsYn() == null) {
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

	@GetMapping("/wishlist.do")
	public void wishlist() {
	}

	/**
	 * 혜진 회원가입 끝
	 */

	/**
	 * 지영 아이디/비밀번호 찾기 시작
	 */

	@GetMapping("/memberFindIdPassword.do")
	public void memberFindIdPassword() {
	}

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
	 * 비밀번호 찾기 - 임시 비밀번호 이메일 발송
	 */
	@PostMapping("/{id}/{email}/findPassword.do")
	public String findPassword(@PathVariable String id, @PathVariable String email, Model model) throws Exception {

		Map<String, Object> param = new HashMap<>();
		param.put("id", id);
		param.put("email", email);

		// 기존 DB에 입력한 아이디와 이메일이 있는지 확인
		Member member = memberService.selectOneMemberByIdEmail(param);

		// member 조회 성공 시
		if (member != null) {
			// 암호화 처리되지 않은 비밀번호
			// RandomStringUtils의 randomAlphanumeric메소드를 호출하면 알파벳(대소문자)+숫자 랜덤 값을 얻을 수 있다.
			String rawPassword = RandomStringUtils.randomAlphanumeric(6);
			param.put("rawPassword", rawPassword);

			// 암호화 처리된 비밀번호
			String encryptedPassword = passwordEncoder.encode(rawPassword);
			member.setPassword(encryptedPassword);

			log.info("{} -> {}", rawPassword, encryptedPassword);

			// 임시 비밀번호 이메일 발송
			MailUtils.mailSendWithPassword(id, rawPassword, email);

			// 비밀번호 업데이트
			int result = memberService.updateMemberPassword(member);
		}

		model.addAttribute("member", member);

		return "member/memberFindPasswordPopup";

	}

	/**
	 * 지영 아이디/비밀번호 찾기 끝
	 */
}
