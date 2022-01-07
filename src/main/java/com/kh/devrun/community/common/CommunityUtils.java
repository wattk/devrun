package com.kh.devrun.community.common;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.devrun.community.model.vo.CommunityEntity;
import com.kh.devrun.questionProduct.model.vo.QuestionProduct;

import lombok.extern.log4j.Log4j;
import lombok.extern.slf4j.Slf4j;



@Slf4j
public class CommunityUtils {

	/**
	 * 
	 *  
	 * @param cPage
	 * @param numPerPage
	 * @param totalContents
	 * @param url
	 * @return
	 */
	public static String getPagebar(int cPage, int numPerPage, int totalContents, String url) {
		// 문자열이 더해져야하기 때문에 StringBuilder() 사용
		StringBuilder pagebar = new StringBuilder();
		
		// 전체페이지수 : 전체 몇페이지냐
		int totalPage = (int) Math.ceil((double) totalContents / numPerPage);
		
		// 페이지번호를 클릭했을때 링크 : ?를 붙일거냐 &를 붙일거냐
		// delimeter : 구분 문자
		String delimeter = url.contains("?") ? "&" : "?";
		url = url + delimeter + "cPage="; // /devrun/community/communityFreeboardList.do?cPage=
		
		// 페이지바크기 
		int pagebarSize = 5;
		
		/* 
		 		1 2 3 4 5  >>
		 		
		 	<<	6 7 8 9 10 >>
		 	
		 	<< 11 12
		 	
		 	pageStart : 시작하는 pageNo
		 		- cPage와 pagebarSize에 의해 결정
		 */
		int pageStart = (cPage - 1) / pagebarSize * pagebarSize + 1;
		int pageEnd = pageStart + pagebarSize - 1;
		
		int pageNo = pageStart;
		
		/*
		<nav aria-label="Page navigation example">
		  <ul class="pagination justify-content-center">
		  
			<<<<<<< 이전 영역 >>>>>>>
			<li class="page-item disabled">
		      <a class="page-link" href="#" aria-label="Previous" tabindex="-1">
		        <span aria-hidden="true">&laquo;</span>
		        <span class="sr-only">Previous</span>
		      </a>
		    </li>
		    
		    <<<<<<< 페이지바 영역 >>>>>>>
			<li class="page-item active"><a class="page-link" href="#">1<span class="sr-only">(current)</span></a></li>
			<li class="page-item"><a class="page-link" href="javascript:paging(2)">2</a></li>
			<li class="page-item"><a class="page-link" href="javascript:paging(3)">3</a></li>
			<li class="page-item"><a class="page-link" href="javascript:paging(4)">4</a></li>
			<li class="page-item"><a class="page-link" href="javascript:paging(5)">5</a></li>
			
			<<<<<<< 다음 영역 >>>>>>>
			<li class="page-item">
		      <a class="page-link" href="javascript:paging(6)" aria-label="Next">
		        <span aria-hidden="true">&raquo;</span>
		        <span class="sr-only">Next</span>
		      </a>
		    </li>
		  </ul>
		</nav>
		
		<script>
		const paging = (cPage) => {
			location.href = '/spring/board/boardList.do?cPage=' + cPage;
		}
		</script>
		
		 */
		
		pagebar.append("<nav aria-label=\"Page navigation example\">\n"
				+ "		  <ul class=\"pagination justify-content-center\">\n"); // \n 추가 (확인할 때 수월하도록)
		
		// 1.이전
		if(pageNo == 1) {
			pagebar.append("<li class=\"page-item disabled\">\r\n"
					+ "		      <a class=\"page-link\" href=\"#\" aria-label=\"Previous\" tabindex=\"-1\">\r\n"
					+ "		        <span aria-hidden=\"true\">&laquo;</span>\r\n"
					+ "		        <span class=\"sr-only\">Previous</span>\r\n"
					+ "		      </a>\r\n"
					+ "		    </li>\n"); // \n 추가
		}
		else {
			// 위에꺼에서 가져와서 일부 삭제, 조정
			// href=\"javascript:paging(" + (pageNo - 1) + ")
			pagebar.append("<li class=\"page-item \">\r\n"
					+ "		      <a class=\"page-link\" href=\"javascript:paging(" + (pageNo - 1) + ")\" aria-label=\"Previous\" >\r\n"
					+ "		        <span aria-hidden=\"true\">&laquo;</span>\r\n"
					+ "		        <span class=\"sr-only\">Previous</span>\r\n"
					+ "		      </a>\r\n"
					+ "		    </li>\n");
		}
		
		// 2.pageNo
		while(pageNo <= pageEnd && pageNo <= totalPage) {
			if(pageNo == cPage) {
				// 현재페이지인 경우 링크 제공안함.
				pagebar.append("<li class=\"page-item active\"><a class=\"page-link\" href=\"#\">" + pageNo + "<span class=\"sr-only\">(current)</span></a></li>\n");
			}
			else {
				// 현재페이지가 아닌 경우 링크를 제공.
				// href=\"javascript:paging(" + pageNo + ") : 페이징 함수 호출.
				pagebar.append("<li class=\"page-item\"><a class=\"page-link\" href=\"javascript:paging(" + pageNo + ")\">" + pageNo + "</a></li>\n");
			}
			
			pageNo++;
		}
		
		// 3.다음 섹션(비활성화 시켜야하는 영역) --> disabled
		// disabled
		// tabindex=\"-1\"
		if(pageNo > totalPage) {
			pagebar.append("<li class=\"page-item disabled\">\r\n"
					+ "		      <a class=\"page-link\" href=\"#\" tabindex=\"-1\" aria-label=\"Next\">\r\n"
					+ "		        <span aria-hidden=\"true\">&raquo;</span>\r\n"
					+ "		        <span class=\"sr-only\">Next</span>\r\n"
					+ "		      </a>\r\n"
					+ "		    </li>\n");
		}
		else {
			// href=\"javascript:paging(" + pageNo + ")
			pagebar.append("<li class=\"page-item\">\r\n"
					+ "		      <a class=\"page-link\" href=\"javascript:paging(" + pageNo + ")\" aria-label=\"Next\">\r\n"
					+ "		        <span aria-hidden=\"true\">&raquo;</span>\r\n"
					+ "		        <span class=\"sr-only\">Next</span>\r\n"
					+ "		      </a>\r\n"
					+ "		    </li>\n");
		}
		// 닫는 태그 추가
		pagebar.append("		  </ul>\r\n"
				+ "		</nav>\r\n"
				+ "		<script>\r\n"
				+ "		const paging = (cPage) => {\r\n"
				+ "			location.href = '" + url + "' + cPage;\r\n" // url : java 변수
				+ "		}\r\n"
				+ "		</script>\n");
		
		return pagebar.toString();
	}
	
