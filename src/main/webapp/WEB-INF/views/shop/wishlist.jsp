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

<style>
.wishDeleteBtn:hover{
	cursor: pointer;
}
</style>

<div class="row p-5 d-flex justify-content-around order-container">
  <div class="col-7">
  	<h4>위시리스트</h4>
  	<table class="table m-3 pr-3">
	  <tbody>
	  <c:forEach items="${wishlist}" var="wl" varStatus="vs">
		  <!-- 위시리스트 한 건 시작 -->
		    <tr>
		      <td>
		      	<input type="checkbox" class="ml-3" name="" id="" />
			  </td>
		      <td class="col-4">
		      	<img 
		      	src="${pageContext.request.contextPath}/resources/upload/product/${wl.thumbnail}"
		      	alt="" class="shop-img img-b w-75">
			  </td>
		      <td class="col-4 align-middle">${wl.name}</td>
		      <td class="col-3 align-middle">
		      	<span class="wishPrice" data-price="${wl.price}">
		      		<fmt:formatNumber value="${wl.price}" pattern="#,###,### 원" />
		      	</span>
		     </td>
		      <td colspan="" class="align-middle">
		      	<i class="wish-icon fas fa-cart-plus pr-3"></i>
		      </td>
		      <td colspan="" class="align-middle ">
		      	<i class="wish-icon fas fa-trash-alt wishDeleteBtn"></i>
		      </td>
		      <input type="hidden" id= "productCode" name="productCode" value="${wl.productCode}" />
		      <input type="hidden" id="wishlistNo" name="wishlistNo" value="${wl.wishlistNo}" />
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
	  <h4 class="text-right" id="wishTotalPrice"></h4>
	  <button 
	  	type="button" 
	  	id="wishCartBtn" 
	  	class="btn btn-primary w-100 h-25 mt-5"
	  	onclick="location.href='${pageContext.request.contextPath}/order/cart.do'">
	  	선택 제품 장바구니에 추가하기 <i class="fas fa-chevron-circle-right"></i>
	  </button>
	  <hr class="w-100"/>
  </div>
</div>	


<script>
window.onload = calTotal;

// 위시리스트 전체 가격 비동기 처리 시작
function calTotal(){
	const prices = document.getElementsByClassName('wishPrice');
	var totalPrice = 0;
	
	Array.prototype.forEach.call(prices, (elem, index) => {
		totalPrice +=  parseInt(elem.dataset.price);
	});
	
	console.log(`최종 가격 : \${totalPrice}`);
	$(wishTotalPrice).text(numberWithCommas(totalPrice) + '원');
}
//위시리스트 전체 가격 비동기 처리 끝

//가격 포맷팅 시작
function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}
//가격 포맷팅 끝

// 위시리스트 삭제 비동기 시작
$(document).on('click', '.wishDeleteBtn', function(e) {
	const memberNo = ${loginMember.memberNo};
	const productCode = $('#productCode').val();
	
	console.log(productCode);
	if(confirm("위시리스트를 삭제하시겠습니까?")){
		
		
	 	$.ajax({
			
			url: "${pageContext.request.contextPath}/shop/wishlistDelete",
			method: "Get",
			data : {
				memberNo:  memberNo,
				productCode : productCode 	
			},
			success(data){
				if(data == 1){
					location.reload();
				
				}
			},
			error: console.log
		}); 

	}
	
})
// 위시리스트 삭제 비동기 끝
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
