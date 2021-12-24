<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<jsp:include page="/WEB-INF/views/mypage/common/header.jsp">
	<jsp:param value="나의 정보" name="title"/>
</jsp:include>

<!-- CSS import -->
<link href="${pageContext.request.contextPath}/resources/css/mypage/myinfo.css" rel="stylesheet">

<%-- EL에서 접근하기 위해 VAR속성 지정 --%>
<sec:authentication property="principal" var="member"/>

			<%-- my info --%>
			<div class="col-12" id="myinfo">
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
			       						<table id="profileInfo">
			       							<caption>${member.nickname}</caption>
								        	<tr><td>이메일</td><td>${member.email}</td></tr>
								        	<tr><td>한줄소개</td><td>${member.intro}</td></tr>
								        	<tr><td>개인 사이트</td><td>${member.url}</td></tr>
								        </table>
								        <hr/>
								        <table id="personalInfo">
								        	<tr><td>아이디</td><td>${member.id}</td></tr>
								        	<tr><td>닉네임</td><td>${member.nickname}</td></tr>
								        	<tr><td>이름</td><td>${member.name}</td></tr>
								        	<tr><td>생년월일</td><td><fmt:formatDate value="${member.birthday}" pattern="yyyy년 MM월 dd일"/></td></tr>
								        	<tr><td>전화번호</td><td>${member.phone}</td></tr>
								        </table>
			       					</article>
		     					</div>
		       					<button class="col-11" type="button" onclick="location.href='${pageContext.request.contextPath}/mypage/myinfo/profileUpdate.do';">수정하기</button>
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
				       					<button class="col-4" onclick="location.href='${pageContext.request.contextPath}/mypage/myinfo/shippingAddress.do';">조회하기</button>
				       				</div>
			       				</article>
		       				</div>
		       				<div class="col-6">
			       				<!-- 신고 내역 -->
			       				<article class="card" id="myReport">
			       					<div class="card-header">신고 내역</div>
				       				<div class="card-body">
				       					<p>내가 신고한 내역을<br/>확인할 수 있습니다.</p>
				       					<button class="col-4" onclick="location.href='${pageContext.request.contextPath}/mypage/myinfo/reportHistory.do';">조회하기</button>
				       				</div>
			       				</article>
		       				</div>
		       			</section>
		       		</article>
		       		
				</div>
			</div>

<jsp:include page="/WEB-INF/views/mypage/common/footer.jsp"></jsp:include>