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
			<div class="tab-pane fade show active col-15" id="myOrderDetail">
		   		<article class="col-9 mx-auto">
	       			<h4 class="order-tab-title">주문 내역</h4>
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
	       									<span>주문상태</span>
	       								</td>
	       								<td rowspan="4" class="col-2">
	       									<button type="button" id="" class="question-btn order-btn btn btn-outline-light">문의하기</button>
	       								</td>
	       								<td rowspan="4" class="col-2">
	       									<button type="button" class="order-btn btn btn-outline-primary">주문취소</button>
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
	       									<span>주문상태</span>
	       								</td>
	       								<td rowspan="4" class="col-2">
	       									<button type="button" id="" class="question-btn order-btn btn btn-outline-light">문의하기</button>
	       								</td>
	       								<td rowspan="4" class="col-2">
	       									<button type="button" class="order-btn btn btn-outline-primary">반품/교환</button>
	       									<button type="button" class="order-btn btn btn-outline-primary">배송조회</button>
	       									<button type="button" class="order-btn btn btn-outline-primary active" data-toggle="modal" data-target="#exampleModal3">후기쓰기</button>
	       								</td>
	       							</tr>
	       						</table>
	       					</div>
	       				</div>
	       			</section>
		    	</article>
			</div>
			<!--리뷰작성모달 시작(부트스트랩)-->
	<form:form
	name="reviewFrm"
	method="POST"
	action="${pageContext.request.contextPath}/shop/review.do"
	enctype="multipart/form-data">
		<div class="modal fade" id="exampleModal3" tabindex="-1" role="dialog" aria-labelledby="reviewModalLabel" aria-hidden="true">
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
							<img id="qPIc" src="https://i.ibb.co/gm7H77f/square.png" alt="">
							<p>삼성 오로라 갤럭시 마우스 2021년 버전</p>
							<input type="hidden" name="productCode" value="332">
							<sec:authorize access="isAuthenticated()">
								<input type="hidden" name="memberNo" value='<sec:authentication property="principal.memberNo"/>' />
							</sec:authorize>
						</div>
						<p class="mt-3">상품 별점</p>
						<select name="rate" class="form-select col-12" aria-label="Default select example">
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
							<textarea name="content" id="reportText" cols="30" rows="10" required></textarea>
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
<!--리뷰작성모달 끝-->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/shop/itemDetail.js" ></script>
<jsp:include page="/WEB-INF/views/mypage/common/footer.jsp"></jsp:include>