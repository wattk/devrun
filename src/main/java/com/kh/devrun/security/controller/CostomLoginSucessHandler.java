package com.kh.devrun.security.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.SavedRequest;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CostomLoginSucessHandler implements AuthenticationSuccessHandler {

	private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {

		String targetUrl = "/";

		// session 받기
		HttpSession session = request.getSession();

		List<String> authList = new ArrayList<>();
		String location = request.getContextPath() + "/";

		// 들어온 사용자의 권한을 authList에 추가 (여러개일 수 있으므로 하나씩 담음.)
		authentication.getAuthorities().forEach(auth -> {
			authList.add(auth.getAuthority());
		});

		log.debug("들어오는 사용자 = {}", authentication.getName());
		log.debug("가진권한 = {}", authentication.getAuthorities());

		// 관리자일 경우
		if (authList.contains("ROLE_AM")) {
			log.debug("관리자 입니다.");
			response.sendRedirect(location + "admin/adminMain.do");
			return;
		}

		
		//로그인 후 원래 페이지로 리다이렉트 처리 
		String next = (String) session.getAttribute("next");
		log.debug("next: {}", next);

		if (next != null && !next.isEmpty()) {
			targetUrl = next;
			session.removeAttribute("next");
		}

		redirectStrategy.sendRedirect(request, response, targetUrl);
	}

}
