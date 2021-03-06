<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/community/common/communitySidebar.jsp"></jsp:include>
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
	
	<!-- 디테일 헤더 시작 -->
	<!-- 제목 -->
    <div class="container-fluid container">
	<div class="row">
		<div class="col-md-12">
			<div class="page-header">
				<h2 class="pt-5">
					<strong>${communityEntity.title}</strong>
				</h2>
			</div>
		</div>
	</div>
	<!-- 제목 -->

	<hr />
	
	<div class="row">
		<div class="col-md-12">
			<div class="row align-self-center" id="contentName">
				<!-- 작성자 -->
				<div class="col-md-4">
					<h4>
						<strong>
							작성자 : ${communityEntity.nickname}
						</strong>
					</h4>
				</div>
				<!-- 작성자 -->
				<!-- 작성자 등급 -->
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
				<!-- 작성자 등급 -->
				<!-- 작성일 -->
				<div class="col-md-4">
					<h4><strong>작성일</strong>
					<fmt:formatDate value="${communityEntity.enrollDate}" pattern="yyyy-MM-dd HH:mm"/>
					</h4>
				</div>
				<!-- 작성일 -->
			</div>
			
			<hr />
			
			<!-- 내용 -->
			<div class="row">
				<div class="col-md-12">
					<textarea class="form-control" rows="5" name="content" id="summernote" readonly="readonly">${communityEntity.content}</textarea>
				</div>	
			</div>
			<!-- 내용 -->
			
			<hr />
			
			<!-- 
			<div class="row">
				<div class="col-md-12">
					<label for="tag"><strong>해시태그</strong></label>
					<input type="text" class="form-control" name="hashtag" id="hashtag" placeholder="태그를 입력해 주세요">
				</div>
			</div>
			<hr />
			 -->
			 
			 <!-- 버튼 시작 -->
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
							data-study-join-yn="${communityEntity.answerYn}"
							data-community-no="${communityEntity.communityNo}">모집중</button>
					</c:if>
					<sec:authorize access="hasRole('AM')">
						<!-- 답변완료 버튼(Y일 때) -->
						<c:if test="${communityEntity.pageCode eq 2 && communityEntity.answerYn eq 'Y'}"> 
							<button type="button" class="btn btn-success" style="margin-right: 10px;" id="changeAnswerYn" 
								data-answer-yn="${communityEntity.answerYn}"
								data-community-no="${communityEntity.communityNo}">답변중</button>
						</c:if>
						<!-- 답변중 버튼(N일 때) -->
						<c:if test="${communityEntity.pageCode eq 2 && communityEntity.answerYn eq 'N'}"> 
							<button type="button" class="btn btn-success" style="margin-right: 10px;" id="changeAnswerYn" 
								data-answer-yn="${communityEntity.answerYn}"
								data-community-no="${communityEntity.communityNo}">답변완료</button>
						</c:if>
					</sec:authorize>
					
					<!-- 신고하기 -->
					<sec:authorize access="hasAnyRole('M1','M2')">
						<button style="margin-right: 10px;" type="button" class="btn btn-danger" data-toggle="modal" data-target="#exampleModal" id="reportButton">신고하기</button>
						<jsp:include page="/WEB-INF/views/community/common/reportModal.jsp">
							<jsp:param value="" name="title"/>
						</jsp:include>
					</sec:authorize>
					<!-- 신고하기 -->
					
					<!-- 좋아요 -->
					<button type="button" class="btn btn-primary" id="likeButton" 
						data-community-no="${communityEntity.communityNo}"
						data-member-no="${communityEntity.memberNo}"
						data-like-yes-no="${likeYesNo}">좋아요</button>
					<!-- 좋아요 -->
				</div>
			</div>
			<!-- 버튼 종료 -->
			
			<hr />
				
			<!-- 수정/삭제/목록 시작 -->
			<div class="row">
				<div class="col-md-12" id="bottomButton">
					<!-- 수정하기 -->
					<button type="button" class="btn btn-secondary btn-lg" id="communityUpdateBtn">수정하기</button>
					<!-- 수정하기 -->
					<!-- 삭제하기 -->
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
					<!-- 삭제하기 -->
					<!-- 목록보기 -->
					<!-- 4 : 자유게시판 / 3 : 스터디 / 2 : Q&A -->
					<c:if test="${communityEntity.pageCode eq '4' }">
						<button type="button" class="btn btn-secondary btn-lg" onclick="location.href = '${pageContext.request.contextPath}/community/communityFreeboardList.do'">목록보기</button>
					</c:if>
					<c:if test="${communityEntity.pageCode eq '3' }">
						<button type="button" class="btn btn-secondary btn-lg" onclick="location.href = '${pageContext.request.contextPath}/community/communityStudyList.do'">목록보기</button>
					</c:if>
					<c:if test="${communityEntity.pageCode eq '2' }">
						<button type="button" class="btn btn-secondary btn-lg" onclick="location.href = '${pageContext.request.contextPath}/community/communityQnAList.do'">목록보기</button>
					</c:if>
					<!-- 목록보기 -->
				</div>
			</div>
			<!-- 수정/삭제/목록 종료 -->
		</div>
	</div>
	
	<hr />
	
	<!-- 회원일때만 댓글 등록창이 보이게끔 설정 -->
	<!-- 댓글 등록 시작 -->
		<sec:authorize access="hasAnyRole('M1', 'M2', 'AM')">
		<div class="card mb-2">
			<div class="card-header bg-light">
				<i class="fa fa-comment fa"></i> 답변 작성
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
		</sec:authorize>
	<!-- 댓글 등록 끝 -->
		
	
	<!-- 댓글 시작 -->
	<div class="card mb-2">
		<div class="card-header bg-light">
	        <i class="fa fa-comment fa"></i> 답변
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

