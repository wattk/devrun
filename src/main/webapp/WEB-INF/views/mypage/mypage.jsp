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
<style>
.bi {font-size:18px;}

main {height:1500px; background:linear-gradient(to top, white 70%, #1A81FF 30%);}
#tabBtns {justify-content:flex-end; padding:0 20px;}
#tabContainer {height:800px; background-color:white; padding:80px 10px;}
#tabContainer div.col-9 {border-left:1px solid #E0E0E0;}
#tabContainer div.card {padding:20px; margin-bottom:40px; border-radius:10px;}

#profileImg i:first-child {font-size:100px; color:#1A81FF;}
#profileImg img:first-child {font-size:100px;}

#myGrade img {width:40px; height:40px;}
#myGrade span {display:block; width:80px; margin:0 auto; border:1px solid black; border-radius:20px; background-color:#66ABFF;}

#myActivity {margin:0 auto; margin-bottom:20px; padding:15px 0; border-top:1px solid #E0E0E0; border-bottom:1px solid #E0E0E0; justify-content:space-around;}
#myActivity span.col-6 {justify-content:space-between;}

#eventImg {margin:0 auto; margin-bottom:40px;}
#eventImg img {height:70px; padding:0 5px;}


</style>
<%-- EL에서 접근하기 위해 VAR속성 지정 --%>
<sec:authentication property="principal" var="member"/>

<main class="section-body">
	<br /><br /><br />
	<section class="container">
		<div class="row">
			<div class="container" id="sectionTab">
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
			       		<div class="col-9">
			       			<!-- 출석일수/활동 등급/활동 배지 -->
			       			<div class="card">
			        			<table class="text-center" id="myGrade">
				       				<tr>
				       					<td>출석일수</td>
				       					<td>활동 등급</td>
				       					<td onclick="location.href='#';">활동 배지</td>
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
				       					<td>
				       						<!-- 대표배지 이미지와 이름 불러오기 -->
				       						<img src="https://i.ibb.co/S7TZCYh/coding.png" alt=""/>
				       						<span>지식인</span>
				       					</td>
				       				</tr>
				       			</table>
			       			</div>
			       			<!-- 쪽지/포인트 -->
			       			<span class="row" id="myActivity">
				       			<span class="col-6 row" onclick="location.href='#';">
					       			<span class="bi bi-envelope"> &nbsp; 쪽지</span>
					       			<span>${totalMessage}건<i class="bi bi-chevron-right"></i></span>
				       			</span>
					       		<span class="col-6 row" onclick="location.href='#';">
						       		<span class="bi bi-coin"> &nbsp; 포인트</span>
						       		<span>사용 가능 ${member.point}포인트<i class="bi bi-chevron-right"></i></span>
					       		</span>
			       			</span>
			       			<!-- 이벤트(최근 등록 이벤트 2개) -->
			       			<span class="row" id="eventImg">
			       				<img src="https://i.ibb.co/w63RdmJ/2021121515051506481-11934059-1.jpg" alt="" class="col-6" onclick="location.href='#';"/>
			       				<img src="https://i.ibb.co/GFmzFXF/2021120917350947828-11922858-1.jpg" alt="" class="col-6" onclick="location.href='#';"/>
			       			</span>
			       			<!-- 나의 활동(좋아요/관심 상품) -->
			       			<h5>나의 활동</h5>
			       			<span class="row" id="myActivity">
			       				<span class="col-6 row" onclick="location.href='#';">
			       					<span class="bi bi-heart"> &nbsp; 좋아요</span>
					       			<i class="bi bi-chevron-right"></i>
			       				</span>
					       		<span class="col-6 row" onclick="location.href='#';">
						       		<span class="bi bi-bookmark"> &nbsp; 관심 상품</span>
						       		<i class="bi bi-chevron-right"></i>
					       		</span>
			       			</span>
			       			<!-- 이벤트(최근 등록 이벤트 1개) -->
			       			<span class="row" id="eventImg">
			       				<img src="https://i.ibb.co/GFmzFXF/2021120917350947828-11922858-1.jpg" alt="" class="col-12" onclick="location.href='#';"/>
			       			</span>
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