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
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/shop/rightSideBox.js"></script>


<link href="${pageContext.request.contextPath }/resources/css/shop/shopDetail.css" rel="stylesheet">
<div class="shop-container">
	<div class="mx-auto text-left p-5" id="">
		<h5 class="m-0"><strong>"마우스"</strong>에 대한 스토어 검색 결과 <strong>30개</strong></h5>
	</div>
	<div class="mx-auto text-right p-4" id="">
		<span class="pr-2 pl-2 shop-sort">추천순</span>
		<span class="pr-2 pl-2 shop-sort">신상품순</span>
		<span class="pr-2 pl-2 shop-sort">판매량순</span>
		<span class="pr-2 pl-2 shop-sort">혜택순</span>
		<span class="pr-2 pl-2 shop-sort">낮은 가격순</span>
		<span class="pr-2 pl-2 shop-sort">높은 가격순</span>
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
