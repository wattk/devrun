package com.kh.devrun.admin.controller;

import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.devrun.common.DevrunUtils;
import com.kh.devrun.customerCenter.model.service.CustomerCenterService;
import com.kh.devrun.customerCenter.model.vo.Notice;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/admin/customerCenter")
public class AdminCustomerCenterController {
	
	@Autowired
	private CustomerCenterService customerCenterService;
	
	/**
	 * 공지사항 관리 페이지 이동
	 */
	@GetMapping("/noticeManage.do")
	public String noticeManage(
			@RequestParam(defaultValue = "1") int cPage,
			@RequestParam(required = false) String searchType,
			@RequestParam(required = false) String searchKeyword,
			Model model,
			HttpServletRequest request) {
		// required = false 하면 기본값으로 파라미터를 전달받을 때, 값이 없다면 Exception 없이 코드를 실행시킨다.
		log.debug("cPage = {}", cPage);
		
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
		String url = request.getRequestURI(); // /devrun/admin/customerCenter/noticeManage.do
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

		return "admin/customerCenter/noticeManage";
	}
	
	/**
	 * 공지사항 등록 페이지 이동
	 */
	@GetMapping("/noticeEnroll.do")
	public String noticeEnroll() {
		return "admin/customerCenter/noticeEnroll";
	}
	
	/**
	 * 공지사항 등록
	 */
	@PostMapping("/noticeEnroll.do")
	public String noticeEnroll(Notice notice, RedirectAttributes redirectAttr) {
		log.debug("notice = {}", notice);
		try {
			// 공지사항 등록
			int result = customerCenterService.insertNotice(notice);
			log.debug("result = {}", result);
			
			redirectAttr.addFlashAttribute("msg", "공지사항 등록 완료");
		} catch (Exception e) {
			log.error("공지사항 등록 실패", e);
			throw e; // spring container에게 예외상황 알림
		} 
		
		return "redirect:/admin/customerCenter/noticeManage.do";
	}
	
	/**
	 * 공지사항 상세 페이지
	 */
	@GetMapping("/noticeDetail.do")
	public String noticeDetail(@RequestParam int noticeNo, Model model) {
		log.debug("noticeNo = {}", noticeNo);
		Notice notice = customerCenterService.selectOneNotice(noticeNo);
		log.debug("notice = {}", notice);
		model.addAttribute("notice", notice);
		return "admin/customerCenter/noticeDetail";
	}
	
	/**
	 * 공지사항 수정
	 */
	@PostMapping("/noticeUpdate.do")
	public String noticeUpdate(Notice notice, RedirectAttributes redirectAttr, HttpServletRequest request) {
		log.debug("notice = {}", notice);
		int noticeNo = notice.getNoticeNo();
		try {
			// 공지사항 수정
			int result = customerCenterService.updateNotice(notice);
			log.debug("result = {}", result);
			
			redirectAttr.addFlashAttribute("msg", "공지사항 수정 완료");
		} catch (Exception e) {
			log.error("공지사항 수정 실패", e);
			throw e; // spring container에게 예외상황 알림
		} 
		
//		return "redirect:/admin/customerCenter/noticeDetail.do?noticeNo="+noticeNo;
		String referer = request.getHeader("Referer");
		return "redirect:" + referer;
	}
	
	/**
	 * 공지사항 삭제
	 */
	@PostMapping("/noticeDelete.do")
	public String noticeDelete(
			@RequestParam int[] noticeNo,
			@RequestParam(defaultValue = "1") int cPage,
			@RequestParam(required = false) String searchType,
			@RequestParam(required = false) String searchKeyword,
			RedirectAttributes redirectAttr, 
			HttpServletRequest request) throws Exception {
		log.debug("noticeNo = {}", noticeNo);
		
		
		try {
			// searchKeyword ?? 로 나옴 - 한글깨짐현상 해결 https://m.blog.naver.com/software705/220645774923 참고
			log.debug("searchKeyword 어떻게 넘어옵니까? {}", searchKeyword);
			searchKeyword= URLEncoder.encode(searchKeyword, "UTF-8");
			log.debug("searchKeyword 인코딩됩니까? {}", searchKeyword);
			// 공지사항 삭제
			int result = customerCenterService.deleteNotice(noticeNo);
			log.debug("result = {}", result);
			
			redirectAttr.addFlashAttribute("msg", "공지사항 삭제 완료");
		} catch (Exception e) {
			log.error("공지사항 삭제 실패", e);
			throw e; // spring container에게 예외상황 알림
		} 
		
		String referer = request.getHeader("Referer");
		log.debug("referer = {}", referer);

		// 리스트 페이지에서 삭제하는 경우와 상세 페이지에서 삭제하는 경우가 존재한다. 
		if(referer.contains("noticeManage.do")) {
			// 리스트페이지에서 삭제하는 경우 - 이전 페이지로 리다이렉트
			return "redirect:" + referer;
		} else {
			return "redirect:/admin/customerCenter/noticeManage.do?searchType=" + searchType + "&searchKeyword=" + searchKeyword + "&cPage=" + cPage;
		}	
	}
	
