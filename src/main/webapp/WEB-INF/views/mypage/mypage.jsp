<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="마이페이지" name="title"/>
</jsp:include>
<style>
main {height:1500px; background:linear-gradient(to top, white 70%, #1A81FF 30%);}
#tabBtns {justify-content:flex-end; padding:0 20px;}
#tabContainer {height:800px; background-color:white; padding:80px 40px;}
#tabContainer div.col-9 {border-left:1px solid #E0E0E0;}
#tabContainer div.card {padding:20px; margin-bottom:30px; border-radius:10px;}

#myGrade img {width:40px; height:40px;}
#myGrade span {display:block; width:80px; margin:0 auto; border:1px solid black; border-radius:20px; background-color:#66ABFF;}
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
						<!-- 회원정보 -->
			       		<div class="col-3">
			        			
			       		</div>
			       		<!-- 마이페이지 -->
			       		<div class="col-9">
			       			<!-- 출석일수/활동 등급/활동 배지 -->
			       			
			       			<div class="card">
			        			<table class="text-center" id="myGrade">
				       				<tr>
				       					<td>출석일수</td>
				       					<td>활동 등급</td>
				       					<td>활동 배지</td>
				       				</tr>
				       				<tr>
				       					<td></td><!-- 출석일수 불러오기 -->
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
			       			<span>쪽지</span>
			       			<span>포인트</span>
			       			
			       			<!-- 최근 등록된 이벤트 -->
			       			<div id="eventImg"><img src="" alt=""/></div>
			       			<!-- 나의 활동(좋아요/관심 상품) -->
			       			
			       		</div>
		       		</div>
	        	</div>
        	</div>
		</div>
    </section>
</main>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>