	/**
	 * 게시글 읽음 여부 확인
	 * 
	 * HttpServletRequest로부터 클라이언트의 쿠키를 가져온다. 
	 * 먼저 쿠키가 null인지 검사하고, 그렇지 않다면 foreach를 통해 해당 쿠키들 중 postView라는 이름의 쿠키가 있는지 검사한다.
	 * 만약 존재한다면 oldCookie라는 이름으로 가져온다.
	 * 
	 * param : 쿠키 저장소 이름(key) 지정
	 */
	public static boolean hasRead(HttpServletRequest request, HttpServletResponse response, int communityNo, String param) {
		
		// 쿠키 배열 선언
		Cookie[] cookies = request.getCookies();
		// hasRead 기본값 fasle로 지정
		boolean hasRead = false;
		// boardValue 선언
		String boardValue = "";
		
		// 쿠기가 null이 아닐 때
		if (cookies != null) {
			// foreach를 통해 해당 쿠키들 중
			for (Cookie c : cookies) {
				String name = c.getName();
				String value = c.getValue();

				// 쿠키의 name(key)이 param과 같을 때 
				if (param.equals(name)) {
					// 선언해 놓은 boardValue에 해당 value를 저장
					boardValue = value;
					
					// communityNo가 확인될 경우 읽었던 게시글임을 확인 할 수 있다.
					if (value.contains("|" + communityNo + "|")) {
						hasRead = true;
					}
					break;
				}
			}
		}

		// 게시글을 읽지 않았다면
		if (!hasRead) {
			// cookie 생성
			// param : name, boardValue : value
			Cookie cookie = new Cookie(param, boardValue + "|" + communityNo + "|");// 그냥 숫자만 쓰면 혼동이 올 수 있으므로 no에 대한 padding문자 추가
			
			// 쿠키 유효기간 정보를 얻음
			cookie.setMaxAge(365 * 24 * 60 * 60);
			
			if ("community".equals(param))
				// setPath() : 쿠키사용 유효 디렉토리를 설정
				cookie.setPath(request.getContextPath() + "/community/communityFreeboardDetail");// 해당 경로 요청 시에만 쿠키 전송
			// response.addCoolie를 해줘야지 쿠키값에 실어진다.
			response.addCookie(cookie);
		}

		return hasRead;
	}
	
