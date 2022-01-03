<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>	
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="wishlist" name="title"/>
</jsp:include>
<link href="${pageContext.request.contextPath }/resources/css/shop/order.css" rel="stylesheet">
<div class="row p-5 d-flex justify-content-around order-container">
  <div class="col-7">
  	<h4>위시리스트</h4>
  	<table class="table m-3 pr-3">
	  <tbody>
	  <c:forEach items="${wishlist}" var="wl" varStatus="">
		  <!-- 위시리스트 한 건 시작 -->
		    <tr>
		      <td>
		      	<input type="checkbox" class="ml-3" name="" id="" />
			  </td>
		      <td class="col-4">
		      	<img 
		      	src="${pageContext.request.contextPath}/resources/upload/product/${wl.thumbnail}"
		      	alt="" class="img-b w-75">
			  </td>
		      <td class="col-4 align-middle">${wl.name}</td>
		      <td class="col-3 align-middle">
		      <fmt:formatNumber	value="${wl.price}" pattern="#,###,### 원" /></td>
		      <td colspan="" class="align-middle">
		      	<i class="wish-icon fas fa-cart-plus pr-3"></i>
		      </td>
		      <td colspan="" class="align-middle">
		      	<i class="wish-icon fas fa-trash-alt"></i>
		      </td>
		      <input type="hidden" name="productCode" value="{wl.productCode}" />
		      <input type="hidden" name="wishlistNo" value="{wl.wishlistNo}" />
		    </tr>
		    <!-- 위시리스트 한 건 끝 -->
	  </c:forEach>
	  </tbody>
	</table>
  </div>
  <div class="col-4 m-3 pl-3 pt-5 d-flex flex-column justify-content-start">
	  <strong>위시리스트 요약</strong>
	  <hr class="w-100"/>
	  <strong>정가</strong>
	  <h4 class="text-right">0,000원</h4>
	  <button 
	  	type="button" 
	  	id="wishCartBtn" 
	  	class="btn btn-primary w-100 h-25 mt-5"
	  	onclick="location.href='${pageContext.request.contextPath}/order/cart.do'">
	  	모든 제품 장바구니에 추가하기 <i class="fas fa-chevron-circle-right"></i>
	  </button>
	  <hr class="w-100"/>
  </div>
</div>	
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
