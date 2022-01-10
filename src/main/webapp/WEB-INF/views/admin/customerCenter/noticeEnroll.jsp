<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>	
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/admin/admin-common/header.jsp">
	<jsp:param value="" name="title"/>
</jsp:include>
<!-- 썸머노트 에디터 -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote-bs4.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote-bs4.js" ></script>
<script src="${pageContext.request.contextPath}/resources/js/summernote/lang/summernote-ko-KR.js"></script>

<link href="${pageContext.request.contextPath}/resources/css/admin/adminManage.css" rel="stylesheet"/>

<style>
.notice-btn {
	width: 10%;
}

</style>
<div class="container">
<div class="notice-container">
	<h3 class="my-5 ml-5">공지사항 등록</h3>
</div>
<form:form name="noticeEnrollFrm" action="${pageContext.request.contextPath}/admin/customerCenter/noticeEnroll.do" method="post">
	<div class="">
		<input type="hidden" name="memberNo" value='<sec:authentication property="principal.memberNo"/>'/>
		<div class="col-md-12 mx-auto">
            <input type="text" name="title" id="" class="form-control" placeholder="제목 입력" required/>
        </div>
		<div class="col-md-12 mx-auto">
            <label for="content" class="col-form-label"></label>
            <textarea id="summernote" name="content" id="content" required></textarea>
        </div>
        <div id="" class="d-flex justify-content-center col-12 mx-auto mt-5 mb-5">
        	<button type="submit" id="noticeEnrollBtn" class="notice-btn btn btn-primary mx-2">등록</button>
	        <button type="button" id="" class="notice-btn btn btn-secondary mx-2 w-10" onclick="window.history.back();">취소</button>
        </div>
	</div>
</form:form>
</div>
<script>
<!-- 써머노트 웹 에디터 로딩 -->
$(document).ready(function() {

	$('#summernote').summernote({
        height: 400,                 // 에디터 높이
        minHeight: 400,             // 최소 높이
        maxHeight: 400,             // 최대 높이
        focus: false,                  // 에디터 로딩후 포커스를 맞출지 여부
        lang: "ko-KR",                    // 한글 설정
        placeholder: '내용 입력',    //placeholder 설정
        toolbar: [
            ['style', ['style']],
            ['fontsize', ['fontsize']],
            ['font', ['bold', 'underline', 'clear']],
            ['color', ['forecolor','color']],
            ['para', ['ul', 'ol', 'paragraph']],
            ['table', ['table']],
            ['insert', ['link', 'picture', 'video']],
            ['view', ['codeview', 'help']]
          ]
  	});
});

</script>
<jsp:include page="/WEB-INF/views/admin/admin-common/footer.jsp"></jsp:include>
