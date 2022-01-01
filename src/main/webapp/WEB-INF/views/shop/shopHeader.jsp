<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- js 임포트 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/shop/shopMain.js" ></script>

<!-- css 임포트 -->
<link href="${pageContext.request.contextPath}/resources/css/shop/shopMain.css" rel="stylesheet">

               <!--쇼핑몰 헤더부분-->
           <div class = "row col-12 space-evenly" id="shopHeaderBarDiv" style="background-color: #f8f9fa">
               <div class = "col-md-1" id="sideMenuBtnDiv">           
                   <!--반응형 사이드바 시작-->
                   <div>
                    <span class="hamburger" onclick="openSideNav()">&#9776;</span>
                  </div>
                   <br class="clear" >
                  <!-- sliding side navigation
                    –––––––––––––––––––––––––––––––––––––––––––––––––– -->
                    <!-- The overlay -->
                   <!-- Overlay content -->
                  <div id="slidingSideNav" class="overlay" style="overflow-x: hidden; overflow-y: scroll;">
                    <a href="javascript:void(0)" class="sideClosebtn" onclick="closeSideNav()">&times;</a>
                    <div class="side-overlay-content">
                    <!-- ACCORDION
                      ================================================== -->
                    <h1 id="accordion">DevRun Shop</h1>
                    <a href="" class="subCategory"><span style="font-size: 15px;">신상품</span></a>
                    <a href="" class="subCategory" style="padding-top: 0;"><span style="font-size: 15px;">할인상품</span></a>
                    <aside class="accordion">
                      <h1>모니터</h1>
                      <div>
                        <h2><a href="${pageContext.request.contextPath}/shop/categoryItemAll?parentCate=mn">전체보기</a></h2>
                        <a href="">표준모니터</a>
                        <a href="">휴대용모니터</a>
                        <a href="">게이밍모니터</a>
                        <a href="">전문가용모니터</a>
                        <a href="">대화면모니터</a>
                      </div>
                      <h1>키보드</h1>
                      <div>
                        <h2><a href="${pageContext.request.contextPath}/shop/categoryItemAll?parentCate=ke">전체보기</a></h2>
                        <a href="">무접점키보드</a>
                        <a href="">기계식키보드</a>
                        <a href="">게이밍키보드</a>
                        <a href="">인체공학키보드</a>
                        <a href="">무선키보드</a>
                      </div>
                      <h1>마우스</h1>
                      <div>
                         <h2><a href="${pageContext.request.contextPath}/shop/categoryItemAll?parentCate=mo">전체보기</a></h2>
                        <a href="">유선마우스</a>
                        <a href="">무선마우스</a>
                        <a href="">저소음마우스</a>
                        <a href="">버티컬마우스</a>
                        <a href="">인체공학마우스</a>
                        <a href="">게이밍마우스</a>
                      </div>
                      <h1>책상</h1>
                      <div>
                        <h2><a href="${pageContext.request.contextPath}/shop/categoryItemAll?parentCate=de">전체보기</a></h2>
                        <a href="">높이조절책상</a>
                        <a href="">스탠딩책상</a>
                        <a href="">독서실책상</a>
                        <a href="">접이형책상</a>
                        <a href="">일반책상</a>
                      </div>
                      <h1>의자</h1>
                      <div>
                        <h2><a href="${pageContext.request.contextPath}/shop/categoryItemAll?parentCate=ch">전체보기</a></h2>
                        <a href="">게이밍의자</a>
                        <a href="">자세보정의자</a>
                        <a href="">컴퓨터의자</a>
                        <a href="">책상의자</a>
                        <a href="">접의식의자</a>
                        <a href="">좌식의자</a>
                      </div>
                      <h1>기타상품</h1>
                      <div>
                        <h2><a href="${pageContext.request.contextPath}/shop/categoryItemAll?parentCate=ot">전체보기</a></h2>
                        <a href="">컴퓨터 악세사리</a>
                        <a href="">사무용품</a>
                        <a href="">아이디어상품</a>
                        <a href="">수납상품</a>
                        <a href="">기타상품</a>
                      </div>
                      <h1 style="font-size:10px;">고객센터</h1>
                      <p>'Tis not so deep as a well, nor so wide as a church-door; but 'tis enough,'twill serve: ask for me to-morrow, and you shall find me a grave man. </p>
                    </aside>
                    </div>
                  </div>  
  
                   <!--반응형 사이드바 끝-->
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
                       <form class="form-inline" action="${pageContext.request.contextPath}/shop/shopSearch.do"> 
                         <input class="form-control mr-sm-2" type="search" placeholder="검색어를 입력하세요" aria-label="Search">
                         <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
                       </form>
                     </nav>
               </div>
               <div id="shopMainEventBtnDiv">
                   <button type="button" class="btn btn-warning" id= "shopMainEventBtn" style="width: 200px" onclick="location.href='${pageContext.request.contextPath}/shop/promotion.do'">이벤트보러가기</button>
               </div>
           </div>