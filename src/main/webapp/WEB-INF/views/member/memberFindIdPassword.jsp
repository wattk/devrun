<%-- <%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="org.springframework.security.core.Authentication"%>
<%@page import="org.springframework.security.core.context.SecurityContext"%> --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>	

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="아아디/비밀번호 찾기" name="title"/>
</jsp:include>
<style>

.find-form h3 {
	font-size: 1.5rem;
	font-weight: bold;
}

/* 탭 중앙 정렬 */
.find-form > .row {
	justify-content: center;
}

.find-form {
	margin-top: 175px;
}

.find-form div {
	padding: 10px;
}

/* 로고 이미지 크기 */
.find-form .logo {
	width: 150px;
	height: auto;
}

</style>
<div class="container find-form">
	
	<div class="row">
	
		<div class="col-md-6">
	
			<!-- Tab 메뉴 -->
			<ul class="nav nav-pills nav-fill" id="pills-tab" role="tablist">
				<li class="nav-item find-id-tab">
			    	<a class="nav-link active" id="pills-home-tab" data-toggle="pill" href="#pills-home" role="tab" aria-controls="pills-home" aria-selected="true">아이디 찾기</a>
			  	</li>
			  	<li class="nav-item find-pw-tab">
			    	<a class="nav-link" id="pills-profile-tab" data-toggle="pill" href="#pills-profile" role="tab" aria-controls="pills-profile" aria-selected="false">비밀번호 찾기</a>
			  	</li>
			</ul>
			
			<!-- Tab 내용 -->
			<div class="tab-content border" id="pills-tabContent">
			
				<!-- 아이디 찾기 Tab 내용 -->
				<div class="tab-pane fade show active" id="pills-home" role="tabpanel" aria-labelledby="pills-home-tab">
					
					<form 
						id="memberFindIdFrm" 
						action="">
						
						<div class="row">
						
							<div class="col-md-12 text-center">
								<img class="mx-auto logo" src="${pageContext.request.contextPath }/resources/images/logo-devrun.png" alt="데브런로고"/>
							</div>
							
							<h3 class="mx-auto">아이디 찾기</h2>
						
							<!-- 이름 -->
							<label for="name" class="col-md-12 col-form-label">이름</label>
							<div class="col-md-12">
								<input type="text" placeholder="이름" class="form-control" name="name" id="name" required>
							</div>
							
							<!-- 이메일 -->
							<label for="email" class="col-md-12 col-form-label">이메일</label>
							<div class="col-md-12">
								<input type="email" placeholder="이메일" class="form-control" name="email" id="email" required>
							</div>
							
							<!-- 찾기 -->
							<div class="col-md-6">
								<button type="submit" class="btn btn-primary btn-block">찾기</button>
							</div>
							
							<!-- 로그인으로 -->
							<div class="col-md-6">
								<button type="button" class="btn btn-primary btn-block" onclick="location.href='${pageContext.request.contextPath}/member/memberLogin.do';">로그인으로</button>
							</div>
							
						</div>
					
					</form>
					
				</div>
				
				<!-- 비밀번호 찾기 Tab 내용 -->
			  	<div class="tab-pane fade" id="pills-profile" role="tabpanel" aria-labelledby="pills-profile-tab">
			  		
					<form 
						id="memberFindPasswordFrm" 
						action="" >
						
						<div class="row">
						
							<div class="col-md-12 text-center">
								<img class="mx-auto logo" src="${pageContext.request.contextPath }/resources/images/logo-devrun.png" alt="데브런로고"/>
							</div>
							
							<h3 class="mx-auto">비밀번호 찾기</h2>
						
							<!-- 이름 -->
							<label for="name" class="col-md-12 col-form-label">아이디</label>
							<div class="col-md-12">
								<input type="text" placeholder="아이디" class="form-control" name="id" id="id" required>
							</div>
							
							<!-- 이메일 -->
							<label for="email" class="col-md-12 col-form-label">이메일</label>
							<div class="col-md-12">
								<input type="email" placeholder="이메일" class="form-control" name="email" id="email" required>
							</div>
							
							<!-- 찾기 -->
							<div class="col-md-6">
								<button type="submit" class="btn btn-primary btn-block">찾기</button>
							</div>
							
							<!-- 로그인으로 -->
							<div class="col-md-6">
								<button type="button" class="btn btn-primary btn-block" onclick="location.href='${pageContext.request.contextPath}/member/memberLogin.do';">로그인으로</button>
							</div>
							
						</div>
					
					</form>

			  	</div>
			
			</div>
	
		</div>
		
	</div>
	
