<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>	

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="공지사항" name="title"/>
</jsp:include>

<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/customerCenter/customerCenter.css" />

<div class="container customer-center">
	<div class="row">
		<!-- 사이드 바 -->
		<jsp:include page="/WEB-INF/views/customerCenter/sidebar.jsp"></jsp:include>
		
		<!-- 본문 -->
		<div class="col-sm-9 page">
			<h2>공지사항</h2>
			
			<!-- 검색 -->
			<div class="row py-3 border-bottom m-0 search">
			
				<div class="col-sm-3">
					<!-- 검색타입 -->
					<select id="searchType" class="custom-select">
					  	<option value="title" ${param.searchType eq 'title' ? 'selected' : ''}>제목</option>
					  	<option value="content" ${param.searchType eq 'content' ? 'selected' : ''}>내용</option>
					</select>	
				</div>

				<div class="col-sm-9">
					<!-- 검색창 -->
					<div class="form-inline search-form">
						<input id="noticeSearchKeyword" class="form-control" type="search" name="searchKeyword" value="${param.searchKeyword}" placeholder="검색어를 입력해 주세요" aria-label="Search">
						<button class="btn btn-outline-primary my-2 my-sm-0 search-btn" type="button">검색</button>
				  	</div>
				</div>
			
			</div>
			<!-- 검색 끝 -->
			
			<p class="text-right mt-3 mb-1">총 ${totalContent}개</p>

			<!-- 공지사항 게시판 -->
			<table class="table table-hover">
				<thead>
					<tr>
						<th scope="col">번호</th>
						<th scope="col">제목</th>
						<th scope="col">등록일</th>
						<th scope="col">조회수</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${not empty noticeList}">
						<c:forEach items="${noticeList}" var="notice" varStatus="vs">
							<tr>
								<%-- 게시물 순번 역순 --%>
								<th scope="row">${totalContent - (((param.cPage eq null ? 1 : param.cPage) - 1) * 10 + vs.index)}</th>
								<%-- <td><a href="${pageContext.request.contextPath}/customerCenter/noticeDetail.do?noticeNo=${notice.noticeNo}">${notice.title}</a></td> --%>
								<%-- 상세페이지에서 목록 버튼 구현을 위해 searchType, searchKeyword, cPage도 넘긴다. --%>
								<td><a href="${pageContext.request.contextPath}/customerCenter/noticeDetail.do?noticeNo=${notice.noticeNo}&searchType=${param.searchType}&searchKeyword=${param.searchKeyword}&cPage=${param.cPage}">${notice.title}</a></td>
								<td><fmt:formatDate value="${notice.enrollDate}" pattern="yyyy-MM-dd"/></td>
								<td>${notice.viewCount}</td>
							</tr>
						</c:forEach>
					</c:if>
					<c:if test="${empty noticeList}">
						<tr>
							<td colspan="4" class="text-center">공지사항이 존재하지 않습니다.</td>
						</tr>
					</c:if>
				</tbody>
			</table>
			<!-- 공지사항 게시판 끝 -->
			
			<!-- 페이징 -->
			${pagebar}
			<!-- 페이징 끝 -->

		</div>
		<!-- 본문 끝 -->
	</div>

</div>

<script>
// 검색 버튼 클릭 이벤트
$('.search-btn').click((e) => {
	// 검색타입
	const searchType =  $('#searchType').val();
	// 검색어
	const searchKeyword = $(noticeSearchKeyword).val(); 
	//console.log("searchType? " + searchType);
	//console.log("searchKeyword? " + searchKeyword);
	
	location.href = `${pageContext.request.contextPath}/customerCenter/noticeList.do?searchType=\${searchType}&searchKeyword=\${searchKeyword}`;
	
});

// 검색어 입력 시 엔터 치면 click 핸들러 호출
$(noticeSearchKeyword).keyup((e) => {
	// 엔터치면 전송하게 해주세요.
	if(e.keyCode == 13){
		$('.search-btn').trigger('click'); // click 핸들러 호출!
	}
});

</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>