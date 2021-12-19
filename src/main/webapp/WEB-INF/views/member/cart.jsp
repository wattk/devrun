<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>	
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="장바구니" name="title"/>
</jsp:include>
<style>
#cartPayBtn{
	font-size : x-large;
}
</style>
<div class="row p-5 d-flex justify-content-around">
  <div class="col-7">
  	<h4>장바구니</h4>
  	<table class="table m-3 pr-3">
	  <tbody>
	    <tr>
	      <td rowspan="2">
	      	<input type="checkbox" class="ml-3" name="" id="" />
		  </td>
	      <td rowspan="2" class="col-3">
	      	<img src="${pageContext.request.contextPath }/resources/images/500x500.jpg" alt="" class="img-b w-75">
		  </td>
	      <td class="col-5 align-middle">제품명</td>
	      <td class="col-3 align-middle">가격</td>
	    </tr>
	    <tr>
	      <td colspan="2" class="align-middle">
	      	<input type="number" name="" id="" class="" placeholder="수량" />
	      	<button type="button" class="btn btn-primary">삭제</button>
	      </td>
	    </tr>
	    <tr>
	      <td rowspan="2">
	      	<input type="checkbox" class="ml-3" name="" id="" />
		  </td>
	      <td rowspan="2" class="col-3">
	      	<img src="${pageContext.request.contextPath }/resources/images/500x500.jpg" alt="" class="img-b w-75">
		  </td>
	      <td class="col-5 align-middle">제품명</td>
	      <td class="col-3 align-middle">가격</td>
	    </tr>
	    <tr>
	      <td colspan="2" class="align-middle">
	      	<input type="number" name="" id="" class="" placeholder="수량" />
	      	<button type="button" class="btn btn-primary">삭제</button>
	      </td>
	    </tr>
	    <tr>
	      <td rowspan="2" >
	      	<input type="checkbox" class="ml-3" name="" id="" />
		  </td>
	      <td rowspan="2" class="col-3">
	      	<img src="${pageContext.request.contextPath }/resources/images/500x500.jpg" alt="" class="img-b w-75">
		  </td>
	      <td class="col-5 align-middle">제품명</td>
	      <td class="col-3 align-middle">가격</td>
	    </tr>
	    <tr>
	      <td colspan="2" class="align-middle">
	      	<input type="number" name="" id="" class="" placeholder="수량" />
	      	<button type="button" class="btn btn-primary">삭제</button>
	      </td>
	    </tr>
	  </tbody>
	</table>
  </div>
  <div class="col-4 m-3 pl-3 d-flex flex-column justify-content-center">
	  <strong>주문 내역</strong>
	  <p>5만원 이상 결제 시 배송비 무료입니다.</p>
	  <p>이 금액에는 배송비가 포함되어 있지 않으며, 배송지에 따라 구매가 불가할 수 있습니다.</p>
	  <hr class="w-100"/>
	  <strong>총 주문 금액</strong>
	  <h4 class="text-right">0,000원</h4>
	  <button type="button" id="cartPayBtn" class="btn btn-primary w-100 h-25 mt-5">결제하기 <i class="fas fa-chevron-circle-right"></i></button>
	  <hr class="w-100"/>
  </div>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
