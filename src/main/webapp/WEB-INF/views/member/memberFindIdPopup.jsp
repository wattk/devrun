<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!doctype html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<title>아이디 찾기</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<!-- bootstrap js: jquery load 이후에 작성할것.-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
<!-- bootstrap css -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
<link href="${pageContext.request.contextPath }/resources/css/member/member.css" rel="stylesheet">

</head>
<body>
	
	<div class="popup-find-id">
	
		<div class="text-center align-middle">
		
			<c:choose>
			
				<%-- 조회된 아이디가 없는 경우 --%>
				<c:when test="${empty id}">
					<p class="font-weight-bold">${name} / ${email} 로 아이디를 찾은 결과, 일치하는 아이디가 없습니다.</p>
				</c:when>
				
				<%-- 조회된 아이디가 있는 경우 --%>
				<c:otherwise>
					<p class="font-weight-bold">회원님의 아이디는 <span class="text-primary">${id}</span>입니다.</p>
					
				</c:otherwise>
				
			</c:choose>
			
			<!-- 닫기 버튼 -->
			<button type="button" class="btn btn-secondary" onclick="javascript:self.close();">닫기</button>
		
		</div>
	
	</div>

</body>
</html>

