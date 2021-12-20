<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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
                    <h1 id="accordion">Accordion Side Nav</h1>
                    <a href="" class="subCategory"><span style="font-size: 15px;">신상품</span></a>
                    <a href="" class="subCategory" style="padding-top: 0;"><span style="font-size: 15px;">할인상품</span></a>
                    <aside class="accordion">
                      <h1>모니터</h1>
                      <div>
                        <a href="">Sub Category</a>
                        <a href="">Sub Category</a>
                        <a href="">Sub Category</a>
                        <a href="">Sub Category</a>
                      </div>
                      <h1>키보드</h1>
                      <div>
                        <a href="">Sub Category</a>
                        <a href="">Sub Category</a>
                        <a href="">Sub Category</a>
                        <a href="">Sub Category</a>
                      </div>
                      <h1>마우스</h1>
                      <div>
                        <a href="">Sub Category</a>
                        <a href="">Sub Category</a>
                        <a href="">Sub Category</a>
                        <a href="">Sub Category</a>
                      </div>
                      <h1>책상</h1>
                      <div>
                        <a href="">Sub Category</a>
                        <a href="">Sub Category</a>
                        <a href="">Sub Category</a>
                        <a href="">Sub Category</a>
                      </div>
                      <h1>의자</h1>
                      <div>
                        <a href="">Sub Category</a>
                        <a href="">Sub Category</a>
                        <a href="">Sub Category</a>
                        <a href="">Sub Category</a>
                      </div>
                      <h1>기타용품</h1>
                      <div>
                        <a href="">Sub Category</a>
                        <a href="">Sub Category</a>
                        <a href="">Sub Category</a>
                        <a href="">Sub Category</a>
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
                       <form class="form-inline" action="${pageContext.request.contextPath}/shop/search.do"> 
                         <input class="form-control mr-sm-2" type="search" placeholder="검색어를 입력하세요" aria-label="Search">
                         <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
                       </form>
                     </nav>
               </div>
               <div id="shopMainEventBtnDiv">
                   <button type="button" class="btn btn-warning" id= "shopMainEventBtn" style="width: 200px">이벤트보러가기</button>
               </div>
           </div>