</div>
<script>
// 처음 로딩 시 아이디 찾기 또는 비밀번호 찾기 탭 활성화 결정
$(document).ready(function(){
	// 탭 구분
	const tab = (window.location.search).slice(-2);
	console.log(tab);
	
	if(tab == 'pw') {
		$("#pills-home-tab").removeClass('active');
		$("#pills-profile-tab").addClass('active');
		$("#pills-home").removeClass('show active');
		$("#pills-profile").addClass('show active');
	} else {
		$("#pills-home-tab").addClass('active');
		$("#pills-profile-tab").removeClass('active');
		$("#pills-home").addClass('show active');
		$("#pills-profile").removeClass('show active');
	}
	
});

// 아이디 찾기 탭 클릭 시 비밀번호 찾기 input 초기화
$(".find-id-tab").click((e) => {
	
	// 폼 리셋
	$(memberFindPasswordFrm)[0].reset();
	
});

// 비밀번호 찾기 탭 클릭 시 아이디 찾기 input 초기화
$(".find-pw-tab").click((e) => {
	
	// 폼 리셋
	$(memberFindIdFrm)[0].reset();
	
});

// 아이디 찾기
$(memberFindIdFrm).submit((e) => {
	e.preventDefault(); // 폼제출방지
	
	//console.log($(e.target));
	
	// 이름
	const name = $(e.target).find("input[name=name]").val();
	// 이메일
	const email = $(e.target).find("input[name=email]").val();

	// 팝업요청
	const url = `${pageContext.request.contextPath}/member/\${name}/\${email}/findId.do`;
	
	// 띄울 팝업창 높이
	const popHeight = 300;		                                      
	// 띄울 팝업창 너비
	const popWidth = 400;                                       
	// 현재창의 높이
	const winHeight = document.body.clientHeight;	  
	// 현재창의 너비
	const winWidth = document.body.clientWidth;	  
	// 현재창의 x좌표
	const winX = window.screenLeft;	                          
	// 현재창의 y좌표
	const winY = window.screenTop;	                          

	const popX = winX + (winWidth - popWidth)/2;
	const popY = winY + (winHeight - popHeight)/2;

	open(url, name, `top=\${popY}, left=\${popX}, width=\${popWidth}, height=\${popHeight}`);
	
});

//비밀번호 찾기
$(memberFindPasswordFrm).submit((e) => {
	e.preventDefault(); // 폼제출방지
	
	//console.log($(e.target));
	
	// 이름
	const id = $(e.target).find("input[name=id]").val();
	// 이메일
	const email = $(e.target).find("input[name=email]").val();

	// 팝업요청
	const url = `${pageContext.request.contextPath}/member/\${id}/\${email}/findPassword.do`;
	
	// 띄울 팝업창 높이
	const popHeight = 300;		                                      
	// 띄울 팝업창 너비
	const popWidth = 400;                                       
	// 현재창의 높이
	const winHeight = document.body.clientHeight
	// 현재창의 너비
	const winWidth = document.body.clientWidth;	  
	// 현재창의 x좌표
	const winX = window.screenLeft;	                          
	// 현재창의 y좌표
	const winY = window.screenTop;	                          

	const popX = winX + (winWidth - popWidth)/2;
	const popY = winY + (winHeight - popHeight)/2;

	open(url, name, `top=\${popY}, left=\${popX}, width=\${popWidth}, height=\${popHeight}`);
	
});

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
