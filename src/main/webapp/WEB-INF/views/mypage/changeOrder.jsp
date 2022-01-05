<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>	
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="changeOrder" name="title"/>
</jsp:include>
<link href="${pageContext.request.contextPath }/resources/css/shop/order.css" rel="stylesheet">
<script src="${pageContext.request.contextPath }/resources/js/shop/order.js"></script>
<div class="claim-container p-5 position-relative">
	<h3>교환/환불/취소 신청</h3>
	<div class="card-container ">
		<div id="claimOne" class="claim-card card m-5 position-absolute show">
		  <div class="card-header d-flex justify-content-center">
		  	<div class="claim-text pr-2">
			  	<span class="badge badge-primary">1</span>
			  	<span>주문 선택</span>
		  	</div>
		  	<span class="pr-2 my-auto">─</span>
		  	<div class="claim-text pr-2">
			  	<span class="badge badge-dark">2</span>
			  	<span>사유 선택</span>
		  	</div>
		  	<span class="pr-2 my-auto">─</span>
		  	<div class="claim-text pr-2">
			  	<span class="badge badge-dark">3</span>
			  	<span>해결 방법 선택</span>
		  	</div>
		  </div>
		  <div class="card-body m-4">
		  	<h5>주문을 확인해 주세요</h5>
	  	  	<table class="claim-table table m-3 pr-3">
			  <tbody>
			    <tr class="text-center">
			    	<th class="col-1">선택</th>
			    	<th class="col-3">주문번호/주문일</th>
			    	<th class="col-7">상품 상세</th>
			    </tr>
			    <c:forEach items="${productList}" var="product" varStatus="vs">
			    <tr>
			      <td>
			      	<input type="checkbox" class="ml-3" name="" id="" />
				  </td>
				  <td class="text-center">
				  	[202112200909]
				  	<br />
				  	2021.12.09
				  </td>
			      <td class="col-3">
			      	<img src="${pageContext.request.contextPath }/resources/images/500x500.jpg" alt="" class="img-b w-25 img-thumbnail">
			      	<span class="align-middle pl-3">제품명 옵션명 어쩌구 저쩌구</span>
				  </td>
			    </tr>
			    </c:forEach>
			    <tr>
			    	<td colspan="3">
					 	<button 
					  	  type="button" 
					  	  id="" 
					  	  class="claim-btn btn btn-primary w-100 h-50 mt-2 order-btn"
					  	  data-target="#claimTwo">
					  	  다음 단계
					    </button>
			    	</td>
			    </tr>
			  </tbody>
		    </table>
		  </div>
		</div>
		<div id="claimTwo" class="claim-card card m-5 position-absolute">
		  <div class="card-header d-flex justify-content-center">
		  	<div class="claim-text pr-2">
			  	<span class="badge badge-dark">1</span>
			  	<span>상품 선택</span>
		  	</div>
		  	<span class="pr-2 my-auto">─</span>
		  	<div class="claim-text pr-2">
			  	<span class="badge badge-primary">2</span>
			  	<span>사유 선택</span>
		  	</div>
		  	<span class="pr-2 my-auto">─</span>
		  	<div class="claim-text pr-2">
			  	<span class="badge badge-dark">3</span>
			  	<span>해결 방법 선택</span>
		  	</div>
		  </div>
		  <div class="card-body m-4">
		  	<h5>어떤 문제가 있나요?</h5>
		  	<ul class="list-group">
			  <li class="list-group-item">
			  	<strong>단순 변심</strong>
			  </li>
			  <li class="list-group-item">
			  	<input type="radio" name="reasonCode" id="reason1" />
			  	<label for="reason1">상품이 마음에 들지 않음</label>
			  	<div class="claim-detail text-center">
			  		<textarea name="" id="" cols="75" rows="5" placeholder="*필수입력"></textarea>
			  	</div>
			  </li>
			  <li class="list-group-item">
			  	<strong>상품 문제</strong>
			  </li>
			  <li class="list-group-item">
			  	<input type="radio" name="reasonCode" id="reason2" />
			  	<label for="reason2">상품이 구성품/부속품이 들어가 있지 않음</label>
			  	<div class="claim-detail text-center">
			  		<textarea name="" id="" cols="75" rows="5" placeholder="*필수입력"></textarea>
			  	</div>
			  </li>
			  <li class="list-group-item">
			  	<input type="radio" name="reasonCode" id="reason3" />
			  	<label for="reason3">상품이 설명과 다름</label>
			  	<div class="claim-detail text-center">
			  		<textarea name="" id="" cols="75" rows="5" placeholder="*필수입력"></textarea>
			  	</div>
			  </li>
			  <li class="list-group-item">
			  	<input type="radio" name="reasonCode" id="reason4" />
			  	<label for="reason4">다른 상품이 배송됨</label>
			  	<div class="claim-detail text-center">
			  		<textarea name="" id="" cols="75" rows="5" placeholder="*필수입력"></textarea>
			  	</div>
			  </li>
			  <li class="list-group-item">
			  	<input type="radio" name="reasonCode" id="reason5" />
			  	<label for="reason5">상품이 파손됨/기능 오동작</label>
			  	<div class="claim-detail text-center">
			  		<textarea name="" id="" cols="75" rows="5" placeholder="*필수입력"></textarea>
			  	</div>
			  </li>
			  <li class="list-group-item">
			  	<input type="radio" name="reasonCode" id="reason6" />
			  	<label for="reason6">판매자로부터 품절 안내 받음</label>
			  	<div class="claim-detail text-center">
			  		<textarea name="" id="" cols="75" rows="5" placeholder="*필수입력"></textarea>
			  	</div>
			  </li>
			</ul>
		  	<hr />
			<div class="d-flex">
				<button 
			  	  type="button" 
			  	  id="" 
			  	  class="claim-btn btn btn-secondary w-50 mt-2 m-2 order-btn"
			  	  data-target="#claimOne">
			  	  이전 단계
			    </button>
				<button 
			  	  type="button" 
			  	  id="" 
			  	  class="claim-btn btn btn-primary w-50 mt-2 m-2 order-btn"
			  	  data-target="#claimThree">
			  	  다음 단계
			    </button>
			</div>
		  </div>
		</div>
		<div id="claimThree" class="claim-card card m-5 position-absolute">
		  <div class="card-header d-flex justify-content-center">
		  	<div class="claim-text pr-2">
			  	<span class="badge badge-dark">1</span>
			  	<span>상품 선택</span>
		  	</div>
		  	<span class="pr-2 my-auto">─</span>
		  	<div class="claim-text pr-2">
			  	<span class="badge badge-dark">2</span>
			  	<span>사유 선택</span>
		  	</div>
		  	<span class="pr-2 my-auto">─</span>
		  	<div class="claim-text pr-2">
			  	<span class="badge badge-primary">3</span>
			  	<span>해결 방법 선택</span>
		  	</div>
		  </div>
		  <div class="card-body m-4">
		  	<div>
		  		<strong>선택한 상품 1건</strong>
		  		<div>
		  			<img src="${pageContext.request.contextPath }/resources/images/500x500.jpg" alt="" class="img-b img-thumbnail w-25">
			      	<span class="align-middle pl-3">제품명 옵션명 어쩌구 저쩌구</span>
		  		</div>
		  		<hr />
		  		<strong>선택한 사유</strong>
		  		<p>상품의 구성품/부속품이 들어가 있지 않음</p>
		  	</div>
		  	<hr />
		  	<h5 class="pt-2">어떤 해결 방법을 원하세요?</h5>
		  	<ul class="list-group">
		  	  <li class="list-group-item">
			  	<input type="radio" name="claimCode" id="exchange" />
			  	<label for="exchange" class="m-0">교환</label>
			  </li>
		  	  <li class="list-group-item">
			  	<input type="radio" name="claimCode" id="refund" />
			  	<label for="refund" class="m-0">반품 후 환불</label>
			  </li>
		  	</ul>
		  	<hr class="w-100"/>
		  	<h5 class="pt-4">배송, 회수 정보를 확인해 주세요</h5>
		  	<div>
		  		<strong>상품 배송지</strong>
		  		<p>어쩌구시 어쩌구동 저쩌구</p>
		  	</div>
		  	<ul class="list-group">
		  	  <li class="list-group-item">
			  	<input type="radio" name="returnCode" id="return1" />
			  	<label for="return1" class="m-0">회수 요청</label>
			  </li>
		  	  <li class="list-group-item">
			  	<input type="radio" name="returnCode" id="return2" />
			  	<label for="return2" class="m-0">이미 발송함</label>
			  </li>
		  	</ul>
		  	<div class="pt-2">
		  		<strong>상품 회수지</strong>
		  		<p>어쩌구시 어쩌구동 저쩌구</p>
		  		<hr />
		  	</div>
		  				<div class="d-flex">
				<button 
			  	  type="button" 
			  	  id="" 
			  	  class="claim-btn btn btn-secondary w-50 mt-2 m-2 order-btn"
			  	  data-target="#claimTwo">
			  	  이전 단계
			    </button>
				<button 
			  	  type="button" 
			  	  id="" 
			  	  class="claim-submit-btn btn btn-primary w-50 mt-2 m-2 order-btn">
			  	  신청
			    </button>
			</div>
		  </div>
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
