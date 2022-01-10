<%@page import="java.util.List"%>
<%@page import="com.kh.devrun.product.model.vo.Product"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>	
<fmt:requestEncoding value="utf-8"/>

<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

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
                    <aside class="accordion">
                      <h1>모니터</h1>
                      <div>
                        <h2><a href="${pageContext.request.contextPath}/shop/categoryItemAll?parentCate=mn">전체보기</a></h2>
                        <a href="${pageContext.request.contextPath}/shop/shopChildCate?childCategoryCode=1mn">표준모니터</a>
                        <a href="${pageContext.request.contextPath}/shop/shopChildCate?childCategoryCode=2mn">휴대용모니터</a>
                        <a href="${pageContext.request.contextPath}/shop/shopChildCate?childCategoryCode=3mn">게이밍모니터</a>
                        <a href="${pageContext.request.contextPath}/shop/shopChildCate?childCategoryCode=4mn">전문가용모니터</a>
                        <a href="${pageContext.request.contextPath}/shop/shopChildCate?childCategoryCode=5mn">대화면모니터</a>
                      </div>
                      <h1>키보드</h1>
                      <div>
                        <h2><a href="${pageContext.request.contextPath}/shop/categoryItemAll?parentCate=ke">전체보기</a></h2>
                        <a href="${pageContext.request.contextPath}/shop/shopChildCate?childCategoryCode=1ke">무접점키보드</a>
                        <a href="${pageContext.request.contextPath}/shop/shopChildCate?childCategoryCode=2ke">기계식키보드</a>
                        <a href="${pageContext.request.contextPath}/shop/shopChildCate?childCategoryCode=3ke">게이밍키보드</a>
                        <a href="${pageContext.request.contextPath}/shop/shopChildCate?childCategoryCode=4ke">인체공학키보드</a>
                        <a href="${pageContext.request.contextPath}/shop/shopChildCate?childCategoryCode=5ke">무선키보드</a>
                      </div>
                      <h1>마우스</h1>
                      <div>
                         <h2><a href="${pageContext.request.contextPath}/shop/categoryItemAll?parentCate=mo">전체보기</a></h2>
                        <a href="${pageContext.request.contextPath}/shop/shopChildCate?childCategoryCode=1mo">유선마우스</a>
                        <a href="${pageContext.request.contextPath}/shop/shopChildCate?childCategoryCode=2mo">무선마우스</a>
                        <a href="${pageContext.request.contextPath}/shop/shopChildCate?childCategoryCode=3mo">저소음마우스</a>
                        <a href="${pageContext.request.contextPath}/shop/shopChildCate?childCategoryCode=4mo">버티컬마우스</a>
                        <a href="${pageContext.request.contextPath}/shop/shopChildCate?childCategoryCode=5mo">인체공학마우스</a>
                        <a href="${pageContext.request.contextPath}/shop/shopChildCate?childCategoryCode=6mo">게이밍마우스</a>
                      </div>
                      <h1>책상</h1>
                      <div>
                        <h2><a href="${pageContext.request.contextPath}/shop/categoryItemAll?parentCate=de">전체보기</a></h2>
                        <a href="${pageContext.request.contextPath}/shop/shopChildCate?childCategoryCode=1de">높이조절책상</a>
                        <a href="${pageContext.request.contextPath}/shop/shopChildCate?childCategoryCode=2de">스탠딩책상</a>
                        <a href="${pageContext.request.contextPath}/shop/shopChildCate?childCategoryCode=3de">독서실책상</a>
                        <a href="${pageContext.request.contextPath}/shop/shopChildCate?childCategoryCode=4de">접이형책상</a>
                        <a href="${pageContext.request.contextPath}/shop/shopChildCate?childCategoryCode==5de">일반책상</a>
                      </div>
                      <h1>의자</h1>
                      <div>
                        <h2><a href="${pageContext.request.contextPath}/shop/categoryItemAll?parentCate=ch">전체보기</a></h2>
                        <a href="${pageContext.request.contextPath}/shop/shopChildCate?childCategoryCode=1ch">게이밍의자</a>
                        <a href="${pageContext.request.contextPath}/shop/shopChildCate?childCategoryCode=2ch">자세보정의자</a>
                        <a href="${pageContext.request.contextPath}/shop/shopChildCate?childCategoryCode=3ch">컴퓨터의자</a>
                        <a href="${pageContext.request.contextPath}/shop/shopChildCate?childCategoryCode=4ch">책상의자</a>
                        <a href="${pageContext.request.contextPath}/shop/shopChildCate?childCategoryCode=5ch">접의식의자</a>
                        <a href="${pageContext.request.contextPath}/shop/shopChildCate?childCategoryCode=6ch">좌식의자</a>
                      </div>
                      <h1>기타상품</h1>
                      <div>
                        <h2><a href="${pageContext.request.contextPath}/shop/categoryItemAll?parentCate=ot">전체보기</a></h2>
                        <a href="${pageContext.request.contextPath}/shop/shopChildCate?childCategoryCode=1ot">컴퓨터 악세사리</a>
                        <a href="${pageContext.request.contextPath}/shop/shopChildCate?childCategoryCode=2ot">사무용품</a>
                        <a href="${pageContext.request.contextPath}/shop/shopChildCate?childCategoryCode=3ot">아이디어상품</a>
                        <a href="${pageContext.request.contextPath}/shop/shopChildCate?childCategoryCode=4ot">수납상품</a>
                        <a href="${pageContext.request.contextPath}/shop/shopChildCate?childCategoryCode=5ot">기타상품</a>
                      </div>
                      <h1  id ="serviceCenter" style="font-size:10px;">고객센터</h1>
                    </aside>
                    </div>
                  </div>  
  
                   <!--반응형 사이드바 끝-->
               </div>
               <div class = "col-md-4" id="shopTop-10Div">
                   <div id="content">
                       <dl id="rank-list">
                           <dt>실시간 급상승 검색어</dt>
                           <dd>
                               <ol>
                                   <li><a href="${pageContext.request.contextPath}/shop/itemDetail/${tenArr[1]}">1위 : ${tenArr[0]}</a></li>
                                   <li><a href="${pageContext.request.contextPath}/shop/itemDetail/${tenArr[3]}">2위 : ${tenArr[2]}</a></li>
                                   <li><a href="${pageContext.request.contextPath}/shop/itemDetail/${tenArr[5]}">3위 : ${tenArr[4]}</a></li>
                                   <li><a href="${pageContext.request.contextPath}/shop/itemDetail/${tenArr[7]}">4위 : ${tenArr[6]}</a></li>
                                   <li><a href="${pageContext.request.contextPath}/shop/itemDetail/${tenArr[9]}">5위 : ${tenArr[8]}</a></li>
                                   <li><a href="${pageContext.request.contextPath}/shop/itemDetail/${tenArr[11]}">6위 : ${tenArr[10]}</a></li>
                                   <li><a href="${pageContext.request.contextPath}/shop/itemDetail/${tenArr[13]}">7위 : ${tenArr[12]}</a></li>
                                   <li><a href="${pageContext.request.contextPath}/shop/itemDetail/${tenArr[15]}">8위 : ${tenArr[14]}</a></li>
                                   <li><a href="${pageContext.request.contextPath}/shop/itemDetail/${tenArr[17]}">9위 : ${tenArr[16]}</a></li>
                                   <li><a href="${pageContext.request.contextPath}/shop/itemDetail/${tenArr[19]}">10위 : ${tenArr[18]}</a></li>
                               </ol>
                           </dd>
                       </dl>
                   </div>
               </div>
               <div id="shopSerachDiv">
                   <nav class="navbar navbar-light bg-light">
                       <form:form method="GET" class="form-inline" action="${pageContext.request.contextPath}/shop/shopSearch"> 
                         <input name="searchKeyword" class="form-control mr-sm-2" type="search" placeholder="검색어를 입력하세요" aria-label="Search" required>
                         <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
                       </form:form>
                     </nav>
               </div>
               <div id="shopMainEventBtnDiv">
                   <button type="button" class="btn btn-warning" id= "shopMainEventBtn" style="width: 200px" onclick="location.href='${pageContext.request.contextPath}/shop/promotion.do'">이벤트보러가기</button>
               </div>
           </div>

<script>
$(serviceCenter).click((e) => {
	   location.href = "${pageContext.request.contextPath}/customerCenter/noticeList.do";
});
</script>                   