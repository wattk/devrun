<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>	
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="통합검색" name="title"/>
</jsp:include>
<link href="${pageContext.request.contextPath }/resources/css/shop/shopDetail.css" rel="stylesheet">
<div class="mx-auto text-center p-4" id="resultText">
	<p class="m-0">검색어 <strong>"마우스"</strong>에 대한 총 <strong>30건</strong>의 결과를 찾았습니다.</p>
</div>
<div class="search-containers">
	<ul class="list-group list-group-flush">
	  <li class="list-group-item p-4">
		<h5 class="pb-2">통합검색 총 0,000건</h5>
	  </li>
	  <li class="list-group-item">
		<h4>커뮤니티 총 0,000건</h4>
		<div class="list-group">
		  <a href="#" class="list-group-item list-group-item-action flex-column align-items-start">
		    <div class="d-flex w-100 justify-content-between">
		      <div>
			      <span class="font-weight-normal">[자유게시판]</span>
			      <h5 class="mb-1 d-inline"> dolorum eligendi facere cupiditate enim quae vero?</h5>
		      </div>
		      <small>2021.12.19</small>
		    </div>
		    <p class="mb-1">Donec id elit non mi porta gravida at eget metus. Maecenas sed diam eget risus varius blandit.</p>
		    <small>Donec id elit non mi porta.</small>
		  </a>
		  <a href="#" class="list-group-item list-group-item-action flex-column align-items-start">
		    <div class="d-flex w-100 justify-content-between">
		      <div>
			      <span class="font-weight-normal">[자유게시판]</span>
			      <h5 class="mb-1 d-inline"> dolorum eligendi facere cupiditate enim quae vero?</h5>
		      </div>
		      <small>2021.12.19</small>
		    </div>
		    <p class="mb-1">Donec id elit non mi porta gravida at eget metus. Maecenas sed diam eget risus varius blandit.</p>
		    <small>Donec id elit non mi porta.</small>
		  </a>
		  <a href="#" class="list-group-item list-group-item-action flex-column align-items-start">
		    <div class="d-flex w-100 justify-content-between">
		      <div>
			      <span class="font-weight-normal">[자유게시판]</span>
			      <h5 class="mb-1 d-inline"> dolorum eligendi facere cupiditate enim quae vero?</h5>
		      </div>
		      <small>2021.12.19</small>
		    </div>
		    <p class="mb-1">Donec id elit non mi porta gravida at eget metus. Maecenas sed diam eget risus varius blandit.</p>
		    <small>Donec id elit non mi porta.</small>
		  </a>
		</div>
		<a href="" class="text-right d-block pb-3">더보기</a>
		<hr />
	  </li>
	  <li class="list-group-item">
	  	<h4>상품 총 0,000건</h4>
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
        <a href="" class="text-right d-block pb-3">더보기</a>
        <hr />
	  </li>
	  <li class="list-group-item">
	  	<h4>공지사항 총 0,000건</h4>
	  	<div class="list-group">
		  <a href="#" class="list-group-item list-group-item-action flex-column align-items-start">
		    <div class="d-flex w-100 justify-content-between">
		      <h5 class="mb-1 d-inline"> dolorum eligendi facere cupiditate enim quae vero?</h5>
		      <small>2021.12.19</small>
		    </div>
		    <p class="mb-1">Donec id elit non mi porta gravida at eget metus. Maecenas sed diam eget risus varius blandit.</p>
		    <small>Donec id elit non mi porta.</small>
		  </a>
		  <a href="#" class="list-group-item list-group-item-action flex-column align-items-start">
		    <div class="d-flex w-100 justify-content-between">
		      <h5 class="mb-1 d-inline"> dolorum eligendi facere cupiditate enim quae vero?</h5>
		      <small>2021.12.19</small>
		    </div>
		    <p class="mb-1">Donec id elit non mi porta gravida at eget metus. Maecenas sed diam eget risus varius blandit.</p>
		    <small>Donec id elit non mi porta.</small>
		  </a>
		  <a href="#" class="list-group-item list-group-item-action flex-column align-items-start">
		    <div class="d-flex w-100 justify-content-between">
		      <h5 class="mb-1 d-inline"> dolorum eligendi facere cupiditate enim quae vero?</h5>
		      <small>2021.12.19</small>
		    </div>
		    <p class="mb-1">Donec id elit non mi porta gravida at eget metus. Maecenas sed diam eget risus varius blandit.</p>
		    <small>Donec id elit non mi porta.</small>
		  </a>
		</div>
		<a href="" class="text-right d-block pb-3">더보기</a>
	  </li>
	</ul>
</div>
<script>

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
