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
<script>
	// summernote 웹 에디터 로딩
	$(document).ready(function(){
		$('#summernote').summernote({
			height: 300, // 에디터 높이
			minHeight: null, // 최소 높이
			maxHeight: null, // 최대 높이
			focus: true, // 에디터 로딩 후 포커스를 맞출 지 여부
			lang: "ko-KR", // 한글 설정
		});
		
		// 읽기 전용화 --> 비활성화 --> disable
		$('#summernote').summernote('disable');
	});
	
	
	// #btnComment 버튼을 'click'하게 되면 #form을 전송(.submit)
	$(document).on('click', '#btnComment', function(e){
		console.log("클릭 이벤트 발생!");
		e.preventDefault();
		//freeBoardForm : form name값
		$(document.freeboardCommentForm).submit();
	});
	
	// 댓글 유효성 검사
	function freeboardCommentValidate(){
		var $content = $("[name=content]");
		// 슬래시(/) "사이"에는 매칭시킬 "패턴"을 써준다.
		// 슬래시(/) "다음"에는 옵션을 설정하는 "플래그"를 써준다.
		// ^문자열 : 특정 문자열로 시작(괄호 없음 주의!)
		// . : 모든 문자열
		// | : OR
		// \n : 줄바꿈
		if (/^(.|\n)+$/.test($content.val()) == false){
			alert("내용을 입력하세요");
			return false;
		}
		return true;
	}
	
	
			
</script>
<style>
	#likeButton, #reportButton {
		width: 90px;
	}
	.card-body li:hover {
	background: lightgray;
	}
	.card-body button#commentBtn {
		display:none;
	}
	.card-body li:hover button#commentBtn {
		display: inline;
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
			<div class="row">
				<div class="col-md-12 text-center"> 
					<button type="button" class="btn btn-danger" id="reportButton">신고하기</button>
					<button type="button" class="btn btn-primary" id="likeButton">좋아요</button>
				</div>
			</div>
				<hr />
				
			<div class="row">
				<div class="col-md-12" id="bottomButton">
					<button type="button" class="btn btn-primary btn-lg">답글쓰기</button>
					<button type="button" class="btn btn-secondary btn-lg">수정하기</button>
					<button type="button" class="btn btn-primary btn-lg">삭제하기</button>
					<button type="button" class="btn btn-secondary btn-lg">목록보기</button>
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
			    <li class="list-group-item">
				<div class="form-inline mb-2">
					<label for="replyId"><i class="fa fa-user-circle-o fa-2x"></i></label>
				</div>
				<form:form
					name="freeboardCommentForm"
					action="${pageContext.request.contextPath}/community/communityFreeboardCommentEnroll.do"
					method="POST"
					onsubmit="return freeboardCommentValidate();">
					<textarea class="form-control" name="content" id="comment" rows="2"></textarea>
					<button type="button" class="btn btn-dark mt-3 float-right" id="btnComment">등록</button>
					
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
								<button type="button" class="btn btn-dark mt-3 float-right" id="commentBtn" >답글</button>
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

<script src="${pageContext.request.contextPath}/resources/js/community/communityColumnDetail/scripts.js"></script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
