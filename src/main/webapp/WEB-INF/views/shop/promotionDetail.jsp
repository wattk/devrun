<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>	
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="promotionDetail" name="title"/>
</jsp:include>
<!-- 오늘 본 상품 -->
<!-- shopHeader 관련 임포트 -->
<jsp:include page="/WEB-INF/views/shop/shopHeader.jsp"/>
<link href="${pageContext.request.contextPath}/resources/css/shop/shopMain.css" rel="stylesheet">

<!-- shopSideBox 관련 임포트 -->
<jsp:include page="/WEB-INF/views/shop/rightSideBox.jsp"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/shop/rightSideBox.js"></script>
<style>
.promotion-container{
	padding-top: 200px;
	margin : 0 10% 0 10%;
	top : 300px;
}
.promotion-title{
	font-size: xx-large;
    font-weight: 700;
}
.category-container{
	border : 1px solid rgba(0,0,0,.125);
	height : 5rem;
}
.category-badge{
	cursor : pointer;
}
.category-badge:hover{
	color: #fff;
    background-color: #007bff;
}
</style>

<div class="promotion-container">
  	<div class="promotion-title m-4">
  		${promotion.name}	
  	</div>
	<div class="promotion-banner">
  		<img src="${pageContext.request.contextPath}/resources/upload/promotion/${promotion.banner}" alt="" class="img-thumbnail" />
  	</div>
  	<div class="promotion-date d-flex justify-content-between ml-4 mr-4 mt-2 mb-5">
  		<div>
  			<fmt:formatDate value="${promotion.startDate}" pattern="yyyy-MM-dd"/>
  			~
  			<fmt:formatDate value="${promotion.endDate}" pattern="yyyy-MM-dd"/>
  		</div>
  		<div>${promotion.viewCount}</div>
  	</div>
  	<div class="category-container d-flex justify-content-center align-items-center w-100">
		<div class="category-all col-2">
			<strong>전체보기</strong>
		</div>
		<div class="category-details col-8">
			<c:forEach items="${productCategory}" var="product" varStatus="vs">
				<span class="category-badge badge badge-secondary" data-target="${product['CHILD_CATEGORY_CODE']}">${product['CHILD_CATEGORY_TITLE']}</span>
			</c:forEach>
		</div>
	</div>
	<div class="item-sort-container d-flex 	justify-content-between">
		<div class="p-4">총 <span id="productSize">${promotion.productList.size()}</span>개</div>
		<div class="p-4" id="">
			<span class="pr-2 pl-2 shop-sort">추천순</span>
			<span class="pr-2 pl-2 shop-sort">신상품순</span>
			<span class="pr-2 pl-2 shop-sort">판매량순</span>
			<span class="pr-2 pl-2 shop-sort">혜택순</span>
			<span class="pr-2 pl-2 shop-sort">낮은 가격순</span>
			<span class="pr-2 pl-2 shop-sort">높은 가격순</span>
		</div>
	</div>
	<div id="productPromotionContainer" class="row">
		<c:forEach items="${promotion.productList}" var="product" varStatus="vs">
	  	  <a href="${pageContext.request.contextPath}/shop/itemDetail.do?productCode=${product.productCode}" class="col-md-3 p-5">
	        <div class="card-box-d">
	          <div class="card-img-d shop-item-img position-relative">
	            <img src="${pageContext.request.contextPath}/resources/upload/product/${product.thumbnail}" alt="" class="img-d img-fluid">
	            <i class="shop-like-icon fas fa-heart position-absolute"></i>
	            <i class="shop-cart-icon fas fa-cart-plus position-absolute"></i>
	          </div>
	          <div>
	          	<p class="m-0">${product.name}</p>
	          	<strong><fmt:formatNumber type="currency">${product.price}</fmt:formatNumber></strong>
	          </div>
	        </div>
	      </a>
	    </c:forEach>
    </div>
    <nav aria-label="..." class="mx-auto text-center">
    <div class="banner mx-auto text-center mb-3">
    </div>
	  <ul class="pagination justify-content-center">
	    <li class="page-item">
	      <a class="page-link" href="#" aria-label="Previous">
	        <span aria-hidden="true">&laquo;</span>
	        <span class="sr-only">Previous</span>
	      </a>
	    </li>
	    <li class="page-item active"><a class="page-link" href="#">1</a></li>
	    <li class="page-item ">
	      <a class="page-link" href="#">2</a>
	    </li>
	    <li class="page-item"><a class="page-link" href="#">3</a></li>
		<li class="page-item">
	      <a class="page-link" href="#" aria-label="Next">
	        <span aria-hidden="true">&raquo;</span>
	        <span class="sr-only">Next</span>
	      </a>
	    </li>
	  </ul>
	</nav>
</div>
<script>
$(".category-badge").click((e)=>{
	//클릭한 배지가 선택되어 있던 배지인지 아닌지 체크
	if($(e.target).is(".badge-secondary")){
		$(e.target)
			.removeClass("badge-secondary")
			.addClass("badge-primary");
	}
	else if($(e.target).is(".badge-primary")){
		$(e.target)
			.removeClass("badge-primary")
			.addClass("badge-secondary");
		
	}
	
	//primary클래스를 가진 소분류 카테고리를 모아 카테고리 코드를 모은 배열 생성
	const $sort = $(".badge-primary");
	const data = [];
	
	$sort.each((i, item)=>{
		data.push($(item).data("target"));
	});
	
	console.log(data);
	
	$.ajax({
		url : "${pageContext.request.contextPath}/shop/sortSearch.do",
		data : {childCategoryCode : data,
				promotionCode : "${promotion.promotionCode}"},
		method : "GET",
		success(data){
			//상품 초기화
			$("#productPromotionContainer").html('');
			
			const productSize = data.length;
			$("#productSize").text(productSize);
			
			$(data).each((i, item)=>{
				//가격에 원화 표기 및 콤마 추가하기
				const itemPrice = item.price;
				const price = itemPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
				
				let str = `<a href="${pageContext.request.contextPath}/shop/itemDetail.do?productCode=\${item.productCode}" class="col-md-3 p-5">
			        <div class="card-box-d">
			          <div class="card-img-d shop-item-img position-relative">
			            <img src="${pageContext.request.contextPath}/resources/upload/product/\${item.thumbnail}" alt="" class="img-d img-fluid">
			            <i class="shop-like-icon fas fa-heart position-absolute"></i>
			            <i class="shop-cart-icon fas fa-cart-plus position-absolute"></i>
			          </div>
			          <div>
			          	<p class="m-0">\${item.name}</p>
			          	<strong>&#8361;\${price}</strong>
			          </div>
			        </div>
			      </a>`;
				$("#productPromotionContainer").append(str);
			});
		},
		error : console.log
	});
	
});
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
