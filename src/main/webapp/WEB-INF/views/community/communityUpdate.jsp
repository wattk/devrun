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
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.20/summernote-lite.min.css" integrity="sha512-ZbehZMIlGA8CTIOtdE+M81uj3mrcgyrh6ZFeG33A4FHECakGrOsTPlPQ8ijjLkxgImrdmSVUHn1j+ApjodYZow==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.20/summernote-lite.min.js" integrity="sha512-lVkQNgKabKsM1DA/qbhJRFQU8TuwkLF2vSN3iU/c7+iayKs08Y8GXqfFxxTZr1IcpMovXnf2N/ZZoMgmZep1YQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="${pageContext.request.contextPath }/resources/js/summernote/lang/summernote-ko-KR.js"></script>
<style>
#like, #report {
	width: 100px;
	margin: auto;
	display: block;
}
</style>
<script>
//summernote 웹 에디터 로딩
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

//내용 유효성 검사
function freeboardUpdateValidate(){
	console.log("업데이트 유효성 검사 시작하나요");
	console.log($("[name=freeboardUpdateForm]"));
	var $content = $("[name=content]");
	var $title = $("[name=title]");
	// 슬래시(/) "사이"에는 매칭시킬 "패턴"을 써준다.
	// 슬래시(/) "다음"에는 옵션을 설정하는 "플래그"를 써준다.
	// ^문자열 : 특정 문자열로 시작(괄호 없음 주의!)
	// . : 모든 문자열
	// | : OR
	// \n : 줄바꿈
	if(/^(.|\n)+$/.test($title.val()) == false){
		alert("제목을 입력하세요");
		return false;
	} 
	else if (/^(.|\n)+$/.test($content.val()) == false){
		alert("내용을 입력하세요");
		return false;
	}
	$(document.freeboardUpdateForm).submit();
}


</script>
	<article>
		<div class="container" role="main">
			<h1 class="pt-5"><strong>수정하기</strong></h1>
	
			<hr>
	
		<form:form 
			name="freeboardUpdateForm" 
			action="${pageContext.request.contextPath}/community/communityUpdateEnroll.do"
			method="POST">
				<div class="mb-3">
					<label for="title"><strong>제목</strong></label>
					<input type="text" class="form-control" name="title" id="title" value="${communityEntity.title}">
				</div>
				<div class="mb-3">
					<label for="writer"><strong>작성자</strong></label>
					<input type="text" class="form-control" name="nickname" id="nickname" readonly value='<sec:authentication property="principal.nickname" />'>
					<input type="hidden" class="form-cotrol" name="memberNo" id="member_no" value='<sec:authentication property="principal.memberNo" />'>
					<input type="hidden" name="communityNo" value="${communityEntity.communityNo}" />
				</div>
				<div class="mb-3">
					<label for="content"><strong>내용</strong></label>
					<textarea class="form-control" rows="5" name="content" id="summernote">
						${communityEntity.content}
					</textarea>
				</div>
				<div class="mb-3">
					<label for="tag"><strong>해시태그</strong></label>
					<input type="text" class="form-control" name="hashtag" id="hashtag" placeholder="태그를 입력해 주세요">
				</div>
		</form:form>
			<div style="text-align: center">
				<button type="button" class="btn btn-primary btn-lg" id="btnUpdate" onclick="freeboardUpdateValidate()">수정</button>
				<button type="button" class="btn btn-secondary btn-lg" onclick="history.go(-1);">취소</button>
			</div>
		</div>
	</article>		
</div>	
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
