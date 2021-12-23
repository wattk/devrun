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
<link href="${pageContext.request.contextPath}/resources/css/community/style.css" rel="stylesheet">
<style>
.input-group {
	justify-content: center;
}
</style>
<script>
function goFreeboardForm(){
	location.href = "${pageContext.request.contextPath}/community/communityFreeboardForm.do";
}
</script>

<!-- 본문 시작 -->
<div class="container-fluid">
	<div class="row">
		<div class="col-md-12">
			<!-- 헤더 시작 -->
			<div class="row">
				<div class="col-md-12">
					<div class="page-header">
						<h1>
							<strong>자유게시판</strong>
						</h1>
					</div>
				</div>
			</div>
			<!-- 헤더 끝 -->
			
			<hr />
					
			<!-- 검색창 시작-->
			<div class="input-group mb-3" id="search">
			  <div class="input-group-prepend">
			    <button class="btn btn-outline-secondary dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Dropdown</button>
			    <div class="dropdown-menu">
			      <a class="dropdown-item" href="#">Action</a>
			      <a class="dropdown-item" href="#">Another action</a>
			      <a class="dropdown-item" href="#">Something else here</a>
			      <div role="separator" class="dropdown-divider"></div>
			      <a class="dropdown-item" href="#">Separated link</a>
			    </div>
			  </div>
			  <div>
			  	<input type="text" class="form-control" aria-label="Text input with dropdown button">
			  </div>
			  <button type="button" class="btn btn-primary">검색</button>
			</div>
			<!-- 검색창 끝 -->
			
			<!-- 상단 탭 시작 -->	
			<nav>
			  <div class="nav nav-tabs" id="nav-tab" role="tablist">
			    <a class="nav-item nav-link active" id="nav-home-tab" data-toggle="tab" href="#nav-home" role="tab" aria-controls="nav-home" aria-selected="true">Home</a>
			    <a class="nav-item nav-link" id="nav-profile-tab" data-toggle="tab" href="#nav-profile" role="tab" aria-controls="nav-profile" aria-selected="false">Profile</a>
			    <a class="nav-item nav-link" id="nav-contact-tab" data-toggle="tab" href="#nav-contact" role="tab" aria-controls="nav-contact" aria-selected="false">Contact</a>
			  </div>
			</nav>
			<div class="tab-content" id="nav-tabContent">
			  <div class="tab-pane fade show active" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab">...</div>
			  <div class="tab-pane fade" id="nav-profile" role="tabpanel" aria-labelledby="nav-profile-tab">...</div>
			  <div class="tab-pane fade" id="nav-contact" role="tabpanel" aria-labelledby="nav-contact-tab">...</div>
			</div>
			<!-- 상단 탭 끝 -->
			
		</div>
	</div>
	
	
	<!-- 리스트 시작 -->
	<table id="tbl-board" class="table table-striped table-hover">
		<tr>
			<th class="text-center">번호</th>
			<th class="text-center">제목</th>
			<th class="text-center">작성자</th>
			<th class="text-center">작성일</th>
			<th class="text-center">좋아요</th> 
			<th class="text-center">조회수</th>
			<th class="text-center">답변개수</th>
		</tr>
		
		<c:forEach items="${list}" var="board">
			<tr data-no="${board.no}">
				<td>${board.no}</td>
				<td>${board.title}</td>
				<td>${board.memberId}</td>
				<td><fmt:formatDate value="${board.regDate}" pattern="yy-MM-dd HH:mm"/> </td>
				<td class="text-center">
					<c:if test="${board.attachCount gt 0}">
						<img src="${pageContext.request.contextPath}/resources/images/file.png" alt="" width="16px"/>
					</c:if>
				</td>
				<td>${board.readCount}</td>
			</tr>
		</c:forEach>
	</table> 
	<!-- 리스트 끝 -->
	
	<!-- 글쓰기 버튼 -->
	<div style="float: right">
		<input type="button" value="글쓰기" id="btn-add" class="btn btn-outline-primary" onclick="goFreeboardForm();"/>
	</div>
	
	<!-- 페이징 시작 -->
	<div>
		<nav aria-label="...">
			<ul class="pagination">
				<li class="page-item disabled">
					<span class="page-link">Previous</span>
				</li>
				<li class="page-item"><a class="page-link" href="#">1</a></li>
				<li class="page-item active" aria-current="page">
					<span class="page-link">2</span>
				</li>
				<li class="page-item"><a class="page-link" href="#">3</a></li>
				<li class="page-item">
					<a class="page-link" href="#">Next</a>
				</li>
			</ul>
		</nav>
	</div>
	<!-- 페이징 끝 -->
</div>
</div>

<script src="${pageContext.request.contextPath}/resources/js/community/communityQnAList/scripts.js"></script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
