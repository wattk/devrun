<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<fmt:requestEncoding value="utf-8"/>
<!-- include summernote css/js -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.20/summernote-lite.min.css" integrity="sha512-ZbehZMIlGA8CTIOtdE+M81uj3mrcgyrh6ZFeG33A4FHECakGrOsTPlPQ8ijjLkxgImrdmSVUHn1j+ApjodYZow==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.20/summernote-lite.min.js" integrity="sha512-lVkQNgKabKsM1DA/qbhJRFQU8TuwkLF2vSN3iU/c7+iayKs08Y8GXqfFxxTZr1IcpMovXnf2N/ZZoMgmZep1YQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="${pageContext.request.contextPath }/resources/js/summernote/lang/summernote-ko-KR.js"></script>

<style>
    .test_obj input[type="radio"] {
        display: none;
    }
 
    .test_obj input[type="radio"] + span {
        display: inline-block;
        padding: 15px 10px;
        margin: 10px;
        border: 1px solid #dfdfdf;
        background-color: #ffffff;
        text-align: center;
        cursor: pointer;
    }
    
    .test_obj span{
    	width : 120px;
    }
 
    .test_obj input[type="radio"]:checked + span {
        background-color: #113a6b;
        color: #ffffff;
    }
</style>

<!-- 글쓰기 버튼 -->
	<sec:authorize access="hasAnyRole('M1','M2','AM')">
		<div style="float: right">
		<button class="btn btn-primary" data-toggle="modal" data-target="#bs-example-modal-lg">글쓰기</button>
		</div>
	</sec:authorize>
	
	<!-- 게시판 글쓰기 모달 시작 -->
	<div class="modal fade" id="bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-lg">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h4 class="modal-title" id="myLargeModalLabel"><strong>커뮤니티</strong></h4>
	      </div>
	      <br />
	  	<form:form 
	  		id="writeForm"
	  		name="writeForm"
	  		action="${pageContext.request.contextPath}/community/communityWriteEnroll.do"
	  		method="POST">
	      <div class="row justify-content-center" id="writeType">
		  	<label class="test_obj">
			    <input type="radio" name="pageCode" value="2">
			    <span>Q&A</span>
			</label>
			<label class="test_obj">
			    <input type="radio" name="pageCode" value="3">
			    <span>스터디</span>
			</label>
			 
			<label class="test_obj">
			    <input type="radio" name="pageCode" value="4">
			    <span>자유게시판</span>
			</label>		  
	      </div>
	      <div class="modal-body">
	      <hr /> 
	      <p><strong>제목</strong></p>
	      <hr />
			<div class="input-group flex-nowrap">
			  <input type="text" class="form-control" name="title" id="title" placeholder="제목을 입력해주세요." aria-label="Username" aria-describedby="addon-wrapping">
			  <sec:authorize access="hasAnyRole('M1','M2','AM')">
			  	<input type="hidden" name="memberNo" id="member_no" value='<sec:authentication property="principal.memberNo"/>' />
			  </sec:authorize>
			</div>
			<%-- 
		  <br />	
		  <p><strong>태그</strong></p>
		  <hr />
		  	<div class="input-group flex-nowrap">
			  <span class="input-group-text" id="addon-wrapping">#</span>
			  <sec:authorize access="hasAnyRole('M2','AM')">
			  	<input type="text" class="form-control" placeholder="태그를 설정해주세요." aria-label="Username" aria-describedby="addon-wrapping">
			  </sec:authorize>
			</div>
			 --%>
		  <br />	
		  <p><strong>내용</strong></p>
		  <hr />	
			<div class="input-group flex-nowrap">
				<textarea class="form-control" rows="5" name="content" id="summernote"></textarea>
			</div>
	      </div>
	      <div class="modal-footer justify-content-center">
			<button type="button" class="btn btn-primary col-4" id="writeBtn">저장</button>
			<button type="button" class="btn btn-secondary col-4" data-dismiss="modal" id="deleteReporBtn">취소</button>
		  </div>
  			</form:form>
	    </div>
	  </div>
	</div>
	
<script>
let imgs = "";
//summernote 웹 에디터 로딩
$(document).ready(function(){
	$('#summernote').summernote({
		height: 300, // 에디터 높이
		minHeight: null, // 최소 높이
		maxHeight: null, // 최대 높이
		focus: true, // 에디터 로딩 후 포커스를 맞출 지 여부
		lang: "ko-KR", // 한글 설정
		placeholder: "내용을 입력해 주세요",  // placeholder 설정
		// 2. callbacks로 함수 설정
		callbacks:{
			// 1. 이미지를 업로드를 할 때(onImageUpload라는 key값)
			onImageUpload : function(files){
				// 3. 0번째에 있는 메소드를 실행해줘
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
	
	// 4. ForamData()에 file, keyword(어디서 왔는지 알아보기 위해)를 설정
	function uploadSummernoteImageFile(file, editor){
		const data = new FormData();
		data.append("file", file);
		data.append("keyword", "community");
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
});

// 글쓰기 & 유효성검사
$('#writeBtn').click(function(){
	
	var pageCode = $('input[name="pageCode"]:checked').val();
	console.log(pageCode); // pageCode 정상작동 확인
	var $title = $('#title');
	console.log($title.val()); // title 정상작동 확인
	var $content = $('#summernote');
	console.log($content.val()); // content 정상작동 확인
	var $memberNo = $('#member_no');
	console.log($memberNo.val()); // memberNo 정상작동 확인
	
	// 유효성 검사
	if(/^(.|\n)+$/.test($title.val()) == false){
		alert("제목을 입력하세요");
		return false;
	}
	else if (/^(.|\n)+$/.test($content.val()) == false){
		alert("내용을 입력하세요");
		return false;
	}
	
	$(window).unbind('beforeunload');
	$(document.writeForm).submit();
	
});

//페이지 벗어날 때 썸머노트 안의 이미지 파일을 서버 상에서 삭제
$("#bs-example-modal-lg").on("hide.bs.modal",
      	function (e) {  
		console.log("닫기 이벤트 시작");
		if(confirm("정말 나가시겠습니까?")){
			$("input[type=radio]:checked").prop('checked', false);
			
			$(".form-control").val('');
			$("#summernote").summernote('reset');
			
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
			return;
		};
    	//비동기 요청을 통해 서버에 저장된 이미지 파일 삭제
	});


</script>
