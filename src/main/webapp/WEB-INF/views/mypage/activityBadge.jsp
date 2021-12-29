<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<jsp:include page="/WEB-INF/views/mypage/common/header.jsp">
	<jsp:param value="활동 배지" name="title"/>
</jsp:include>

<!-- CSS import -->
<link href="${pageContext.request.contextPath}/resources/css/mypage/activityBadge.css" rel="stylesheet">

<%-- EL에서 접근하기 위해 VAR속성 지정 --%>
<%-- <sec:authentication property="principal" var="member"/> --%>

			<%-- my page --%>
			<div class="col-12" id="mypage">
				<div class="row">
					
					<!-- member profile -->
					<article class="col-3" id="profile">
						<!-- profile image : 프로필 이미지가 null일 경우, 기본 이미지 출력 -->
					    <section>
				   			<c:if test="${member.proPhoto eq null}"><img src="${pageContext.request.contextPath}/resources/images/common/blank-profile.png" alt="" id="profileImg"/></c:if>
							<c:if test="${member.proPhoto ne null}"><img src="${pageContext.request.contextPath}/resources/upload/profilePhoto/${member.id}.png" alt="" id="profileImg"/></c:if>
					       	<p class="cursor" onclick="location.href='${pageContext.request.contextPath}/mypage/myinfo.do';">${member.nickname}님<i class="bi bi-chevron-right"></i></p>
					       	<img src="https://i.ibb.co/HNQhz98/pencil.png" alt="" id="edit" class="cursor" onclick="location.href='${pageContext.request.contextPath}/mypage/myinfo/profileUpdate.do';"/>
					    	<img src="https://i.ibb.co/S7TZCYh/coding.png" alt="" id="badge" class="cursor" onclick="location.href='${pageContext.request.contextPath}/mypage/myinfo/activityBadge.do';"/>
					    </section>
					    <!-- profile info -->
				        <section>
				        	<p><span>이메일</span><br/><span>${member.email}</span></p>
					        <p><span>한줄소개</span><br/><span>${member.intro}</span></p>
					        <button id="url" onclick="location.href='${member.url}';">${member.url}</button>
				        </section>
				        <hr/>
				       	<!-- login info / logout button -->
				       	<section>
				       		<form:form
					    		method="POST"
					    		action="${pageContext.request.contextPath}/member/memberLogout.do">
					        	<p><img src="" alt="" />(으)로 로그인</p>
					        	<button type="submit" class="col-9 cursor">로그아웃</button>
				        	</form:form>
				       	</section>
			    	</article>
				     	
		      		<!-- activity badge -->
			   		<article class="col-9" id="info">
		      		<h4 id="breadcrumb"><a href="${pageContext.request.contextPath}/mypage/myinfo.do">나의 정보</a> <i class="bi bi-chevron-right"></i> <span>활동 배지</span></h4>
			    		<!-- badge list -->
			    		<c:forEach var="i" begin="1" end="10" step="1">
			    			
			    		</c:forEach>
			    	</article>
			    	
				</div>
			</div>
			
<jsp:include page="/WEB-INF/views/mypage/common/footer.jsp"></jsp:include>