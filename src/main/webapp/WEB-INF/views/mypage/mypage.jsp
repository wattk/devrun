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

<!-- CSS import -->
<link href="${pageContext.request.contextPath}/resources/css/mypage/mypage.css" rel="stylesheet">

<!-- <style>
/* 공통 적용 style */
.bi {font-size:20px;}
.cursor {cursor:pointer; cursor:hand;}
button {background-color:#FFFFFF; border:1px solid #F1F1F2; border-radius:20px; padding:5px;}
button:focus {outline:none;}
button:hover {background-color:#1A81FF; color:#FFFFFF; border:1px solid #1A81FF; transition:.3s;}

/* tabContent frame */
main {height:900px; background:linear-gradient(to top, #FFFFFF 70%, #1A81FF 30%);}
#tabBtns {justify-content:flex-end; padding:0 20px;}
#tabContainer {height:800px; background-color:#FFFFFF; padding:80px 0; margin:0 auto;}
#tabContainer div.col-3 {padding:0 40px; border-right:1px solid #F1F1F2;}
#tabContainer div.col-9 {padding:0 40px;}


/* member profile */
#tabContainer .col-3 div:not(:nth-of-type(2)) {text-align:center;}
#profile div #profileImg {font-size:100px; position:relative; color:#1A81FF;}
#profile div #edit {position:absolute; top:90px; right:90px; width:30px; height:30px;}
#profile div #badge {position:absolute; top:15px; left:75px; width:40px; height:40px; background-color:#2ECC71; border:5px solid #2ECC71; border-radius:50%; box-shadow:2px 2px 2px hsl(0deg 0% 0% / 0.38);}
#profile div:nth-of-type(2) p span:first-of-type {color:#1A81FF;}


/* member activity grade */
#myGrade {padding:30px 0; margin-bottom:20px; border-radius:10px;}
#myGrade table tr td:not(:last-of-type) {border-right:1px solid #F1F1F2;}
#myGrade img {width:40px; height:40px;}
#myGrade span {display:block; width:80px; margin:0 auto; border:1px solid black; border-radius:20px; background-color:#66ABFF;}

/* member activity */
#myActivity {margin:0 auto; margin-bottom:20px; padding:20px 0; border-top:1px solid #F1F1F2; border-bottom:1px solid #F1F1F2; justify-content:space-around;}
#myActivity span.col-6 {justify-content:space-between; align-items:center;}
#myActivity span span:nth-of-type(2) {color:#1A81FF;}
#myActivity .bi-chevron-right {color:#A1A1A1; font-size:17px;}

/* event */
#eventImg {margin:0 auto; margin-bottom:50px;}
#eventImg img {height:100px; padding:10px; border-radius:18px;}
</style> -->

<%-- EL에서 접근하기 위해 VAR속성 지정 --%>
<sec:authentication property="principal" var="member"/>

<main>
	<br/><br/>
	<article class="container" id="tabContent">
		
		<%-- tap button --%>
		<nav id="tabBtns">
			<ul class="nav nav-tabs">
				<li class="nav-item">
				   <a class="nav-link" id="mycommunityTab" data-toggle="tab" href="#mycommunity" role="tab" aria-controls="mycommunity" aria-selected="false">나의 커뮤니티</a>
				</li>
				<li class="nav-item">
				   <a class="nav-link" id="myshoppingTab" data-toggle="tab" href="#myshopping" role="tab" aria-controls="myshopping" aria-selected="false">나의 쇼핑</a>
				</li>
				<li class="nav-item">
				   <a class="nav-link" id="myinfoTab" data-toggle="tab" href="#myinfo" role="tab" aria-controls="myinfo" aria-selected="false">나의 정보</a>
				</li>
				<li class="nav-item">
				   <a class="nav-link active" id="mypageTab" data-toggle="tab" href="#mypage" role="tab" aria-controls="mypage" aria-selected="true">마이페이지</a>
				</li>
			</ul>
		</nav>
		
		<%-- tap container --%>
		<section class="col-12 tab-content" id="tabContainer">
		
			<%-- my page --%>
			<div class="tab-pane fade show active col-12" id="mypage">
				<div class="row">
				
					<!-- member profile -->
					<article class="col-3" id="profile">
						<!-- profile image : 프로필 이미지가 null일 경우, 기본 이미지 출력 -->
					    <section>
				   			<c:if test="${member.proPhoto eq null}"><i class="bi bi-person-circle" id="profileImg"></i></c:if>
					      	<c:if test="${member.proPhoto ne null}"><img src="${member.proPhoto}" alt="" id="profileImg"/></c:if>
					       	<p class="cursor" onclick="location.href='${pageContext.request.contextPath}/mypage/myinfo.do';">${member.nickname}님<i class="bi bi-chevron-right"></i></p>
					       	<img src="https://i.ibb.co/HNQhz98/pencil.png" alt="" id="edit" onclick="location.href='${pageContext.request.contextPath}/mypage/myinfo/infoUpdate.do';"/>
					    	<img src="https://i.ibb.co/S7TZCYh/coding.png" alt="" id="badge" onclick="location.href='${pageContext.request.contextPath}/mypage/myinfo/activityBadge.do';"/>
					    </section>
					    <!-- profile info -->
				        <section>
				        	<p><span>이메일</span><br/><span>${member.email}</span></p>
					        <p><span>한줄소개</span><br/><span>${member.intro}</span></p>
					        <button onclick="location.href='${member.url}';">${member.url}</button>
				        </section>
				        <hr/>
			        	<!-- login info / logout button -->
			        	<section class="">
				        	<p><img src="" alt="" />(으)로 로그인</p>
				        	<button class="col-9">로그아웃</button>
			        	</section>
			      	</article>
			      	
		      		<!-- member info -->
			   		<article class="col-9">
		    			<!-- member grade info : total attendance / activity grade / activity badge -->
		       			<section class="card" id="myGrade">
		        			<table class="text-center">
			       				<tr>
			       					<td class="col-4">출석일수</td>
			       					<td class="col-4">활동 등급</td>
			       					<td class="col-4 cursor" onclick="location.href='${pageContext.request.contextPath}/mypage/myinfo/activityBadge.do';">활동 배지</td>
			       				</tr>
			       				<tr>
			       					<!-- 출석일수 -->
			       					<td>일</td>
			       					<!-- 활동 등급 -->
			       					<td>
			       						<img src="https://i.ibb.co/jgyRRVB/badge.png" alt="" />
			       						<span>
			       							<!-- c:if 태그로 회원 권한에 따른 활동 등급명 분기 -->
			       							<c:if test="${member.authorities eq '[ROLE_M1]'}">일반회원</c:if>
			       							<c:if test="${member.authorities eq '[ROLE_M2]'}">지식인</c:if>
			       							<c:if test="${member.authorities eq '[ROLE_AM]'}">관리자</c:if>
			       						</span>
			       					</td>
			       					<!-- 활동 배지 -->
			       					<td class="cursor">
			       						<!-- 대표배지 이미지와 이름 불러오기 -->
			       						<img src="https://i.ibb.co/S7TZCYh/coding.png" alt=""/>
			       						<span>지식인</span>
			       					</td>
			       				</tr>
			       			</table>
		       			</section>
			       			
		       			<!-- member activity info : message / point -->
		       			<section class="row cursor" id="myActivity">
			       			<span class="col-6 row" onclick="location.href='#';">
				       			<span class="bi bi-envelope"> &nbsp; 채팅</span>
				       			<span>건<i class="bi bi-chevron-right"></i></span>
			       			</span>
				       		<span class="col-6 row" onclick="location.href='#';">
					       		<span class="bi bi-coin"> &nbsp; 포인트</span>
					       		<span>사용 가능 ${member.point}포인트<i class="bi bi-chevron-right"></i></span>
				       		</span>
		       			</section>
		       			<!-- event : 최근 등록 이벤트 2개 -->
		       			<section class="row" id="eventBanner">
		       				<img src="https://i.ibb.co/w63RdmJ/2021121515051506481-11934059-1.jpg" alt="" class="col-6" onclick="location.href='#';"/>
		       				<img src="https://i.ibb.co/GFmzFXF/2021120917350947828-11922858-1.jpg" alt="" class="col-6" onclick="location.href='#';"/>
		       			</section>
		       			<!-- member activity info : like / wishList -->
		       			<h5>나의 활동</h5>
		       			<section class="row cursor" id="myActivity">
		       				<span class="col-6 row" onclick="location.href='#';">
		       					<span class="bi bi-heart"> &nbsp; 좋아요</span>
				       			<i class="bi bi-chevron-right"></i>
		       				</span>
				       		<span class="col-6 row" onclick="location.href='#';">
					       		<span class="bi bi-bookmark"> &nbsp; 관심 상품</span>
					       		<i class="bi bi-chevron-right"></i>
				       		</span>
		       			</section>
		       			<!-- event : 최근 등록 이벤트 1개 -->
		    	  		<section class="row" id="eventBanner">
		      				<img src="https://i.ibb.co/GFmzFXF/2021120917350947828-11922858-1.jpg" alt="" class="col-12" onclick="location.href='#';"/>
			       		</section>
			    	</article>
			    	
				</div>
			</div>
			
			<%-- my info --%>
			<div class="tab-pane fade col-12" id="myinfo">
				<div class="row">
				
					<article class="col-10" id="info">
		       			<h4>나의 정보</h4>
		       			<hr/>
		       			<!-- 내 프로필 -->
		       			<section class="card" id="myProfile">
		       				<div class="card-header">내 프로필</div>
		       				<div class="card-body">
		       					<div class="row">
			       					<!-- 프로필 이미지 : 프로필 이미지가 null일 경우, 기본 이미지 출력 -->
			       					<article class="col-3">
				       					<c:if test="${member.proPhoto eq null}"><i class="bi bi-person-circle" id="profileImg"></i></c:if>
								      	<c:if test="${member.proPhoto ne null}"><img src="${member.proPhoto}" alt="" id="profileImg"/></c:if>
								       	<img src="https://i.ibb.co/HNQhz98/pencil.png" alt="" id="edit" onclick="location.href='${pageContext.request.contextPath}/mypage/myinfo/infoUpdate.do';"/>
			       					</article>
			       					<!-- 프로필 내용 -->
			       					<article class="col-9">
			       						<h5>${member.nickname}</h5>
				       					<p><span>이메일</span><span>${member.email}</span></p>
								        <p><span>한줄소개</span><span>${member.intro}</span></p>
								        <p><span>개인 사이트</span><span>${member.url}</span></p>
								        <hr/>
								        <p><span>닉네임</span><span>${member.nickname}</span></p>
								        <p><span>이름</span><span>${member.name}</span></p>
								        <p><span>아이디</span><span>${member.id}</span></p>
								        <p><span>비밀번호</span><span>${member.password}</span></p>
								        <p><span>생년월일</span><span>${member.birthday}</span></p>
								        <p><span>전화번호</span><span>${member.phone}</span></p>
			       					</article>
		       					</div>
		       					<button class="col-12">수정하기</button>
		       				</div>
		       			</section>
		       			<br/>
		       			<section class="row">
		       				<div class="col-6">
			       				<!-- 배송지 관리 -->
			       				<article class="card" id="myAddress">
			       					<div class="card-header">배송지 관리</div>
				       				<div class="card-body">
				       					<p>내가 저장한 배송지를<br/>관리할 수 있습니다.</p>
				       					<button class="col-4">조회하기</button>
				       				</div>
			       				</article>
		       				</div>
		       				<div class="col-6">
			       				<!-- 신고 내역 -->
			       				<article class="card" id="myReport">
			       					<div class="card-header">신고 내역</div>
				       				<div class="card-body">
				       					<p>내가 신고한 내역을<br/>확인할 수 있습니다.</p>
				       					<button class="col-4">조회하기</button>
				       				</div>
			       				</article>
		       				</div>
		       			</section>
		       		</article>
				</div>
			</div>
				
			<%-- my shopping --%>
			<div class="tab-pane fade col-12" id="myshopping">
				<div class="row">
				나의 쇼핑
				</div>
			</div>
				
			<%-- my community --%>
			<div class="tab-pane fade col-12" id="mycommunity">
				<div class="row">
				나의 커뮤니티
				</div>
			</div>

       	</section>		   
        	   
    </article>
</main>

<script>
/* $(document).click(function(){
	const $ative = $(".nav-item a.active");
	$ative
		.parents(".nav-item")
		.css("background-color", "#FFFFFF");
}); */
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>