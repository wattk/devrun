<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="" name="title"/>
</jsp:include>
<jsp:include page="/WEB-INF/views/community/common/communitySidebar.jsp">
	<jsp:param value="" name="title"/>
</jsp:include>
<!-- include summernote css/js -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.20/summernote-lite.min.css" integrity="sha512-ZbehZMIlGA8CTIOtdE+M81uj3mrcgyrh6ZFeG33A4FHECakGrOsTPlPQ8ijjLkxgImrdmSVUHn1j+ApjodYZow==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.20/summernote-lite.min.js" integrity="sha512-lVkQNgKabKsM1DA/qbhJRFQU8TuwkLF2vSN3iU/c7+iayKs08Y8GXqfFxxTZr1IcpMovXnf2N/ZZoMgmZep1YQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="${pageContext.request.contextPath}/resources/js/summernote/lang/summernote-ko-KR.js"></script>
<style>
	#likeButton, #reportButton {
		width: 90px;
	}
	.card-body li:hover {
	background: lightgray;
	cursor: pointer;
	}
	.card-body button#commentBtn {
		display:none;
	}
	.card-body li:hover button#commentBtn {
		display: inline;
		cursor: pointer;
	}
	textarea {
		resize: none;
	}
</style>
<!-- authentication에 저장된(member) principal 객체를 member 변수에 담아서 사용한다. -->
<sec:authentication property="principal" var="member"/>

    <div class="container-fluid">
	<div class="row">
		<div class="col-md-12">
			<div class="page-header">
				<h2>
					<strong>${communityEntity.title}</strong>
				</h2>
			</div>
		</div>
	</div>

	<hr />
	
	<div class="row">
		<div class="col-md-12">
			<div class="row align-self-center" id="contentName">
				<div class="col-md-4">
					<h4>
						<strong>
							작성자 : ${communityEntity.nickname}
						</strong>
					</h4>
				</div>
				<div class="col-md-4">
					<h4>
						<strong>
							작성자 등급 : 
							<!-- c:if 태그로 회원 권한에 따른 활동 등급명 분기 -->
		                    <c:if test="${communityEntity.authority eq 'ROLE_M1'}">일반회원</c:if>
		                    <c:if test="${communityEntity.authority eq 'ROLE_M2'}">지식인</c:if>
		                    <c:if test="${communityEntity.authority eq 'ROLE_AM'}">관리자</c:if>
		                </strong>
                    </h4>
				</div>
				<div class="col-md-4">
					<h4><strong>작성일</strong>
					<fmt:formatDate value="${communityEntity.enrollDate}" pattern="yyyy-MM-dd HH:mm"/>
					</h4>
				</div>
			</div>
			
			<hr />
			
			<div class="row">
				<div class="col-md-12">
					<textarea class="form-control" rows="5" name="content" id="summernote" readonly="readonly">${communityEntity.content}</textarea>
				</div>
				
			</div>
			
			<hr />
			
			<div class="row">
				<div class="col-md-12">
					<label for="tag"><strong>해시태그</strong></label>
					<input type="text" class="form-control" name="hashtag" id="hashtag" placeholder="태그를 입력해 주세요">
				</div>
			</div>
			
			<hr />
			<div class="row" >
				<div class="col-md-12 row justify-content-end">
					<!-- 스터디 게시판이고 글쓴이 본인일 경우에만 노출 -->
					<!-- 모집중 : Y(default), 모집완료 : N -->
					<!-- 모집완료 버튼(Y일 때) -->
					<c:if test="${communityEntity.pageCode eq 3 && communityEntity.memberNo eq member.memberNo && communityEntity.studyJoinYn eq 'Y'}"> 
						<button type="button" class="btn btn-success" style="margin-right: 10px;" id="changeJoinYn" 
							data-study-join-yn="${communityEntity.studyJoinYn}"
							data-community-no="${communityEntity.communityNo}">모집완료</button>
					</c:if>
					<!-- 모집중 버튼(N일 때) -->
					<c:if test="${communityEntity.pageCode eq 3 && communityEntity.memberNo eq member.memberNo && communityEntity.studyJoinYn eq 'N'}"> 
						<button type="button" class="btn btn-success" style="margin-right: 10px;" id="changeJoinYn" 
							data-study-join-yn="${communityEntity.studyJoinYn}"
							data-community-no="${communityEntity.communityNo}">모집중</button>
					</c:if>
					<button style="margin-right: 10px;" type="button" class="btn btn-danger" data-toggle="modal" data-target="#exampleModal" id="reportButton">신고하기</button>
					<jsp:include page="/WEB-INF/views/community/common/reportModal.jsp">
						<jsp:param value="" name="title"/>
					</jsp:include>
					
					<button type="button" class="btn btn-primary" id="likeButton" 
						data-community-no="${communityEntity.communityNo}"
						data-member-no="${communityEntity.memberNo}"
						data-like-yes-no="${likeYesNo}">좋아요</button>
				</div>
			</div>
				<hr />
				
			<div class="row">
				<div class="col-md-12" id="bottomButton">
					<button type="button" class="btn btn-secondary btn-lg" id="communityUpdateBtn">수정하기</button>
					<!-- 회원일 경우 -->
					<sec:authorize access="hasAnyRole('M1', 'M2')">
						<!-- 회원이고 글쓴이 본인일 경우 -->
						<c:if test="${communityCommentEntity.memberNo eq member.memberNo}">
							<button type="button" class="btn btn-secondary btn-lg communityDeleteBtn"
								data-community-no = "${communityEntity.communityNo}"
								data-page-code= "${communityEntity.pageCode}">삭제하기</button>
						</c:if>
					</sec:authorize>
					<!-- 관리자일 경우 -->
					<sec:authorize access="hasRole('AM')">
						<button type="button" class="btn btn-secondary btn-lg communityDeleteBtn"
								data-community-no = "${communityEntity.communityNo}"
								data-page-code= "${communityEntity.pageCode}">삭제하기</button>
					</sec:authorize>
					<button type="button" class="btn btn-secondary btn-lg" onclick="location.href = '${pageContext.request.contextPath}/community/communityStudyList.do'">목록보기</button>
				</div>
			</div>
		</div>
	</div>
	
	<hr />
	
	<!-- 회원일때만 댓글 등록창이 보이게끔 설정 -->
	<sec:authorize access="hasAnyRole('M1', 'M2', 'AM')">
	<!-- 댓글 등록 시작 -->
	<div class="card mb-2">
		<div class="card-header bg-light">
			<i class="fa fa-comment fa"></i> 댓글 작성
		</div>
		<div class="card-body">
			<ul class="list-group list-group-flush">
			    <li class="list-group-item" id="comment-li">
				<div class="form-inline mb-2">
					<label for="replyId"><i class="fa fa-user-circle-o fa-2x"></i></label>
				</div>
				<form:form
					name="commentForm"
					action="${pageContext.request.contextPath}/community/communityCommentEnroll.do"
					method="POST"
					>
					<textarea class="form-control" name="content" id="comment" rows="2"></textarea>
					<button type="button" class="btn btn-dark mt-3 float-right" id="btnComment" onclick="commentValidate()">등록</button>
					
					<input type="hidden" name="commentLevel" value="1" />
					<input type="hidden" name="memberNo" value='<sec:authentication property="principal.memberNo" />' />
					<!-- <input type="hidden" name="memberNo" value='<c:if test="${member ne null}"><sec:authentication property="principal.memberNo" /></c:if>'>  -->
					<input type="hidden" name="communityNo" value="${communityEntity.communityNo}" />
				</form:form>
			    </li>
			</ul>
		</div>
	</div>
	<!-- 댓글 등록 끝 -->
	</sec:authorize>
	
	<!-- 댓글 시작 -->
	<div class="card mb-2">
		<div class="card-header bg-light">
		        <i class="fa fa-comment fa"></i> 댓글
		</div>
		<div class="card-body">
			<c:if test="${null ne freeboardCommentList  && not empty freeboardCommentList}">
				<c:forEach items="${freeboardCommentList}" var="communityCommentEntity">
					<c:choose>
						<c:when test="${communityCommentEntity.commentLevel eq 1}">
							<ul class="list-group list-group-flush" id="level1">
						    <li class="list-group-item" id="commentList">
							<div class="form-inline mb-2">
								<label for="replyId"><i class="fa fa-user-circle-o fa-2x"></i>&nbsp;&nbsp;<strong>${communityCommentEntity.nickname}</strong></label>
								&nbsp;&nbsp;<fmt:formatDate value="${communityCommentEntity.regDate}" pattern="yyyy-MM-dd HH:mm"/>
							</div>
							<textarea class="form-control" id="exampleFormControlTextarea1" rows="1" readonly="readonly">${communityCommentEntity.content}</textarea>
							<!-- 회원일때만 답글 버튼이 나타나도록 처리 -->
							<sec:authorize access="hasAnyRole('M1', 'M2', 'AM')">
								<div class="row float-right">
								<button type="button" onclick="firstReply()" class="btn btn-dark mt-3 float-right btnReComment" value="${communityCommentEntity.commentNo}">답글</button>&nbsp;
								<!-- 회원일 경우 -->
								<sec:authorize access="hasAnyRole('M1', 'M2')">
									<!-- 회원이고 글쓴이 본인일 경우 -->
									<c:if test="${communityCommentEntity.memberNo eq member.memberNo}">				
										<button type="button" class="btn btn-dark mt-3 float-right btnCommentDelete" value="${communityCommentEntity.commentNo}">삭제</button>&nbsp;
									</c:if>
								</sec:authorize>
								<!-- 관리자일 경우 -->
								<sec:authorize access="hasRole('AM')">
									<button type="button" class="btn btn-dark mt-3 float-right btnCommentDelete" value="${communityCommentEntity.commentNo}">삭제</button>&nbsp;
								</sec:authorize>
									<button type="button" class="btn btn-dark mt-3 float-right" data-toggle="modal" data-target="#exampleModal">신고</button>&nbsp;
								</div>
							</sec:authorize>
						    </li>
						</ul>
						</c:when>
						<c:otherwise>
							<ul class="list-group list-group-flush" id="level2">
							    <li class="list-group-item" id=level2Reply style="padding-left: 100px;">
								<div class="form-inline mb-2">
									<label for="replyId"><i class="fa fa-user-circle-o fa-2x"></i>&nbsp;&nbsp;<strong>${communityCommentEntity.nickname}</strong></label>
									&nbsp;&nbsp;<fmt:formatDate value="${communityCommentEntity.regDate}" pattern="yyyy-MM-dd HH:mm"/>
								</div>
								<textarea class="form-control" id="exampleFormControlTextarea1" rows="1" readonly="readonly">${communityCommentEntity.content}</textarea>
								<div class="row float-right">
								<!-- 회원일 경우 -->
								<sec:authorize access="hasAnyRole('M1', 'M2')">
									<!-- 회원이고 글쓴이 본인일 경우 -->
									<c:if test="${communityCommentEntity.memberNo eq member.memberNo}">				
										<button type="button" class="btn btn-dark mt-3 float-right btnCommentDelete" value="${communityCommentEntity.commentNo}">삭제</button>&nbsp;
									</c:if>
								</sec:authorize>
								<!-- 관리자일 경우 -->
								<sec:authorize access="hasRole('AM')">
									<button type="button" class="btn btn-dark mt-3 float-right btnCommentDelete" value="${communityCommentEntity.commentNo}">삭제</button>&nbsp;
								</sec:authorize>
									<button type="button" class="btn btn-dark mt-3 float-right" data-toggle="modal" data-target="#exampleModal">신고</button>&nbsp;
								</div>
							    </li>
							</ul>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</c:if>
		</div>
	</div>	
	<!-- 댓글 끝 -->

</div>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
