<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="활동 배지" name="title"/>
</jsp:include>
<!-- 부트스트랩 아이콘 CDN -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">

<style>
/* 공통 적용 style */
.bi {font-size:20px;}
.cursor {cursor:pointer; cursor:hand;}
button {background-color:#FFFFFF; border:1px solid #F1F1F2; border-radius:20px; padding:5px;}
button:focus {outline:none;}
button:hover {background-color:#1A81FF; color:#FFFFFF; border:1px solid #1A81FF; transition:.3s;}

/* tabContent frame */
main {height:950px; background:linear-gradient(to top, #FFFFFF 70%, #1A81FF 30%);}
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
</style>
<%-- EL에서 접근하기 위해 VAR속성 지정 --%>
<sec:authentication property="principal" var="member"/>

<main class="section-body">
	<br /><br /><br />
	<section class="container">
		<div class="row">
			<div class="container" id="tabContent">
				<!-- 탭 버튼 -->
				<ul class="nav nav-tabs" id="tabBtns">
					<li class="nav-item">
					   <a class="nav-link active" aria-current="page" href="#">나의 커뮤니티</a>
					</li>
					<li class="nav-item">
					   <a class="nav-link active" aria-current="page" href="#">나의 쇼핑</a>
					</li>
					<li class="nav-item">
					   <a class="nav-link active" aria-current="page" href="#">나의 정보</a>
					</li>
					<li class="nav-item">
					   <a class="nav-link active" aria-current="page" href="">마이페이지</a>
					</li>
				</ul>
				<!-- 탭 페이지 -->
				<div class="col-12" id="tabContainer">
					<!-- 마이페이지 -->
					<div class="row">
						<!-- 회원 정보 -->
			       		<div class="col-3">
			       			<!-- 프로필 이미지 : 프로필 이미지가 null일 경우, 기본 이미지 출력 -->
			       			<div id="profileImg">
			       				<c:if test="${member.proPhoto eq null}"><i class="bi bi-person-circle"></i></c:if>
					       		<c:if test="${member.proPhoto ne null}"><img src="${member.proPhoto}" alt=""/></c:if>
					       		<i class="bi bi-pencil-square"></i>
					        </div>
					        <div>
					        	<div onclick="location.href='#';">${member.nickname}님<i class="bi bi-chevron-right"></i></div>
					        	<p>이메일<br/>${member.email}</p>
						        <p>한줄소개<br/>${member.intro}</p>
						        <button onclick="location.href='${member.url}';">${member.url}</button>
					        </div>
				        	<!-- 로그인 정보/로그아웃 버튼 -->
				        	<div class="">
					        	<img src="" alt="" />
					        	<p>(으)로 로그인</p>
					        	<button class="btn">로그아웃</button>
				        	</div>
			       		</div>
			       		<!-- 회원 활동 관련 정보 -->
			       		<div class="col-10">
			       			
			       		</div>
		       		</div>
	        	</div>
        	</div>
		</div>
    </section>
</main>

<script>

</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>