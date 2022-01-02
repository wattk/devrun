<%@page import="com.kh.devrun.shop.model.vo.Cart"%>
<%@page import="java.util.List"%>
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
<link href="${pageContext.request.contextPath}/resources/css/shop/order.css" rel="stylesheet">
<div class="row p-5 d-flex justify-content-around order-container">
  <div class="col-7">
  	<h4>장바구니</h4>
  	<form:form name="orderEnrollFrm" action="${pageContext.request.contextPath}/order/order" method="GET">
	  	<table class="table m-3 pr-3">
		  <tbody>
		  	<c:set var="sum" value="0" />
		  	<c:forEach items="${list}" var="cart" varStatus="vs">
		    <tr class="cart-item"
		    	data-product-code = "${cart.product.productCode }"
		    	data-detail-no = "${cart.detailNo}"
		    	data-name = "${cart.product.name }"
		    	data-price = "${cart.product.price }"
		    	data-amount = "${cart.amount}"
		    >
		      <td rowspan="2">
		      	<input type="checkbox" class="cart-checkbox ml-3" name="" id="" checked/>
		      	<input type="hidden" name="detailNo" class="detail-no" value="${cart.detailNo}" />
			  </td>
		      <td rowspan="2" class="col-3">
		      	<img src="${pageContext.request.contextPath}/resources/upload/product/${cart.product.thumbnail}" alt="" class=" img-b w-75" >
			  </td>
		      <td class="col-5 align-middle ">${cart.product.name}</td>
		      <td class="col-3 align-middle " >
		      	<fmt:formatNumber type="currency">${cart.product.price * cart.amount}</fmt:formatNumber>
		      </td>
		    </tr>
		    <tr>
		      <td colspan="2" class="align-middle text-right">
		      	<input type="number" name="amount" id="" class="col-2 " placeholder="수량" value="${cart.amount}"/>
		      	<button type="button" class="btn btn-primary">삭제</button>
		      </td>
		    </tr>
		    <c:set var="sum" value="${sum + (cart.product.price * cart.amount)}" />
		    </c:forEach>
		  </tbody>
		</table>
	</form:form>
  </div>
  <div class="col-4 m-3 pl-3 pt-5 d-flex flex-column justify-content-start">
	  <strong>주문 내역</strong>
	  <p>5만원 이상 결제 시 배송비 무료입니다.</p>
	  <p>이 금액에는 배송비가 포함되어 있지 않으며, 배송지에 따라 구매가 불가할 수 있습니다.</p>
	  <hr class="w-100"/>
	  <strong>총 주문 금액</strong>
	  <h4 class="text-right"><fmt:formatNumber type="currency">${sum }</fmt:formatNumber></h4>
	  <button 
	  	type="button" 
	  	id="cartPayBtn" 
	  	class="btn btn-primary w-100 h-25 mt-5">
	  	결제하기 <i class="fas fa-chevron-circle-right"></i>
	  </button>
	  <hr class="w-100"/>
  </div>
</div>
<script>
//체크박스 해제 시 상품 detailNo 정보 삭제
$(".cart-checkbox").change((e)=>{
	console.log($(e.target).prop("checked"));
	if(!$(e.target).prop("checked")){
		$(e.target).siblings("input:hidden").val('');
	}
});

//주문하기 버튼 클릭 시 주문 페이지 이동
$("#cartPayBtn").click((e)=>{
	const $cartItems = $(".cart-item"); 
	//localStorage.setItem("cartItems", JSON.stringify());
	$(document.orderEnrollFrm).submit();
});
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
