package com.kh.devrun.questionProduct.utils;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Random;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.devrun.common.DevrunUtils;
import com.kh.devrun.member.model.vo.Member;
import com.kh.devrun.product.model.vo.ProductEntity;
import com.kh.devrun.questionProduct.model.vo.QuestionProduct;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class QuestionProductUtils {

	
	/**
	 * 페이징바 메소드
	 * 
	 * @param cPage
	 * @param numPerPage
	 * @param totalContents
	 * @param url
	 * @return
	 */
	public static String getPagebar(int cPage, int numPerPage, int totalContents, String url) {
		StringBuilder pagebar = new StringBuilder();

		// 전체페이지수
		int totalPage = (int) Math.ceil((double) totalContents / numPerPage);

		// 페이지번호를 클릭했을때 링크
		String delimeter = url.contains("?") ? "&" : "?";
		url = url + delimeter + "cPage="; // /spring/board/boardList.do?cPage=
		log.debug("Utils URL = {}",url);
		// 페이지바크기
		int pagebarSize = 5;

		/*
		 * 1 2 3 4 5 >>
		 * 
		 * << 6 7 8 9 10 >>
		 * 
		 * << 11 12
		 * 
		 * pageStart : 시작하는 pageNo - cPage와 pagebarSize에 의해 결정
		 */
		int pageStart = (cPage - 1) / pagebarSize * pagebarSize + 1;
		int pageEnd = pageStart + pagebarSize - 1;

		int pageNo = pageStart;

		pagebar.append("<nav class=\"pagebar\" aria-label=\"Page navigation example\">\n"
				+ "		  <ul class=\"pagination justify-content-center\">\n");

		// 1.이전
		if (pageNo == 1) {
			pagebar.append("<li class=\"page-item disabled\">\r\n"
					+ "		      <a class=\"page-link\" href=\"#\" aria-label=\"Previous\" tabindex=\"-1\">\r\n"
					+ "		        <span aria-hidden=\"true\">&laquo;</span>\r\n"
					+ "		        <span class=\"sr-only\">Previous</span>\r\n" + "		      </a>\r\n"
					+ "		    </li>\n");
		} else {
			pagebar.append(
					"<li class=\"page-item \">\r\n" + "		      <a class=\"page-link\" href=\"javascript:paging("
							+ (pageNo - 1) + ")\" aria-label=\"Previous\" >\r\n"
							+ "		        <span aria-hidden=\"true\">&laquo;</span>\r\n"
							+ "		        <span class=\"sr-only\">Previous</span>\r\n" + "		      </a>\r\n"
							+ "		    </li>\n");
		}

		// 2.pageNo
		while (pageNo <= pageEnd && pageNo <= totalPage) {
			if (pageNo == cPage) {
				// 현재페이지인 경우 링크 제공안함.
				pagebar.append("<li class=\"page-item active\"><a class=\"page-link\" href=\"#\">" + pageNo
						+ "<span class=\"sr-only\">(current)</span></a></li>\n");
			} else {
				// 현재페이지가 아닌 경우 링크를 제공.
				pagebar.append("<li class=\"page-item\"><a class=\"page-link\" href=\"javascript:paging(" + pageNo
						+ ")\">" + pageNo + "</a></li>\n");
			}

			pageNo++;
		}

		// 3.다음
		if (pageNo > totalPage) {
			pagebar.append("<li class=\"page-item disabled\">\r\n"
					+ "		      <a class=\"page-link\" href=\"#\" tabindex=\"-1\" aria-label=\"Next\">\r\n"
					+ "		        <span aria-hidden=\"true\">&raquo;</span>\r\n"
					+ "		        <span class=\"sr-only\">Next</span>\r\n" + "		      </a>\r\n"
					+ "		    </li>\n");
		} else {
			pagebar.append("<li class=\"page-item\">\r\n"
					+ "		      <a class=\"page-link\" href=\"javascript:paging(" + pageNo
					+ ")\" aria-label=\"Next\">\r\n" + "		        <span aria-hidden=\"true\">&raquo;</span>\r\n"
					+ "		        <span class=\"sr-only\">Next</span>\r\n" + "		      </a>\r\n"
					+ "		    </li>\n");
		}

		pagebar.append("		  </ul>\r\n" + "		</nav>\r\n" + "		<script>\r\n"
				+ "		const paging = (cPage) => {\r\n" + "			location.href = '" + url + "' + cPage;\r\n"
				+ "		}\r\n" + "		</script>\n");

		return pagebar.toString();
	}

	public static String getRenamedFilename(String originalFilename) {
		// 확장자 가져오기
		String ext = "";
		int dot = originalFilename.lastIndexOf(".");
		if (dot > -1)
			ext = originalFilename.substring(dot); // .txt .jpg .png

		// 형식지정
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmssSSS_");
		DecimalFormat df = new DecimalFormat("000"); // 30 -> 030

		// 새파일명
		return sdf.format(new Date()) + df.format(Math.random() * 999) + ext;
	}

	/**
	 * chat_dfslk23lskd341d
	 * 
	 * @return
	 */
	public static String getRandomNo() {
		Random rnd = new Random();
		StringBuffer sb = new StringBuffer();

		for (int i = 0; i < 15; i++) {
			if (rnd.nextBoolean()) {
				// 영문자 : 대문자 65~90, 소문자 97~122
				boolean isUpperCase = rnd.nextBoolean();
				char ch = (char) ((isUpperCase ? 65 : 97) + rnd.nextInt(26));
				sb.append(ch);
			} else {
				// 숫자
				sb.append(rnd.nextInt(10));
			}
		}

		return sb.toString();
	}

	/**
	 * chat_dfslk23lskd341d
	 * 
	 * @return
	 */
	public static String getRandomChatId() {
		Random rnd = new Random();
		StringBuffer sb = new StringBuffer();
		sb.append("chat_");
		for (int i = 0; i < 15; i++) {
			if (rnd.nextBoolean()) {
				// 영문자 : 대문자 65~90, 소문자 97~122
				boolean isUpperCase = rnd.nextBoolean();
				char ch = (char) ((isUpperCase ? 65 : 97) + rnd.nextInt(26));
				sb.append(ch);
			} else {
				// 숫자
				sb.append(rnd.nextInt(10)); // 0 ~ 9 사이의 숫자 생성되어 추가된다.
			}
		}

		return sb.toString();
	}



	/**
	 * 게시글 읽음 여부 확인
	 */
	public static boolean hasRead(HttpServletRequest request, HttpServletResponse response, String code, String param) {

		Cookie[] cookies = request.getCookies();
		boolean hasRead = false;
		String boardValue = "";

		if (cookies != null) {
			for (Cookie c : cookies) {
				String name = c.getName();
				String value = c.getValue();

				if (param.equals(name)) {
					boardValue = value;

					if (value.contains("|" + code + "|")) {
						hasRead = true;
					}
					break;
				}
			}
		}

		if (!hasRead) {
			Cookie cookie = new Cookie(param, boardValue + "|" + code + "|");// 그냥 숫자만 쓰면 혼동이 올 수 있으므로 no에 대한 padding문자
																				// 추가
			cookie.setMaxAge(365 * 24 * 60 * 60);
			if ("promotion".equals(param))
				cookie.setPath(request.getContextPath() + "/shop/promotionDetail.do");// 해당 경로 요청 시에만 쿠키 전송
				
			response.addCookie(cookie);
		}

		return hasRead;
	}
	
	/**
	 *  회원 목록 비동기로 띄우기
	 * @param url 
	 */
	public static String getMemberList(List<Member> memberList) {
		//DecimalFormat fmt = new DecimalFormat("###,###");
		StringBuilder sb = new StringBuilder();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		for (Member member : memberList) {
			sb.append(
			"<tr> \n"
				+"<td>"+member.getMemberNo()+"</td>\n"
				+"<td>"+member.getId() +"</td>\n"
				+"<td>"+member.getName()+"</td>\n"
				+"<td>"+member.getNickname()+"</td>\n"						
				+"<td>"+sdf.format(member.getEnrollDate())+"</td>\n"
				+"<td><select class=\"select-authority\">"	
				+"<option value=\"ROLE_AM\" "+(member.getAuthorities().toString().equals("[ROLE_AM]") ? "selected " : "")+" >관리자</option>"
				+"<option value=\"ROLE_M1\" "+(member.getAuthorities().toString().equals("[ROLE_M1]") ? "selected " : "")+" >지식인</option>"
				+"<option value=\"ROLE_M2\" "+(member.getAuthorities().toString().equals("[ROLE_M2]") ? "selected " : "")+" >일반 회원</option>"
				+"</select></td>\n"
					+"</tr>");
		}		
		return sb.toString();

	}
	public static String getPagebar2(int cPage, int numPerPage, int totalContents, String url) {
		StringBuilder pagebar = new StringBuilder();

		// 전체페이지수
		int totalPage = (int) Math.ceil((double) totalContents / numPerPage);

		// 페이지번호를 클릭했을때 링크
		String delimeter = url.contains("?") ? "&" : "?";
		url = url + delimeter + "cPage="; // /spring/board/boardList.do?cPage=
		log.debug("Utils URL = {}",url);
		// 페이지바크기
		int pagebarSize = 5;

		/*
		 * 1 2 3 4 5 >>
		 * 
		 * << 6 7 8 9 10 >>
		 * 
		 * << 11 12
		 * 
		 * pageStart : 시작하는 pageNo - cPage와 pagebarSize에 의해 결정
		 */
		int pageStart = (cPage - 1) / pagebarSize * pagebarSize + 1;
		int pageEnd = pageStart + pagebarSize - 1;

		int pageNo = pageStart;

		pagebar.append("<nav class=\"pagebar\" aria-label=\"Page navigation example\">\n"
				+ "		  <ul class=\"pagination justify-content-center\">\n");

		// 1.이전
		if (pageNo == 1) {
			pagebar.append("<li class=\"page-item disabled\">\r\n"
					+ "		      <a class=\"page-link\" href=\"#\" aria-label=\"Previous\" tabindex=\"-1\">\r\n"
					+ "		        <span aria-hidden=\"true\">&laquo;</span>\r\n"
					+ "		        <span class=\"sr-only\">Previous</span>\r\n" + "		      </a>\r\n"
					+ "		    </li>\n");
		} else {
			pagebar.append(
					"<li class=\"page-item \">\r\n" + "		      <a class=\"page-link\" href=\"javascript:getPage("
							+ (pageNo - 1) + ")\" aria-label=\"Previous\" >\r\n"
							+ "		        <span aria-hidden=\"true\">&laquo;</span>\r\n"
							+ "		        <span class=\"sr-only\">Previous</span>\r\n" + "		      </a>\r\n"
							+ "		    </li>\n");
		}

		// 2.pageNo
		while (pageNo <= pageEnd && pageNo <= totalPage) {
			if (pageNo == cPage) {
				// 현재페이지인 경우 링크 제공안함.
				pagebar.append("<li class=\"page-item active\"><a class=\"page-link\" href=\"#\">" + pageNo
						+ "<span class=\"sr-only\">(current)</span></a></li>\n");
			} else {
				// 현재페이지가 아닌 경우 링크를 제공.
				pagebar.append("<li class=\"page-item\"><a class=\"page-link\" href=\"javascript:getPage(" + pageNo
						+ ")\">" + pageNo + "</a></li>\n");
			}

			pageNo++;
		}

		// 3.다음
		if (pageNo > totalPage) {
			pagebar.append("<li class=\"page-item disabled\">\r\n"
					+ "		      <a class=\"page-link\" href=\"#\" tabindex=\"-1\" aria-label=\"Next\">\r\n"
					+ "		        <span aria-hidden=\"true\">&raquo;</span>\r\n"
					+ "		        <span class=\"sr-only\">Next</span>\r\n" + "		      </a>\r\n"
					+ "		    </li>\n");
		} else {
			pagebar.append("<li class=\"page-item\">\r\n"
					+ "		      <a class=\"page-link\" href=\"javascript:getPage(" + pageNo
					+ ")\" aria-label=\"Next\">\r\n" + "		        <span aria-hidden=\"true\">&raquo;</span>\r\n"
					+ "		        <span class=\"sr-only\">Next</span>\r\n" + "		      </a>\r\n"
					+ "		    </li>\n");
		}

		pagebar.append(" </ul>\r\n" + "</nav>\r\n" );

		return pagebar.toString();
	}

	public static String getQuestionList(List<QuestionProduct> questionList) {
		StringBuilder sb = new StringBuilder();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		for (QuestionProduct questionProduct : questionList) {
		
			sb.append(
					"<tr> \n"
							+"<td>"+questionProduct.getQuestionNo()+"</td>\n"
							+"<td>"+questionProduct.getMemberNo() +"</td>\n"
							+"<td>"+questionProduct.getProductCode()+"</td>\n"
							+"<td>"+questionProduct.getTitle()+"</td>\n"						
							+"<td>"+questionProduct.getContent()+"</td>\n"						
							+"<td>"+sdf.format(questionProduct.getEnrollDate())+"</td>\n"
							+"<td>"+questionProduct.getPrivateYn()+"</td>\n"						
						
							+"</td>\n"
					);
			if(questionProduct.getQuestionRefNo() == 0) {
				sb.append("<td><button type=\"button\" class=\"btn btn-warning answer-btn\" data-bs-toggle=\"modal\" data-bs-target=\"#questionModal\">답변 대기</button></td></tr>");
			}
			else {
				sb.append("<td><button type=\"button\" class=\"btn btn-primary answer-btn\" data-bs-toggle=\"modal\" data-bs-target=\"#questionModal\">답변 완료</button></td></tr>");				
			}
		}		
		return sb.toString();
	}

	public static String getPagebarQuestion(int cPage, int numPerPage, int totalContent, String url) {
		StringBuilder pagebar = new StringBuilder();

		// 전체페이지수
		int totalPage = (int) Math.ceil((double) totalContent / numPerPage);

		// 페이지번호를 클릭했을때 링크
		String delimeter = url.contains("?") ? "&" : "?";
		url = url + delimeter + "cPage="; // /spring/board/boardList.do?cPage=
		log.debug("Utils URL = {}",url);
		// 페이지바크기
		int pagebarSize = 5;

		/*
		 * 1 2 3 4 5 >>
		 * 
		 * << 6 7 8 9 10 >>
		 * 
		 * << 11 12
		 * 
		 * pageStart : 시작하는 pageNo - cPage와 pagebarSize에 의해 결정
		 */
		int pageStart = (cPage - 1) / pagebarSize * pagebarSize + 1;
		int pageEnd = pageStart + pagebarSize - 1;

		int pageNo = pageStart;

		pagebar.append("<nav class=\"pagebar\" aria-label=\"Page navigation example\">\n"
				+ "		  <ul class=\"pagination justify-content-center\">\n");

		// 1.이전
		if (pageNo == 1) {
			pagebar.append("<li class=\"page-item disabled\">\r\n"
					+ "		      <a class=\"page-link\" href=\"#\" aria-label=\"Previous\" tabindex=\"-1\">\r\n"
					+ "		        <span aria-hidden=\"true\">&laquo;</span>\r\n"
					+ "		        <span class=\"sr-only\">Previous</span>\r\n" + "		      </a>\r\n"
					+ "		    </li>\n");
		} else {
			pagebar.append(
					"<li class=\"page-item \">\r\n" + "		      <a class=\"page-link\" href=\"javascript:getPage("
							+ (pageNo - 1) + ")\" aria-label=\"Previous\" >\r\n"
							+ "		        <span aria-hidden=\"true\">&laquo;</span>\r\n"
							+ "		        <span class=\"sr-only\">Previous</span>\r\n" + "		      </a>\r\n"
							+ "		    </li>\n");
		}

		// 2.pageNo
		while (pageNo <= pageEnd && pageNo <= totalPage) {
			if (pageNo == cPage) {
				// 현재페이지인 경우 링크 제공안함.
				pagebar.append("<li class=\"page-item active\"><a class=\"page-link\" href=\"#\">" + pageNo
						+ "<span class=\"sr-only\">(current)</span></a></li>\n");
			} else {
				// 현재페이지가 아닌 경우 링크를 제공.
				pagebar.append("<li class=\"page-item\"><a class=\"page-link\" href=\"javascript:getPage(" + pageNo
						+ ")\">" + pageNo + "</a></li>\n");
			}

			pageNo++;
		}

		// 3.다음
		if (pageNo > totalPage) {
			pagebar.append("<li class=\"page-item disabled\">\r\n"
					+ "		      <a class=\"page-link\" href=\"#\" tabindex=\"-1\" aria-label=\"Next\">\r\n"
					+ "		        <span aria-hidden=\"true\">&raquo;</span>\r\n"
					+ "		        <span class=\"sr-only\">Next</span>\r\n" + "		      </a>\r\n"
					+ "		    </li>\n");
		} else {
			pagebar.append("<li class=\"page-item\">\r\n"
					+ "		      <a class=\"page-link\" href=\"javascript:getPage(" + pageNo
					+ ")\" aria-label=\"Next\">\r\n" + "		        <span aria-hidden=\"true\">&raquo;</span>\r\n"
					+ "		        <span class=\"sr-only\">Next</span>\r\n" + "		      </a>\r\n"
					+ "		    </li>\n");
		}

		pagebar.append(" </ul>\r\n" + "</nav>\r\n" );

		return pagebar.toString();
		
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	


}
