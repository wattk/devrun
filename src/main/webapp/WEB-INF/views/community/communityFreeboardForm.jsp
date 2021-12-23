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

<!-- 사이드바 css -->
<link href="${pageContext.request.contextPath}/resources/css/community/style.css" rel="stylesheet">

<!-- include summernote css/js -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
<style>
#like, #report {
	width: 100px;
	margin: auto;
	display: block;
}
</style>
<script>
	// #btnSave 버튼을 'click'하게 되면 #form을 전송(.submit)
	$(document).on('click', '#btnSave', function(e){
		e.preventDefault();
		$("#form").submit();
	});
	
	// #btnList 버튼을 'click'하게 되면 communityFreboardList 페이지로 이동.
	$(document).on('click', '#btnList', function(e){
		e.preventDefault();
		location.href="${pageContext.request.contextPath}/community/communityFreeboardList.do";
	});
	
	// summernote 웹 에디터 로딩
	$(document).ready(function(){
		$('#summernote').summernote({
			height: 300, // 에디터 높이
			minHeight: null, // 최소 높이
			maxHeight: null, // 최대 높이
			focus: true, // 에디터 로딩 후 포커스를 맞출 지 여부
			lang: "ko-KR", // 한글 설정
			placeholder: "내용을 입력해 주세요"  // placeholder 설정
		});
	});
	
	/* textarea에도 required속성을 적용가능하지만, 공백이 입력된 경우 대비 유효성검사를 실시함. */
	function boardValidate(){
		var $content = $("[name=content]");
		if(/^(.|\n)+$/.test($content.val()) == false){
			alert("내용을 입력하세요");
			return false;
		}
		return true;
	}
	
</script>

	<article>
		<div class="container" role="main">
			<h1><strong>글쓰기</strong></h1>
	
			<hr>
	
		<form:form name="form" id="form" role="form" method="POST" action="${pageContext.request.contextPath}/community/communityColumnEnroll.do">
				<div class="mb-3">
					<label for="title"><strong>제목</strong></label>
					<input type="text" class="form-control" name="title" id="title" placeholder="제목을 입력해 주세요">
				</div>
				<div class="mb-3">
					<label for="writer"><strong>작성자</strong></label>
					<input type="text" class="form-control" name="reg_id" id="reg_id" placeholder="이름을 입력해 주세요">
					<input type="hidden" class="form-cotrol" name="memberNo" id="member_no" value='<sec:authentication property="principal.memberNo" />' placeholder="이름을 입력해 주세요">
				</div>
				<div class="mb-3">
					<label for="content"><strong>내용</strong></label>
					<textarea class="form-control" rows="5" name="content" id="summernote"></textarea>
				</div>
				<div class="mb-3">
					<label for="tag"><strong>해시태그</strong></label>
					<input type="text" class="form-control" name="tag" id="tag" placeholder="태그를 입력해 주세요">
				</div>
		</form:form>
			<div style="text-align: center;">
				<button type="submit" class="btn btn-primary btn-lg" id="btnSave">저장</button>
				<button type="button" class="btn btn-secondary btn-lg" id="btnList">목록</button>
			</div>
		</div>
	</article>		
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
