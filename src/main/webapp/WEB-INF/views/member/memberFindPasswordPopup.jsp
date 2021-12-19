<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!doctype html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<title>비밀번호 찾기</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<!-- bootstrap js: jquery load 이후에 작성할것.-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
<!-- bootstrap css -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
<style>
.popup-find-pw {
	width: 400px;
	height: 299px;
	display: table-cell;
	vertical-align:middle;
}
</style>
</head>
<body>
	
	<div class="popup-find-pw">
	
		<div class="text-center align-middle">
		
			<c:choose>
			
				<%-- 조회된 회원이 없는 경우 --%>
				<c:when test="${empty member}">
					<p class="font-weight-bold">${id} / ${email} 의 <br>회원 정보가 존재하지 않습니다.</p>
				</c:when>
				
				<%-- 조회된 회원이 있는 경우 --%>
				<c:otherwise>
					<p class="font-weight-bold">임시 비밀번호를 <span class="text-primary">이메일</span>로 전송 하였습니다.</p>
					<span class="">임시 비밀번호를 확인하여 로그인 하신 후</span>
					<p class="text-danger">꼭 비밀번호를 변경해주세요.</p>
				</c:otherwise>
				
			</c:choose>
			
			<!-- 닫기 버튼 -->
			<button type="button" class="btn btn-secondary" onclick="javascript:self.close();">닫기</button>
		
		</div>
	
	</div>

</body>
</html>

