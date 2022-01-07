<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>	

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="자주 묻는 질문" name="title"/>
</jsp:include>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/customerCenter/customerCenter.css" />

<style>

</style>

<div class="container customer-center">
	<div class="row">
		<!-- 사이드 바 -->
		<jsp:include page="/WEB-INF/views/customerCenter/sidebar.jsp"></jsp:include>
		
		<!-- 본문 -->
		<div class="col-sm-9 page faq">
		
			<h2>자주 묻는 질문</h2>
			
			<!-- 검색 -->
			<nav class="navbar navbar-light bg-light border">
			  <%-- action 속성을 생략하면 해당 페이지를 요청할 때와 같은 방식으로 처리가 된다. --%>
			  <form class="form-inline">
			    <input id="faqSearchKeyword" class="form-control mr-sm-2" type="search" name="searchKeyword" value="${param.searchKeyword}" placeholder="질문을 입력해 주세요(제목+내용)" aria-label="Search">
			    <button class="btn btn-outline-primary my-2 my-sm-0" type="submit">검색</button>
			  </form>
			</nav>
			<!-- 검색 끝 -->
			
			
			<!-- 전체 / 쇼핑몰 / 카테고리 / 기타 선택 -->
			<ul class="nav nav-pills nav-fill my-4">
			  <li class="nav-item">
			    <a class="nav-link ${param.noticeCode eq null ? 'active' : ''}" href="${pageContext.request.contextPath}/customerCenter/faq.do?searchKeyword=${param.searchKeyword}">전체</a>
			  </li>
			  <li class="nav-item">
			    <a class="nav-link ${param.noticeCode eq 'S' ? 'active' : ''}" href="${pageContext.request.contextPath}/customerCenter/faq.do?noticeCode=S&searchKeyword=${param.searchKeyword}">쇼핑몰</a>
			  </li>
			  <li class="nav-item">
			    <a class="nav-link ${param.noticeCode eq 'C' ? 'active' : ''}" href="${pageContext.request.contextPath}/customerCenter/faq.do?noticeCode=C&searchKeyword=${param.searchKeyword}">커뮤니티</a>
			  </li>
			  <li class="nav-item">
			    <a class="nav-link ${param.noticeCode eq 'E' ? 'active' : ''}" href="${pageContext.request.contextPath}/customerCenter/faq.do?noticeCode=E&searchKeyword=${param.searchKeyword}">기타</a>
			  </li>
			</ul>
			<!-- 전체 / 쇼핑몰 / 카테고리 / 기타 선택 끝 -->
			
			<p class="text-right mt-3 mb-1">총 <span class="text-primary">${totalContent}</span> 건의 자주 묻는 질문이 있습니다.</p>
			
			<!-- 선택에 따른 값 불러오기 - 아코디언 형식 -->
			<table class="table">
				<thead>
			        <tr>
			            <th>번호</th>
			            <th>분류</th>
			            <th>제목</th>
			        </tr>
			    </thead>
			    <tbody>
			    	<c:if test="${not empty faqList}">
			    		<c:forEach items="${faqList}" var="faq" varStatus="vs">
				    		<tr class="faq-title">
					            <td>${totalContent - (((param.cPage eq null ? 1 : param.cPage) - 1) * 10 + vs.index)}</td>
					            <td>${faq.noticeCode eq 'S' ? '쇼핑몰' : faq.noticeCode eq 'C' ? '커뮤니티' : '기타'}</td>
					            <td>${faq.title}</td>
					        </tr>
					        <tr class="faq-content">
					            <td colspan="3" class="hiddenRow">
					            	<div class="">${faq.content}</div>
					            </td>
					        </tr>
			    		</c:forEach>   
			    	</c:if>
			    
			    	<c:if test="${empty faqList}">
						<tr>
							<td colspan="3" class="text-center">자주 묻는 질문이 존재하지 않습니다.</td>
						</tr>
					</c:if>
			    </tbody>
		    </table>
			<!-- 선택에 따른 값 불러오기 - 아코디언 형식 끝 -->
			
			<!-- 페이징 -->
			${pagebar}
			<!-- 페이징 끝 -->

		</div>
		<!-- 본문 끝 -->
		
	</div>

</div>

<script src="${pageContext.request.contextPath }/resources/js/customerCenter/customerCenter.js"></script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>