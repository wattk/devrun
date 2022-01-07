package com.kh.devrun.customerCenter.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.devrun.common.DevrunUtils;
import com.kh.devrun.customerCenter.model.service.CustomerCenterService;
import com.kh.devrun.customerCenter.model.vo.Notice;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/customerCenter")
public class customerCenterContoller {
	
	@Autowired
	private CustomerCenterService customerCenterService;
	
	/**
	 * 공지사항 리스트
	 */
	@GetMapping("/noticeList.do")
	public String noticeList(
			@RequestParam(defaultValue = "1") int cPage,
			@RequestParam(required = false) String searchType,
			@RequestParam(required = false) String searchKeyword,
			Model model,
			HttpServletRequest request) {
		// required = false 하면 기본값으로 파라미터를 전달받을 때, 값이 없다면 Exception 없이 코드를 실행시킨다.
		
		int limit = 10;
		int offset = (cPage - 1) * limit;
		
		Map<String, Object> param = new HashMap<>();
		param.put("searchType", searchType);
		param.put("searchKeyword", searchKeyword);
		
		// 1. 전체 공지 목록
		List<Notice> list = customerCenterService.selectAllNoticeList(param, offset, limit);
		log.debug("list = {}", list);
		model.addAttribute("noticeList", list);
		
		// 2. 전체 공지 수 totalCount
		int totalContent = customerCenterService.selectNoticeTotalCount(param);
		log.debug("totalContent = {}", totalContent);
		model.addAttribute("totalContent", totalContent);
		
		// 3. pagebar
		String url = request.getRequestURI(); // /devrun/admin/customerCenter/noticeList.do
		log.debug("getRequestURI() url = {}", url);
		String queryString = request.getQueryString(); // tel=123&id=abc
		log.debug("queryString = {}", queryString);
		if(queryString != null) {
			// cPage 파라미터 값은 하위 getPagebar에서 처리됨. cPage넘어온 파라미터를 url 또 추가되지 않도록 함
			// 3가지 경우의 수 존재함(검색의 경우는 무조건 다른 파라미터가 존재하며 cPage는 &cPage=? 상태로 온다. - 3번째 경우의 수)
			// 1. 검색을 통하지 않고 첫 페이지 버튼(아무페이지버튼이나) 클릭 시 파라미터 존재하지 않은 상태의 queryString이 cPage=? 인 경우
			// 2. cPage외의 파라미터가 존재하진 않지만 다른 페이지 버튼 클릭 시 &cPage=?로 넘어온 경우
			// 3. 검색으로 다른 파라미터가 존재하는 경우
			
			// 첫 번째 경우의 수 if, 나머지 else 처리
			if(queryString.replaceAll("cPage=[0-9]\\d*", "").isEmpty()) {
				url += queryString.replaceAll("cPage=[0-9]\\d*", "");
			} else {
				url += "?" + queryString.replaceAll("&cPage=[0-9]\\d*", "");
			}
		}
		log.debug("url = {}", url);
		
		String pagebar = DevrunUtils.getPagebar(cPage, limit, totalContent, url);
		log.debug("pagebar = {}", pagebar);
		model.addAttribute("pagebar", pagebar);

		return "customerCenter/noticeList";
	}
	
	
	/**
	 * 공지사항 상세 페이지
	 */
	@GetMapping("/noticeDetail.do")
	public String noticeDetail(
			@RequestParam int noticeNo, Model model, HttpServletRequest request, HttpServletResponse response) {
		log.debug("noticeNo = {}", noticeNo);
		
		// 조회 중복 방지
		boolean hasRead = DevrunUtils.hasRead(request, response, noticeNo, "notice");
		// 읽음 여부
		if (!hasRead) {
			// 조회수 증가
			int result = customerCenterService.updateViewCount(noticeNo);
			log.debug("result = {}", result);
		}
		
		Notice notice = customerCenterService.selectOneNotice(noticeNo);
		log.debug("notice = {}", notice);
		model.addAttribute("notice", notice);
		return "customerCenter/noticeDetail";
	}
	
	
	/**
	 * 자주묻는질문 리스트
	 */
	@GetMapping("/faq.do")
	public String faq(
			@RequestParam(defaultValue = "1") int cPage,
			@RequestParam(required = false) String noticeCode,
			@RequestParam(required = false) String searchKeyword,
			Model model,
			HttpServletRequest request) {
		log.debug("cPage = {}", cPage);
		
		int limit = 10;
		int offset = (cPage - 1) * limit;
		
		Map<String, Object> param = new HashMap<>();
		param.put("noticeCode", noticeCode);
		param.put("searchKeyword", searchKeyword);
		
		// 1. 전체 자주묻는질문 목록
		List<Notice> list = customerCenterService.selectAllFaqList(param, offset, limit);
		log.debug("list = {}", list);
		model.addAttribute("faqList", list);
		
		// 2. 전체 자주묻는질문 수 totalCount
		int totalContent = customerCenterService.selectFaqTotalCount(param);
		log.debug("totalContent = {}", totalContent);
		model.addAttribute("totalContent", totalContent);
		
		// 3. pagebar
		String url = request.getRequestURI(); // /devrun/admin/customerCenter/faq.do
		log.debug("getRequestURI() url = {}", url);
		String queryString = request.getQueryString(); // tel=123&id=abc
		log.debug("queryString = {}", queryString);
		if(queryString != null) {
			// cPage 파라미터 값은 하위 getPagebar에서 처리됨. cPage넘어온 파라미터를 url 또 추가되지 않도록 함
			// 3가지 경우의 수 존재함(검색의 경우는 무조건 다른 파라미터가 존재하며 cPage는 &cPage=? 상태로 온다. - 3번째 경우의 수)
			// 1. 검색을 통하지 않고 첫 페이지 버튼(아무페이지버튼이나) 클릭 시 파라미터 존재하지 않은 상태의 queryString이 cPage=? 인 경우
			// 2. cPage외의 파라미터가 존재하진 않지만 다른 페이지 버튼 클릭 시 &cPage=?로 넘어온 경우
			// 3. 검색으로 다른 파라미터가 존재하는 경우
			
			// 첫 번째 경우의 수 if, 나머지 else 처리
			if(queryString.replaceAll("cPage=[0-9]\\d*", "").isEmpty()) {
				url += queryString.replaceAll("cPage=[0-9]\\d*", "");
			} else {
				url += "?" + queryString.replaceAll("&cPage=[0-9]\\d*", "");
			}
		}
		log.debug("url = {}", url);
		
		
		String pagebar = DevrunUtils.getPagebar(cPage, limit, totalContent, url);
		log.debug("pagebar = {}", pagebar);
		model.addAttribute("pagebar", pagebar);

		return "customerCenter/faq";
	}

}
