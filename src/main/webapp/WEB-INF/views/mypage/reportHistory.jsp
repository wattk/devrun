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
<link href="${pageContext.request.contextPath}/resources/css/mypage/profileUpdate.css" rel="stylesheet">

<%-- EL에서 접근하기 위해 VAR속성 지정 --%>
<sec:authentication property="principal" var="member"/>

<main>
	<br/><br/>
	<article class="container" id="tabContent">
		
		<%-- tap button --%>
		<nav id="tabBtns">
			<ul class="nav nav-tabs">
				<li class="nav-item">
				   <a class="nav-link" id="mycommunityTab" href="${pageContext.request.contextPath}/mypage#mycommunity" role="tab" aria-controls="mycommunity" aria-selected="false">나의 커뮤니티</a>
				</li>
				<li class="nav-item">
				   <a class="nav-link" id="myshoppingTab" href="${pageContext.request.contextPath}/mypage#myshopping" role="tab" aria-controls="myshopping" aria-selected="false">나의 쇼핑</a>
				</li>
				<li class="nav-item">
				   <a class="nav-link active" id="myinfoTab" href="${pageContext.request.contextPath}/mypage#myinfo" role="tab" aria-controls="myinfo" aria-selected="false">나의 정보</a>
				</li>
				<li class="nav-item">
				   <a class="nav-link" id="mypageTab" href="${pageContext.request.contextPath}/mypage#mypage" role="tab" aria-controls="mypage" aria-selected="true">마이페이지</a>
				</li>
			</ul>
		</nav>
		
		<%-- tap container --%>
		<section class="col-12 tab-content" id="tabContainer">
		
		<div class="col-12" id="profileUpdate">
			<div class="row">
			
				<article class="col-10" id="info">
		      		<h4 id="breadcrumb"><a href="${pageContext.request.contextPath}/mypage#myinfo">나의 정보</a> <i class="bi bi-chevron-right"></i> <span>프로필 수정</span></h4>
		       		<hr/>
		       		<!-- 내 프로필 -->
		       		<section class="card" id="myProfile">
		       			<div class="card-header">내 프로필</div>
		       			<div class="card-body">
		       				<form name="profileUpdateFrm" action="${pageContext.request.contextPath}/mypage/myinfo/profileUpdate.do" method="POST">
			       				<div class="row">
				       				<!-- 프로필 이미지 : 프로필 이미지가 null일 경우, 기본 이미지 출력 -->
				       				<article class="col-4">
				     					<c:if test="${member.proPhoto eq null}"><i class="bi bi-person-circle" id="profileImg"></i></c:if>
								      	<c:if test="${member.proPhoto ne null}"><img src="${member.proPhoto}" alt="" id="profileImg"/></c:if>
								       	<input class="form-control" type="file" id="formFile">
			       					</article>
			       					<!-- 프로필 내용 -->
			       					<article class="col-8">
			       						<table id="profileInfo">
								        	<tr>
									        	<td><label for="email">이메일</label></td>
								        		<td><input type="email" class="form-control" id="email" name="email" value="${member.email}"></td>
								        	</tr>
								        	<tr>
								        		<td><label for="intro">한줄소개</label></td>
								        		<td><input type="text" class="form-control" id="intro" name="intro" value="${member.intro}"></td>
								        	</tr>
								        	<tr>
								        		<td><label for="url">개인 사이트</label></td>
								        		<td><input type="text" class="form-control" id="url" name="url" value="${member.url}"></td>
								        	</tr>
								        </table>
								        <hr/>
								        <table id="personalInfo">
								        	<tr>
								        		<td>아이디</td>
								        		<td><input type="text" class="form-control" name="id" value="${member.id}" readonly required></td>
								        	</tr>
								        	<tr>
								        		<td>기존 비밀번호</td>
								        		<td><input type="password" class="form-control" name="password" value="${member.password}" required></td>
								        	</tr>
								        	<tr>
								        		<td>새 비밀번호</td>
								        		<td><input type="password" class="form-control" required></td>
								        	</tr>
								        	<tr>
								        		<td>닉네임</td>
								        		<td><input type="text" class="form-control" name="nickname" value="${member.nickname}" required></td>
								        	</tr>
								        	<tr>
								        		<td>이름</td>
								        		<td><input type="text" class="form-control" name="name" value="${member.name}" required></td>
								        	</tr>
								        	<tr>
								        		<td>생년월일</td>
								        		<td><input type="date" class="form-control" name="birthday" value="<fmt:formatDate value="${member.birthday}" pattern="yyyy-MM-dd"/>" maxlength="11" required></td>
								        	</tr>
								        	<tr>
								        		<td>전화번호</td>
								        		<td><input type="tel" class="form-control" name="phone" value="${member.phone}" maxlength="11" required></td>
								        	</tr>
								        </table>
			       					</article>
		    					</div>
		    					<div id="btns" class="col-11 row">
		    						<button class="col-6" type="submit" onclick="location.href='${pageContext.request.contextPath}/mypage/myinfo/profileUpdate.do';">탈퇴하기</button>
		    						<button class="col-6" type="submit" onclick="location.href='${pageContext.request.contextPath}/mypage/myinfo/profileUpdate.do';">수정하기</button>
		    					</div>
	    					</form>
	       				</div>
	       			</section>
		       			
	       		</article>

			</div>
		</div>
		
		</section>
		
    </article>
</main>