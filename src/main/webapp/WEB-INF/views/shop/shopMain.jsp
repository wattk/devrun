<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="" name=""/>
</jsp:include>
<title>ShopMainPage</title>

<!-- 구글폰트 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Song+Myung&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Pen+Script&display=swap" rel="stylesheet">

<style>

 /*실시간 순위 시작*/
#content {
    margin: 20px;
    padding: 10px;
    background: #393;
}

#rank-list a {
    color: #FFF;
    text-decoration: none;
}

#rank-list a:hover {
    text-decoration: underline;
}

#rank-list {
    overflow: hidden;
    width: 160px;
    height: 20px;
    margin: 0;
}

#rank-list dt {
    display: none;
}

#rank-list dd {
    position: relative;
    margin: 0;
}

#rank-list ol {
    position: absolute;
    top: 0;
    left: 0;
    margin: 0;
    padding: 0;
    list-style-type: none;
}

#rank-list li {
    height: 20px;
    line-height: 20px;
}
/*실시간 순위 끝*/

#shopSerachDiv input {
    width: 500px;
}
#sideMenuBtn{
    padding-left: 15px;
    padding-top: 10px;
}
#shopSerachDiv, #shopMainEventBtnDiv{
    margin: auto 0 ;
}
#shopMainEventBtnDiv{
    margin-left: 100px;
}
#shopMainEventBtn{
    color: white;
    font-weight: bold;
}
#sideMenuBtn:hover{
    cursor: pointer;
}
#sideMenuBtn {
    border-radius: 30;
}
#iconBoxDiv{
    margin-left: 50px;
    border: solid;
    width: 95%;
}
.icon {
    width: 70px;
    height: 70px;
    margin: auto 80px;
}
#shopIconCategoryDiv{
    margin: 60px 0;
}
#shopMainMidEventBannerDiv{
    display: table;
    margin: auto auto;
    
}
#shopMostSearchedKeywordDiv{
    margin-left: 50px;
    margin-top: 60px;
}
#hotKeywordP{
    font-size: 30px;
    font-weight: bold;
    font-family: 'Song Myung', serif;
}
.keyword{
    width: 330px;
    height: 150px;
    margin: auto 20px;
}
#shopMainBestReviewsDiv{
    margin-left: 50px;
    margin-top: 60px;
}
#bestReviewsP{
    font-size: 30px;
    font-weight: bold;
    font-family: 'Song Myung', serif;
}
.bestReview img{
    width: 300px;
    height: 300px;
    margin: auto 30px;
}
#bestReviewDiv2 img{
    width: 600px;
}
#hr2{
    border: 3px solid black;
}
.accordionP{
    font-size: 30px;
    font-weight: bold;
    font-family: 'Song Myung', serif;
}
/*오늘 본 상품 div 시작*/
#sidebox { 
    background-color:#F0F0F0; 
    position:absolute; 
    width:120px; 
    top:360px; 
    right:10px;
    padding: 3px 10px;
    z-index: 5;
}
#sideboxHeader{
    background-color: cornflowerblue;
}
#sideboxHeader>p{
    color: white;
    font-family: 'Nanum Pen Script', cursive;
}
.todayView{
    width: 98px;
    height: 98px;
    margin-bottom: 10px;
}
.errow-img{
    width: 20px;
}
#sideboxFooter{
    margin-bottom: 10px;
}

/*오늘 본 상품 div 끝*/

/*인기 키워드 시작*/
.keywordImg{
    position: relative;
}
.keywordSpan {
    position: absolute;
    top: 57px;
    left: 89px;
    z-index: 1;
    color: white;
    font-size: 23px;
    width: 142px;
    font-weight: bold;
}
/*인기 키워드 끝*/

/*혜진상품시작*/
.shop-like-icon{
    bottom : 3%;
    left : 5%;
    font-size : 30px;
}
.shop-cart-icon{
    bottom : 3%;
    right : 5%;
    font-size : 30px;
}
/*혜진상품끝*/

</style>

