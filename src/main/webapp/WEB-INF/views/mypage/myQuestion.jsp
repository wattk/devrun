<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<jsp:include page="/WEB-INF/views/mypage/common/header.jsp">
	<jsp:param value="마이페이지" name="title"/>
</jsp:include>

<link href="${pageContext.request.contextPath}/resources/css/mypage/myshopping.css" rel="stylesheet">

<%-- EL에서 접근하기 위해 VAR속성 지정 --%>
<sec:authentication property="principal" var="member"/>
<%-- my shopping --%>
<div class="tab-pane fade show active col-15" id="myQuestionList">
  <article class="col-9 mx-auto">
	<div class="question-header d-flex justify-content-between">
		<h4 class="review-tab-title">
			나의 문의
		</h4>
		<select class="form-control form-control-sm w-25">
		  <option>최신순</option>
		  <option>조회순</option>
		  <option>좋아요순</option>
		</select>
	</div>
	<section class="review-list " id="myOrder">
		<ul class="list-group list-group-flush">
		  <li class="list-group-item ">
		  	<div class="question-container d-flex align-items-center justify-content-center question-item">
		  		<div class="col-7"><strong>[ㅇㅇ키보드]ㅇㅇ키보드 문의합니다</strong></div>
		  		<div class="col-4">2021.12.20 | 답변완료</div>
		  		<button type="button" id="" class="question-btn order-btn btn btn-outline-light">삭제하기</button>
		  	</div>
		  </li>
		  <li class="list-group-item ">
		  	<div class="question-container d-flex align-items-center justify-content-center question-item">
		  		<div class="col-7"><strong>[ㅇㅇ키보드]ㅇㅇ키보드 문의합니다</strong></div>
		  		<div class="col-4">2021.12.20 | 답변완료</div>
		  		<button type="button" id="" class="question-btn order-btn btn btn-outline-light">삭제하기</button>
		  	</div>
		  </li>
		  <li class="list-group-item ">
		  	<div class="question-container d-flex align-items-center justify-content-center question-item">
		  		<div class="col-7"><strong>[ㅇㅇ키보드]ㅇㅇ키보드 문의합니다</strong></div>
		  		<div class="col-4">2021.12.20 | 답변완료</div>
		  		<button type="button" id="" class="question-btn order-btn btn btn-outline-light">삭제하기</button>
		  	</div>
		  </li>
		  <li class="list-group-item ">
		  	<div class="question-container d-flex align-items-center justify-content-center question-item">
		  		<div class="col-7"><strong>[ㅇㅇ키보드]ㅇㅇ키보드 문의합니다</strong></div>
		  		<div class="col-4">2021.12.20 | 답변완료</div>
		  		<button type="button" id="" class="question-btn order-btn btn btn-outline-light">삭제하기</button>
		  	</div>
		  </li>
		</ul>	
	</section>
  </article>
</div>

<jsp:include page="/WEB-INF/views/mypage/common/footer.jsp"></jsp:include>