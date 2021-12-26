<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<jsp:include page="/WEB-INF/views/mypage/common/header.jsp">
	<jsp:param value="나의 커뮤니티" name="title"/>
</jsp:include>

<!-- CSS import -->
<link href="${pageContext.request.contextPath}/resources/css/mypage/mycommunity.css" rel="stylesheet">

			<%-- my community --%>
			<div class="col-12" id="mycommunity">
				<div class="row">
				
					<%-- tap button --%>
					<nav id="mycommunityTab" class="col-12">
						<ul class="nav nav-tabs">
							<li class="nav-item col-6">
								<a class="nav-link active bi bi-journal-text" id="postListTab" data-toggle="tab" href="#postList" role="tab" aria-controls="postList" aria-selected="true"> 내가 쓴 글</a>
							</li>
							<li class="nav-item col-6">
								<a class="nav-link  bi bi-heart" id="likeListTab" data-toggle="tab" href="#likeList" role="tab" aria-controls="likeList" aria-selected="false"> 좋아요</a>
							</li>
						</ul>
					</nav>
					
					<%-- tap container --%>
					<section class="col-12 tab-content" id="tabContainer">
					
						<%-- my post list --%>
						<div class="tab-pane fade show active col-12" id="postList">
							<div class="row">
								
								<article class="col-10" id="communityList">
									<!-- 몇가지 조건에 따른 보기 제공 -->
									<table class="table">
					       				<c:forEach var="i" begin="1" end="10" step="1">
					       					<tr>
						       					<td>
						       						<div>2021.12.25 20:45 | 자유게시판</div>
						       						<div id="postTitle">OO키보드 사용 후</div>
						       						<div id="postContent">내용입니다 내용입니다 내용입니다 내용입니다 내용입니다...</div>
						       					</td>
						       					<td>
						       						<span class="bi bi-chat-dots"> 5 </span>&nbsp;
						       						<span class="bi bi-eye"> 60 </span>&nbsp;
						       						<span class="bi bi-heart"> 2 </span>
						       					</td>
						       				</tr>
						       			</c:forEach>
					       			</table>
						    	</article>
						    	
							</div>
						</div>
						
						<%-- my like list --%>
						<div class="tab-pane fade col-12" id="likeList">
							<div class="row">
								
								<article class="col-10" id="communityList">
									<!-- 몇가지 조건에 따른 보기 제공 -->
									<table class="table">
					       				<c:forEach var="i" begin="1" end="10" step="1">
					       					<tr>
						       					<td>
						       						<div>2021.12.25 20:45 | 자유게시판</div>
						       						<div id="postTitle">OO키보드 사용 후</div>
						       						<div id="postContent">내용입니다 내용입니다 내용입니다 내용입니다 내용입니다...</div>
						       					</td>
						       					<td>
						       						<span class="bi bi-chat-dots"> 5 </span>&nbsp;
						       						<span class="bi bi-eye"> 60 </span>&nbsp;
						       						<span class="bi bi-heart-fill"> 2 </span>
						       					</td>
						       				</tr>
						       			</c:forEach>
					       			</table>
						    	</article>
						    	
							</div>
						</div>

					</section>
					
				</div>
			</div>

<jsp:include page="/WEB-INF/views/mypage/common/footer.jsp"></jsp:include>