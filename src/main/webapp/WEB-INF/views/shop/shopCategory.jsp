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

@font-face {
      font-family: 'SANJUGotgam';
      src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2112@1.0/SANJUGotgam.woff') format('woff');
      font-weight: normal;
      font-style: normal;
  }

.category-container{
	border :0px;
	background-color: beige;
}
.shop-item-img img{
	width:200px;
	height:200px;
	padding: 0.25rem;
    background-color: #fff;
    border: 1px solid #dee2e6;
    border-radius: 0.25rem;
    max-width: 100%;

}

</style>

<div class="shop-container">
	<div class="mx-auto text-center p-5">
		<h4 id="parentTitle" data-target="${parentCategory}">마우스</h4>
	</div>
	<div class="category-container d-flex justify-content-center align-items-center w-100">
		<div class="category-all col-2">
			<strong id="thisCateName" style="font-family: 'SANJUGotgam';" >전체보기</strong>
		</div>
		<div class="category-details col-8">
		<c:forEach items="${childCategoryList}" var ="c">
			<span class="category-badge badge badge-secondary" data-target="${c['CHILD_CATEGORY_CODE']}">${c["CHILD_CATEGORY_TITLE"]}</span>
		</c:forEach>
		</div>
	</div>
	</div>
		<div class="item-sort-container d-flex 	justify-content-between">
		<div class="p-4">총 <span id="productSize">${total}</span>개</div>
		<div class="p-4" id="">
			<span class="pr-2 pl-2 shop-sort" data-target="recommend" data-valid="0">추천순</span>
			<span class="pr-2 pl-2 shop-sort" data-target="new" data-valid="0">신상품순</span>
			<span class="pr-2 pl-2 shop-sort" data-target="row" data-valid="0">낮은 가격순</span>
			<span class="pr-2 pl-2 shop-sort" data-target="high" data-valid="0">높은 가격순</span>
		</div>
	</div>
	<div id="productContainer" class="row itembox">
		<!-- 아이템 나열 시작 -->
		<c:if test = "${itemList != null}">
			<c:forEach items="${itemList}" var="l">
		        <div class="card-box-d col-md-3 p-5">
		          <div class="card-img-d shop-item-img position-relative">
		          	<a href="${pageContext.request.contextPath}/shop/itemDetail/${l.productCode}">
		            <img src="${pageContext.request.contextPath }/resources/upload/product/${l.thumbnail}" alt="" class="img-d img-fluid">
		            </a>
		            <i class="shop-like-icon far fa-heart position-absolute"></i>
		          </div>
		          <div>
		          	<p class="m-0 ml-2">${l.name}</p>
		          	<strong class="ml-2"><fmt:formatNumber value="${l.price}" pattern="₩#,###,###"/></strong>
		          </div>
		        </div>
			</c:forEach>
		</c:if>
      <!-- 아이템 나열 끝 -->
    </div>
    <!-- <nav aria-label="..." class="mx-auto text-center"> -->
    <div class="banner mx-auto text-center">
    	<img src="${pageContext.request.contextPath}/resources/upload/promotion/PROMO_0y7fZo5w789Pse8.png" alt="" />
    </div>
	  ${pagebar}
	<!-- </nav> -->



<script>
const parentCategoryCode = $("#parentTitle").data("target");
let cPage = 1;

//이벤트 상품 소분류 코드별 정렬
$(document).on("click", ".category-badge, .shop-sort, .page-link", (e)=>{
	
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
		$(".shop-sort").data("valid", 0);
		sort = $(e.target).data("target");
		$(e.target).data("valid", 1);
	};
	if($(e.target).is(".page-link")){
		const $sortList = $(".shop-sort");
		cPage = $(e.target).data("cPage");
		$sortList.each((i, item)=>{
			if($(item).data("valid") == 1){
				sort = $(item).data("target");
			}
		});
	};
	console.log(cPage);
	console.log(sort);
	
	//primary클래스를 가진 소분류 카테고리를 모아 카테고리 코드를 모은 배열 생성
	const $badges = $(".badge-primary");
	const data = [];
	
	$badges.each((i, item)=>{
		data.push($(item).data("target"));
	});
	
	
	$.ajax({
		url : "${pageContext.request.contextPath}/shop/childCategorySearch.do",
		data : {parentCategoryCode : parentCategoryCode,
				childCategoryCode : data,
				keyword : sort,
				cPage : cPage},
		method : "GET",
		success(data){
			console.log(data);
			$("#productContainer").html(data["productStr"]);
			$("#productSize").text(data["totalContent"]);
			$(".pagebar").detach();
			$(".banner").after(data["pagebar"]);
			
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
