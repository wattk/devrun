<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<!-- 부트스트랩 아이콘 CDN -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
<!-- 한글 폰트 CDN -->
<link href="https://fonts.googleapis.com/css2?family=Gowun+Dodum&display=swap" rel="stylesheet">
<!-- CSS import -->
<link href="${pageContext.request.contextPath}/resources/css/mypage/mypageFrame.css" rel="stylesheet">

<main>
	<br/><br/>
	<article class="container" id="tabContent">
		
		<%-- tap button --%>
		<nav id="tabBtns">
			<ul class="nav nav-tabs">
				<li class="nav-item">
				   <a href="${pageContext.request.contextPath}/mypage/mycommunity/postList.do" class="nav-link" id="mycommunityTab">나의 커뮤니티</a>
				</li>
				<li class="nav-item">
				   <a href="${pageContext.request.contextPath}/mypage/myshopping.do" class="nav-link" id="myshoppingTab">나의 쇼핑</a>
				</li>
				<li class="nav-item">
				   <a href="${pageContext.request.contextPath}/mypage/myinfo.do" class="nav-link" id="myinfoTab">나의 정보</a>
				</li>
				<li class="nav-item">
				   <a href="${pageContext.request.contextPath}/mypage/mypage.do" class="nav-link" id="mypageTab">마이페이지</a>
				</li>
			</ul>
		</nav>
		
		<%-- tap container --%>
		<section class="col-12 tab-content" id="tabContainer">
		