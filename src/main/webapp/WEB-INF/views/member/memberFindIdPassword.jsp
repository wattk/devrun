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
/* 탭 중앙 정렬 */
.container > .row {
	justify-content: center;
}

h3 {
	font-size: 1.5rem;
	font-weight: bold;
}

</style>
<div class="container">
	
	<div class="row">
	
		<div class="col-md-6">
	
			<!-- Tab 메뉴 -->
			<ul class="nav nav-pills nav-fill" id="pills-tab" role="tablist">
				<li class="nav-item">
			    	<a class="nav-link active" id="pills-home-tab" data-toggle="pill" href="#pills-home" role="tab" aria-controls="pills-home" aria-selected="true">아이디 찾기</a>
			  	</li>
			  	<li class="nav-item">
			    	<a class="nav-link" id="pills-profile-tab" data-toggle="pill" href="#pills-profile" role="tab" aria-controls="pills-profile" aria-selected="false">비밀번호 찾기</a>
			  	</li>
			</ul>
			
			<!-- Tab 내용 -->
			<div class="tab-content border" id="pills-tabContent">
			
				<!-- 아이디 찾기 Tab 내용 -->
				<div class="tab-pane fade show active" id="pills-home" role="tabpanel" aria-labelledby="pills-home-tab">
					
					<form 
						name="" 
						action="" 
						method="">
						
						<div class="row">
						
							<div class="col-md-12 text-center">
								<img class="mx-auto" src="${pageContext.request.contextPath }/resources/images/logo-devrun.png" alt="데브런로고" style="width: 150px; height:auto;"/>
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
								<button type="button" class="btn btn-primary btn-block">로그인으로</button>
							</div>
							
						</div>
					
					</form>
					
				</div>
				
				<!-- 비밀번호 찾기 Tab 내용 -->
			  	<div class="tab-pane fade" id="pills-profile" role="tabpanel" aria-labelledby="pills-profile-tab">
			  		
					<form 
						name="" 
						action="" 
						method="">
						
						<div class="row">
						
							<div class="col-md-12 text-center">
								<img class="mx-auto" src="${pageContext.request.contextPath }/resources/images/logo-devrun.png" alt="데브런로고" style="width: 150px; height:auto;"/>
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
								<button type="button" class="btn btn-primary btn-block">로그인으로</button>
							</div>
							
						</div>
					
					</form>


			  	</div>
			
			</div>
	
		</div>
		
	</div>
	
</div>
<script>

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
