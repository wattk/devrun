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
<div class="tab-pane fade show active col-15" id="myPointList">
  <article class="col-9 mx-auto">
	<div class="point-header">
		<h4 class="">포인트</h4>
		<div class="point-title badge-primary w-100 d-flex justify-content-between p-4 align-items-center mb-3">
			<span>보유 포인트</span>
			<div class="d-flex align-items-center"><h4 class="m-0 mr-2 text-light">2400</h4><strong>포인트</strong></div>
		</div>
		<div class="button-container d-flex m-2 justify-content-around">
			<button type="button" class="point-btn btn btn-outline-primary active">전체</button>
			<button type="button" class="point-btn btn btn-outline-secondary">사용</button>
			<button type="button" class="point-btn btn btn-outline-secondary">적립</button>
		</div>
		<div class="text-center m-3">
			<span class="badge badge-pill badge-light">2022.01</span>
		</div>
	</div>
	<section class="review-list " id="">
		<ul class="point-month-group list-group list-group-flush">
		  <li class="list-group-item pt-4 pb-4">
		  	<div class="point-container d-flex align-items-center justify-content-start question-item ">
		  		<div class="point-check-val col-3 d-flex flex-column align-items-center ">
		  			<div class="point-badge">
		  				<span>사용</span>
		  			</div>
		  			<strong class="text-danger">-1,200포인트</strong>
		  		</div>
		  		<div class="col-7 d-flex flex-column ">
		  			<span class="font-weight-light">2021.12.29</span>
		  			<strong>결제 시 사용</strong>
		  			<span>xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx</span>
		  		</div>
		  	</div>
		  </li>
		  <li class="list-group-item pt-4 pb-4">
		  	<div class="point-container d-flex align-items-center justify-content-start question-item ">
		  		<div class="point-check-val col-3 d-flex flex-column align-items-center ">
		  			<div class="point-badge">
		  				<span>사용</span>
		  			</div>
		  			<strong class="text-danger">-1,200포인트</strong>
		  		</div>
		  		<div class="col-7 d-flex flex-column ">
		  			<span class="font-weight-light">2021.12.29</span>
		  			<strong>결제 시 사용</strong>
		  			<span>xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx</span>
		  		</div>
		  	</div>
		  </li>
		  <li class="list-group-item pt-4 pb-4">
		  	<div class="point-container d-flex align-items-center justify-content-start question-item ">
		  		<div class="point-check-val col-3 d-flex flex-column align-items-center ">
		  			<div class="point-badge">
		  				<span>사용</span>
		  			</div>
		  			<strong class="text-danger">-1,200포인트</strong>
		  		</div>
		  		<div class="col-7 d-flex flex-column ">
		  			<span class="font-weight-light">2021.12.29</span>
		  			<strong>결제 시 사용</strong>
		  			<span>xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx</span>
		  		</div>
		  	</div>
		  </li>
		  <li class="list-group-item pt-4 pb-4">
		  	<div class="point-container d-flex align-items-center justify-content-start question-item ">
		  		<div class="point-check-val col-3 d-flex flex-column align-items-center ">
		  			<div class="point-badge">
		  				<span>사용</span>
		  			</div>
		  			<strong class="text-danger">-1,200포인트</strong>
		  		</div>
		  		<div class="col-7 d-flex flex-column ">
		  			<span class="font-weight-light">2021.12.29</span>
		  			<strong>결제 시 사용</strong>
		  			<span>xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx</span>
		  		</div>
		  	</div>
		  </li>
		</ul>	
	</section>
  </article>
</div>

<jsp:include page="/WEB-INF/views/mypage/common/footer.jsp"></jsp:include>