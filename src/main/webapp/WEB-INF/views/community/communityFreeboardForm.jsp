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

<!-- 사이드바 css -->
<link href="${pageContext.request.contextPath}/resources/css/community/style.css" rel="stylesheet">

<!-- include summernote css/js -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
		
<script>
	// #btnSave 버튼을 'click'하게 되면 #form을 전송(.submit)
	$(document).on('click', '#btnSave', function(e){
		e.preventDefault();
		$("#form").submit();
	});
	
	// #btnList 버튼을 'click'하게 되면 communityColumn 페이지로 이동.
	$(document).on('click', '#btnList', function(e){
		e.preventDefault();
		location.href="${pageContext.request.contextPath}/community/communityColumn.do";
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

<div id="coummunityFreeboardForm-container">
	<form 
		name="FreeboardForm"
		action="${pageContext.request.contextPath}/community/communityFreeboardEnroll.do"
		method="post"
		onsubmit="return boardValidate();">
		<div class="container" role="main">
			<h2>제목</h2>
	
			<hr>
	
	      	<table class="table">
	        	  <tr>
	            	<td>작성자</td>
		            <td>Otto</td>
		            <td>작성일</td>
		            <td>12121</td>
		            <td>조회수</td>
		            <td>1212</td>
		            <td>
	              		<button type="button" class="btn btn-primary" id="like">좋아요</button>
	            	</td>
	            	<td>
	              		<button type="button" class="btn btn-danger" id="report">신고</button>
	            	</td>
	              </tr>
	      	</table>
	
			<div class="mb-3">
				<label for="title">제목</label>
				<input type="text" class="form-control" name="title" id="title" placeholder="제목을 입력해 주세요">
			</div>
			<div class="mb-3">
				<label for="writer">작성자</label>
				<input type="text" class="form-control" name="reg_id" id="reg_id" placeholder="이름을 입력해 주세요">
			</div>
			<div class="mb-3">
				<label for="content">내용</label>
				<textarea class="form-control" rows="5" name="editordata" id="summernote"></textarea>
			</div>
			<div class="mb-3">
				<label for="tag">TAG</label>
				<input type="text" class="form-control" name="tag" id="tag" placeholder="태그를 입력해 주세요">
			</div>
			<div >
				<input type="submit" class="btn btn-sm btn-primary" id="btnsave" value="저장" />
				<button type="button" class="btn btn-sm btn-primary" id="btnList">목록</button>
			</div>
		</div>
	</form>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
