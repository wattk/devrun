<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>	
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="promotion" name="title"/>
</jsp:include>

<!-- 오늘 본 상품 -->
<jsp:include page="/WEB-INF/views/shop/rightSideBox.jsp">
	<jsp:param value="" name=""/>
</jsp:include>
<!-- 오늘 본 상품 -->

<!--쇼핑몰 헤더-->
<jsp:include page="/WEB-INF/views/shop/shopHeader.jsp">
	<jsp:param value="" name=""/>
</jsp:include>
<!--쇼핑몰 헤더부분-->
<!-- 오늘 본 상품 -->
<!-- shopHeader 관련 임포트 -->
<link href="${pageContext.request.contextPath}/resources/css/shop/shopMain.css" rel="stylesheet">

<!-- shopSideBox 관련 임포트 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/shop/rightSideBox.js"></script>

<style>
.promotion-container{
	padding-top: 200px;
	top : 300px;
}
#promotionTab a{
	font-size : x-large;
}
.promotion-title{
	font-size: larger;
    font-weight: 700;
}
</style>
<div class="promotion-container container">
	<nav>
	  <div class="nav nav-tabs" id="promotionTab" role="tablist">
	    <a class="nav-item nav-link active w-50 text-center" id="currentPromotionTab" data-toggle="tab" href="#currentPromotion" role="tab" aria-controls="currentPromotionTab" aria-selected="true">진행중인 이벤트</a>
	    <a class="nav-item nav-link w-50 text-center" id="endPromotionTab" data-toggle="tab" href="#endPromotion" role="tab" aria-controls="endPromotionTab" aria-selected="false">종료 이벤트</a>
	  </div>
	</nav>
	<div class="tab-content" id="nav-tabContent">
	  <div class="tab-pane fade show active" id="currentPromotion" role="tabpanel" aria-labelledby="currentPromotionTab">
	  	<ul class="list-group list-group-flush">
	  	<c:forEach items="${currentPromotionList}" var="promotion" varStatus="vs">
		  <li class="list-group-item">
		  <a href="${pageContext.request.contextPath}/shop/promotionDetail/${promotion.promotionCode}">
			  	<div class="promotion-title">
			  		${promotion.name}	
			  	</div>
			  	<div class="promotion-banner">
			  		<img src="${pageContext.request.contextPath}/resources/upload/promotion/${promotion.banner}" alt="" class="img-thumbnail" />
			  	</div>
			  	<div class="promotion-date d-flex justify-content-between">
			  		<div>
			  			<fmt:formatDate value="${promotion.startDate}" pattern="yyyy-MM-dd"/>
			  			~
			  			<fmt:formatDate value="${promotion.endDate}" pattern="yyyy-MM-dd"/>
			  		</div>
			  		<div>${promotion.viewCount}</div>
			  	</div>
		  	</a>
		  </li>
		  </c:forEach>
		</ul>
	  </div>
	  <div class="tab-pane fade" id="endPromotion" role="tabpanel" aria-labelledby="endPromotionTab">
	  	<ul class="list-group list-group-flush">
	  	<c:forEach items="${endPromotionList}" var="promotion" varStatus="vs">
		  <li class="list-group-item">
		  <a href="${pageContext.request.contextPath}/shop/promotionDetail/${promotion.promotionCode}">
			  	<div class="promotion-title">
			  		${promotion.name} 
			  	</div>
			  	<div class="promotion-banner">
			  		<img src="${pageContext.request.contextPath}/resources/upload/promotion/${promotion.banner}" alt="" class="img-thumbnail" />
			  	</div>
			  	<div class="promotion-date d-flex justify-content-between">
			  		<div>
			  			<fmt:formatDate value="${promotion.startDate}" pattern="yyyy-MM-dd"/>
			  			~
			  			<fmt:formatDate value="${promotion.endDate}" pattern="yyyy-MM-dd"/>
			  		</div>
			  		<div>${promotion.viewCount}</div>
			  	</div>
		  	</a>
		  </li>
		  </c:forEach>
		</ul>
	  </div>
	</div>
</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/shop/shopMain.js" ></script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
