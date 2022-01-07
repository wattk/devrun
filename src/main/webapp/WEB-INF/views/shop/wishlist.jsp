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
	color : #66ABFF;
}
.shop-item-info{
	width : 12rem;
	margin : 0 auto;
}
</style>

<sec:authentication property="principal" var="loginMember"/>

<div class=" p-5 order-container">
  	<h4>위시리스트</h4>
	<div class="row">
		<!-- 아이템 나열 시작 -->
		<c:if test = "${wishlist != null}">
			<c:forEach items="${wishlist}" var="l">
		        <div class="card-box-d p-5">
			  	  <a href="${pageContext.request.contextPath}/shop/itemDetail/${l.productCode}" class="col-md-3 ">
		          <div class="card-img-d shop-item-img position-relative">
		            <img src="${pageContext.request.contextPath}/resources/upload/product/${l.thumbnail}" alt="" class="img-thumbnail shop-img img-d img-fluid">
		          </div>
			      </a>
		          <div class="shop-item-info">
		          	<p class="m-0">${l.name}</p>
		          	<div class="d-flex justify-content-between">
		          	<strong class="wishPrice" data-price="${l.price}"><fmt:formatNumber value="${l.price}" pattern="#,###,### 원" /></strong>
			      	<i class="wish-icon fas fa-trash-alt wishDeleteBtn" data-product-code="${l.productCode}"></i>
		          	</div>
		          </div>
		        </div>
			</c:forEach>
		</c:if>
      <!-- 아이템 나열 끝 -->
    </div>
  <hr class="w-100"/>
  <div class=" m-3 pl-3 pt-5 text-right">
	  <strong class="wishlist-summary pl-2 mb-2">위시리스트 요약</strong>
	  <hr class="w-25" align="right"/>
	  <strong class="">정가</strong>
	  <h4 class="text-right" id="wishTotalPrice"></h4>
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
	const productCode = $(e.target).data("productCode");
	
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
