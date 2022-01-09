<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<fmt:requestEncoding value="utf-8"/>
<!-- header include -->
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<!-- sidebar include -->
<jsp:include page="/WEB-INF/views/community/common/communitySidebar.jsp"></jsp:include>
<!-- css -->
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

/* 타입별 검색 - 제목 */
div#search-title {
	display: inline-block;
}

/* 타입별 검색 - 내용 */
div#search-content {
	display: none;
}

/* 타입별 검색 - 작성자(별명) */
div#search-nickname {
	display: none;
}
</style>


<!-- 본문 시작 -->
<div class="container-fluid">
	<div class="row">
		<div class="col-md-12">
			<!-- 헤더 시작 -->
			<div class="row">
				<div class="col-md-12">
					<div class="page-header">
						<h1>
							<strong>Q&A</strong>
						</h1>
					</div>
				</div>
			</div>
			<!-- 헤더 끝 -->
			
			<hr />
					
			<!-- 검색창 시작-->
			<div class="row py-3 border-bottom m-0 search justify-content-center" id="search-container">
				<select id="searchType" class="custom-select" style="width: 100px; float: right; cursor: pointer;">
				  	<option value="title">제목</option>
				  	<option value="content">내용</option>
				  	<option value="nickname">작성자</option>
				</select>
				<!-- 제목검색 시작 -->
				<div id="search-title" class="search-type">
		            <form class="form-inline search-form"> 
		            	<input type="hidden" name="searchType" value="title" />
						<input class="form-control" type="search" name="searchKeyword" placeholder="Search" aria-label="Search">
						<input type="hidden" name="pageCode" value="3" />
						<button class="btn btn-outline-primary my-2 my-sm-0 search-btn" type="submit" >검색</button>
				  	</form>
		        </div>
		        <!-- 제목검색 종료 -->
		        <!-- 내용검색 시작 -->
		        <div id="search-content" class="search-type">
		            <form class="form-inline search-form"> 
		            	<input type="hidden" name="searchType" value="content" />
						<input class="form-control" type="search" name="searchKeyword" placeholder="Search" aria-label="Search">
						<input type="hidden" name="pageCode" value="3" />
						<button class="btn btn-outline-primary my-2 my-sm-0 search-btn" type="submit" >검색</button>
				  	</form>
		        </div>
		        <!-- 내용검색 종료 -->
		        <!-- 작성자검색 시작 -->
		        <div id="search-nickname" class="search-type">
		            <form class="form-inline search-form"> 
		            	<input type="hidden" name="searchType" value="nickname" />
						<input class="form-control" type="search" name="searchKeyword" placeholder="Search" aria-label="Search">
						<input type="hidden" name="pageCode" value="3" />
						<button class="btn btn-outline-primary my-2 my-sm-0 search-btn" type="submit" >검색</button>
				  	</form>
		        </div>
		        <!-- 작성자검색 종료 -->	
			</div>
			<!-- 검색창 끝 -->
			
	
			
			<br />
			
			<!-- 상단 탭 시작 -->	
			<nav>
			  <div class="nav nav-tabs" id="nav-tab" role="tablist">
			    <a class="nav-item nav-link active" id="nav-home-tab" data-toggle="tab" href="#nac-home" role="tab" aria-controls="nav-home" aria-selected="true">최신순</a>
			    <a class="nav-item nav-link" id="nav-comment-tab" data-toggle="tab" href="#nav-profile" role="tab" aria-controls="nav-profile" aria-selected="false" data-value="2">답변많은순</a>
			    <a class="nav-item nav-link" id="nav-like-tab" data-toggle="tab" href="#nav-like" role="tab" aria-controls="nav-contact" aria-selected="false" data-value="2">좋아요순</a>
			    <a class="nav-item nav-link" id="nav-like-tab" data-toggle="tab" href="#nav-like" role="tab" aria-controls="nav-contact" aria-selected="false" data-value="2">최근답변순</a>
			  </div>
			</nav>
			
			<br />
			<!-- 상단 탭 끝 -->
			
		</div>
	</div>
	
	<div id="totalCountContainer">
	 <p>총 게시물 수 : ${totalContent}</p>			  
	</div>
	
	<br />
			
	<!-- 리스트 시작 -->
	<div id="freeboardContainer">
	<table id="tbl-board" class="table table-hover">
		<tr style="background-color: #1A81FF; color: white;">
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
		<tbody id = "tbody">
			<c:forEach items="${list}" var="communityEntity">
				<tr data-no="${communityEntity.communityNo}" style="cursor: pointer;" class="whynot">
					<td>${communityEntity.communityNo}</td>
					<td>${communityEntity.title}</td>
					<td>${communityEntity.nickname}</td>
					<td><fmt:formatDate value="${communityEntity.enrollDate}" pattern="yy-MM-dd"/></td>
					<td><i class="fas fa-heart"></i> ${communityEntity.likeCount}</td>
					<td>${communityEntity.viewCount}</td>
					<td>${communityEntity.commentCount}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>  
	<!-- 리스트 끝 -->
	
	<jsp:include page="/WEB-INF/views/community/common/writeModal.jsp">
		<jsp:param value="" name="title"/>
	</jsp:include>
	
	<!-- 페이징 시작 -->
	<div>
		${pagebar}
	</div>
	<!-- 페이징 끝 -->
</div>
</div>

				
<script src="${pageContext.request.contextPath}/resources/js/community/communityQnAList/scripts.js"></script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
