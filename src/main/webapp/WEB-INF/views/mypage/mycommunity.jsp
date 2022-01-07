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
								<a id="postListTab" class="nav-link active bi bi-journal-text" data-toggle="tab" href="#postList" role="tab" aria-controls="postList" aria-selected="true"> 내가 쓴 글</a>
							</li>
							<li class="nav-item col-6">
								<a id="likeListTab" class="nav-link  bi bi-heart" data-toggle="tab" href="#likeList" role="tab" aria-controls="likeList" aria-selected="false"> 좋아요</a>
							</li>
						</ul>
					</nav>
					
					<%-- tap container --%>
					<section class="col-12 tab-content" id="comnunityTabContainer">
						
						<%-- my post list --%>
						<div class="tab-pane fade show active col-12" id="postList">
							<div class="row">
							
								<%-- select type --%>
								<div id="selectType" class="row col-10">
									<select name="selectType" class="row custom-select">
							            <option value="latest">최신순</option>
							            <option value="viewCount">조회순</option>
							            <option value="likeCount">좋아요순</option>
							            <option value="oldest">오래된순</option>
							        </select>
								</div>
								
								<article class="col-10" id="communityList">
									<!-- 몇가지 조건에 따른 보기 제공 -->
									<table class="table">
					       				<c:if test="${totalContent ne 0}">
		       								<c:forEach items="${postList}" var="community">
						       					<tr>
							       					<td>
							       						<div>
							       							<fmt:formatDate value="${community.enrollDate}" pattern="yy.MM.dd HH:mm"/> | 
							       							<c:if test="${community.pageCode == 1}">칼럼</c:if>
							       							<c:if test="${community.pageCode == 2}">QnA</c:if>
							       							<c:if test="${community.pageCode == 3}">스터디</c:if>
							       							<c:if test="${community.pageCode == 4}">자유게시판</c:if>
							       						</div>
							       						<div id="postTitle">${community.title}</div>
							       						<div id="postContent">${community.content}</div>
							       					</td>
							       					<td>
							       						<span class="bi bi-chat-dots"> ${community.commentCount} </span>&nbsp;
							       						<span class="bi bi-eye"> ${community.viewCount} </span>&nbsp;
							       						<span class="bi bi-heart-fill"> ${community.likeCount} </span>
							       					</td>
							       				</tr>
							       			</c:forEach>
							       		</c:if>
							       		<c:if test="${totalContent eq 0}">
				       						<tr id="noList"><td>커뮤니티 활동 내역이 없습니다.</td></tr>
				       					</c:if>
					       			</table>
					       			
					       			<!-- pagebar : 내가 쓴 글이 있는 경우에만 제공 -->
	       							<c:if test="${totalContent ne 0}">${pagebar}</c:if>
					       			
						    	</article>
						    	
							</div>
						</div>
						
						<%-- my like list --%>
						<div class="tab-pane fade col-12" id="likeList">
							<div class="row">
							
								<%-- select type --%>
								<div id="selectType" class="row col-10">
									<select class="row custom-select">
							            <option value="latest">최신순</option>
							            <option value="viewNum">조회순</option>
							            <option value="likeNum">좋아요순</option>
							            <option value="oldest">오래된순</option>
							        </select>
								</div>
								
								<article class="col-10" id="communityList">
									<!-- 몇가지 조건에 따른 보기 제공 -->
									<table class="table">
					       				<%-- <c:if test="${totalContent ne 0}">
		       								<c:forEach items="${likeList}" var="community">
						       					<tr>
							       					<td>
							       						<div>
							       							<fmt:formatDate value="${community.enrollDate}" pattern="yy.MM.dd HH:mm"/> | 
							       							<c:if test="${community.pageCode eq 1}">칼럼</c:if>
							       							<c:if test="${community.pageCode eq 1}">QnA</c:if>
							       							<c:if test="${community.pageCode eq 1}">스터디</c:if>
							       							<c:if test="${community.pageCode eq 1}">자유게시판</c:if>
							       						</div>
							       						<div id="postTitle">${community.title}</div>
							       						<div id="postContent">${community.content}</div>
							       					</td>
							       					<td>
							       						<span class="bi bi-chat-dots"> ${community.content} </span>&nbsp;
							       						<span class="bi bi-eye"> ${community.viewCount} </span>&nbsp;
							       						<span class="bi bi-heart-fill"> ${community.likeCount} </span>
							       					</td>
							       				</tr>
						       				</c:forEach>
						       			</c:if>
						       			<c:if test="${totalContent eq 0}">
				       						<tr id="noList"><td>커뮤니티에 좋아요 한 내역이 없습니다.</td></tr>
				       					</c:if> --%>
					       			</table>
						    	</article>
						    	
							</div>
						</div>

					</section>
					
				</div>
			</div>

<script>
/**
 * selectType별 change이벤트 핸들러를 이용해서 해당 div만 보여주고 나머지는 감춘다.
 */
$("#selectType select").change(function(e){
	const selectType = $(e.target).val();
	console.log(selectType);
	
	$.ajax({
		url : "${pageContext.request.contextPath}/mypage/mycommunity/selectType",
		data : selectType,
		constentType : "application/json; charset=utf-8",
		success(data){
			console.log(data);
			
		},
		error:console.log
	});
	
});
</script>

<jsp:include page="/WEB-INF/views/mypage/common/footer.jsp"></jsp:include>