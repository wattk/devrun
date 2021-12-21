<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>	
<fmt:requestEncoding value="utf-8"/>

<!-- Header 임포트 -->
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="shopMain" name="title"/>
</jsp:include>

<!-- js 임포트 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/shop/shopMain.js" ></script>


<!-- css 임포트 -->
<link href="${pageContext.request.contextPath}/resources/css/shop/shopMain.css" rel="stylesheet">


<!-- Body부분 시작 -->

        <!-- 오늘 본 상품 -->
        <jsp:include page="/WEB-INF/views/shop/rightSideBox.jsp">
			<jsp:param value="" name=""/>
		</jsp:include>
        <!-- 오늘 본 상품 -->
        
        <!--쇼핑몰 헤더-->
        <jsp:include page="/WEB-INF/views/shop/shopHeader.jsp">
			<jsp:param value="" name=""/>
		</jsp:include>
        <!--쇼핑몰 헤더부분-->
  

           <div id="shopitemsDiv">
               <div id="shopEventSlideDiv" >
                   <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
                       <ol class="carousel-indicators">
                         <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
                         <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
                         <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
                       </ol>
                       <div class="carousel-inner">
                         <div class="carousel-item active">
                           <img class="d-block w-100" src="https://i.ibb.co/cDFYP1c/image.jpg" alt="First slide">
                         </div>
                         <div class="carousel-item">
                           <img class="d-block w-100"  src="https://i.ibb.co/MDTWkNY/2.png" alt="Second slide">
                         </div>
                         <div class="carousel-item">
                           <img class="d-block w-100" src="https://i.ibb.co/3F96Sy0/3.png" alt="Third slide">
                         </div>
                       </div>
                       <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
                         <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                         <span class="sr-only">Previous</span>
                       </a>
                       <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
                         <span class="carousel-control-next-icon" aria-hidden="true"></span>
                         <span class="sr-only">Next</span>
                       </a>
                     </div>
               </div>
               <div id="shopIconCategoryDiv">
                   <div id="iconBoxDiv" class="row space-evenly">
                       <a href="#"><img class="icon" src="https://i.ibb.co/7zcnV7J/monitor.png" alt=""></a>
                       <a href="#"><img class="icon" src="https://i.ibb.co/vvXdtzx/keyboard.png" alt=""></a>
                       <a href="#"><img class="icon" src="https://i.ibb.co/WxvDnGD/mouse.png" alt=""></a>
                       <a href="#"><img class="icon" src="https://i.ibb.co/z4n9ZXF/desk.png" alt=""></a>
                       <a href="#"><img class="icon" src="https://i.ibb.co/HGP3PCL/chair.png" alt=""></a>
                       <a href="#"><img class="icon" src="https://i.ibb.co/N386GVd/gitf.png" alt=""></a>
                   </div>
               </div>
               <div id="shopDisplayDiv">
                   <div id="shopItemsSlideByCategoryDiv">
                   <!-- 카테고리 슬라이드 시작 -->
		             <div style="text-align:center">
		               <span class="dot" onclick="currentSlide(1)"></span> 
		               <span class="dot" onclick="currentSlide(2)"></span> 
		               <span class="dot" onclick="currentSlide(3)"></span> 
		             </div>
		             <div class="slideshow-container">
		               <div class="mySlides fade">
		                         <div class="cateText">신상품</div>
		                 <!-- <div class="numbertext">1 / 3</div> -->
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
		               </div>
		               
		               <div class="mySlides fade">
		                         <div class="cateText">이번주 top-8</div>
		                 <!-- <div class="numbertext">2 / 3</div> -->
		                 <div class="row">
		                   <a href="#" class="col-md-3 p-5">
		                       <div class="card-box-d">
		                         <div class="card-img-d shop-item-img position-relative">
		                           <img src="${pageContext.request.contextPath }/resources/images/800x896.jpg" alt="" class="img-d img-fluid">
		                           <i class="shop-like-icon fas fa-heart position-absolute"></i>
		                           <i class="shop-cart-icon fas fa-cart-plus position-absolute"></i>
		                         </div>
		                         <div>
		                           <p class="m-0">삼성 Galxay 우주를 담은 키보드</p>
		                           <strong>20,000원</strong>
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
		                           <p class="m-0">삼성 Galxay 우주를 담은 키보드</p>
		                           <strong>20,000원</strong>
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
		                           <p class="m-0">삼성 Galxay 우주를 담은 키보드</p>
		                           <strong>20,000원</strong>
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
		                           <p class="m-0">삼성 Galxay 우주를 담은 키보드</p>
		                           <strong>20,000원</strong>
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
		                           <p class="m-0">삼성 Galxay 우주를 담은 키보드</p>
		                           <strong>20,000원</strong>
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
		                           <p class="m-0">삼성 Galxay 우주를 담은 키보드</p>
		                           <strong>20,000원</strong>
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
		                           <p class="m-0">삼성 Galxay 우주를 담은 키보드</p>
		                           <strong>20,000원</strong>
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
		                           <p class="m-0">삼성 Galxay 우주를 담은 키보드</p>
		                           <strong>20,000원</strong>
		                         </div>
		                       </div>
		                     </a>
		                   </div>
		               </div>
		               <div class="mySlides fade">
		                         <div class="cateText">할인상품</div>
		                 <!-- <div class="numbertext">3 / 3</div> -->
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
		                           <strong>10,000원</strong>
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
		                           <strong>10,000원</strong>
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
		                           <strong>10,000원</strong>
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
		                           <strong>10,000원</strong>
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
		                           <strong>10,000원</strong>
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
		                           <strong>10,000원</strong>
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
		                           <strong>10,000원</strong>
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
		                           <strong>10,000원</strong>
		                         </div>
		                       </div>
		                     </a>
		                   </div>
		               </div>
		               <a class="prev" onclick="plusSlides(-1)">&#10094;</a>
		               <a class="next" onclick="plusSlides(1)">&#10095;</a>
		             </div>
                   <!-- 카테고리 슬라이드 끝 -->
                   </div>
                   <div id="shopMainMidEventBannerDiv">
                       <a href=""><img src="https://i.ibb.co/zRCKwsF/image.png" alt=""></a>
                   </div>
                   <hr>
                   <!-- 인기 키워드 시작 -->
                   <div id="shopMostSearchedKeywordDiv">
                       <p id="hotKeywordP">인기 키워드</p>
                       <div class="row space-evenly">
                           <div class="keyword" id="keywordDiv1">
                               <div class="keywordImg" >
                                   <a href=""><img src="https://i.ibb.co/tQyHz8m/hot-Keyword.png" alt=""></a>
                                   <a href=""><span class="keywordSpan">#신입개발자</span></a>
                               </div>
                           </div>
                           <div class="keyword" id="keywordDiv2">
                               <div class="keywordImg" >
                                   <a href=""><img src="https://i.ibb.co/M8vtK1H/hot-Keyword3.png" alt=""></a>
                                   <a href=""><span class="keywordSpan">#5년대세일</span></a>
                               </div>
                           </div>
                           <div class="keyword" id="keywordDiv3">
                               <div class="keywordImg" >
                                   <a href=""><img src="https://i.ibb.co/tQyHz8m/hot-Keyword.png" alt=""></a>
                                   <a href=""><span class="keywordSpan">#겨울용품</span></a>
                               </div>
                           </div>
                           <div class="keyword" id="keywordDiv4">
                               <div class="keywordImg" >
                                   <a href=""><img src="https://i.ibb.co/M8vtK1H/hot-Keyword3.png" alt=""></a>
                                   <a href=""><span class="keywordSpan">#허허허헣허</span></a>
                               </div>
                           </div>
                       </div>
                   </div>
                   <!-- 인기 키워드 끝 -->
                   <hr>
                   <!-- 베스트 리뷰 시작 -->
                   <div id="shopMainBestReviewsDiv">
                       <p id="bestReviewsP">이달의 Best Reviews</p>
                       <div class="row space-evenly">
                           <div class="bestReview" id="bestReviewDiv1">
                               <a href=""><img src="https://i.ibb.co/Z6J4nTt/best-Review1.jpg" alt=""></a>
                           </div>
                           <div class="bestReview" id="bestReviewDiv3">
                               <a href=""><img src="https://i.ibb.co/Z6J4nTt/best-Review1.jpg" alt=""></a>
                           </div> 
                           <div class="bestReview" id="bestReviewDiv3">
                               <a href=""><img src="https://i.ibb.co/Z6J4nTt/best-Review1.jpg" alt=""></a>
                           </div>
                           <div class="bestReview" id="bestReviewDiv3">
                               <a href=""><img src="https://i.ibb.co/Z6J4nTt/best-Review1.jpg" alt=""></a>
                           </div>  
                       </div>
                   </div>
                   <!-- 베스트 리뷰 끝 -->
                   <hr id="hr2">
                   <div id="shopItemsAccordionDiv">
                       <div id="shopAccordionDiv1">
                           <div class="text-center">
                               <p class="accordionP">
                                   <a class="" data-toggle="collapse" href="#collapseExample" role="button" aria-expanded="false" aria-controls="collapseExample">
                                      1만원 이하 인기 상품 ▽
                                   </a>
                               </p>
                           </div>
                           <div class="collapse" id="collapseExample">
                             <div class="card card-body">
                               <div class="arrordionItemsC">
                                   <!--혜진상품시작-->
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
                                   <!--혜진상품끝-->
                               </div>
                             </div>
                           </div>
                       </div>
                       <div id="shopAccordionDiv2">
                           <div class="text-center">
                               <p class="accordionP">
                                   <a class="" data-toggle="collapse" href="#collapseExample2" role="button" aria-expanded="false" aria-controls="collapseExample">
                                      MD추천상품 ▽
                                   </a>
                               </p>
                           </div>
                           <div class="collapse" id="collapseExample2">
                               <div class="arrordionItemsC">
                                                                    <!--혜진상품시작-->
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
                                   <!--혜진상품끝-->
                               </div>
                             </div>
                           </div>
                       </div>
                       <div id="shopAccordionDiv3">
                           <div class="text-center">
                               <p class="accordionP">
                                   <a class="" data-toggle="collapse" href="#collapseExample3" role="button" aria-expanded="false" aria-controls="collapseExample">
                                      손목 고통은 이제 안녕~ ▽
                                   </a>
                               </p>
                           </div>
                           <div class="collapse" id="collapseExample3">
                             <div class="card card-body">
                               <div class="arrordionItemsC">
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
                               </div>
                             </div>
                           </div>
                       </div>
                   </div>
               </div>   



<!-- js 임포트 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/shop/shopMain.js" ></script>


<!-- footer 임포트 -->
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
<!-- footer 임포트 -->