<script>
/* ---------------------------- 답변 기능 시작 ---------------------------- */
// 답변완료 : Y
// 답변중 : N

$(document).on('click', '#changeAnswerYn', function(e){
	e.preventDefault();
	console.log("답변기능 도착했나요?");
	console.log(e.target);
	var $answerYn = $(e.target).data("answerYn");
	const $communityNo = $(e.target).data("communityNo");
	console.log("답변완료:Y,답변중:N --> " + $answerYn);
	console.log("답변 게시글 번호 : " + $communityNo);
		
	// 답변완료 상태일때
	if($answerYn == 'Y'){
		
		$.ajax({
			url: "${pageContext.request.contextPath}/community/answerNo.do",
			method: "GET",
			data:{
				answerYn : $answerYn,
				communityNo : $communityNo
			},
			success(data){
				const result = data["result"]
				// 1이면 답변중 상태로 변경
				if(result == 1){
					alert("답변중 상태로 변경되었습니다.");
					$("#changeAnswerYn").html('답변완료');
					$(e.target).data("answerYn", "N");
				}
			},
			error:function(xhr, status, err){
				console.log(xhr, status, err)
					alert("로그인 후 이용이 가능합니다.");
			}
		});
	} else{
		
		console.log("답변중에서 답변완료로 변경");
		$.ajax({
			url: "${pageContext.request.contextPath}/community/answerYes.do",
			method: "GET",
			data: {
				answerYn : $answerYn,
				communityNo : $communityNo
			},
			success(data){
				const result = data["result"]
				// 1이면 답변완료 상태로 변경 
				if(result == 1){
					alert("답변완료 상태로 변경되었습니다.");
					$("#changeAnswerYn").html("답변중");
					$(e.target).data("answerYn", "Y");
					
				}
			},
			error:function(xhr, status, err){
			console.log(xhr, status, err);
				alert("로그인 후 이용이 가능합니다.");
			}
		});
	}
});

/* ---------------------------- 답변 기능 종료 ---------------------------- */


/* ---------------------------- 모집 기능 시작 ---------------------------- */
// 모집중 : Y
// 모집완료 : N

$(document).on('click', '#changeJoinYn', function(e){
	e.preventDefault();
	console.log("모집기능 도착했나요?");
	console.log(e.target);
	var $studyJoinYn = $(e.target).data("studyJoinYn");
	const $communityNo = $(e.target).data("communityNo");
	console.log("모집중:Y,모집완료:N --> " + $studyJoinYn);
	console.log("모집 게시글 번호 : " + $communityNo);
		
	// 모집중 상태일 때
	if($studyJoinYn == 'Y'){
		
		$.ajax({
			url: "${pageContext.request.contextPath}/community/joinNo.do",
			method: "GET",
			data:{
				studyJoinYn : $studyJoinYn,
				communityNo : $communityNo
			},
			success(data){
				const result = data["result"]
				// 1이면 모집완료 상태로 변경
				if(result == 1){
					alert("모집완료 상태로 변경되었습니다.");
					$("#changeJoinYn").html('모집중');
					$(e.target).data("studyJoinYn", "N");
				}
			},
			error:function(xhr, status, err){
				console.log(xhr, status, err);
					alert("로그인 후 이용이 가능합니다.");
			}
		});
	} else{
		
		console.log("모집완료에서 모집중으로 변경");
		$.ajax({
			url: "${pageContext.request.contextPath}/community/joinYes.do",
			method: "GET",
			data: {
				studyJoinYn : $studyJoinYn,
				communityNo : $communityNo
			},
			success(data){
				const result = data["result"]
				// 1이면 모집중 상태로 변경 
				if(result == 1){
					alert("모집중 상태로 변경되었습니다.");
					$("#changeJoinYn").html("모집완료");
					$(e.target).data("studyJoinYn", "Y");
					
				}
			},
			error:function(xhr, status, err){
			console.log(xhr, status, err);
				alert("로그인 후 이용이 가능합니다.");
			}
		});
	}
});


