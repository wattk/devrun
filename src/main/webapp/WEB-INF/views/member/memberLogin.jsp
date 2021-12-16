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

<meta charset="UTF-8">
<title>로그인</title>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<!-- bootstrap js: jquery load 이후에 작성할것.-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>

<!-- bootstrap css -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">

<!-- 사용자작성 css -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/style.css" />

<c:if test="${param.error != null}">
alert("아이디 또는 비밀번호가 일치하지 않습니다.");
</c:if>


<style>
	#login-container{width:700px; height:600px;text-align:center; margin-top:150px; margin-left: auto;margin-right: auto;}
	#title{width:250px;margin-bottom:10px;margin-top:50px; text-align: center;} 
	#form-container{text-align:center; width:300px; height:300px; margin: auto;}
	#id,#password{width:300px; height:40px;}
	#id{margin-top:80px; margin-bottom:30px;}
	#password{margin-bottom:20px;}
	#login-btn{width:300px; height:40px; background-color:rgb(26, 129, 255); color:white; font-weight: 800; margin-top:45px; border: unset;}
	#find-id{border-right:1.5px solid gray; padding-right:13px;}
	#find-pass{margin-left:10px;}
	#find-container{width:300px; text-align: right;}
	#form-container{width:300px;}
	.simple-login{width:50px; margin-top:40px; margin-right:20px;}
	
</style>
	<div id="login-container">

		<img src="${pageContext.request.contextPath }/resources/images/logo-devrun.png" id="title" />
		<form 
			name="login-form"
			method="POST">
						
			<div id="form-container">		
				<input type="text" id="id" name="id" placeholder="아이디" required><br />
				<input type="password" id="password" name="password" placeholder="비밀번호" required/><br />
			<div/>	
			<div id="find-container">
				<span class="find" id="find-id"><a href="${pageContext.request.contextPath}/member/memberFindIdPassword.do">아이디 찾기</a></span>
				<span class="find" id="find-pass"><a href="${pageContext.request.contextPath}/member/memberFindIdPassword.do">패스워드 찾기</a></span>
			</div>
				<button id="login-btn" type="submit">로그인</button>
		</form>
	</div>
	
	<br /><hr />
	<div>간편 로그인</div>
	<img src="${pageContext.request.contextPath }/resources/images/kakao.jpg" class="simple-login">
	<img src="${pageContext.request.contextPath }/resources/images/naver.jpg" class="simple-login">
	
<script>
$("#login-btn").click(e=>{
	location.href="${pageContext.request.contextPath}/member/memberLogin.do"
});
</script>


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>