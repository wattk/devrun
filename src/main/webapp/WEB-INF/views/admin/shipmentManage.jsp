<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>	
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/admin/admin-common/header.jsp">
	<jsp:param value="배송관리" name="title"/>
</jsp:include>
<link href="${pageContext.request.contextPath }/resources/css/admin/adminManage.css" rel="stylesheet"/>
<div class="shipment-container">
	<h3 class="m-5">배송내역</h3>
</div>
<form:form>
	<div class="shipment-search-container mt-5 ml-5">
		<strong class="pr-3">날짜 선택</strong>
		<input type="date" name="" id="" class=" bg-light border-0 small"/>
		<span>~</span>
		<input type="date" name="" id="" class="bg-light border-0 small"/>
		<span class="badge badge-primary">오늘</span>
		<span class="badge badge-secondary">이번주</span>
		<span class="badge badge-secondary">이번달</span>
		<span class="badge badge-secondary">전체</span>
	</div>
	<div class="shipment-search-container mt-3 ml-5">
       <div class="input-group w-50">
		 <select name="search-type" id="shipmentSearch" class=" bg-light border-0 small">
		 	<option value="all" selected>모든 주문 조회</option>
		 	<option value="delivery">배송번호로 검색</option>
		 	<option value="tracking">송장번호로 검색</option>
			<option value="order">주문번호로 검색</option>
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
<div class="shipment-list">
	<strong class="m-5">배송 목록</strong>
	<table class="admin-tbl table table-hover mx-auto mt-3">
	  <thead>
	    <tr>
	      <th scope="col">배송 번호</th>
	      <th scope="col">송장 번호</th>
	      <th scope="col">주문 번호</th>
	      <th scope="col">변동 기록 번호</th>
	      <th scope="col">발송 일자</th>
	    </tr>
	  </thead>
	  <tbody>
	    <tr>
	      <td>0</td>
	      <td>0</td>
	      <td>0</td>
	      <td>0</td>
	      <td>2021/12/20</td>
	    </tr>
	    <tr>
	      <td>0</td>
	      <td>0</td>
	      <td>0</td>
	      <td>0</td>
	      <td>2021/12/20</td>
	    </tr>
	    <tr>
	      <td>0</td>
	      <td>0</td>
	      <td>0</td>
	      <td>0</td>
	      <td>2021/12/20</td>
	    </tr>
	    <tr>
	      <td>0</td>
	      <td>0</td>
	      <td>0</td>
	      <td>0</td>
	      <td>2021/12/20</td>
	    </tr>
	    <tr>
	      <td>0</td>
	      <td>0</td>
	      <td>0</td>
	      <td>0</td>
	      <td>2021/12/20</td>
	    </tr>
	  </tbody>
	</table>
</div>
<jsp:include page="/WEB-INF/views/admin/admin-common/footer.jsp"></jsp:include>