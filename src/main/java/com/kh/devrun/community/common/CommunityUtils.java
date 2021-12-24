package com.kh.devrun.community.common;

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
	
}
