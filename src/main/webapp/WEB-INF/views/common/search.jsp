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
	<p class="m-0">검색어 <strong>"${map.searchKeyword}"</strong>에 대한 총 <strong><fmt:formatNumber pattern="#,###,###">${map.totalCnt}</fmt:formatNumber> 건</strong>의 결과를 찾았습니다.</p>
</div>
<div class="search-containers container">
	<ul class="list-group list-group-flush">
	  <li class="list-group-item p-4">
		<h5 class="pb-2">통합검색 총 <fmt:formatNumber pattern="#,###,###">${map.totalCnt}</fmt:formatNumber>건</h5>
	  </li>
	  <li class="list-group-item">
		<h4>커뮤니티 총 <fmt:formatNumber pattern="#,###,###">${map.communityCnt}</fmt:formatNumber>건</h4>
		<div class="list-group">
			<c:if test="${not empty map.communityList}">
				<c:forEach items="${map.communityList}" var="c" varStatus="vs">
					<a href="#" class="list-group-item list-group-item-action flex-column align-items-start">
					    <div class="d-flex w-100 justify-content-between">
					      <div>
						      <span class="font-weight-normal">
						      	[${c.pageCode eq 1?'칼럼': c.pageCode eq 2?'QnA':c.pageCode eq 3?'스터디':'자유게시판' }]
						      </span>
						      <h5 class="mb-1 d-inline"> ${c.title}</h5>
					      </div>
					      <small><fmt:formatDate value="${c.enrollDate}" pattern="YY-MM-dd"/></small>
					    </div>
					    <p class="mb-1">${fn:substring(c.content,0,30)}</p>
					    <small>${c.nickname}</small>
					  </a>
				</c:forEach>
			</c:if>
			<c:if test="${empty map.communityList}">
				<div class="mx-auto text-center">
					<h5>검색 결과가 없습니다.</h5>
				</div>
			</c:if>
		</div>
		<c:if test="${map.communityCnt > 3}">
			<a href="" class="text-right d-block pb-3">더보기</a>
		</c:if>
		<hr />
	  </li>
	  <li class="list-group-item">
	  	<h4>상품 총 <fmt:formatNumber pattern="#,###,###">${map.productCnt}</fmt:formatNumber>건</h4>
	  	<div class="row">
	  		<c:if test="${not empty map.productList}">
	  			<c:forEach items="${map.productList}" var="p" varStatus="vs">
	  				<a href="${pageContext.request.contextPath}/shop/itemDetail.do?productCode=${p.productCode}" class="col-md-3 p-5">
				          <div class="card-box-d">
				            <div class="card-img-d shop-item-img position-relative">
					            <img src="${pageContext.request.contextPath}/resources/upload/product/${p.thumbnail}" alt="" class="img-thumbnail shop-img img-d img-fluid">
					          </div>
				            <div>
				            	<p class="m-0">${p.name}</p>
				            	<strong><fmt:formatNumber type="currency">${p.price}</fmt:formatNumber> </strong>
				            </div>
				          </div>
			          </a>
	  			</c:forEach>
	  		</c:if>
	  		<c:if test="${empty map.productList}">
	  			<div class="mx-auto text-center">
					<h5>검색 결과가 없습니다.</h5>
				</div>
	  		</c:if>
        </div>
        <c:if test="${map.productCnt > 4}">
			<a href="${pageContext.request.contextPath}/shop/shopSearch?searchKeyword=${map.searchKeyword}" class="text-right d-block pb-3">더보기</a>
		</c:if>
        <hr />
	  </li>
	  <li class="list-group-item">
	  	<h4>공지사항 총 <fmt:formatNumber pattern="#,###,###">${map.noticeCnt}</fmt:formatNumber>건</h4>
	  	<div class="list-group">
	  		<c:if test="${not empty map.noticeList}">
	  			<c:forEach items="${map.noticeList}" var="n" varStatus="vs">
	  				<a href="${pageContext.request.contextPath}/customerCenter/noticeDetail.do?noticeNo=${n.noticeNo}" class="list-group-item list-group-item-action flex-column align-items-start">
					    <div class="d-flex w-100 justify-content-between">
					      <h5 class="mb-1 d-inline">${n.title}</h5>
					      <small><fmt:formatDate value="${c.enrollDate}" pattern="YY-MM-dd"/></small>
					    </div>
					    <p class="mb-1">${fn:substring(n.content,0,30)}</p>
					    <small>${n.nickname}</small>
					  </a>
	  			</c:forEach>
	  		</c:if>
	  		<c:if test="${empty map.noticeList}">
	  			<div class="mx-auto text-center">
					<h5>검색 결과가 없습니다.</h5>
				</div>
	  		</c:if>
		</div>
		<c:if test="${map.noticeCnt > 3}">
			<a href="" class="text-right d-block pb-3">더보기</a>
		</c:if>
	  </li>
	</ul>
</div>
<script>

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
