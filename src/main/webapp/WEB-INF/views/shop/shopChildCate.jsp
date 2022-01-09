<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>	
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="category" name="title"/>
</jsp:include>

<!-- shopHeader 관련 임포트 -->
<jsp:include page="/WEB-INF/views/shop/shopHeader.jsp"/>
<link href="${pageContext.request.contextPath}/resources/css/shop/shopMain.css" rel="stylesheet">


<!-- shopSideBox 관련 임포트 -->
<jsp:include page="/WEB-INF/views/shop/rightSideBox.jsp"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/shop/rightSideBox.js"></script>

<link href="${pageContext.request.contextPath }/resources/css/shop/shopDetail.css" rel="stylesheet">


<style>
@font-face {
      font-family: 'SANJUGotgam';
      src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2112@1.0/SANJUGotgam.woff') format('woff');
      font-weight: normal;
      font-style: normal;
  }

#thisCateName{
	font-family: 'SANJUGotgam';
	font-size: 23px;
}
.category-container{
	border :0px;
	background-color: beige;
}
</style>


<div class="shop-container">
	<div class="mx-auto text-center p-5">
		<h4>마우스</h4>
	</div>
	<div class="category-container d-flex justify-content-center align-items-center w-100">
		<strong id="thisCateName" >${thisCateName}</strong>
		<div class="category-all col-2">
		</div>
		<div class="category-details col-8">
		</div>
	</div>
	<div class="item-sort-container d-flex 	justify-content-between">
		<div class="p-4">총 ${total}개</div>
		<div class="p-4" id="">
			<span class="pr-2 pl-2 shop-sort">추천순</span>
			<span class="pr-2 pl-2 shop-sort">신상품순</span>
			<span class="pr-2 pl-2 shop-sort">판매량순</span>
			<span class="pr-2 pl-2 shop-sort">혜택순</span>
			<span class="pr-2 pl-2 shop-sort">낮은 가격순</span>
			<span class="pr-2 pl-2 shop-sort">높은 가격순</span>
		</div>
	</div>
	<div class="row">
		<!-- 아이템 나열 시작 -->
		<c:if test = "${itemList != null}">
			<c:forEach items="${itemList}" var="l">
		  	  <a href="${pageContext.request.contextPath}/shop/itemDetail/${l.productCode}" class="col-md-3 p-5">
		        <div class="card-box-d">
		          <div class="card-img-d shop-item-img position-relative">
		            <img src="${pageContext.request.contextPath }/resources/upload/product/${l.thumbnail}" alt="" class="img-thumbnail shop-img img-d img-fluid">
		            <i class="shop-like-icon fas fa-heart position-absolute"></i>
		            <i class="shop-cart-icon fas fa-cart-plus position-absolute"></i>
		          </div>
		          <div>
		          	<p class="m-0">${l.name}</p>
		          	<strong><fmt:formatNumber value="${l.price}" pattern="₩#,###,###"/></strong>
		          </div>
		        </div>
		      </a>
			</c:forEach>
		</c:if>
      <!-- 아이템 나열 끝 -->
    </div>
    <nav aria-label="..." class="mx-auto text-center">
    <div class="banner mx-auto text-center mb-3">
    	<img src="${pageContext.request.contextPath}/resources/upload/promotion/PROMO_f2z7M27K77UDWm9.png" alt="" />
    </div>
	  <ul class="pagination justify-content-center mt-5">
	  </ul>
	  ${pagebar}
	</nav>
</div>

<!-- shopHeader js  -->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/shop/shopHeader.js"></script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
