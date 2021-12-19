package com.kh.devrun.common.security;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CostomLoginSucessHandler implements AuthenticationSuccessHandler{

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		
		List<String> authList = new ArrayList<>();
		String location = request.getContextPath()+"/";
		
		// 들어온 사용자의 권한을 authList에 추가 (여러개일 수 있으므로 하나씩 담음.)
		authentication.getAuthorities().forEach(auth -> {
			authList.add(auth.getAuthority());
		});
		
		log.debug("들어오는 사용자 = {}", authentication.getName());
		log.debug("가진권한 = {}", authentication.getAuthorities());
		
		// 관리자일 경우
		if(authList.contains("ROLE_AM")) {
			log.debug("관리자 입니다.");
			response.sendRedirect(location +"admin/adminMain.do");
			return;
		}
		else if(authList.contains("ROLE_M1 ROLE_M2")) {
			log.debug("일반회원");
			response.sendRedirect(location);
			return;
		}
		 
		response.sendRedirect(location);
		
	}

	
}
