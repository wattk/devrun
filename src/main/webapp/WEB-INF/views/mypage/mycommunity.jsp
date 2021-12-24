<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/mypage/common/header.jsp">
	<jsp:param value="나의 커뮤니티" name="title"/>
</jsp:include>

<!-- CSS import -->
<link href="${pageContext.request.contextPath}/resources/css/mypage/mycommunity.css" rel="stylesheet">

			<%-- my community --%>
			<div class="col-12" id="mycommunity">
				<div class="row">
				나의 커뮤니티
				</div>
			</div>

<jsp:include page="/WEB-INF/views/mypage/common/footer.jsp"></jsp:include>