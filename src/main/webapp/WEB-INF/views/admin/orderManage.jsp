<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>	
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/admin/admin-common/header.jsp">
	<jsp:param value="주문관리" name="title"/>
</jsp:include>
<link href="${pageContext.request.contextPath }/resources/css/admin/adminManage.css" rel="stylesheet"/>
<div class="order-container">
	<h3 class="m-5">주문내역</h3>
</div>
<form:form>
	<div class="order-search-container mt-5 ml-5">
		<strong class="pr-3">주문 처리 상태</strong>
		<input type="radio" name="orderStatus" id="order0" />
		<label for="order0">전체</label>
		<input type="radio" name="orderStatus" id="order1" />
		<label for="order1">준비중</label>
		<input type="radio" name="orderStatus" id="order2" />
		<label for="order2">배송 시작</label>
		<input type="radio" name="orderStatus" id="order3" />
		<label for="order3">배송중</label>
		<input type="radio" name="orderStatus" id="order4" />
		<label for="order4">배송 완료</label>
		<input type="radio" name="orderStatus" id="order5" />
		<label for="order5">구매 확정</label>
	</div>
	<div class="order-search-container mt-3 ml-5">
		<strong class="pr-3">상품 처리 상태</strong>
		<input type="radio" name="productStatus" id="ps0" />
		<label for="ps0">전체</label>
		<input type="radio" name="productStatus" id="ps1" />
		<label for="ps1">정상</label>
		<input type="radio" name="productStatus" id="ps2" />
		<label for="ps2">환불</label>
		<input type="radio" name="productStatus" id="ps3" />
		<label for="ps3">교환</label>
		<input type="radio" name="productStatus" id="ps4" />
		<label for="ps4">반품</label>
		<input type="radio" name="productStatus" id="ps5" />
		<label for="ps5">주문취소</label>
		<input type="radio" name="productStatus" id="ps6" />
		<label for="ps6">완료</label>
	</div>
	<div class="order-search-container mt-3 ml-5">
		<strong class="pr-3">날짜 선택</strong>
		<input type="date" name="" id="" class=" bg-light border-0 small"/>
		<span>~</span>
		<input type="date" name="" id="" class="bg-light border-0 small"/>
		<span class="badge badge-primary">오늘</span>
		<span class="badge badge-secondary">이번주</span>
		<span class="badge badge-secondary">이번달</span>
		<span class="badge badge-secondary">전체</span>
	</div>
	<div class="order-search-container mt-3 ml-5">
       <div class="input-group w-50">
		 <select name="search-type" id="orderSearch" class=" bg-light border-0 small">
		 	<option value="all" selected>모든 주문 조회</option>
		 	<option value="order">주문번호로 검색</option>
		 	<option value="member">회원번호로 검색</option>
		 </select>
         <input type="text" class="form-control bg-light border-0 small" placeholder="검색어를 입력하세요."
             aria-label="Search" aria-describedby="basic-addon2">
         <div class="input-group-append">
             <button class="btn btn-primary" type="button">
                 <i class="fas fa-search fa-sm"></i>
             </button>
         </div>
       </div>
	</div>
</form:form>
<hr class="w-100"/>
<div class="order-list">
	<strong class="m-5">주문 목록</strong>
	<table class="admin-tbl table table-hover mx-auto mt-3">
	  <thead>
	    <tr>
	      <th scope="col">주문 번호</th>
	      <th scope="col">회원 번호</th>
	      <th scope="col">주문 일자</th>
	      <th scope="col">주문 상태</th>
	      <th scope="col">상품 처리 상태</th>
	      <th scope="col">사용 포인트</th>
	      <th scope="col">총 상품 금액</th>
	      <th scope="col">배송비</th>
	      <th scope="col">총 주문 금액</th>
	      <th scope="col">요청사항</th>
	    </tr>
	  </thead>
	  <tbody>
	    <tr>
	      <td>0</td>
	      <td>0</td>
	      <td>0</td>
	      <td>0</td>
	      <td>0</td>
	      <td>0</td>
	      <td>0</td>
	      <td>0</td>
	      <td>0</td>
	      <td>0</td>
	    </tr>
	    <tr>
	      <td>0</td>
	      <td>0</td>
	      <td>0</td>
	      <td>0</td>
	      <td>0</td>
	      <td>0</td>
	      <td>0</td>
	      <td>0</td>
	      <td>0</td>
	      <td>0</td>
	    </tr>
	    <tr>
	      <td>0</td>
	      <td>0</td>
	      <td>0</td>
	      <td>0</td>
	      <td>0</td>
	      <td>0</td>
	      <td>0</td>
	      <td>0</td>
	      <td>0</td>
	      <td>0</td>
	    </tr>
	    <tr>
	      <td>0</td>
	      <td>0</td>
	      <td>0</td>
	      <td>0</td>
	      <td>0</td>
	      <td>0</td>
	      <td>0</td>
	      <td>0</td>
	      <td>0</td>
	      <td>0</td>
	    </tr>
	  </tbody>
	</table>
</div>
<div class="order-list">
	<strong class="m-5">처리할 주문</strong>
	<table class="admin-tbl table table-hover mx-auto mt-3">
	  <thead>
	    <tr>
	      <th scope="col" class="col-3">상태 변경</th>
	      <th scope="col" class="col-5">건수</th>
	      <th scope="col" class="col-5">금액</th>
	    </tr>
	  </thead>
	  <tbody>
	    <tr>
	      <th scope="row">주문 → 상품 준비중</th>
	      <td>0</td>
	      <td>0</td>
	    </tr>
	    <tr>
	      <th scope="row">상품 준비중 → 배송 시작</th>
	      <td>0</td>
	      <td>0</td>
	    </tr>
	    <tr>
	      <th scope="row">배송 시작 → 배송중</th>
	      <td>0</td>
	      <td>0</td>
	    </tr>
	    <tr>
	      <th scope="row">배송중 → 배송 완료</th>
	      <td>0</td>
	      <td>0</td>
	    </tr>
	    <tr>
	      <th scope="row">배송 완료 → 구매 확정</th>
	      <td>0</td>
	      <td>0</td>
	    </tr>
	  </tbody>
	</table>
</div>
<div class="order-list">
	<strong class="m-5">주문 판매량</strong>
	<table class="admin-tbl table table-hover mx-auto mt-3">
	  <thead>
	    <tr>
	      <th scope="col" class="col-2">품목</th>
	      <th scope="col" class="col-3">일간</th>
	      <th scope="col" class="col-3">주간</th>
	      <th scope="col" class="col-3">월간</th>
	    </tr>
	  </thead>
	  <tbody>
	    <tr>
	      <th scope="row">의자</th>
	      <td>0</td>
	      <td>0</td>
	      <td>0</td>
	    </tr>
	    <tr>
	      <th scope="row">책상</th>
	      <td>0</td>
	      <td>0</td>
	      <td>0</td>
	    </tr>
	    <tr>
	      <th scope="row">모니터</th>
	      <td>0</td>
	      <td>0</td>
	      <td>0</td>
	    </tr>
	    <tr>
	      <th scope="row">키보드</th>
	      <td>0</td>
	      <td>0</td>
	      <td>0</td>
	    </tr>
	    <tr>
	      <th scope="row">마우스</th>
	      <td>0</td>
	      <td>0</td>
	      <td>0</td>
	    </tr>
	    <tr>
	      <th scope="row">기타용품</th>
	      <td>0</td>
	      <td>0</td>
	      <td>0</td>
	    </tr>
	  </tbody>
	</table>
</div>
<jsp:include page="/WEB-INF/views/admin/admin-common/footer.jsp"></jsp:include>
