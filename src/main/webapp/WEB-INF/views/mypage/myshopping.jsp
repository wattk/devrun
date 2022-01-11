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
<div class="col-12" id="myshopping">
	<div class="row">
		
		<!-- 나의 쇼핑 nav -->
		<nav class="col-3" id="shoppingNav">
		    <ul class="nav flex-column">
			  <li class="nav-item shopping-nav-item">
			    <a class="nav-link active shopping-nav-item w-100" href="${pageContext.request.contextPath}/mypage/orderList.do">
			    	<span>주문내역</span>
			    	<i class="shop-icon fas fa-chevron-right"></i>
			    </a>
			  </li>
			  <li class="nav-item shopping-nav-item">
			    <a class="nav-link shopping-nav-item w-100" href="${pageContext.request.contextPath}/mypage/myReview.do">
			    	<span>나의 후기</span>
			    	<i class="shop-icon fas fa-chevron-right"></i>
			    </a>
			  </li>
			  <li class="nav-item shopping-nav-item">
			    <a class="nav-link active shopping-nav-item w-100" href="${pageContext.request.contextPath}/mypage/myQuestion.do">
			    	<span>나의 문의</span>
			    	<i class="shop-icon fas fa-chevron-right"></i>
			    </a>
			  </li>
			  <li class="nav-item mt-3 ">
			    <a class="nav-link shopping-nav-item w-100" href="${pageContext.request.contextPath}/mypage/myPoint.do">
			    	<span>포인트<span class="small-font-size font-weight-light ml-2">2400<%-- <sec:authentication property="principal.point"/> --%> 포인트</span></span>
			    	<i class="fas fa-chevron-right"></i>
			    </a>
			  </li>
			</ul>
	        <hr/>
	       	<!-- login info / logout button -->
	       	<section class="text-center">
        		<form:form
		    		method="POST"
		    		action="${pageContext.request.contextPath}/member/memberLogout.do">
		        	<!-- <p><img src="" alt="" />(으)로 로그인</p> -->
				    	<button
				    		class="col-9"
				    		type="submit">로그아웃
				    	</button>
		   		</form:form>
	       	</section>
    	</nav>
	     	
   		<article class="col-9">
      			<section class="card justify-content-center" id="myShipment">
       			<table class="text-center align-middle">
       				<tr>
       					<td class="">0</td>
       					<td class="">0</td>
       					<td class="">0</td>
       					<td class="">0</td>
       					<td class="">0</td>
       					<td class="">0</td>
       				</tr>
       				<tr>
       					<td>주문</td>
       					<td>상품 준비중</td>
       					<td>배송 시작</td>
       					<td>배송중</td>
       					<td>배송 완료</td>
       					<td>구매 확정</td>
       				</tr>
       			</table>
      			</section>
       			
      			<section class="cursor card justify-content-between mt-3 mb-5 align-items-center" id="myOrderLog">
       			<span class="ml-5">취소/교환/환불</span>
       			<a href="${pageContext.request.contextPath}/mypage/changeOrderList.do">
       				<span class="mr-5">총 <span>${orderLogCnt}</span>건</span>
       			</a>
      			</section>
      			
      			<h5>나의 활동</h5>
      			<section class="row cursor" id="myActivity">
      				<span class="col-6 row" onclick="location.href='${pageContext.request.contextPath}/order/cart.do';">
      					<span class="cart-icon"><i class="bi bi-minecart-loaded"></i> &nbsp; 장바구니</span>
	       			<i class="bi bi-chevron-right"></i>
      				</span>
	       		<span class="col-6 row" onclick="location.href='${pageContext.request.contextPath}/shop/wishlist.do';">
		       		<span class="bi bi-bookmark"> &nbsp; 관심 상품</span>
		       		<i class="bi bi-chevron-right"></i>
	       		</span>
      			</section>
      			<!-- event : 최근 등록 이벤트 2개 -->
      			<section class="" id="eventBanner">
      				<img src="${pageContext.request.contextPath}/resources/upload/promotion/${promotion.banner}" alt="" class="col-12" style="cursor : pointer;" onclick="location.href='${pageContext.request.contextPath}/shop/promotionDetail/${promotion.promotionCode }';"/>
      			</section>
      			
      			<div class="d-flex justify-content-between mt-5">
       			<h5>주문 내역</h5>
       			<a href="${pageContext.request.contextPath}/mypage/orderList.do">
       				<span class="small-font-size">더보기&nbsp;<i class="bi bi-chevron-right small-font-size"></i></span>
       			</a>
      			</div>
    					<hr />
      			<section class="" id="myOrder">
      			<c:forEach items="${orderList}" var="item" varStatus="vs">
      				<div>
      					<sup class="d-box mb-2 ml-2"><fmt:formatDate value="${item.orderDate}" pattern="yy-MM-dd"/> </sup>
       				<div class="order-box card p-3 cursor" onclick="location.href = '${pageContext.request.contextPath}/mypage/orderDetail/${item.merchantUid}'">
       					<div class="order-title d-flex justify-content-between">
	       					<h5>${item.imp.name}</h5><i class="fas fa-chevron-right"></i>
       					</div>
       					<div class="order-content d-flex align-items-center mt-2">
       						<div class="order-img img-thumbnail">
       							<img src="${pageContext.request.contextPath}/resources/upload/product/${item.thumbnail}" alt="" class="w-100 h-100"/>
       						</div>
       						<div class="order-detail-content ml-3">
       							<span>주문번호</span>&nbsp;<strong>${item.merchantUid }</strong>
       							<br />
       							<span>결제금액</span>&nbsp;<strong><fmt:formatNumber type="currency">${item.imp.amount}</fmt:formatNumber></strong>
       							<br />
       							<span>주문상태</span>&nbsp;<strong>${item.orderStatus eq 'OR'? '주문' : item.orderStatus eq 'PP'? '상품준비중' : item.orderStatus eq 'SS'? '배송시작' : item.orderStatus eq 'SP'? '배송중' : item.orderStatus eq 'SC'? '배송완료':'구매확정' }</strong>
       						</div>
       					</div>
       				</div>
      				</div>
      			</c:forEach>
      			</section>
    	</article>
    	
	</div>
</div>

<jsp:include page="/WEB-INF/views/mypage/common/footer.jsp"></jsp:include>