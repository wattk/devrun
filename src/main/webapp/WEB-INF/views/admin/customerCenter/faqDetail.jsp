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
/* css 합칠 때 faqEnroll 과 동일함 */
.faq-btn {
	width: 10%;
}

/* 분류 클릭 시 색 바꿈*/
.faq-category .btn-secondary:not(:disabled):not(.disabled).active {
	background-color: #1a81ff;
	border-color: #1A81FF;
}

.faq-category label {
	width: 100px;
}
</style>

<div class="faq-container">
	<h3 class="my-5 ml-5">자주묻는질문 상세보기</h3>
</div>
<form:form name="faqUpdateFrm" action="${pageContext.request.contextPath}/admin/customerCenter/faqUpdate.do" method="post">
	<div class="">
		<input type="hidden" name="noticeNo" value="${faq.noticeNo}"/>
        <table id="faqDetailTbl" class="admin-tbl table mx-auto mt-3 col-md-10">
			<tbody>
				<tr>
			    	<th>분류</th>
			    	<td>
			    		<div class="btn-group-toggle faq-category my-3" data-toggle="buttons">
							<label class="btn btn-secondary ${faq.noticeCode ne 'S' ? 'disabled' : ''}">
								<input type="radio" name="noticeCode" id="notice-code-shop" class="faq-input" value="S" ${faq.noticeCode eq 'S' ? 'checked' : ''} disabled> 쇼핑몰
							</label>
							<label class="btn btn-secondary ${faq.noticeCode ne 'C' ? 'disabled' : ''}">
								<input type="radio" name="noticeCode" id="notice-code-community" class="faq-input" value="C" ${faq.noticeCode eq 'C' ? 'checked' : ''} disabled> 커뮤니티
							</label>
							<label class="btn btn-secondary ${faq.noticeCode ne 'E' ? 'disabled' : ''}">
								<input type="radio" name="noticeCode" id="notice-code-etc" class="faq-input" value="E" ${faq.noticeCode eq 'E' ? 'checked' : ''} disabled> 기타
							</label>
						</div> 
			    	</td>
			    </tr>
			    <tr>
			    	<th>제목</th>
			    	<td><input type="text" name="title" id="" class="d-inline-block form-control w-75 faq-input" value="${faq.title}" disabled/></td>
			    </tr>
			    <tr>
			    	<th>글쓴이</th>
			    	<td>${faq.nickname}</td>
			    </tr>
			    <tr>
			    	<th>등록일</th>
			    	<td><input type="date" name="enrollDate" id="" value='<fmt:formatDate value="${faq.enrollDate}" pattern="yyyy-MM-dd"/>' disabled/></td>
			    </tr>
	  	 	</tbody>
		</table>

		<div class="col-md-10 mx-auto">
            <label for="content" class="col-form-label"></label>
            <textarea id="summernote" name="content" id="content">${faq.content}</textarea>
        </div>
        <div id="faqDetailBtns" class="d-flex justify-content-center col-10 mx-auto mt-5 mb-5">
        	<button type="button" id="faqEditBtn" class="faq-btn btn btn-primary mx-2">수정</button>
        	<button type="button" id="faqDeleteBtn" class="faq-btn btn btn-secondary mx-2">삭제</button>
        	<button type="button" id="faqCancelBtn" class="faq-btn btn btn-dark mx-2" onclick="location.href='${pageContext.request.contextPath}/admin/customerCenter/faqManage.do?noticeCode=${param.noticeCode}&searchKeyword=${param.searchKeyword}&cPage=${param.cPage eq '' ? 1 : param.cPage}'">목록</button>
        </div>
	</div>
</form:form>
<form:form name="faqDeleteFrm" action="${pageContext.request.contextPath}/admin/customerCenter/faqDelete.do" method="post">
	<input type="hidden" name="noticeNo" value="${faq.noticeNo}"/>
	<input type="hidden" name="noticeCode" value="${param.noticeCode}"/>
	<input type="hidden" name="searchKeyword" value="${param.searchKeyword}"/>
	<input type="hidden" name="cPage" value="${param.cPage}"/>
</form:form>
<script>
<!-- 썸머노트 웹 에디터 로딩 -->
$(document).ready(function() {
	
	$('#summernote').summernote({
        height: 400,			// 에디터 높이
        minHeight: 400,			// 최소 높이
        maxHeight: 400,			// 최대 높이
        focus: false,			// 에디터 로딩후 포커스를 맞출지 여부
        lang: "ko-KR",			// 한글 설정
        placeholder: '내용 입력',	//placeholder 설정
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
  	}).summernote('disable');	// 상세보기 시 썸머노트 비활성화
});


//수정 버튼 클릭 시 비활성화 풀기 & 수정 버튼 등록 버튼으로 변경하고 삭제/목록 버튼 대신 취소 버튼 만들기
$(faqEditBtn).click((e)=>{
	const $inputArr = $('#faqDetailTbl .faq-input');
	$inputArr.each((i, item)=>{
		$(item).prop('disabled', false);
	});

	$('.faq-category label').removeClass("disabled");
	
	// 썸머노트 활성화
	$('#summernote').summernote('enable');
	
	$(faqDetailBtns)
		.html('')
		.append(`<button type="button" id="faqUpdateBtn" class="faq-btn btn btn-primary mx-2">등록</button>
	        	<button type="button" id="faqResetBtn" class="faq-btn btn btn-secondary mx-2" onclick="location.reload(true);">취소</button>`);
	
	//등록 버튼 클릭 시 form 제출
	$(faqUpdateBtn).click((e)=>{
		$(document.faqUpdateFrm).submit();	
	});
});

//삭제 버튼 클릭 시 이벤트 삭제
$(faqDeleteBtn).click((e)=>{
	$(document.faqDeleteFrm).submit();
});

</script>
<jsp:include page="/WEB-INF/views/admin/admin-common/footer.jsp"></jsp:include>
