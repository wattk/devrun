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
								<input type="text" placeholder="이름" class="form-control" name="name" id="name" value="테스트" required>
							</div>
							
							<!-- 이메일 -->
							<label for="email" class="col-md-12 col-form-label">이메일</label>
							<div class="col-md-12">
								<input type="email" placeholder="이메일" class="form-control" name="email" id="email" value="test@naver.com" required>
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
						action="" 
						method="">
						
						<div class="row">
						
							<div class="col-md-12 text-center">
								<img class="mx-auto logo" src="${pageContext.request.contextPath }/resources/images/logo-devrun.png" alt="데브런로고"/>
							</div>
							
							<h3 class="mx-auto">비밀번호 찾기</h2>
						
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
			
			</div>
	
		</div>
		
	</div>
	
</div>
<script>

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
	const spec = "width=500px, height=500px";
	open(url, name, spec);
	
});


</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
