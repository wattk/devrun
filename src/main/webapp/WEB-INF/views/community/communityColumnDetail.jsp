<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="" name="title"/>
</jsp:include>
<jsp:include page="/WEB-INF/views/community/common/communitySidebar.jsp">
	<jsp:param value="" name="title"/>
</jsp:include>
<link href="${pageContext.request.contextPath}/resources/css/community/communityColumnDetail/bootstrap.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/community/style.css" rel="stylesheet">



    <div class="container-fluid container">
	<div class="row">
		<div class="col-md-12">
			<div class="page-header">
				<h1>
					게시글 상세보기 
				</h1>
			</div>
		</div>
	</div>

	<div class="row">
		<div class="col-md-12">
			<h3>
				내용
			</h3>
			<div class="row" id="contentName">
				<div class="col-md-4">
					작성자 아이디
				</div>
				<div class="col-md-3">
					작성자 등급
				</div>
				<div class="col-md-3">
					작성일
				</div>
				<div class="col-md-1"> 
					<button type="button" class="btn btn-danger">신고하기</button>
				</div>
				<div class="col-md-1">
					<button type="button" class="btn btn-primary" id="likeButton">좋아요</button>
				</div>
			</div>
			<div class="row">
				<div class="col-md-12">
					내용
					내용
					내용
					내용
					내용
					내용
					내용

				</div>
			</div>
			<div class="row">
				<div class="col-md-12" id="bottomButton">
					<button type="button" class="btn btn-primary btn-lg">답글쓰기</button>
					<button type="button" class="btn btn-secondary btn-lg">주문하기</button>
					<button type="button" class="btn btn-primary btn-lg">삭제하기</button>
					<button type="button" class="btn btn-secondary btn-lg">목록보기</button>
				</div>
			</div>
		</div>
	</div>
</div>

    <script src="${pageContext.request.contextPath}/js/community/communityColumnDetail/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/community/communityColumnDetail/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/community/communityColumnDetail/scripts.js"></script>
  </body>
</html>
		
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
