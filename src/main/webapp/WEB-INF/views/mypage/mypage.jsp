<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="마이페이지" name="title"/>
</jsp:include>
<!-- 부트스트랩 아이콘 CDN -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
<style>
main {height:1500px; background:linear-gradient(to top, white 70%, #1A81FF 30%);}
#tabBtns {justify-content:flex-end; padding:0 20px;}
#tabContainer {height:800px; background-color:white; padding:80px 40px;}
#tabContainer div.col-9 {border-left:1px solid #E0E0E0;}
#tabContainer div.card {padding:20px; margin-bottom:40px; border-radius:10px;}

#myGrade img {width:40px; height:40px;}
#myGrade span {display:block; width:80px; margin:0 auto; border:1px solid black; border-radius:20px; background-color:#66ABFF;}

#myActivity {margin:0 auto; margin-bottom:20px; padding:15px 0; border-top:1px solid #E0E0E0; border-bottom:1px solid #E0E0E0; justify-content:space-around;}
#myActivity span.col-6 {justify-content:space-between;}

#eventImg {margin:0 auto; margin-bottom:40px;}
#eventImg img {height:70px; padding:0 5px;}


.bi {font-size:18px;}
</style>

<main class="section-body">
	<br /><br /><br /><br /><br /><br />
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
			       			<!-- 프로필 -->
			       			<span id="profile">
			       				<!-- 프로필 이미지가 없을 경우, 기본 이미지 출력 -->
				       				<img src="" alt="" />
				        		
				        		<!-- 로그인 정보/로그아웃 버튼 -->
				        		<span class="">
					        		<img src="" alt="" />
					        		<span>(으)로 로그인</span>
					        		<button class="btn">로그아웃</button>
				        		</span>
			       			</span>
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
				       					<td>일</td><!-- 출석일수 불러오기 -->
				       					<td>
				       						<img src="https://i.ibb.co/jgyRRVB/badge.png" alt="" />
				       						<span>일반회원</span>
				       					</td><!-- 회원권한명 불러오기 -->
				       					<td>
				       						<img src="https://i.ibb.co/S7TZCYh/coding.png" alt=""/>
				       						<span>지식인</span>
				       					</td><!-- 대표배지 이미지와 이름 불러오기 -->
				       				</tr>
				       			</table>
			       			</div>
			       			<!-- 쪽지/포인트 -->
			       			<span class="row" id="myActivity">
				       			<span class="col-6 row" onclick="location.href='#';">
					       			<span class="bi bi-envelope"> &nbsp; 쪽지</span>
					       			<span>건<i class="bi bi-chevron-right"></i></span>
				       			</span>
					       		<span class="col-6 row" onclick="location.href='#';">
						       		<span class="bi bi-coin"> &nbsp; 포인트</span>
						       		<span>사용 가능 포인트<i class="bi bi-chevron-right"></i></span>
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