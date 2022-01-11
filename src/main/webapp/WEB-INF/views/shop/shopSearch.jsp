<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>	
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="shopSearch" name="title"/>
</jsp:include>

<!-- shopHeader 관련 임포트 -->
<jsp:include page="/WEB-INF/views/shop/shopHeader.jsp"/>
<link href="${pageContext.request.contextPath}/resources/css/shop/shopMain.css" rel="stylesheet">

<!-- shopSideBox 관련 임포트 -->
<jsp:include page="/WEB-INF/views/shop/rightSideBox.jsp"/>
<%-- <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/shop/rightSideBox.js"></script> --%>


<link href="${pageContext.request.contextPath }/resources/css/shop/shopDetail.css" rel="stylesheet">



<style>
.shop-container{
	padding-top: 160px;
}

</style>

<div class="shop-container">
	<div class="mx-auto text-left p-5" id="">
		<h5 class="m-0"><strong>${searchKeyword}</strong>에 대한 상품 검색 결과 : <strong>${total}개</strong></h5>
	</div>
	<hr />
	<div class="mx-auto text-right p-4" id="">
		<div class="p-4" id="">
			<span class="pr-2 pl-2 shop-sort" data-target="recommend" data-valid="0">추천순</span>
			<span class="pr-2 pl-2 shop-sort" data-target="new" data-valid="0">신상품순</span>
			<span class="pr-2 pl-2 shop-sort" data-target="row" data-valid="0">낮은 가격순</span>
			<span class="pr-2 pl-2 shop-sort" data-target="high" data-valid="0">높은 가격순</span>
		</div>
	</div>
	<div id = "productSortContainer" class="row">
		<c:if test = "${searchList != null}">
			<c:forEach items="${searchList}" var="l">
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
    </div>
    <div id="pageBar">
    	${pagebar}
    </div>
</div>

<script>
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
		url : "${pageContext.request.contextPath}/shop/shopSearchSort",
		method : "GET",
		data : {
				searchKeyword : "${searchKeyword}",
				keyword : sort,
				total : ${total},
				cPage : cPage
				},
		success(data){
				console.log(data);
				$("#productSortContainer").html(data["productStr"]);
				$(".pagebar").detach();
				$("#pageBar").html(data["pagebar"]);
			
		},
		error : console.log
	});
	
});

</script>
<!-- shopHeader js  -->
<%-- <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/shop/shopHeader.js"></script> --%>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