	/**
	 * 검색 타입별 리스트 
	 * 
	 * @param productList
	 * @param url
	 * @returnL
	 */
	public static String getFreeboardList(List<CommunityEntity> searchFreeboardList, String url) {
		//DecimalFormat fmt = new DecimalFormat("###,###");
		StringBuilder sb = new StringBuilder();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		for (CommunityEntity freeboard : searchFreeboardList) {
			sb.append(
					"<tr data-no=\"" + freeboard.getCommunityNo() + "\" class=\"whynot\" value=\""+ freeboard.getCommunityNo()+"\"style=\"cursor: pointer;\">\n" 
					+ "<td>" + freeboard.getCommunityNo() + "</td>\n"
					+ "<td>" + freeboard.getTitle() + "</td>\n"
					+ "<td>" + freeboard.getNickname() + "</td>\n"
					+ "<td>" + sdf.format(freeboard.getEnrollDate()) + "</td>\n"
					+ "<td><i class=\"fas fa-heart\"></i> " + freeboard.getLikeCount() + "</td>\n"
					+ "<td>" + freeboard.getViewCount() + "</td>\n"
					+ "<td>" + freeboard.getCommentCount() + "</td>\n"
					+ "</tr>"
					);
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
	
	
	/**
	 * 좋아요순 리스트 
	 * 
	 * @param productList
	 * @param url
	 * @returnL
	 */
	public static String getlikeBoardList(List<CommunityEntity> likeBoardList, String url) {
		//DecimalFormat fmt = new DecimalFormat("###,###");
		StringBuilder sb = new StringBuilder();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		for (CommunityEntity freeboard : likeBoardList) {
			sb.append(
					"<tr>\n" 
					+ "<td>" + freeboard.getCommunityNo() + "</td>\n"
					+ "<td>" + freeboard.getTitle() + "</td>\n"
					+ "<td>" + freeboard.getNickname() + "</td>\n"
					+ "<td>" + sdf.format(freeboard.getEnrollDate()) + "</td>\n"
					+ "<td><i class=\"fas fa-heart\"></i> " + freeboard.getLikeCount() + "</td>\n"
					+ "<td>" + freeboard.getViewCount() + "</td>"
					+ "<td>" + freeboard.getCommentCount() + "</td>"
					+ "/<tr>"
					);
		}

		return sb.toString();

	}

	public static String getPagebar3(int cPage, int numPerPage, int totalContents, String url) {
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
					"<li class=\"page-item \">\r\n" + "		      <a class=\"page-link\" href=\"javascript:likeGetPage("
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
				pagebar.append("<li class=\"page-item\"><a class=\"page-link\" href=\"javascript:likeGetPage(" + pageNo
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
					+ "		      <a class=\"page-link\" href=\"javascript:likeGetPage(" + pageNo
					+ ")\" aria-label=\"Next\">\r\n" + "		        <span aria-hidden=\"true\">&raquo;</span>\r\n"
					+ "		        <span class=\"sr-only\">Next</span>\r\n" + "		      </a>\r\n"
					+ "		    </li>\n");
		}

		pagebar.append(" </ul>\r\n" + "</nav>\r\n" );

		return pagebar.toString();
	}

	/**
	 * 답변순 리스트 
	 * 
	 * @param productList
	 * @param url
	 * @returnL
	 */
	public static String getCommentBoardList(List<CommunityEntity> commentBoardList, String url) {
		//DecimalFormat fmt = new DecimalFormat("###,###");
		StringBuilder sb = new StringBuilder();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		for (CommunityEntity freeboard : commentBoardList) {
			sb.append(
					"<tr>\n" 
					+ "<td>" + freeboard.getCommunityNo() + "</td>\n"
					+ "<td>" + freeboard.getTitle() + "</td>\n"
					+ "<td>" + freeboard.getNickname() + "</td>\n"
					+ "<td>" + sdf.format(freeboard.getEnrollDate()) + "</td>\n"
					+ "<td><i class=\"fas fa-heart\"></i> " + freeboard.getLikeCount() + "</td>\n"
					+ "<td>" + freeboard.getViewCount() + "</td>"
					+ "<td>" + freeboard.getCommentCount() + "</td>"
					+ "/<tr>"
					);
		}

		return sb.toString();

	}

	public static String getPagebar4(int cPage, int numPerPage, int totalContents, String url) {
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
					"<li class=\"page-item \">\r\n" + "		      <a class=\"page-link\" href=\"javascript:commentGetPage("
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
				pagebar.append("<li class=\"page-item\"><a class=\"page-link\" href=\"javascript:commentGetPage(" + pageNo
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
					+ "		      <a class=\"page-link\" href=\"javascript:commentGetPage(" + pageNo
					+ ")\" aria-label=\"Next\">\r\n" + "		        <span aria-hidden=\"true\">&raquo;</span>\r\n"
					+ "		        <span class=\"sr-only\">Next</span>\r\n" + "		      </a>\r\n"
					+ "		    </li>\n");
		}

		pagebar.append(" </ul>\r\n" + "</nav>\r\n" );

		return pagebar.toString();
	}

	
	
}
