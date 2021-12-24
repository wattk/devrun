<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="마이페이지" name="title"/>
</jsp:include>
<!-- 부트스트랩 아이콘 CDN -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
<!-- 한글 폰트 CDN -->
<link href="https://fonts.googleapis.com/css2?family=Gowun+Dodum&display=swap" rel="stylesheet">
<!-- CSS import -->
<link href="${pageContext.request.contextPath}/resources/css/mypage/mypage.css" rel="stylesheet">

<%-- EL에서 접근하기 위해 VAR속성 지정 --%>
<sec:authentication property="principal" var="member"/>
<style>
.search-badge{
	border : 1px solid rgba(0,0,0,.125);
	border-radius : 1.5rem;
	height : 1.5rem;
	width : 4rem;
}
.order-btn{
	border-radius : 0;
	width : 6rem;
	height : 1.5rem;
	margin : 3px 0 3px 0;
	padding : 0;
}
.question-btn{
	color : #007bff;
	font-weight : 700;
}
</style>
<main>
	<br/><br/>
	<article class="container" id="tabContent">
		
		<%-- tap button --%>
		<nav id="tabBtns">
			<ul class="nav nav-tabs">
				<li class="nav-item">
				   <a class="nav-link" id="mycommunityTab" href="#mycommunity" role="tab" aria-controls="mycommunity" aria-selected="false">나의 커뮤니티</a>
				</li>
				<li class="nav-item">
				   <a class="nav-link" id="myshoppingTab" href="#myshopping" role="tab" aria-controls="myshopping" aria-selected="false">나의 쇼핑</a>
				</li>
				<li class="nav-item">
				   <a class="nav-link" id="myinfoTab" href="#myinfo" role="tab" aria-controls="myinfo" aria-selected="false">나의 정보</a>
				</li>
				<li class="nav-item">
				   <a class="nav-link active" id="mypageTab" href="#mypage" role="tab" aria-controls="mypage" aria-selected="true">마이페이지</a>
				</li>
			</ul>
		</nav>
		
		<%-- tap container --%>
		<section class="col-12 tab-content " id="tabContainer">
			<%-- my shopping --%>
			<div class="tab-pane fade show active col-15" id="myOrderList">
		   		<article class="col-9 mx-auto">
	       			
	       			<h5>주문 내역</h5>
	       			<div class="search-box mt-3">
			          <form class="form-inline" name="orderSearchFrm" action="${pageContext.request.contextPath}/mypage/orderSearch.do" method="GET">
					    <div class="input-group w-50 mb-2">
					      <input type="text" id="searchKeyword" name="searchKeyword" class="form-control" placeholder="주문한 상품을 검색할 수 있어요." aria-label="Username" aria-describedby="basic-addon1">
					      <button type="button" id="orderSearchBtn" class="btn btn-b-n d-none d-md-block" data-toggle="collapse"
					        data-target="#navbarTogglerDemo01" aria-expanded="false">
					        <span class="fa fa-search" aria-hidden="true"></span>
					      </button>
					    </div>
					    <div class="search-details w-100">
							<span class="search-badge badge badge-primary">전체</span>
							<span class="search-badge badge badge-light">최근 6개월</span>
							<span class="search-badge badge badge-light">2022</span>
							<span class="search-badge badge badge-light">2021</span>
							<span class="search-badge badge badge-light">2020</span>
						</div>
					  </form>
				    </div>
   					<hr />
	       			<section class="order-list " id="myOrder">
	       				<div class="order-box mt-3">
	       					<sup class="d-box mb-2 ml-2">2021.12.24</sup>
	       					<div class=" card p-3">
		       					<div class="order-title d-flex justify-content-between">
			       					<h5>ㅇㅇ키보드 외 1건</h5><i class="fas fa-chevron-right"></i>
		       					</div>
	       						<table class="mt-3">
	       							<tr>
	       								<td rowspan="4" class="col-2">
	       									<img src="${pageContext.request.contextPath}/resources/images/80x80.jpg" alt="" class="img-thumbnail"/>
	       								</td>
	       							</tr>
	       							<tr>
	       								<td class="col-5">
	       									<span>주문번호</span>
	       									<br />
	       									<span>결제금액</span>
	       									<br />
	       									<span>주문상태</span>
	       								</td>
	       								<td rowspan="4" class="col-2">
	       									<button type="button" id="" class="question-btn order-btn btn btn-outline-light">문의하기</button>
	       								</td>
	       								<td rowspan="4" class="col-2">
	       									<button type="button" class="order-btn btn btn-outline-primary">주문취소</button>
	       								</td>
	       							</tr>
	       						</table>
	       					</div>
	       				</div>
	       				<div class="order-box mt-3">
	       					<sup class="d-box mb-2 ml-2">2021.12.24</sup>
	       					<div class=" card p-3">
		       					<div class="order-title d-flex justify-content-between">
			       					<h5>ㅇㅇ키보드 외 1건</h5><i class="fas fa-chevron-right"></i>
		       					</div>
	       						<table class="mt-3">
	       							<tr>
	       								<td rowspan="4" class="col-2">
	       									<img src="${pageContext.request.contextPath}/resources/images/80x80.jpg" alt="" class="img-thumbnail"/>
	       								</td>
	       							</tr>
	       							<tr>
	       								<td class="col-5">
	       									<span>주문번호</span>
	       									<br />
	       									<span>결제금액</span>
	       									<br />
	       									<span>주문상태</span>
	       								</td>
	       								<td rowspan="4" class="col-2">
	       									<button type="button" id="" class="question-btn order-btn btn btn-outline-light">문의하기</button>
	       								</td>
	       								<td rowspan="4" class="col-2">
	       									<button type="button" class="order-btn btn btn-outline-primary">반품/교환</button>
	       									<button type="button" class="order-btn btn btn-outline-primary">배송조회</button>
	       									<button type="button" class="order-btn btn btn-outline-primary active">후기쓰기</button>
	       								</td>
	       							</tr>
	       						</table>
	       					</div>
	       				</div>
	       			</section>
		    	</article>
			</div>
		</section>		   
        	   
    </article>
</main>
<style>
.small-font-size{
	font-size : x-small;
}
#myOrderLog{
	flex-direction : row;
	height : 2.5rem;
}
#myShipment{
	height : 5rem;
}
.shopping-nav-item{
	display : flex;
	justify-content : space-between;
}
.order-title{
	border-bottom : 1px solid rgba(0,0,0,.125);
}
.cart-icon{
	font-size : 20px;
}
</style>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>