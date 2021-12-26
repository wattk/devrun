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
						    	<span>포인트<span class="small-font-size font-weight-light ml-2"><sec:authentication property="principal.point"/> 포인트</span></span>
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
					        	<p><img src="" alt="" />(으)로 로그인</p>
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
			       					<td>입금 대기</td>
			       					<td>배송 준비</td>
			       					<td>결제 완료</td>
			       					<td>배송중</td>
			       					<td>배송 완료</td>
			       					<td>구매 확정</td>
			       				</tr>
			       			</table>
		       			</section>
			       			
		       			<section class="cursor card justify-content-between mt-3 mb-5 align-items-center" id="myOrderLog">
			       			<span class="ml-5">취소/교환/환불</span>
			       			<a href="${pageContext.request.contextPath}/mypage/claimList.do">
			       				<span class="mr-5">총 <span></span>건</span>
			       			</a>
		       			</section>
		       			
		       			<h5>나의 활동</h5>
		       			<section class="row cursor" id="myActivity">
		       				<span class="col-6 row" onclick="location.href='${pageContext.request.contextPath}/member/cart.do';">
		       					<span class="cart-icon"><i class="bi bi-minecart-loaded"></i> &nbsp; 장바구니</span>
				       			<i class="bi bi-chevron-right"></i>
		       				</span>
				       		<span class="col-6 row" onclick="location.href='${pageContext.request.contextPath}/member/wishlist.do';">
					       		<span class="bi bi-bookmark"> &nbsp; 관심 상품</span>
					       		<i class="bi bi-chevron-right"></i>
				       		</span>
		       			</section>
		       			<!-- event : 최근 등록 이벤트 2개 -->
		       			<section class="row" id="eventBanner">
		       				<img src="https://i.ibb.co/w63RdmJ/2021121515051506481-11934059-1.jpg" alt="" class="col-6" onclick="location.href='#';"/>
		       				<img src="https://i.ibb.co/GFmzFXF/2021120917350947828-11922858-1.jpg" alt="" class="col-6" onclick="location.href='#';"/>
		       			</section>
		       			
		       			<div class="d-flex justify-content-between mt-5">
			       			<h5>주문 내역</h5>
			       			<a href="${pageContext.request.contextPath}/mypage/orderList.do">
			       				<span class="small-font-size">더보기&nbsp;<i class="bi bi-chevron-right small-font-size"></i></span>
			       			</a>
		       			</div>
       					<hr />
		       			<section class="" id="myOrder">
	       					<sup class="d-box mb-2 ml-2">2021.12.24</sup>
		       				<div class="order-box card p-3 cursor" onclick="location.href = '${pageContext.request.contextPath}/mypage/orderDetail.do'">
		       					<div class="order-title d-flex justify-content-between">
			       					<h5>ㅇㅇ키보드 외 1건</h5><i class="fas fa-chevron-right"></i>
		       					</div>
		       					<div class="order-content d-flex align-items-center mt-2">
		       						<div class="order-img img-thumbnail">
		       							<img src="${pageContext.request.contextPath}/resources/images/80x80.jpg" alt="" />
		       						</div>
		       						<div class="order-detail-content ml-3">
		       							<span>주문번호</span>
		       							<br />
		       							<span>결제금액</span>
		       							<br />
		       							<span>주문상태</span>
		       						</div>
		       					</div>
		       				</div>
		       			</section>
			    	</article>
			    	
				</div>
			</div>

<jsp:include page="/WEB-INF/views/mypage/common/footer.jsp"></jsp:include>