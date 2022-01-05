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
			<div class="tab-pane fade show active col-15" id="myClaimDetail">
		   		<article class="col-9 mx-auto">
	       			<h4 class="order-tab-title">교환/환불/취소 내역</h4>
	       			<div class="search-box mt-3">
			          <form class="form-inline" name="orderSearchFrm" action="${pageContext.request.contextPath}/mypage/orderSearch.do" method="GET">
					    <div class="input-group w-50 mb-2">
					      <input type="text" id="searchKeyword" name="searchKeyword" class="form-control" placeholder="주문한 상품을 검색할 수 있어요." aria-label="Username" aria-describedby="basic-addon1">
					      <button type="button" id="orderSearchBtn" class="btn btn-b-n d-none d-md-block" data-toggle="collapse"
					        data-target="#navbarTogglerDemo01" aria-expanded="false">
					        <span class="fa fa-search" aria-hidden="true"></span>
					      </button>
					    </div>
					    <div class="search-details w-100">
							<span class="search-badge badge badge-primary">전체</span>
							<span class="search-badge badge badge-light">최근 6개월</span>
							<span class="search-badge badge badge-light">2022</span>
							<span class="search-badge badge badge-light">2021</span>
							<span class="search-badge badge badge-light">2020</span>
						</div>
					  </form>
				    </div>
   					<hr />
	       			<section class="order-list " id="myOrder">
	       				<div class="order-box mt-3">
	       					<sup class="d-box mb-2 ml-2">2021.12.24</sup>
	       					<div class=" card p-3">
		       					<div class="order-title d-flex justify-content-between">
			       					<h5>ㅇㅇ키보드 외 1건</h5><i class="fas fa-chevron-right"></i>
		       					</div>
	       						<table class="mt-3">
	       							<tr>
	       								<td rowspan="4" class="col-2">
	       									<img src="${pageContext.request.contextPath}/resources/images/80x80.jpg" alt="" class="img-thumbnail"/>
	       								</td>
	       							</tr>
	       							<tr>
	       								<td class="col-5">
	       									<span>주문번호</span>
	       									<br />
	       									<span>결제금액</span>
	       									<br />
	       									<span>처리상태</span>
	       								</td>
	       								<td rowspan="4" class="col-2">
	       									<button type="button" id="" class="question-btn order-btn btn btn-outline-light">문의하기</button>
	       								</td>
	       								<td rowspan="4" class="col-2">
	       									<button type="button" class="order-btn btn btn-outline-primary">반품/교환 취소</button>
	       								</td>
	       							</tr>
	       						</table>
	       					</div>
	       				</div>
	       				<div class="order-box mt-3">
	       					<sup class="d-box mb-2 ml-2">2021.12.24</sup>
	       					<div class=" card p-3">
		       					<div class="order-title d-flex justify-content-between">
			       					<h5>ㅇㅇ키보드 외 1건</h5><i class="fas fa-chevron-right"></i>
		       					</div>
	       						<table class="mt-3">
	       							<tr>
	       								<td rowspan="4" class="col-2">
	       									<img src="${pageContext.request.contextPath}/resources/images/80x80.jpg" alt="" class="img-thumbnail"/>
	       								</td>
	       							</tr>
	       							<tr>
	       								<td class="col-5">
	       									<span>주문번호</span>
	       									<br />
	       									<span>결제금액</span>
	       									<br />
	       									<span>처리상태</span>
	       								</td>
	       								<td rowspan="4" class="col-2">
	       									<button type="button" id="" class="question-btn order-btn btn btn-outline-light">문의하기</button>
	       								</td>
	       								<td rowspan="4" class="col-2">
	       									<button type="button" class="order-btn btn btn-outline-primary">배송조회</button>
	       									<button type="button" class="order-btn btn btn-outline-primary">교환확인</button>
	       								</td>
	       							</tr>
	       						</table>
	       					</div>
	       				</div>
	       			</section>
		    	</article>
			</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/shop/itemDetail.js" ></script>
<jsp:include page="/WEB-INF/views/mypage/common/footer.jsp"></jsp:include>