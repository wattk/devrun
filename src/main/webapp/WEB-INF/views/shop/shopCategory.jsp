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
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/shop/rightSideBox.js"></script>

<link href="${pageContext.request.contextPath }/resources/css/shop/shopDetail.css" rel="stylesheet">
<div class="shop-container">
	<div class="mx-auto text-center p-5">
		<h4>마우스</h4>
	</div>
	<div class="category-container d-flex justify-content-center align-items-center w-100">
		<div class="category-all col-2">
			<strong>전체보기</strong>
		</div>
		<div class="category-details col-8">
			<span class="category-badge badge badge-primary">유선 마우스</span>
			<span class="category-badge badge badge-secondary">무선 마우스</span>
			<span class="category-badge badge badge-secondary">버티컬 마우스</span>
			<span class="category-badge badge badge-secondary">충전식 마우스</span>
			<span class="category-badge badge badge-secondary">블루투스 마우스</span>
			<span class="category-badge badge badge-secondary">레이저 마우스</span>
			<span class="category-badge badge badge-secondary">인체공학 마우스</span>
		</div>
	</div>
	<div class="item-sort-container d-flex 	justify-content-between">
		<div class="p-4">총 465개</div>
		<div class="p-4" id="">
			<span class="pr-2 pl-2 shop-sort">추천순</span>
			<span class="pr-2 pl-2 shop-sort">신상품순</span>
			<span class="pr-2 pl-2 shop-sort">판매량순</span>
			<span class="pr-2 pl-2 shop-sort">혜택순</span>
			<span class="pr-2 pl-2 shop-sort">낮은 가격순</span>
			<span class="pr-2 pl-2 shop-sort">높은 가격순</span>
		</div>
	</div>
	<div class="row">
  	  <a href="#" class="col-md-3 p-5">
        <div class="card-box-d">
          <div class="card-img-d shop-item-img position-relative">
            <img src="${pageContext.request.contextPath }/resources/images/800x896.jpg" alt="" class="img-d img-fluid">
            <i class="shop-like-icon fas fa-heart position-absolute"></i>
            <i class="shop-cart-icon fas fa-cart-plus position-absolute"></i>
          </div>
          <div>
          	<p class="m-0">ROCCAT KONE PURE ULTRA 게이밍 마우스 블랙</p>
          	<strong>5,490원</strong>
          </div>
        </div>
      </a>
  	  <a href="#" class="col-md-3 p-5">
       <div class="card-box-d">
         <div class="card-img-d shop-item-img position-relative">
           <img src="${pageContext.request.contextPath }/resources/images/800x896.jpg" alt="" class="img-d img-fluid">
           <i class="shop-like-icon fas fa-heart position-absolute"></i>
           <i class="shop-cart-icon fas fa-cart-plus position-absolute"></i>
         </div>
         <div>
         	<p class="m-0">ROCCAT KONE PURE ULTRA 게이밍 마우스 블랙</p>
         	<strong>5,490원</strong>
         </div>
       </div>
      </a>
  	  <a href="#" class="col-md-3 p-5">
       <div class="card-box-d">
         <div class="card-img-d shop-item-img position-relative">
           <img src="${pageContext.request.contextPath }/resources/images/800x896.jpg" alt="" class="img-d img-fluid">
           <i class="shop-like-icon fas fa-heart position-absolute"></i>
           <i class="shop-cart-icon fas fa-cart-plus position-absolute"></i>
         </div>
         <div>
         	<p class="m-0">ROCCAT KONE PURE ULTRA 게이밍 마우스 블랙</p>
         	<strong>5,490원</strong>
         </div>
       </div>
      </a>
  	  <a href="#" class="col-md-3 p-5">
        <div class="card-box-d">
          <div class="card-img-d shop-item-img position-relative">
            <img src="${pageContext.request.contextPath }/resources/images/800x896.jpg" alt="" class="img-d img-fluid">
            <i class="shop-like-icon fas fa-heart position-absolute"></i>
            <i class="shop-cart-icon fas fa-cart-plus position-absolute"></i>
          </div>
          <div>
          	<p class="m-0">ROCCAT KONE PURE ULTRA 게이밍 마우스 블랙</p>
          	<strong>5,490원</strong>
          </div>
        </div>
      </a>
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

<!-- shopHeader js  -->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/shop/shopHeader.js"></script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
