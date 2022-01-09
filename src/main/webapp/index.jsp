<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="데브런" name="title"/>
</jsp:include>
<style>
.product-title{
	word-break : keep-all;
}
</style>
  <!--/ Carousel Star /-->
  <div class="intro intro-carousel">
    <div id="carousel" class="owl-carousel owl-theme">
      <div class="carousel-item-a intro-item bg-image" style="background-image: url(${pageContext.request.contextPath}/resources/images/main2.jpg)">
        <div class="overlay overlay-a"></div>
        <div class="intro-content display-table">
          <div class="table-cell">
            <div class="container">
              <div class="row">
                <div class="col-lg-8">
                  <div class="intro-body">
                    <p class="intro-title-top">Developer Comprehensive Platform
                      <br>devrun.com</p>
                    <h1 class="intro-title mb-4">
                      Dev <span class="color-b">Run </span>
                      <br>For a better life as a developer</h1>
                    <p class="intro-subtitle intro-price">
                      <a href="${pageContext.request.contextPath}/about.do"><span class="price-a">About DevRun</span></a>
                    </p>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="carousel-item-a intro-item bg-image" style="background-image: url(${pageContext.request.contextPath}/resources/images/main3.jpg)">
        <div class="overlay overlay-a"></div>
        <div class="intro-content display-table">
          <div class="table-cell">
            <div class="container">
              <div class="row">
                <div class="col-lg-8">
                  <div class="intro-body">
                    <p class="intro-title-top">Developer Comprehensive Platform
                      <br>devrun.com</p>
                    <h1 class="intro-title mb-4">
                      Find Your 
                      <br> <span class="color-b">Best </span> Product</h1>
                    <p class="intro-subtitle intro-price">
                      <a href="${pageContext.request.contextPath}/shop/shopMain.do"><span class="price-a">just click here</span></a>
                    </p>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="carousel-item-a intro-item bg-image" style="background-image: url(${pageContext.request.contextPath}/resources/images/main1.jpg)">
        <div class="overlay overlay-a"></div>
        <div class="intro-content display-table">
          <div class="table-cell">
            <div class="container">
              <div class="row">
                <div class="col-lg-8">
                  <div class="intro-body">
                    <p class="intro-title-top">Developer Comprehensive Platform
                      <br>devrun.com</p>
                    <h1 class="intro-title mb-4">
                      The Only <span class="color-b">One </span>
                      <br> Developer Community</h1>
                    <p class="intro-subtitle intro-price">
                      <a href="${pageContext.request.contextPath}/community/communityMain.do"><span class="price-a">be productive</span></a>
                    </p>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <!--/ Carousel end /-->

 <!-- / Community Start/ -->
 <section class="section-services section-t8">
 	<div class="container">
      <div class="row">
        <div class="col-md-12">
          <div class="title-wrap d-flex justify-content-between">
            <div class="title-box">
              <h2 class="title-a">커뮤니티</h2>
            </div>
            <div class="title-link">
              <a href="${pageContext.request.contextPath}/community/communityMain.do">더보기
                <span class="ion-ios-arrow-forward"></span>
              </a>
            </div>
          </div>
        </div>
      </div>
      <div class="row">
        <div class="col-md-4">
          <div class="card-box-d">
          	<table class="table">
			  <thead>
			    <tr>
			      <th scope="col" colspan="3">주간 인기글</th>
			    </tr>
			  </thead>
			  <tbody>
			  	<c:if test="${not empty map.likeCommunityList }">
			  		<c:forEach items="${map.likeCommunityList}" var="c" varStatus="vs">
					    <tr>
					      <th scope="row">${vs.count}</th>
					      <td>
					      	<a href="#">
					      		<span>${c["PAGECODE"] eq 1?'[칼럼]': c["PAGECODE"] eq 2?'[QnA]':c["PAGECODE"] eq 3?'[스터디]':'[자유게시판]' }</span>
					      		${c["TITLE"]}
					      	</a>
					      </td>
					      <td>${c["NICKNAME"]}</td>
					    </tr>
			  		</c:forEach>
			  	</c:if>
			  	<c:if test="${empty map.likeCommunityList }">
				    <tr>
				      <th scope="row" colspan="3" class="text-center">글이 없습니다.</th>
				    </tr>
			  	</c:if>
			  </tbody>
			</table>
          </div>
        </div>
        <div class="col-md-4">
          <div class="card-box-d">
            <table class="table">
			  <thead>
			    <tr>
			      <th scope="col" colspan="3">자유게시판</th>
			    </tr>
			  </thead>
			  <tbody>
			    <c:if test="${not empty map.freeboardList}">
			  		<c:forEach items="${map.freeboardList}" var="c" varStatus="vs">
					    <tr>
					      <th scope="row">${vs.count}</th>
					      <td><a href="${pageContext.request.contextPath}/community/freeboardDetail.do?communityNo=${c.communityNo}">${c.title}</a></td>
					      <td>${c.nickname}</td>
					    </tr>
			  		</c:forEach>
			  	</c:if>
			  	<c:if test="${empty map.freeboardList}">
				    <tr>
				      <th scope="row" colspan="3" class="text-center">글이 없습니다.</th>
				    </tr>
			  	</c:if>
			  </tbody>
			</table>
          </div>
        </div>
        <div class="col-md-4">
          <div class="card-box-d">
            <table class="table">
			  <thead>
			    <tr>
			      <th scope="col" colspan="3">Q&A</th>
			    </tr>
			  </thead>
			  <tbody>
			    <c:if test="${not empty map.qnaList}">
			  		<c:forEach items="${map.qnaList}" var="c" varStatus="vs">
					    <tr>
					      <th scope="row">${vs.count}</th>
					      <td><a href="${pageContext.request.contextPath}/community/qnaDetail.do?communityNo=${c['NO']}">${c["TITLE"]}</a></td>
					      <td>${c["NICKNAME"]}</td>
					    </tr>
			  		</c:forEach>
			  	</c:if>
			  	<c:if test="${empty map.qnaList}">
				    <tr>
				      <th scope="row" colspan="3" class="text-center">글이 없습니다.</th>
				    </tr>
			  	</c:if>
			  </tbody>
			</table>
          </div>
        </div>
      </div>
    </div>
 </section>
 <!-- / Community End/ -->
  
  <!--/ Agents Star /-->
  <section class="section-agents section-t8">
    <div class="container">
      <div class="row">
        <div class="col-md-12">
          <div class="title-wrap d-flex justify-content-between">
            <div class="title-box">
              <h2 class="title-a">베스트셀러</h2>
            </div>
            <div class="title-link">
              <a href="${pageContext.request.contextPath}/shop/shopMain.do">더보기
                <span class="ion-ios-arrow-forward"></span>
              </a>
            </div>
          </div>
        </div>
      </div>
      <div class="row">
      	<c:if test="${not empty map.likeProductList}">
      		<c:forEach items="${map.likeProductList}" var="p" varStatus="vs">
      			<div class="col-md-4">
		          <div class="card-box-d">
		            <div class="card-img-d">
		              <img src="${pageContext.request.contextPath }/resources/upload/product/${p.thumbnail}" alt="" class="img-d img-fluid">
		            </div>
		            <div class="card-overlay card-overlay-hover">
		              <div class="card-header-d">
		                <div class="card-title-d align-self-center">
		                  <h3 class="product-title title-d">
		                    <a href="${pageContext.request.contextPath}/shop/itemDetail/${p.productCode}" class="link-two">${p.name}</a>
		                  </h3>
		                </div>
		              </div>
		              <div class="card-body-d">
		                <p class="content-d text-white">
		                	${fn:substring(p.productCode,0,2) eq 'ke'?'키보드':fn:substring(p.productCode,0,2) eq 'ot'?'기타':fn:substring(p.productCode,0,2) eq 'mn'?'모니터':fn:substring(p.productCode,0,2) eq 'mo'?'마우스':fn:substring(p.productCode,0,2) eq 'ch'?'의자':'책상' }
		                </p>
		                <div class="info-agents color-a">
		                  <p>
		                    <strong><fmt:formatNumber type="currency">${p.price}</fmt:formatNumber> </strong>
		                  </p>
		                </div>
		              </div>
		            </div>
		          </div>
		        </div>
      		</c:forEach>
      	</c:if>
      	<c:if test="${empty map.likeProductList}">
      	</c:if>
      </div>
    </div>
  </section>
  <!--/ Agents End /-->
  
   <!--/ Services Star /-->
  <section class="section-services section-t8">
    <div class="container">
      <div class="row">
        <div class="col-md-12">
          <div class="title-wrap d-flex justify-content-between">
            <div class="title-box">
              <h2 class="title-a">칼럼</h2>
            </div>
            <div class="title-link">
              <a href="${pageContext.request.contextPath}/community/communityColumnMain.do">더보기
                <span class="ion-ios-arrow-forward"></span>
              </a>
            </div>
          </div>
        </div>
      </div>
      <div class="row">
      	<c:if test="${not empty map.columnList}">
	  		<c:forEach items="${map.columnList}" var="c" varStatus="vs">
		        <div class="col-md-4">
					<div class="card" style="height:330px;">
						<c:if test="${c.thumbnail eq null}">
							<img class="card-img-top p-5" alt="" src="${pageContext.request.contextPath}/resources/images/logo-devrun.png">
						</c:if>
						<c:if test="${c.thumbnail ne null}">
							<img class="card-img-top" alt="" src="${pageContext.request.contextPath}/resources/upload/community/${c.thumbnail}">
						</c:if>
						<div class="card-block p-3">
							<h3 class="card-title">
								<a href="${pageContext.request.contextPath}/community/communityColumnDetail.do?communityNo=${c.communityNo}">${c.title}</a>
							</h3>
							<p class="card-text">
								<span>${fn:substring(c.content,0,30)}</span>
							</p>
						</div>
					</div>
				</div>
	  		</c:forEach>
	  	</c:if>
	  	<c:if test="${empty map.columnList}">
		    <div class="mx-auto text-align">
		    	<h4>등록된 칼럼이 없습니다.</h4>
		    </div>
	  	</c:if>
      </div>
    </div>
  </section>
  <!--/ Services End /-->
   <!--/ News Star /-->
  <section class="section-news section-t8">
    <div class="container">
      <div class="row">
        <div class="col-md-12">
          <div class="title-wrap d-flex justify-content-between">
            <div class="title-box">
              <h2 class="title-a">이벤트</h2>
            </div>
            <div class="title-link">
              <a href="${pageContext.request.contextPath}/shop/promotion.do">더보기
                <span class="ion-ios-arrow-forward"></span>
              </a>
            </div>
          </div>
        </div>
      </div>
	    <div class="mx-auto text-center col-md-12" id="currentPromotion" >
		  	<c:forEach items="${map.promotionList}" var="promotion" varStatus="vs">
			  <a href="${pageContext.request.contextPath}/shop/promotionDetail/${promotion.promotionCode}" class="m-3">
			  	<div class="promotion-banner" >
			  		<img src="${pageContext.request.contextPath}/resources/upload/promotion/${promotion.banner}" alt="" class="img-thumbnail" />
			  	</div>
		      </a>
	       </c:forEach>
	    </div>
    </div>
  </section>
  <!--/ News End /-->


  

 

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>