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
                       <a href="${pageContext.request.contextPath}/shop/categoryItemAll?parentCate=mn"><img class="icon" src="https://i.ibb.co/7zcnV7J/monitor.png" alt=""></a>
                       <a href="${pageContext.request.contextPath}/shop/categoryItemAll?parentCate=ke"><img class="icon" src="https://i.ibb.co/vvXdtzx/keyboard.png" alt=""></a>
                       <a href="${pageContext.request.contextPath}/shop/categoryItemAll?parentCate=mo"><img class="icon" src="https://i.ibb.co/WxvDnGD/mouse.png" alt=""></a>
                       <a href="${pageContext.request.contextPath}/shop/categoryItemAll?parentCate=de"><img class="icon" src="https://i.ibb.co/z4n9ZXF/desk.png" alt=""></a>
                       <a href="${pageContext.request.contextPath}/shop/categoryItemAll?parentCate=ch"><img class="icon" src="https://i.ibb.co/HGP3PCL/chair.png" alt=""></a>
                       <a href="${pageContext.request.contextPath}/shop/categoryItemAll?parentCate=ot"><img class="icon" src="https://i.ibb.co/N386GVd/gitf.png" alt=""></a>
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
					               <c:forEach items="${latestProductList}" var="product" varStatus="vs">    
					                   <a href="${pageContext.request.contextPath}/shop/itemDetail/${product.productCode}" class="col-md-3 p-5">
					                       <div class="card-box-d">
					                           <div class="card-img-d shop-item-img position-relative">
						                           <img src="${pageContext.request.contextPath}/resources/upload/product/${product.thumbnail}" alt="" class="img-d img-fluid">
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
		               </div>
		               
		               <div class="mySlides fade">
			               <div class="cateText">인기 top-12</div>
			                   <!-- <div class="numbertext">2 / 3</div> -->
			                   <div class="row">
					               <c:forEach items="${top12ProductList}" var="product" varStatus="vs">
					                   <a href="${pageContext.request.contextPath}/shop/itemDetail/${product.productCode}" class="col-md-3 p-5">
					                       <div class="card-box-d">
					                           <div class="card-img-d shop-item-img position-relative">
						                           <img src="${pageContext.request.contextPath}/resources/upload/product/${product.thumbnail}" alt="" class="img-d img-fluid">
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
		               </div>
		               
		               <div class="mySlides fade">
			               <div class="cateText">만원의 행복</div>
			                   <!-- <div class="numbertext">3 / 3</div> -->
			                   <div class="row">
					               <c:forEach items="${tenThousandWonProductList}" var="product" varStatus="vs">
					                   <a href="${pageContext.request.contextPath}/shop/itemDetail/${product.productCode}" class="col-md-3 p-5">
					                       <div class="card-box-d">
					                           <div class="card-img-d shop-item-img position-relative">
						                           <img src="${pageContext.request.contextPath}/resources/upload/product/${product.thumbnail}" alt="" class="img-d img-fluid">
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
		               </div>
		               <a class="prev" onclick="plusSlides(-1)">&#10094;</a>
		               <a class="next" onclick="plusSlides(1)">&#10095;</a>
		           </div>
                   <!-- 카테고리 슬라이드 끝 -->
                   </div>
                   <!-- 이벤트 배너 시작 -->
                   <div id="shopMainMidEventBannerDiv">
                       <a href=""><img src="https://i.ibb.co/zRCKwsF/image.png" alt=""></a>
                   </div>
                   <!-- 이벤트 배너 끝 -->
                   <hr>
                   <!-- 인기 키워드 시작 -->
                   <div id="shopMostSearchedKeywordDiv">
                       <p id="hotKeywordP">인기 키워드</p>
                       <div class="row space-evenly">
                           <div class="keyword" id="keywordDiv1">
                               <div class="keywordImg" >
                                   <a href="${pageContext.request.contextPath}/shop/shopSearch?searchKeyword=자세"><img class="keyword-pic" src="https://i.ibb.co/s1sg93V/4ca2ccf43-700x700-95-FIT-1.jpg" alt=""></a>
                                   <a href="${pageContext.request.contextPath}/shop/shopSearch?searchKeyword=자세"><span class="keywordSpan">#자세보정</span></a>
                               </div>
                           </div>
                           <div class="keyword" id="keywordDiv2">
                               <div class="keywordImg" >
                                   <a href="${pageContext.request.contextPath}/shop/categoryItemAll?parentCate=ke"><img class="keyword-pic"  src="https://i.ibb.co/1LPhNct/keyboard.jpg" alt=""></a>
                                   <a href="${pageContext.request.contextPath}/shop/categoryItemAll?parentCate=ke"><span class="keywordSpan">#예쁜 키보드</span></a>
                               </div>
                           </div>
                           <div class="keyword" id="keywordDiv3">
                               <div class="keywordImg" >
                                   <a href="${pageContext.request.contextPath}/shop/shopChildCate?childCategoryCode=3ot"><img class="keyword-pic"  src="https://i.ibb.co/02XgsZ1/ot-3ot-194.jpg" alt=""></a>
                                   <a href="${pageContext.request.contextPath}/shop/shopChildCate?childCategoryCode=3ot"><span class="keywordSpan">#재밌는제품</span></a>
                               </div>
                           </div>
                           <div class="keyword" id="keywordDiv4">
                               <div class="keywordImg" >
                                   <a href="${pageContext.request.contextPath}/about.do"><img class="keyword-pic"  src="https://i.ibb.co/Pzt3ZKY/Giant-Thumb.jpg" alt=""></a>
                                   <a href="${pageContext.request.contextPath}/about.do"><span class="keywordSpan">#우리이야기</span></a>
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
                       <c:if test="${reviewList != null}">
	                       <c:forEach items="${reviewList}" var ="r">
	                           <div class="bestReview">
	                               <a href="${pageContext.request.contextPath}/shop/itemDetail/${r.productCode}">
	                               	<img src="${pageContext.request.contextPath}/resources/upload/review/${r.attach.renamedFilename}" alt="">
	                               	<span class="reviewSpan2">${r.id}님의</span>
	                               	<span class="reviewSpan">리뷰상품보러가기</span>
	                               </a>
	                           </div>
	                       </c:forEach>
                       </c:if>
                   </div>
                   <!-- 베스트 리뷰 끝 -->
                   <hr id="hr2">
                   <div id="shopItemsAccordionDiv">
                       <div id="shopAccordionDiv1">
                           <div class="text-center">
                               <p class="accordionP">
	                               <a class="" data-toggle="collapse" href="#collapseExample" role="button" aria-expanded="false" aria-controls="collapseExample">
	                                   ${currentPromotion[0].name} ▽
	                               </a>
                               </p>
                           </div>
                           <div class="collapse" id="collapseExample">
     	                      <div class="card card-body">
     	                         <div class="arrordionItemsC">
     	                             <!--혜진상품시작-->
                                     <div class="row">
                                       	   <!-- 지원 상품 조회 시작 -->
    	                                   <c:if test="${promotionProductList1 ne null}">
				                               <c:forEach items="${promotionProductList1}" var="product" varStatus="vs">
				                                   <a href="#" class="col-md-3 p-5">
				                                       <div class="card-box-d">
				                                           <div class="card-img-d shop-item-img position-relative">
				                                               <img src="${pageContext.request.contextPath }/resources/upload/product/${product.thumbnail}" alt="" class="img-d img-fluid">
				                                               <i class="shop-cart-icon fas fa-cart-plus position-absolute"></i>
				                                           </div>
				                                           <div>
				                                               <p class="m-0">${product.name}</p>
				                                               <strong><fmt:formatNumber type="currency">${product.price}</fmt:formatNumber></strong>
				                                           </div>
				                                       </div>
				                                   </a>
				                               </c:forEach>
			                               </c:if>
			                               <c:if test="${promotionProductList1 eq null}">
				                 	           해당 이벤트는 현재 상품 준비중입니다.   
			                               </c:if>
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
	                                      ${currentPromotion[1].name} ▽
	                                   </a>
	                               </p>
	                           </div>
                           <div class="collapse" id="collapseExample2">
	                               <div class="arrordionItemsC">
		                               <!--혜진상품시작-->
		                               <div class="row">
    	                                   <c:if test="${promotionProductList2 ne null}">
				                               <c:forEach items="${promotionProductList2}" var="product" varStatus="vs">
				                                   <a href="#" class="col-md-3 p-5">
				                                       <div class="card-box-d">
				                                           <div class="card-img-d shop-item-img position-relative">
				                                               <img src="${pageContext.request.contextPath }/resources/upload/product/${product.thumbnail}" alt="" class="img-d img-fluid">
				                                               <i class="shop-cart-icon fas fa-cart-plus position-absolute"></i>
				                                           </div>
				                                           <div>
				                                               <p class="m-0">${product.name}</p>
				                                               <strong><fmt:formatNumber type="currency">${product.price}</fmt:formatNumber></strong>
				                                           </div>
				                                       </div>
				                                   </a>
				                               </c:forEach>
			                               </c:if>
			                               <c:if test="${promotionProductList2 eq null}">
				                 	           해당 이벤트는 현재 상품 준비중입니다.   
			                               </c:if>
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
                                      ${currentPromotion[2].name} ▽
                                   </a>
                               </p>
                           </div>
                           <div class="collapse" id="collapseExample3">
                             <div class="card card-body">
                               <div class="arrordionItemsC">
            	                   <div class="row">
                                       <c:if test="${promotionProductList1 ne null}">
			                               <c:forEach items="${promotionProductList1}" var="product" varStatus="vs">
			                                   <a href="#" class="col-md-3 p-5">
			                                       <div class="card-box-d">
			                                           <div class="card-img-d shop-item-img position-relative">
			                                               <img src="${pageContext.request.contextPath }/resources/upload/product/${product.thumbnail}" alt="" class="img-d img-fluid">
			                                               <i class="shop-cart-icon fas fa-cart-plus position-absolute"></i>
			                                           </div>
			                                           <div>
			                                               <p class="m-0">${product.name}</p>
			                                               <strong><fmt:formatNumber type="currency">${product.price}</fmt:formatNumber></strong>
			                                           </div>
			                                       </div>
			                                   </a>
			                               </c:forEach>
		                               </c:if>
		                               <c:if test="${promotionProductList3 eq null}">
			                 	           해당 이벤트는 현재 상품 준비중입니다.   
		                               </c:if>
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