<body>
    <div id="shopMainOuter">
        <div id="sidebox"> 
            <div id="sideboxHeader">
                <p class="text-center">최근 본 상품 </p><p></p>
            </div>
            <div id="sideboxBody">
                <div id="todayView1">
                    <img class="todayView" src="https://i.ibb.co/5KSC7pC/mouse-Item.png" alt="">
                </div>
                <div id="todayView2">
                    <img class="todayView" src="https://i.ibb.co/bW9Mnh7/today-View.png" alt="">
                </div>
            </div>
            <div id="sideboxFooter">
                <div id="todayViewErrow">
                    <img class="errow-img"src="https://i.ibb.co/TwyPKry/errow2.png" alt="" style="margin-left: 15px">
                    <img class="errow-img"src="https://i.ibb.co/ZTyXx9q/errow.png" alt="" style="margin-left: 30px">
                </div>
            </div>
        </div>
        <div class = "row " id="shopHeaderBarDiv" style="background-color: #f8f9fa">
            <div class = "col-md-1" id="sideMenuBtnDiv">           
                <img id="sideMenuBtn" src="https://i.ibb.co/zFxp8tw/3.png" alt="" >
            </div>
            <div class = "col-md-3" id="shopTop-10Div">
                <div id="content">
                    <dl id="rank-list">
                        <dt>실시간 급상승 검색어</dt>
                        <dd>
                            <ol>
                                <li><a href="#">1 순위</a></li>
                                <li><a href="#">2 순위</a></li>
                                <li><a href="#">3 순위</a></li>
                                <li><a href="#">4 순위</a></li>
                                <li><a href="#">5 순위</a></li>
                                <li><a href="#">6 순위</a></li>
                                <li><a href="#">7 순위</a></li>
                                <li><a href="#">8 순위</a></li>
                                <li><a href="#">9 순위</a></li>
                                <li><a href="#">10 순위</a></li>
                            </ol>
                        </dd>
                    </dl>
                </div>
            </div>
            <div id="shopSerachDiv">
                <nav class="navbar navbar-light bg-light">
                    <form class="form-inline"> 
                        <!-- 쇼핑몰 검색도 카테고리 나눌 건가?
                        <select class="form-select" aria-label="Default select example">
                            <option selected>Open this select menu</option>
                            <option value="1">One</option>
                            <option value="2">Two</option>
                            <option value="3">Three</option>
                          </select> -->
                      <input class="form-control mr-sm-2" type="search" placeholder="검색어를 입력하세요" aria-label="Search">
                      <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
                    </form>
                  </nav>
            </div>
            <div id="shopMainEventBtnDiv">
                <button type="button" class="btn btn-warning" id= "shopMainEventBtn" style="width: 200px">이벤트보러가기</button>
            </div>
        </div>
 
        <!--구분-->
        <div id="shopitemsDiv">
            <div id="shopEventSlideDiv">
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
                        <img class="d-block w-100" src="https://i.ibb.co/cDFYP1c/image.jpg" alt="Second slide">
                      </div>
                      <div class="carousel-item">
                        <img class="d-block w-100" src="https://i.ibb.co/cDFYP1c/image.jpg" alt="Third slide">
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
                <div id="iconBoxDiv">
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
                </div>
                <div id="shopMainMidEventBannerDiv">
                    <a href=""><img src="https://i.ibb.co/zRCKwsF/image.png" alt=""></a>
                </div>
                <hr>
                <div id="shopMostSearchedKeywordDiv">
                    <p id="hotKeywordP">인기 키워드</p>
                    <div class="row">
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
                <hr>
                <div id="shopMainBestReviewsDiv">
                    <p id="bestReviewsP">이달의 Best Reviews</p>
                    <div class="row">
                        <div class="bestReview" id="bestReviewDiv1">
                            <a href=""><img src="https://i.ibb.co/Z6J4nTt/best-Review1.jpg" alt=""></a>
                        </div>
                        <div class="bestReview" id="bestReviewDiv2">
                            <a href=""><img src="https://i.ibb.co/Pzt3ZKY/Giant-Thumb.jpg" alt=""></a>
                        </div>
                        <div class="bestReview" id="bestReviewDiv3">
                            <a href=""><img src="https://i.ibb.co/Z6J4nTt/best-Review1.jpg" alt=""></a>
                        </div> 
                    </div>
                </div>
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
                          <div class="card card-body">
                           
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
        </div>
    </div>

<script>
/*실시간 순위 시작*/
$(function() {
    var count = $('#rank-list li').length;
    var height = $('#rank-list li').height();

    function step(index) {
        $('#rank-list ol').delay(2000).animate({
            top: -height * index,
        }, 500, function() {
            step((index + 1) % count);
        });
    }
    step(1);
});

/*실시간 순위 끝*/

/*오늘 본 상품 div 시작*/
var currentPosition = parseInt($("#sidebox").css("top")); 
$(window).scroll(function() { 
    var position = $(window).scrollTop(); 
    $("#sidebox").stop()
                 .animate({"top":position+currentPosition+"px"},1000); 
});
/*오늘 본 상품 div 끝*/

</script>
</body>

<jsp:include page="/WEB-INF/views/common/footer.jsp">
	<jsp:param value="" name=""/>
</jsp:include>

</html>