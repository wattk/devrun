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
<!-- 사이드바 css -->
<link href="${pageContext.request.contextPath}/resources/css/community/style.css" rel="stylesheet">
<!-- include summernote css/js -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.20/summernote-lite.min.css" integrity="sha512-ZbehZMIlGA8CTIOtdE+M81uj3mrcgyrh6ZFeG33A4FHECakGrOsTPlPQ8ijjLkxgImrdmSVUHn1j+ApjodYZow==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.20/summernote-lite.min.js" integrity="sha512-lVkQNgKabKsM1DA/qbhJRFQU8TuwkLF2vSN3iU/c7+iayKs08Y8GXqfFxxTZr1IcpMovXnf2N/ZZoMgmZep1YQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="${pageContext.request.contextPath }/resources/js/summernote/lang/summernote-ko-KR.js"></script>
<script>
	// #btnSave 버튼을 'click'하게 되면 #form을 전송(.submit)
	$(document).on('click', '#btnSave', function(e){
		e.preventDefault();
		$("#form").submit();
	});
	
	// #btnList 버튼을 'click'하게 되면 communityColumnList 페이지로 이동.
	$(document).on('click', '#btnList', function(e){
		e.preventDefault();
		location.href="${pageContext.request.contextPath}/community/communityColumnList.do";
	});
	
	// summernote 웹 에디터 로딩
	$(document).ready(function(){
		$('#summernote').summernote({
			height: 300, // 에디터 높이
			minHeight: null, // 최소 높이
			maxHeight: null, // 최대 높이
			focus: true, // 에디터 로딩 후 포커스를 맞출 지 여부
			lang: "ko-KR", // 한글 설정
			placeholder: "내용을 입력해 주세요",  // placeholder 설정
			callbacks:{
				onImageUpload : function(files){
					uploadSummernoteImageFile(files[0], this);
				},
				onPaste : ((e)=>{
					let clipboardData = e.originalEvent.clipboardData;
					if(clipboardData && clipboardData.items && clipboardData.items.length){
						let item = clipboardData.items[0];
						if(item.kind === 'file' && item.type.indexof('image/') != -1){
							e.preventDefault();
						}
					}
				})
			}
		});
	});
	
	function uploadSummernoteImageFile(file, editor){
		const data = new FormData();
		data.append("file", file);
		data.append("keyword", "promotion");
		$.ajax({
			data : data,
			type : "POST",
			url : "${pageContext.request.contextPath}/uploadSummernoteImageFile",
			contentType : false,
			processData : false,
			success(data){
				console.log(data);
				//imgs 변수 안에 /filename 추가. /는 구분자
				imgs += "/" + data["filename"];
				$('#summernote').summernote('insertImage', "${pageContext.request.contextPath}/resources/upload/community/"+data["filename"]);
			},
			error : console.log
			
		});
	}
	
	//페이지 벗어날 때 썸머노트 안의 이미지 파일을 서버 상에서 삭제
	$(document).ready(function () { 
		//페이지 이동 전에 beforeunload함수 실행
	    $(window).bind('beforeunload',  
	      	function (e) {  
	    	//비동기 요청을 통해 서버에 저장된 이미지 파일 삭제
	    	$.ajax({
	    		url : "${pageContext.request.contextPath}/deleteSummernoteImageFile",
	    		data : {imgs : imgs,
	    				keyword : "community"},
	    		method : "POST",
	    		success(data){
	    		console.log(data);
	    		},
	    		error : console.log
	    	});
	    	//크롬은 문자열을 리턴해야만 페이지를 나가겠냐는 confirm창이 뜬다.
	    	return "";
		});
	});
</script>

	<article>
		<div class="container" role="main">
			<h1 class="pt-5"><strong>칼럼 글쓰기</strong></h1>
			
			<hr />
			
			<form:form name="form" id="form" role="form" method="POST" action="${pageContext.request.contextPath}/community/communityColumnEnroll.do">
				<div class="w-50 p-2">
					<label for="title">제목</label>
					<input type="text" class="form-control d-inline" name="title" id="title" placeholder="제목을 입력해 주세요">
				</div>
				<div class="w-25 p-2">
					<label for="reg_id">작성자</label>
					<input type="text" class="form-control" name="reg_id" id="reg_id" value='<sec:authentication property="principal.nickname" />' disabled>
					<input type="hidden" class="form-control" name="memberNo" id="member_no" value='<sec:authentication property="principal.memberNo" />'>
					<input type="hidden" class="form-control" name="pageCode"  value='1' >
				</div>
				<div class="mb-3 p-2">
					<label for="content">내용</label>
					<textarea class="form-control" rows="5" name="content" id="summernote"></textarea>
				</div>
				<!-- 
				<div class="mb-3">
					<label for="tag">TAG</label>
					<input type="text" class="form-control" name="tag" id="tag" placeholder="태그를 입력해 주세요">
				</div>
				 -->
			</form:form>
			<div style="text-align: center">
				<button type="button" class="btn btn-primary btn-lg" id="btnSave">저장</button>
				<button type="button" class="btn btn-secondary btn-lg" id="btnList">목록</button>
			</div>
		</div>
	</article>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
