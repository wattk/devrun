<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>	
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="데브런" name="title"/>
</jsp:include>

 <!--/ login 본문 start /-->
<!DOCTYPE html>

<title>로그인</title>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<!-- bootstrap js: jquery load 이후에 작성할것.-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>

<!-- bootstrap css -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">

<!-- 사용자작성 css -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/style.css" />

<style>
	#login-container{width:100%text-align: center; margin-top:150px;background-color:gray;}
	#title{font-weight: bold; font-size: 4rem; margin-bottom:50px;} /* 헤더 굵기 */
	#login-frm{text-align:center; width:500px; height:300px; border:1px solid #80808099; margin: auto;}
	#id,#password{width:300px; height:40px;}
	#id{margin-top:80px; margin-bottom:30px;}
	#password{margin-bottom:50px;}
	#login-btn{width:300px; height:40px; background-color:rgb(26, 129, 255); color:white; font-weight: 800;}
	
</style>

	<div id="login-container">
		<h1 id=title>Devrun</h1>
		<div id="login-frm">
			<input type="text" id="id" name="id" placeholder="아이디"/><br />
			<input type="password" id="password" name="password" placeholder="비밀번호"/><br />
			
			<button id="login-btn">로그인</button>
		</div>
		
	</div>
 <!--/ login 본문 end /-->
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>