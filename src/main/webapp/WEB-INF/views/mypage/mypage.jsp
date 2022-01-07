<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<jsp:include page="/WEB-INF/views/mypage/common/header.jsp">
	<jsp:param value="마이페이지" name="title"/>
</jsp:include>

<!-- CSS import -->
<link href="${pageContext.request.contextPath}/resources/css/mypage/mypage.css" rel="stylesheet">

<%-- EL에서 접근하기 위해 VAR속성 지정 --%>
<sec:authentication property="principal" var="member"/>

			<%-- my page --%>
			<div class="col-12" id="mypage">
				<div class="row">
					
					<!-- member profile -->
					<article class="col-3" id="profile">
						<!-- profile image : 프로필 이미지가 null일 경우, 기본 이미지 출력 -->
					    <section>
				   			<c:if test="${member.proPhoto eq null}"><img src="${pageContext.request.contextPath}/resources/images/common/blank-profile.png" alt="" id="profileImg"/></c:if>
							<c:if test="${member.proPhoto ne null}"><img src="${pageContext.request.contextPath}/resources/upload/profilePhoto/${member.id}.png" alt="" id="profileImg"/></c:if>
					       	<p class="cursor" onclick="location.href='${pageContext.request.contextPath}/mypage/myinfo.do';">${member.nickname}님<i class="bi bi-chevron-right"></i></p>
					       	<img src="https://i.ibb.co/HNQhz98/pencil.png" alt="" id="edit" class="cursor" onclick="location.href='${pageContext.request.contextPath}/mypage/myinfo/profileUpdate.do';"/>
					    	<img src="https://i.ibb.co/S7TZCYh/coding.png" alt="" id="badge" class="cursor" onclick="location.href='${pageContext.request.contextPath}/mypage/myinfo/activityBadge.do';"/>
					    </section>
					    <!-- profile info -->
				        <section>
				        	<p><span>이메일</span><br/><span>${member.email}</span></p>
					        <p><span>한줄소개</span><br/><span>${member.intro}</span></p>
					        <button id="url" onclick="location.href='${member.url}';">${member.url}</button>
				        </section>
				        <hr/>
				       	<!-- login info / logout button -->
				       	<section>
				       		<form:form
					    		method="POST"
					    		action="${pageContext.request.contextPath}/member/memberLogout.do">
					        	<p><img src="" alt="" />(으)로 로그인</p>
					        	<button type="submit" class="col-9 cursor">로그아웃</button>
				        	</form:form>
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
			       			<span class="col-6 row" onclick="chatList();">
				       			<span class="bi bi-envelope"> &nbsp; 채팅</span>
				       			<span>${totalUnreadCount}건<i class="bi bi-chevron-right"></i></span>
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

<jsp:include page="/WEB-INF/views/mypage/common/footer.jsp"></jsp:include>
