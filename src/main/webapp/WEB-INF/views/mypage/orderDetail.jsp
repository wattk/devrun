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
<link href="${pageContext.request.contextPath}/resources/css/shop/shopItemDetail.css" rel="stylesheet">

<%-- EL에서 접근하기 위해 VAR속성 지정 --%>
<sec:authentication property="principal" var="member"/>
<%-- my shopping --%>
<div class="tab-pane fade show active col-15" id="myOrderList">
<!--리뷰작성모달 시작(부트스트랩)-->
<!-- 
<form:form
name="reviewFrm"
method="POST"
action="${pageContext.request.contextPath}/shop/insertReview"
enctype="multipart/form-data">
	<div class="modal fade" id="exampleModal3" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
			<h5 class="modal-title" id="exampleModalLabel">리뷰 작성하기</h5>
			<button type="button" class="close" data-dismiss="modal" aria-label="Close">
				<span aria-hidden="true">&times;</span>
			</button>
			</div>
			<div class="modal-body">
				<div class="qm-body1">
					<p>해당상품</p>
					<div class="row" id="qItem">
						<img id="qPIc" src="${pageContext.request.contextPath}/resources/upload/product/${product.thumbnail}" alt="">
						<p>${product.name}</p>
						<input type="hidden" id="productCodeV" name="productCode" value='${product.productCode}' />
						<sec:authorize access="isAuthenticated()">
							<input type="hidden" id="memberNoV" name="memberNo" value='<sec:authentication property="principal.memberNo"/>' />
							<input type="hidden" name="id" value='<sec:authentication property="principal.id"/>' />
						</sec:authorize>
					</div>
					<p class="mt-3">상품 별점</p>
					<select id="rateSelect" name="rate" class="form-select col-12" aria-label="Default select example">
						<option value="5" selected> 별점 5점 </option>
						<option value="4">별점 4점</option>
						<option value="3">별점 3점</option>
						<option value="2">별점 2점</option>
						<option value="1">별점 1점</option>
					</select>
				</div>
				<div class="m-body2 mt-3">
					<div>
						<div id="rSelectP" class="text-center">
							<p id="choosePicP">사진첨부(선택)</p>
						</div>
						<div class="text-center">
							<input type="file" name="upFile" id="reviewPic" onchange='openFile(event)'>
						</div>
					</div>
					<p class="mt-3">리뷰 작성</p>
					<div class="checkboxReport">
						<textarea style="-ms-overflow-style: none;" name="content" id="reportText" cols="30" rows="10" maxlength='900' required></textarea>
						<span id="textLength">0/900</span>
					</div>
					<p style="font-size: 12px;">ⓘ 포토리뷰 500P / 글리뷰 100P 적립</p>
				</div>
			</div>
			<div class="modal-footer justify-content-center">
			<button type="submit" class="btn btn-primary col-4">등록하기</button>
			<button type="button" class="btn btn-secondary col-4" data-dismiss="modal" onclick="deleteReview();">취소하기</button>
			</div>
		</div>
		</div>
	</div>
</form:form>
 -->
<!--리뷰작성모달 끝-->

<article class="col-9 mx-auto">
	<div class="order-detail-header d-flex justify-content-between">
		<a href="${pageContext.request.contextPath}/mypage/orderList.do">
			<h4 class="order-tab-title">
				<i class="shop-icon fas fa-chevron-left pr-2"></i>
				주문 번호 <span>${merchant.merchantUid}</span>
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
			<h5 class="pb-2">${imp.name}</h5>
			<ul class="list-group list-group-flush">
			  <c:forEach items="${list}" var="item" varStatus="vs">
				  <li class="list-group-item">
					<table class="mt-3">
						<tr>
							<td rowspan="4" class="col-2">
								<div class="cart-item-img">
									<img src="${pageContext.request.contextPath}/resources/upload/product/${item.thumbnail}" alt="" class="shop-img img-thumbnail"/>
								</div>
							</td>
						</tr>
						<tr>
							<td class="col-5">
								<strong class="">[${item.name}]</strong>
								<br />
								<span>${item.productDetail.optionNo}${item.productDetail.optionContent}</span>
								<br />
								<strong><fmt:formatNumber type="currency">${item.price}</fmt:formatNumber></strong>
								&nbsp;
								<span class="pl-2">${item.buyCount}개 구매</span>
							</td>
							<c:if test="${merchant.orderStatus ne 'SC' and merchant.orderStatus ne 'OC'}">
								<td rowspan="4" class="col-2">
									<button type="button" id="" class="question-btn order-btn btn btn-outline-light">${merchant.orderStatus eq 'OR'? '주문' : merchant.orderStatus eq 'PP'? '상품준비중' : merchant.orderStatus eq 'SS'? '배송시작' : '배송중' }</button>
								</td>
								<td rowspan="4" class="col-2">
									<button type="button" class="order-btn btn btn-outline-primary">장바구니 담기</button>
							</c:if>
							<c:if test="${merchant.orderStatus eq 'SC' or merchant.orderStatus eq 'OC'}">
								<td rowspan="4" class="col-2">
									<button type="button" id="" class="question-btn order-btn btn btn-outline-light">${merchant.orderStatus eq 'SC'? '배송완료' : '구매확정' }</button>
								</td>
								<td rowspan="4" class="col-2">
									<button type="button" class="order-btn btn btn-outline-primary active" data-toggle="modal" data-target="#exampleModal3">리뷰작성하기</button>
									<button type="button" class="order-btn btn btn-outline-primary">장바구니 담기</button>
								</td>
							</c:if>
						</tr>
					</table>
				  </li>
			  </c:forEach>
			</ul>
			<h5 class="mt-5 pb-2 order-detail-header">결제 정보</h5>
			<table id="orderPaymentTbl" class="mt-3">
				<tr>
					<th class="col-3">총 주문금액</th>
					<td class="col-5"><fmt:formatNumber type="currency">${merchant.productPrice}</fmt:formatNumber></td>
				</tr>
				<tr>
					<th class="col-3">상품 할인</th>
					<td class="col-5"><fmt:formatNumber type="currency">0</fmt:formatNumber></td>
				</tr>
				<tr>
					<th class="col-3">포인트 사용</th>
					<td class="col-5"><fmt:formatNumber type="currency">${merchant.pointValue}</fmt:formatNumber></td>
				</tr>
				<tr>
					<th class="col-3">배송비</th>
					<td class="col-5"><fmt:formatNumber type="currency">${merchant.shippingFee}</fmt:formatNumber></td>
				</tr>
				<tr>
					<th class="col-3">결제 금액</th>
					<td class="col-5"><fmt:formatNumber type="currency">${imp.amount}</fmt:formatNumber></td>
				</tr>
				<tr>
					<th class="col-3">결제 방법</th>
					<td class="col-5">${imp.payMethod}</td>
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
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/shop/itemDetail.js" ></script>
<jsp:include page="/WEB-INF/views/mypage/common/footer.jsp"></jsp:include>