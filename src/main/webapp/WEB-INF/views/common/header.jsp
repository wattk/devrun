<%@page import="java.util.Collection"%>
<%@page import="org.springframework.security.core.GrantedAuthority"%>
<%@page import="org.springframework.security.core.context.SecurityContext"%>
<%@page import="org.springframework.security.core.Authentication"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="com.kh.devrun.member.model.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%
	//SecurityContext securityContext = SecurityContextHolder.getContext();
	//Authentication authentication = securityContext.getAuthentication();
	//Collection<? extends GrantedAuthority> authorities = authentication.getAuthorities();
	
	//System.out.print("권한 = " + authorities);

%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>${param.title}</title>
  <meta content="width=device-width, initial-scale=1.0" name="viewport">
  <meta content="" name="keywords">
  <meta content="" name="description">


  <!-- Favicons -->
  <!--   <link href="#" rel="icon">
  <link href="#" rel="apple-touch-icon"> -->


  
    <!-- Google Fonts -->
  <link href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700" rel="stylesheet">

  <!-- Bootstrap CSS File -->
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>

	<!-- bootstrap js: jquery load 이후에 작성할것.-->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
	
	<!-- bootstrap css -->
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">

  <!-- Libraries CSS Files -->
  <link href="${pageContext.request.contextPath }/resources/css/font-awesome/css/font-awesome.min.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath }/resources/css/animate.min.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath }/resources/css/ionicons/css/ionicons.min.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath }/resources/css/owl.carousel.min.css" rel="stylesheet">
  
   <!-- 태영 css -->
  <link href="${pageContext.request.contextPath }/resources/css/header/header.css" rel="stylesheet">

  <!-- Main Stylesheet File -->
  <link href="${pageContext.request.contextPath }/resources/css/style.css" rel="stylesheet">

  <!-- =======================================================
    Theme Name: EstateAgency
    Theme URL: https://bootstrapmade.com/real-estate-agency-bootstrap-template/
    Author: BootstrapMade.com
    License: https://bootstrapmade.com/license/
  ======================================================= -->
</head>
<style>
/* #navLoginContainer{margin-left:40px;} */
</style>

<body>

  <div class="click-closed"></div>

  <!--/ Nav Star /-->
  <nav class="navbar navbar-default navbar-trans navbar-expand-lg fixed-top">
    <div class="container">
      <button class="navbar-toggler collapsed" type="button" data-toggle="collapse" data-target="#navbarDefault"
        aria-controls="navbarDefault" aria-expanded="false" aria-label="Toggle navigation">
        <span></span>
        <span></span>
        <span></span>
      </button>
      <a class="navbar-brand text-brand" href="${pageContext.request.contextPath}/">Dev<span class="color-b">Run</span></a>
      <button type="button" class="btn btn-link nav-search navbar-toggle-box-collapse d-md-none" data-toggle="collapse"
        data-target="#navbarTogglerDemo01" aria-expanded="false">
        <span class="fa fa-search" aria-hidden="true"></span>
      </button>
      <div class="navbar-collapse collapse justify-content-center" id="navbarDefault">
        <ul class="navbar-nav">
          <li class="nav-item">
            <a class="nav-link active" href="${pageContext.request.contextPath}/">Home</a>
          </li>
          <li class="nav-item">
            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown"
              aria-haspopup="true" aria-expanded="false">Community</a>
            <div class="dropdown-menu" aria-labelledby="navbarDropdown">
              <a class="dropdown-item" href="${pageContext.request.contextPath}/community/communityMain.do">전체</a>
              <a class="dropdown-item" href="${pageContext.request.contextPath}/community/communityColumn.do">칼럼</a>
              <a class="dropdown-item" href="${pageContext.request.contextPath}/community/communityQnA.do">Q&A</a>
              <a class="dropdown-item" href="${pageContext.request.contextPath}/community/communityStudy.do">스터디</a>
              <a class="dropdown-item" href="${pageContext.request.contextPath}/community/communityBoard.do">자유게시판</a>
            </div>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/shop/shopMain.do">Shop</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="about.html">About</a>
          </li>
        </ul>
      </div>
	  <div class="search-box">
          <form class="form-inline" name="unifiedSearchFrm" action="${pageContext.request.contextPath}/common/search.do" method="GET">
		    <div class="input-group">
		      <input type="text" id="searchKeyword" name="searchKeyword" class="form-control" placeholder="검색어를 입력하세요" aria-label="Username" aria-describedby="basic-addon1">
		      <button type="button" id="unifiedSearchBtn" class="btn btn-b-n d-none d-md-block" data-toggle="collapse"
		        data-target="#navbarTogglerDemo01" aria-expanded="false">
		        <span class="fa fa-search" aria-hidden="true"></span>
		      </button>
		    </div>
		  </form>
	  </div>
      
      <!-- 로그인 안 되어 있을 때 -->
      <sec:authorize access="isAnonymous()">
      <div id="navLoginContainer">
    	  <a class="btn btn-primary log-con" id="navLoginBtn" href="${pageContext.request.contextPath}/member/memberLogin.do" >로그인</a>
      </div>
      </sec:authorize>
      
      <!-- 로그인 되어있을 때 -->
      <sec:authorize access="isAuthenticated()">&nbsp;&nbsp;
	      <a href="${pageContext.request.contextPath}/member/memberDetail.do">
	      	[<sec:authentication property="principal.nickname"/>]
	      </a> 님 안녕하세요
	      <div id="navLoginContainer">      		
		    	<a class="btn btn-primary log-con" id ="navDetail" href="${pageContext.request.contextPath}/member/memberDetail.do">내 정보</a>
		    <form:form
		    	id="navLogoutFrm"
		    	method="POST"
		    	action="${pageContext.request.contextPath}/member/memberLogout.do">
		    	<button
		    		class="btn btn-primary log-con"
		    		type="submit">로그아웃</button>
		    </form:form>
	      </div>		
	 </sec:authorize>
	 
      <!-- 관리자가 로그인 하였을 때 -->
	 <sec:authorize  access="hasRole('AM')">
	 	<h1>관리자 ㅎㅇ</h1> 	
	 </sec:authorize>
	</div>
  </nav>
  
  <script>

  </script>
  <!--/ Nav End /-->
  <section style="margin-top:115px;">
  
  
  
  
  
