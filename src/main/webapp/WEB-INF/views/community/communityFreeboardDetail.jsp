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
<link href="${pageContext.request.contextPath}/resources/css/community/style.css" rel="stylesheet">
<jsp:include page="/WEB-INF/views/community/common/communitySidebar.jsp">
	<jsp:param value="" name="title"/>
</jsp:include>
<!-- include summernote css/js -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.20/summernote-lite.min.css" integrity="sha512-ZbehZMIlGA8CTIOtdE+M81uj3mrcgyrh6ZFeG33A4FHECakGrOsTPlPQ8ijjLkxgImrdmSVUHn1j+ApjodYZow==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.20/summernote-lite.min.js" integrity="sha512-lVkQNgKabKsM1DA/qbhJRFQU8TuwkLF2vSN3iU/c7+iayKs08Y8GXqfFxxTZr1IcpMovXnf2N/ZZoMgmZep1YQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="${pageContext.request.contextPath }/resources/js/summernote/lang/summernote-ko-KR.js"></script>
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
		
</script>
<style>
	#likeButton, #reportButton {
		width: 90px;
	}
</style>

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
</div>
</div>

<script src="${pageContext.request.contextPath}/resources/js/community/communityColumnDetail/scripts.js"></script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
