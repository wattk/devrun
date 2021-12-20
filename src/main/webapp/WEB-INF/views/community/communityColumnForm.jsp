<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="" name="title"/>
</jsp:include>
<jsp:include page="/WEB-INF/views/community/common/nav.jsp">
	<jsp:param value="" name="title"/>
</jsp:include>

<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8" />
	<title>communityColumnForm</title>
	
	<!-- 사이드바 css -->
	<link href="${pageContext.request.contextPath}/resources/css/community/style.css" rel="stylesheet">
	
	<!-- bootstrap js: jquery load 이후에 작성할것.-->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
	
	<!-- bootstrap css -->
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">

    <!-- include summernote css/js -->
    <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
	
</head>

<body>

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
	
</script>
	<article>
		<div class="container" role="main">
			<h2>칼럼 글쓰기</h2>
			<hr />
			<form name="form" id="form" role="form" method="POST" action="${pageContext.request.contextPath}/board/saveBoard">
				<div class="mb-3">
					<label for="title">제목</label>
					<input type="text" class="form-control" name="title" id="title" placeholder="제목을 입력해 주세요">
				</div>
				<div class="mb-3">
					<label for="reg_id">작성자</label>
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
			</form>
			<div >
				<button type="button" class="btn btn-sm btn-primary" id="btnSave">저장</button>
				<button type="button" class="btn btn-sm btn-primary" id="btnList">목록</button>
			</div>
		</div>
	</article>
	
</body>
</html>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
