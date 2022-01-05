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


<!-- shopSideBox 관련 임포트 -->
<jsp:include page="/WEB-INF/views/shop/rightSideBox.jsp"/>

<link href="${pageContext.request.contextPath }/resources/css/shop/shopDetail.css" rel="stylesheet">


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
		<div class="p-4">총 <span id="productSize">${totalContent}</span>개</div>
		<div class="p-4" id="">
			<span class="pr-2 pl-2 shop-sort" data-target="recommend">추천순</span>
			<span class="pr-2 pl-2 shop-sort" data-target="new">신상품순</span>
			<span class="pr-2 pl-2 shop-sort" data-target="sell">판매량순</span>
			<span class="pr-2 pl-2 shop-sort" data-target="row">낮은 가격순</span>
			<span class="pr-2 pl-2 shop-sort" data-target="high">높은 가격순</span>
		</div>
	</div>
	<div id="productPromotionContainer" class="row">
		<c:forEach items="${productList}" var="product" varStatus="vs">
	        <div class="card-box-d col-md-3 p-5">
	          <div class="card-img-d shop-item-img position-relative">
	            <img src="${pageContext.request.contextPath}/resources/upload/product/${product.thumbnail}" alt="" class="img-thumbnail shop-img img-d img-fluid">
	            <i class="shop-like-icon fas fa-heart position-absolute"></i>
	          </div>
		  	  <a href="${pageContext.request.contextPath}/shop/itemDetail/${product.productCode}">
		          <div>
		          	<p class="product-name m-0">${product.name}</p>
		          	<strong><fmt:formatNumber type="currency">${product.price}</fmt:formatNumber></strong>
		          </div>
		      </a>
	        </div>
	    </c:forEach>
    </div>
    ${pagebar}
</div>
<script>
//이벤트 상품 소분류 코드별 정렬
$(".category-badge, .shop-sort").click((e)=>{
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
	
	let sort;
	if($(e.target).is(".shop-sort")){
		sort = $(e.target).data("target");
	};
	
	//primary클래스를 가진 소분류 카테고리를 모아 카테고리 코드를 모은 배열 생성
	const $badges = $(".badge-primary");
	const data = [];
	
	$badges.each((i, item)=>{
		data.push($(item).data("target"));
	});
	
	
	$.ajax({
		url : "${pageContext.request.contextPath}/shop/childCategorySearch.do",
		data : {childCategoryCode : data,
				promotionCode : "${promotion.promotionCode}",
				keyword : sort},
		method : "GET",
		success(data){
			console.log(data);
			$("#productPromotionContainer").html(data["productStr"]);
			$("#productSize").text(data["totalContent"]);
			$(".pagebar").detach();
			$("#productPromotionContainer").after(data["pagebar"]);
			
		},
		error : console.log
	});
	
});

//상품 찜 리스트에 추가
$(".shop-like-icon").click((e)=>{
	
});
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
