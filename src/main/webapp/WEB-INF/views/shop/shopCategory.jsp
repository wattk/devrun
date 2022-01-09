<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>	
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="category" name="title"/>
</jsp:include>

<!-- shopHeader 관련 임포트 -->
<jsp:include page="/WEB-INF/views/shop/shopHeader.jsp"/>
<link href="${pageContext.request.contextPath}/resources/css/shop/shopMain.css" rel="stylesheet">


<!-- shopSideBox 관련 임포트 -->
<jsp:include page="/WEB-INF/views/shop/rightSideBox.jsp"/>

<link href="${pageContext.request.contextPath }/resources/css/shop/shopDetail.css" rel="stylesheet">

<style>

.item-sort-container, .itembox{
	margin: 0 10% 0 10%;
}
</style>

<div class="shop-container">
	<div class="mx-auto text-center p-5">
		<h4>마우스</h4>
	</div>
	<div class="category-container d-flex justify-content-center align-items-center w-100">
		<div class="category-all col-2">
			<strong>전체보기</strong>
		</div>
		<div class="category-details col-8">
		<c:forEach items="${ChildCateNames}" var ="c">
			<span class="category-badge badge badge-primary">${c}</span>
		</c:forEach>
		</div>
	</div>
	</div>
		<div class="item-sort-container d-flex 	justify-content-between">
		<div class="p-4">총 ${total}개</div>
		<div class="p-4" id="">
			<span class="pr-2 pl-2 shop-sort" data-target="recommend">추천순</span>
			<span class="pr-2 pl-2 shop-sort" data-target="new">신상품순</span>
			<span class="pr-2 pl-2 shop-sort" data-target="row">낮은 가격순</span>
			<span class="pr-2 pl-2 shop-sort" data-target="high">높은 가격순</span>
		</div>
	</div>
	<div class="row itembox">
		<!-- 아이템 나열 시작 -->
		<c:if test = "${itemList != null}">
			<c:forEach items="${itemList}" var="l">
		  	  <a href="${pageContext.request.contextPath}/shop/itemDetail/${l.productCode}" class="col-md-3 p-5">
		        <div class="card-box-d">
		          <div class="card-img-d shop-item-img position-relative">
		            <img src="${pageContext.request.contextPath}/resources/upload/product/${l.thumbnail}" alt="" class="img-thumbnail shop-img img-d img-fluid">
		            <i class="shop-like-icon fas fa-heart position-absolute"></i>
		            <i class="shop-cart-icon fas fa-cart-plus position-absolute"></i>
		          </div>
		          <div>
		          	<p class="m-0">${l.name}</p>
		          	<strong><fmt:formatNumber value="${l.price}" pattern="₩#,###,###"/></strong>
		          </div>
		        </div>
		      </a>
			</c:forEach>
		</c:if>
      <!-- 아이템 나열 끝 -->
    </div>
    <nav aria-label="..." class="mx-auto text-center">
    <div class="banner mx-auto text-center mb-3">
    	<img src="${pageContext.request.contextPath}/resources/upload/promotion/PROMO_0y7fZo5w789Pse8.png" alt="" />
    </div>
	  <ul class="pagination justify-content-center mt-5">
	  </ul>
	  ${pagebar}
	</nav>



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
</script>

<!-- shopSideBox 관련 임포트 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/shop/rightSideBox.js"></script>

<!-- shopHeader js  -->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/shop/shopHeader.js"></script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
