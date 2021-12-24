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
<div class="tab-pane fade show active col-15" id="myOrderList">
<article class="col-9 mx-auto">
	<div class="order-detail-header d-flex justify-content-between">
		<a href="">
			<h4 class="order-tab-title">
				<i class="shop-icon fas fa-chevron-left pr-2"></i>
				주문 번호 <span></span>
			</h4>
		</a>
		<span>
			제품 또는 상품에 문제가 있나요? 
			<a href="" class="text-primary">
				<span>1:1문의하기</span>
				<i class="shop-icon fas fa-chevron-right"></i>
			</a>
		</span>
	</div>
	<section class="order-list " id="myOrder">
		<div class="order-box mt-3 p-3">
			<h5 class="pb-2">ㅇㅇ키보드</h5>
			<ul class="list-group list-group-flush">
			  <li class="list-group-item">
				<table class="mt-3">
					<tr>
						<td rowspan="4" class="col-2">
							<img src="${pageContext.request.contextPath}/resources/images/80x80.jpg" alt="" class="img-thumbnail"/>
						</td>
					</tr>
					<tr>
						<td class="col-5">
							<strong>[ㅇㅇ키보드]키보드 그레이</strong>
							<br />
							<strong>32,000원</strong><sub class="pl-2">1개 구매</sub>
						</td>
						<td rowspan="4" class="col-2">
							<button type="button" id="" class="question-btn order-btn btn btn-outline-light">배송완료</button>
						</td>
						<td rowspan="4" class="col-2">
							<button type="button" class="order-btn btn btn-outline-primary active">후기쓰기</button>
							<button type="button" class="order-btn btn btn-outline-primary">장바구니 담기</button>
						</td>
					</tr>
				</table>
			  </li>
			  <li class="list-group-item">
			  </li>
			</ul>
			<h5 class="mt-5 pb-2 order-detail-header">결제 정보</h5>
			<table id="orderPaymentTbl" class="mt-3">
				<tr>
					<th class="col-3">총 주문금액</th>
					<td class="col-5">78,000</td>
				</tr>
				<tr>
					<th class="col-3">상품 할인</th>
					<td class="col-5">0원</td>
				</tr>
				<tr>
					<th class="col-3">포인트 사용</th>
					<td class="col-5">0원</td>
				</tr>
				<tr>
					<th class="col-3">배송비</th>
					<td class="col-5">0원</td>
				</tr>
				<tr>
					<th class="col-3">결제 금액</th>
					<td class="col-5">0원</td>
				</tr>
				<tr>
					<th class="col-3">결제 방법</th>
					<td class="col-5">신용카드</td>
				</tr>
			</table>
			<hr />
			<div class="button-container d-flex m-2 justify-content-around">
				<button type="button" class="order-btn order-detail-btn btn btn-outline-primary ">반품/교환</button>
				<button type="button" class="order-btn order-detail-btn btn btn-outline-primary">배송조회</button>
				<button type="button" class="order-btn order-detail-btn btn btn-outline-primary active">구매확정</button>
			</div>
		</div>
		</section>
   	</article>
</div>

<jsp:include page="/WEB-INF/views/mypage/common/footer.jsp"></jsp:include>