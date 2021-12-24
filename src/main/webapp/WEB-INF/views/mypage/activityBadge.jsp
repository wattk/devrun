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
<sec:authentication property="principal" var="member"/>

					<div class="row">
						<!-- 회원 정보 -->
			       		<div class="col-3">
			       			<!-- 프로필 이미지 : 프로필 이미지가 null일 경우, 기본 이미지 출력 -->
			       			<div id="profileImg">
			       				<c:if test="${member.proPhoto eq null}"><i class="bi bi-person-circle"></i></c:if>
					       		<c:if test="${member.proPhoto ne null}"><img src="${member.proPhoto}" alt=""/></c:if>
					       		<i class="bi bi-pencil-square"></i>
					        </div>
					        <div>
					        	<div onclick="location.href='#';">${member.nickname}님<i class="bi bi-chevron-right"></i></div>
					        	<p>이메일<br/>${member.email}</p>
						        <p>한줄소개<br/>${member.intro}</p>
						        <button onclick="location.href='${member.url}';">${member.url}</button>
					        </div>
				        	<!-- 로그인 정보/로그아웃 버튼 -->
				        	<div class="">
					        	<img src="" alt="" />
					        	<p>(으)로 로그인</p>
					        	<button class="btn">로그아웃</button>
				        	</div>
			       		</div>
			       		<!-- 회원 활동 관련 정보 -->
			       		<div class="col-10">
			       			
			       		</div>
		       		</div>

<jsp:include page="/WEB-INF/views/mypage/common/footer.jsp"></jsp:include>