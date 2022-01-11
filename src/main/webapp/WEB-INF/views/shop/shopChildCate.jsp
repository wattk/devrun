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
<%-- <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/shop/rightSideBox.js"></script> --%>

<link href="${pageContext.request.contextPath }/resources/css/shop/shopDetail.css" rel="stylesheet">


<style>
@font-face {
      font-family: 'SANJUGotgam';
      src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2112@1.0/SANJUGotgam.woff') format('woff');
      font-weight: normal;
      font-style: normal;
  }

#thisCateName{
	font-family: 'SANJUGotgam';
	font-size: 23px;
}
</style>


<sec:authentication property="principal" var="member" />


<div class="shop-container">
	<div class="mx-auto text-center p-5">
		<h4>마우스</h4>
	</div>
	<div class="category-container d-flex justify-content-center align-items-center w-100">
		<strong id="thisCateName" >${thisCateName}</strong>
		<div class="category-all col-2">
		</div>
		<div class="category-details col-8">
		</div>
	</div>
	<div class="item-sort-container d-flex 	justify-content-between">
		<div class="p-4">총 ${total}개</div>
		<div class="p-4">
			<span class="pr-2 pl-2 shop-sort" data-target="new" data-valid="1">신상품순</span>
			<span class="pr-2 pl-2 shop-sort" data-target="recommend" data-valid="0">추천순</span>
			<span class="pr-2 pl-2 shop-sort" data-target="row" data-valid="0">낮은 가격순</span>
			<span class="pr-2 pl-2 shop-sort" data-target="high" data-valid="0">높은 가격순</span>
		</div>
	</div>
	<div id = "productSortContainer" class="row">
		<!-- 아이템 나열 시작 -->
      <!-- 아이템 나열 끝 -->
    </div>
    <div class="banner mx-auto text-center mb-3">
    	<img src="${pageContext.request.contextPath}/resources/upload/promotion/PROMO_f2z7M27K77UDWm9.png" alt="" />
    </div>
	  <ul class="pagination justify-content-center mt-5">
	  </ul>
	  <div id="pageBar">
	  </div>
</div>





<!-- 위시리스트 로그인 했을 시 비동기 시작 -->
<sec:authorize access="isAuthenticated()">
	<script>
$(document).on('click', '.wishBtn', function(e) {
	console.log("도착?");
	const $memberNo = ${member.memberNo};
	const $productCode = $(e.target).data("productCode");

	console.log(`$memberNo : \${$memberNo}`);
	console.log(`$productCode : \${$productCode}`);
	
	const wishYn = $(e.target).data("wishyn");
	
	if(wishYn == 'N'){
			$.ajax({
				
				url: "${pageContext.request.contextPath}/shop/wishlistAdd",
				method: "Get",
				data : {
					memberNo:  $memberNo,
					productCode : $productCode 
					
				},
				success(data){
					if(data == 1){
						$(e.target).data('wishyn', 'Y');
						$(e.target).attr('class', 'shop-like-icon fas fa-heart position-absolute wishBtn');							
					}
				},
				error: console.log
		});
	}else{
		$.ajax({
			
			url: "${pageContext.request.contextPath}/shop/wishlistDelete",
			method: "Get",
			data : {
				memberNo:  $memberNo,
				productCode : $productCode 
				
			},
			success(data){
				if(data == 1){
					$(e.target).data('wishyn', 'N');
					$(e.target).attr('class', 'shop-like-icon far fa-heart position-absolute wishBtn');							
				}
			},
			error: console.log
	});
		
		
	}
	
})
</script>
</sec:authorize>
<!-- 위시리스트 로그인 했을 시 비동기 끝 -->

<!-- 위시리스트 비 로그인 시 비동기 시작 -->
<sec:authorize access="isAnonymous()">
	<script>
$(document).on('click', '.wishBtn', function(e) {
	alert("로그인 후 이용가능합니다.");
	return;

})

</script>
</sec:authorize>
<!-- 위시리스트 비 로그인 시 비동기 끝 -->



<script>

window.onload = basic;

function basic(){
	let cPage = 1;
	
	$.ajax({
		url : "${pageContext.request.contextPath}/shop/childCatePageSort",
		method : "GET",
		data : {
				childCateCode : "${childCategoryCode}",
				keyword : 'new',
				total : ${total},
				cPage : cPage
				},
		success(data){
				console.log(data);
				$("#productSortContainer").html(data["productStr"]);
				$(".pagebar").detach();
				$("#pageBar").after(data["pagebar"]);
			
		},
		error : console.log
	});
	
}


//이벤트 상품 소분류 코드별 정렬
$(document).on("click", ".shop-sort, .page-link", (e)=>{
	let cPage = 1;
	
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
	

	$.ajax({
		url : "${pageContext.request.contextPath}/shop/childCatePageSort",
		method : "GET",
		data : {
				childCateCode : "${childCategoryCode}",
				keyword : sort,
				total : ${total},
				cPage : cPage
				},
		success(data){
				console.log(data);
				$("#productSortContainer").html(data["productStr"]);
				$(".pagebar").detach();
				$("#pageBar").after(data["pagebar"]);
			
		},
		error : console.log
	});
	
});
//혜진코드 끝

</script>
<!-- shopHeader js  -->
<%-- <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/shop/shopHeader.js"></script> --%>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
