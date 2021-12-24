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
<!-- 폰트어썸 CDN -->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.14.0/css/all.css" integrity="sha384-HzLeBuhoNPvSl5KYnjx0BT+WB0QEEqLprO+NBkkk5gbc67FTaL7XIGa2w1L0Xbgc" crossorigin="anonymous">
<style>
.input-group {
	justify-content: center;
}
td, th {
	text-align: center;
}
</style>
<script>
// 글쓰기 폼으로 이동
function goFreeboardForm(){
	location.href = "${pageContext.request.contextPath}/community/communityFreeboardForm.do";
}

// 게시글 상세보기로 이동
/**
 * event boubling 기반 핸들링
 */
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
			    <button class="btn btn-outline-secondary dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">전체</button>
			    <div class="dropdown-menu">
			      <a class="dropdown-item" href="#">제목</a>
			      <a class="dropdown-item" href="#">작성자</a>
			      <a class="dropdown-item" href="#">내용</a>
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
			  <p>총 ${totalContent}개의 게시물이 있습니다.</p>
			  <div class="nav nav-tabs" id="nav-tab" role="tablist">
			    <a class="nav-item nav-link active" id="nav-home-tab" data-toggle="tab" href="#nav-home" role="tab" aria-controls="nav-home" aria-selected="true">최신순</a>
			    <a class="nav-item nav-link" id="nav-profile-tab" data-toggle="tab" href="#nav-profile" role="tab" aria-controls="nav-profile" aria-selected="false">댓글 많은 순</a>
			    <a class="nav-item nav-link" id="nav-contact-tab" data-toggle="tab" href="#nav-contact" role="tab" aria-controls="nav-contact" aria-selected="false">좋아요 순</a>
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
			<th class="col-1">번호</th>
			<th class="col-3">제목</th>
			<th class="col-1">작성자</th>
			<th class="col-1">작성일</th>
			<th class="col-1">좋아요</th> 
			<th class="col-1">조회수</th>
			<th class="col-1">답변개수</th>
		</tr>
		
		<!-- 반복접근할 요소 : items="${list} -->
		<!-- 꺼내면 cmmunityEntity니까 communityEntity라는 이름으로 사용 -->
		<c:forEach items="${list}" var="communityEntity">
			<tr data-no="${communityEntity.communityNo}">
				<td>${communityEntity.communityNo}</td>
				<td>${communityEntity.title}</td>
				<td>${communityEntity.nickname}</td>
				<td><fmt:formatDate value="${communityEntity.enrollDate}" pattern="yy-MM-dd HH:mm"/> </td>
				<td><i class="fas fa-heart"></i> ${communityEntity.likeCount}</td>
				<td>${community.viewCount}</td>
				<td>만들어야함</td>
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
		${pagebar}
	</div>
	<!-- 페이징 끝 -->
</div>
</div>

<script src="${pageContext.request.contextPath}/resources/js/community/communityQnAList/scripts.js"></script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