/* ---------------------------- 모집 기능 종료 ---------------------------- */

/* ---------------------------- 썸머 노트 시작 ---------------------------- */

// summernote 웹 에디터 로딩
$(document).ready(function(){
	$('#summernote').summernote({
		height: 300, // 에디터 높이
		minHeight: 300, // 최소 높이
		maxHeight: 300, // 최대 높이
		focus: true, // 에디터 로딩 후 포커스를 맞출 지 여부
		lang: "ko-KR", // 한글 설정
	});
	if($("#closeJoinYn").val()=="N"){
		$("#closeJoinYn").html('모집완료');	
	} else {
		$("#closeJoinYn").html('모집중');	
	}
	
	
	// 읽기 전용화 --> 비활성화 --> disable
	$('#summernote').summernote('disable');
});

/* ---------------------------- 썸머 노트 종료 ---------------------------- */

/* ---------------------------- 커뮤니티 수정하기 기능 시작 ---------------------------- */

$(document).on('click', '#communityUpdateBtn', function(e){
	e.preventDefault();
	console.log("업데이트 도착했나요?")
	console.log("삭제할 게시글 번호 : ${communityEntity.communityNo}");
	
	if(confirm("정말로 수정하시겠습니까?")){
		location.href=`${pageContext.request.contextPath}/community/communityUpdate.do?communityNo=${communityEntity.communityNo}`;	
	}else{
		 return;
	}  
});

/* ---------------------------- 커뮤니티 수정하기 기능 종료 ---------------------------- */


/* ---------------------------- 커뮤니티 삭제하기 기능 시작 ---------------------------- */
$(document).on('click', '.communityDeleteBtn', function(e){
	e.preventDefault();
	console.log("삭제하기 도착했나요?");
	console.log(e.target);
	const $communityNo = $(e.target).data("communityNo");
	const $pageCode = $(e.target).data("pageCode");
	console.log("삭제할 게시글 번호 : " + $communityNo);
	console.log("삭제할 게시글 코드 : " + $pageCode);
		
	if(confirm("정말로 삭제하시겠습니까?")){
		location.href=`${pageContext.request.contextPath}/community/communityDelete.do?communityNo=${communityEntity.communityNo}&pageCode=${communityEntity.pageCode}`;	
	}else{
		 return;
	}
});

/* ---------------------------- 커뮤니티 삭제하기 기능 종료 ---------------------------- */

<sec:authorize access="hasAnyRole('M1','M2','AM')">
/* ---------------------------- 커뮤니티 댓글 기능 시작 ---------------------------- */
//댓글 유효성 검사
function commentValidate(){
	//console.log("도착했나요오");
	var $content = $('#comment');
	//console.log($content, typeof $content);
	// 슬래시(/) "사이"에는 매칭시킬 "패턴"을 써준다.
	// 슬래시(/) "다음"에는 옵션을 설정하는 "플래그"를 써준다.
	// ^문자열 : 특정 문자열로 시작(괄호 없음 주의!)
	// . : 모든 문자열
	// | : OR
	// \n : 줄바꿈
	if(/^(.|\n)+$/.test($content.val()) == false){
		alert("내용을 입력하세요");
		return false;
	}
	$(document.commentForm).submit();
}
/* ---------------------------- 커뮤니티 댓글 기능 종료 ---------------------------- */

/* ---------------------------- 커뮤니티 대댓글 기능 시작 ---------------------------- */
// 답글(대댓글) 클릭 시 댓글 번호 참조 
function firstReply() {
	const commentRefNo = $(".btnReComment").val();
	
	const div = `
		<div id="ii">
			<ul class="list-group list-group-flush" id="level2">
				<div class="card-body" style="padding-left: 100px;">
					<ul class="list-group list-group-flush">
					    <li class="list-group-item" style="border: solid; background-color: white;">
						<div class="form-inline mb-2">
							<label for="replyId"><i class="fa fa-user-circle-o fa-2x"></i></label>
						</div>
						<form:form
							name="reCommentForm"
							action="${pageContext.request.contextPath}/community/communityCommentEnroll.do"
							method="POST">
							<textarea class="form-control" name="content" id="reComment" rows="1"></textarea>
							<div class="row float-right">
								<button type="button" class="btn btn-dark mt-3 float-right" onclick="reCommentValidate()">등록</button>&nbsp;
								<button type="button" class="btn btn-dark mt-3 float-right" onclick="closeDiv()">취소</button>
							</div>
							
							<input type="hidden" name="commentLevel" value="2"/>
							<input type="hidden" name="memberNo" value='<sec:authentication property="principal.memberNo" />' />
							<input type="hidden" name="communityNo" value="${communityEntity.communityNo}" />
							<input type="hidden" name="commentRefNo" value= "\${commentRefNo}" /> 
						</form:form>
					    </li>
					</ul>
				</div>
			</ul>
		</div>`;
		
	// e.target 의 부모의 부모 div (등록 전체 div를 지칭)
	const $divOfBtn = $(".btnReComment").parent();
	// jQuery 객체 $divOfBtn 이 div 다음으로 들어가게끔 조치
	$divOfBtn.after(div);
	
	$(".btnReComment").attr("onclick", "aa()");
		
		
}


