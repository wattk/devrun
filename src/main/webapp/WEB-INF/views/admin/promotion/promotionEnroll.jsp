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
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.20/summernote-lite.min.css" integrity="sha512-ZbehZMIlGA8CTIOtdE+M81uj3mrcgyrh6ZFeG33A4FHECakGrOsTPlPQ8ijjLkxgImrdmSVUHn1j+ApjodYZow==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.20/summernote-lite.min.js" integrity="sha512-lVkQNgKabKsM1DA/qbhJRFQU8TuwkLF2vSN3iU/c7+iayKs08Y8GXqfFxxTZr1IcpMovXnf2N/ZZoMgmZep1YQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="${pageContext.request.contextPath}/resources/js/summernote/lang/summernote-ko-KR.js"></script>

<link href="${pageContext.request.contextPath}/resources/css/admin/adminManage.css" rel="stylesheet"/>
<script src="${pageContext.request.contextPath}/resources/js/admin/promotionDetail.js"></script>
<div class="promotion-container">
	<h3 class="mt-5 ml-5">이벤트 관리</h3>
	<strong class="ml-5 pl-2">이벤트 등록</strong>
</div>
<form:form name="promotionEnrollFrm" action="${pageContext.request.contextPath}/admin/promotionEnroll.do" method="post" enctype="multipart/form-data">
	<div class="event-list">
		<hr />
		<strong class="ml-5 pl-5">이벤트 정보</strong>
			<table id="promotionDetailTbl" class="admin-tbl table mx-auto mt-3 col-md-10">
				<tbody>
				    <tr>
				    	<th>이벤트명</th>
				    	<td>
				    		<input type="text" name="name" id="" class="bg-light border-0 small w-50" />
				    	</td>
				    </tr>
				    <tr>
				    	<th>이벤트 기간</th>
				    	<td>
				    		<input type="date" name="startDate" id="startDate" class="bg-light border-0 small"/>
				    		<span>~</span>
				    		<input type="date" name="endDate" id="endDate" class="bg-light border-0 small"/>
				    		<span>총 <span id="calculateDate"></span>일</span>
				    		<input type="hidden" name="validDates" id="validDates"/>
				    	</td>
				    </tr>
				    <tr>
				    	<th>해당 이벤트 아이템</th>
				    	<td >
				    		<div class="d-flex">
					    		<input type="text" id="productCodeSearch" class="bg-light border-0 small" placeholder="상품번호를 입력하세요.">
					             <button id="productAddBtn" class="btn btn-primary" type="button">
					                 <i class="fas fa-plus-square"></i>
					             </button>
				    		</div>
				    		<ul id="productCodeList" class="list-group">
							</ul>
				    	</td>
				    </tr>
				    <tr>
				    	<th>배너 파일</th>
				    	<td>
				    		<input type="file" name="upFile" id="banner" />
				    	</td>
				    </tr>
				    <tr>
				    	<th>정기 이벤트 유무</th>
				    	<td>
				    		<input type="checkbox" name="isRegular" id="isRegular" />
				    	</td>
				    </tr>
				    <tr>
				    	<th>글쓴이</th>
				    	<td>
				    		<input type="text" name="" id="" value='<sec:authentication property="principal.nickname"/>' disabled/>
				    		<input type="hidden" name="nickname" id="" value='<sec:authentication property="principal.nickname"/>'/>
				    		<input type="hidden" name="memberNo" value='<sec:authentication property="principal.memberNo"/>'/>
				    	</td>
				    </tr>
		  	 </tbody>
		</table>
		<div id="promotionImg" class="promotion-img col-10 mx-auto">
			<img src="" alt="" id="promotionBanner" class="img-thumbnail" />
		</div>
		<div class="col-md-10 mx-auto">
            <label for="contents" class="col-form-label"></label>
            <textarea id="summernoteEnroll" name="sideNote"></textarea>
        </div>
        <div id="promotionDetailBtns" class="d-flex justify-content-center col-10 mx-auto mt-5 mb-5">
        	<button type="button" id="promotionEnrollBtn" class="promotion-btn btn btn-primary">등록</button>
	        <button type="button" id="" class="promotion-btn btn btn-secondary" onclick="window.history.back();">취소</button>
        </div>
	</div>
</form:form>
<script>
let imgs = "";
$(document).ready(function() {
	
	//이벤트 등록 썸머노트
	$('#summernoteEnroll')
		.summernote({
		  height: 300,                 // 에디터 높이
		  minHeight: 300,             // 최소 높이
		  maxHeight: 300,             // 최대 높이
		  focus: false,                  // 에디터 로딩후 포커스를 맞출지 여부
		  lang: "ko-KR",					// 한글 설정
		  placeholder: '최대 2048자까지 쓸 수 있습니다',	//placeholder 설정
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
	
	function uploadSummernoteImageFile(file, editor){
		const data = new FormData();
		data.append("file", file);
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
				$('#summernoteEnroll').summernote('insertImage', "${pageContext.request.contextPath}/resources/upload/promotion/"+data["filename"]);
			},
			error : console.log
			
		});
	}
	
});

//페이지 벗어날 때 썸머노트 안의 이미지 파일을 서버 상에서 삭제
$(document).ready(function () { 
	//페이지 이동 전에 beforeunload함수 실행
    $(window).bind('beforeunload',  
      	function (e) {  
    	//비동기 요청을 통해 서버에 저장된 이미지 파일 삭제
    	$.ajax({
    		url : "${pageContext.request.contextPath}/deleteSummernoteImageFile",
    		data : {imgs : imgs},
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

	

//등록 버튼 클릭 시 form 제출
$(promotionEnrollBtn).click((e)=>{
    $(window).unbind('beforeunload');
	$(document.promotionEnrollFrm).submit();	
});	


//상품번호 autocomplete
$("#productCodeSearch").autocomplete({
	source(request, response){
		const {term : searchCode} = request;
		
		$.ajax({
			url : `${pageContext.request.contextPath}/admin/promotionAutocomplete`,
			data : {searchCode},
			success(data){
				const temp = $.map(data, ({productCode, name}, i)=>{
					return {
						label : productCode + "(" + name + ")",
						value : productCode + "(" + name + ")"
					}
				});
				console.log(temp);
				response(temp);
			},
			error : console.log
		});
	}	
});


  

</script>
<jsp:include page="/WEB-INF/views/admin/admin-common/footer.jsp"></jsp:include>