	/**
	 * 자주묻는질문 관리 페이지 이동
	 */
	@GetMapping("/faqManage.do")
	public String faqManage(
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
		String url = request.getRequestURI(); // /devrun/admin/customerCenter/faqManage.do
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

		return "admin/customerCenter/faqManage";
	}
	
	/**
	 * 자주묻는질문 등록 페이지 이동
	 */
	@GetMapping("/faqEnroll.do")
	public String faqEnroll() {
		return "admin/customerCenter/faqEnroll";
	}
	
	/**
	 * 자주묻는질문 등록
	 */
	@PostMapping("/faqEnroll.do")
	public String faqEnroll(Notice notice, RedirectAttributes redirectAttr) {
		log.debug("notice = {}", notice);
		try {
			// 자주묻는질문 등록
			int result = customerCenterService.insertFaq(notice);
			log.debug("result = {}", result);
			
			redirectAttr.addFlashAttribute("msg", "자주묻는질문 등록 완료");
		} catch (Exception e) {
			log.error("자주묻는질문 등록 실패", e);
			throw e; // spring container에게 예외상황 알림
		} 
		
		return "redirect:/admin/customerCenter/faqManage.do";
	}
	
	/**
	 * 자주묻는질문 삭제
	 * @throws Exception 
	 */
	@PostMapping("/faqDelete.do")
	public String faqDelete(
			@RequestParam int[] noticeNo,
			@RequestParam(defaultValue = "1") int cPage,
			@RequestParam(required = false) String noticeCode,
			@RequestParam(required = false) String searchKeyword,
			RedirectAttributes redirectAttr, 
			HttpServletRequest request) throws Exception {
		log.debug("noticeNo = {}", noticeNo);

		
		try {
			// searchKeyword ?? 로 나옴 - 한글깨짐현상 해결 https://m.blog.naver.com/software705/220645774923 참고
			log.debug("searchKeyword 어떻게 넘어옵니까? {}", searchKeyword);
			searchKeyword= URLEncoder.encode(searchKeyword, "UTF-8");
			log.debug("searchKeyword 인코딩됩니까? {}", searchKeyword);
			
			// 자주묻는질문 삭제
			int result = customerCenterService.deleteNotice(noticeNo);
			log.debug("result = {}", result);
			
			redirectAttr.addFlashAttribute("msg", "자주묻는질문 삭제 완료");
		} catch (Exception e) {
			log.error("자주묻는질문 삭제 실패", e);
			throw e; // spring container에게 예외상황 알림
		}
		
		String referer = request.getHeader("Referer");
		log.debug("referer = {}", referer);

		// 리스트 페이지에서 삭제하는 경우와 상세 페이지에서 삭제하는 경우가 존재한다. 
		if(referer.contains("faqManage.do")) {
			// 리스트페이지에서 삭제하는 경우 - 이전 페이지로 리다이렉트
			return "redirect:" + referer;
		} else {
			return "redirect:/admin/customerCenter/faqManage.do?noticeCode=" + noticeCode + "&searchKeyword=" + searchKeyword + "&cPage=" + cPage;
		}	
	}
	
	/**
	 * 자주묻는질문 상세 페이지
	 */
	@GetMapping("/faqDetail.do")
	public String faqDetail(@RequestParam int faqNo, Model model) {
		log.debug("noticeNo = {}", faqNo);
		Notice faq = customerCenterService.selectOneNotice(faqNo);
		log.debug("notice = {}", faq);
		model.addAttribute("faq", faq);
		return "admin/customerCenter/faqDetail";
	}
	
	/**
	 * 자주묻는질문 수정
	 */
	@PostMapping("/faqUpdate.do")
	public String faqUpdate(Notice notice, RedirectAttributes redirectAttr, HttpServletRequest request) {
		log.debug("notice = {}", notice);

		try {
			// 자주묻는질문 수정
			int result = customerCenterService.updateFaq(notice);
			log.debug("result = {}", result);
			
			redirectAttr.addFlashAttribute("msg", "자주묻는질문 수정 완료");
		} catch (Exception e) {
			log.error("자주묻는질문 수정 실패", e);
			throw e; // spring container에게 예외상황 알림
		} 
		
//		return "redirect:/admin/customerCenter/faqDetail.do?faqNo="+faqNo;
		String referer = request.getHeader("Referer");
		return "redirect:" + referer;
	}
}