function aa (){
	$("#ii").show();
}

function closeDiv(){
	console.log("도착꾸?");
	$("#ii").undind();
}
/* ---------------------------- 커뮤니티 대댓글 기능 종료 ---------------------------- */

/* ---------------------------- 커뮤니티 대댓글 등록 시작 ---------------------------- */
  
function reCommentValidate(){
	console.log("도착했나요오");
	var $reComment = $('#reComment');
	//console.log($content, typeof $content);
	// 슬래시(/) "사이"에는 매칭시킬 "패턴"을 써준다.
	// 슬래시(/) "다음"에는 옵션을 설정하는 "플래그"를 써준다.
	// ^문자열 : 특정 문자열로 시작(괄호 없음 주의!)
	// . : 모든 문자열
	// | : OR
	// \n : 줄바꿈
	if(/^(.|\n)+$/.test($reComment.val()) == false){
		alert("내용을 입력하세요");
		return false;
	}
	$(document.reCommentForm).submit();
}

/* ---------------------------- 커뮤니티 대댓글 등록 종료 ---------------------------- */


// 댓글 삭제
$('.btnCommentDelete').click((e) => {
	//console.log("도착했나요?");
	//console.log(e.target);
	var commentNo = $(e.target).val();	
	//console.log(`삭제할 댓글 번호 : \${commentNo}`);
	//communityNo은 communityEntity로 받아왔기때문에 이점을 유의한다.
	//console.log(${communityEntity.communityNo})
	
	// 사용자 입력값을 복수개로 가져와 넘길 수 있다.
	if(confirm("정말로 삭제하시겠습니까?")){
		location.href=`${pageContext.request.contextPath}/community/commentDelete.do?commentNo=\${commentNo}&communityNo=${communityEntity.communityNo}`;	
	}else{
		 return;
	}  
	
});

/* ---------------------------- 좋아요 기능 시작 ---------------------------- */

</sec:authorize>
// 좋아요 
$(document).on('click', '#likeButton', function(e) {
	console.log("좋아요 도착하나요?");
	
	const $communityNo = $(e.target).data("communityNo");
	const $memberNo = $(e.target).data("memberNo");
	const likeYesNo = $(e.target).data("likeYesNo");
	console.log($communityNo);
	console.log($memberNo);
	console.log(likeYesNo);
	
	if(likeYesNo == 0){
		
		$.ajax({
			url : "${pageContext.request.contextPath}/community/freeboardLikeAdd",
			method : "GET",
			data : {
				memberNo : $memberNo,
				communityNo : $communityNo
			},
			success(data){
				const result = data["result"]
				const newCountLikes = data["newCountLikes"];
				console.log(`result : \${result}`);
				console.log(`newCountLikes : \${newCountLikes}`);
				
				if(result == 1) {
					$(e.target).data("likeYesNo", 1);
					console.log($(e.target).data("likeYesNo"));
					
					//$(e.target).text(newCountLikes);
					console.log("newCountLikes = " + newCountLikes);
					console.log("좋아요 등록!");
					alert("좋아요를 등록했습니다.");
						
				}
			},
			error : function(xhr, status, err){
				console.log(xhr, status, err);
					alert("로그인 후 이용이 가능합니다.");
			}
		});
	// 좋아요를 이미 눌렀을 경우
	}else{
		
		$.ajax({
			url : "${pageContext.request.contextPath}/community/freeboardLikeDelete",
			method : "GET",
			data : {
				communityNo : $communityNo,
				memberNo : $memberNo
			},
			success(data){
				const result = data["result"];
				const newCountLikes = data["newCountLikes"];
				console.log(`result : \${result}`);
				console.log(`newcountLikes : \${newCountLikes}`);
				
				if(result == 1) {
					$(e.target).data("likeYesNo", 0);
					console.log($(e.target).data("likeYesNo"));
					
					//$(e.target).text(newCountLikes);
					console.log("newCountLikes = " + newCountLikes);
					console.log("좋아요 취소!");
					alert("좋아요를 취소했습니다.");
				}
			},
			error : console.log
		})
	}
});

/* ---------------------------- 좋아요 기능 종료 ---------------------------- */

</script>
<script src="${pageContext.request.contextPath}/resources/js/community/communityColumnDetail/scripts.js"></script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
