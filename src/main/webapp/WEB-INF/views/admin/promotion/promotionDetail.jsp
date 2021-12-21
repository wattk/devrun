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
<script src="${pageContext.request.contextPath }/resources/js/summernote/lang/summernote-ko-KR.js"></script>

<link href="${pageContext.request.contextPath }/resources/css/admin/adminManage.css" rel="stylesheet"/>
<style>
.promotion-btn{
	width : 10%;
	margin : 0 2% 0 2%;
}
</style>
<div class="promotion-container">
	<h3 class="mt-5 ml-5">이벤트 관리</h3>
	<strong class="ml-5 pl-2">이벤트 상세보기</strong>
</div>
<form:form>
	<div class="event-list">
		<hr />
		<strong class="ml-5 pl-5">이벤트 정보</strong>
			<table class="admin-tbl table mx-auto mt-3 col-md-10">
				<tbody>
				    <tr>
				    	<th>이벤트 등록일</th>
				    	<td>
				    		<input type="date" name="" id="" disabled/>
				    	</td>
				    </tr>
				    <tr>
				    	<th>이벤트 시작일</th>
				    	<td>
				    		<input type="date" name="" id="" disabled/>
				    	</td>
				    </tr>
				    <tr>
				    	<th>이벤트 이름</th>
				    	<td>
				    		<input type="text" name="" id="" disabled/>
				    	</td>
				    </tr>
				    <tr>
				    	<th>진행 기간</th>
				    	<td>
				    		<input type="date" name="" id="" disabled/>
				    		<span>~</span>
				    		<input type="date" name="" id="" disabled/>
				    		<span>총 00일</span>
				    	</td>
				    </tr>
				    <tr>
				    	<th>조회수</th>
				    	<td>
				    		111
				    	</td>
				    </tr>
				    <tr>
				    	<th>정기 이벤트 유무</th>
				    	<td>
				    		<input type="checkbox" name="" id="" disabled/>
				    	</td>
				    </tr>
				    <tr>
				    	<th>글쓴이</th>
				    	<td>
				    		한치
				    	</td>
				    </tr>
				    <tr>
				    	<th>해당 이벤트 아이템</th>
				    	<td>
				    	</td>
				    </tr>
				    <tr>
				    	<th>배너 파일</th>
				    	<td>
				    		<input type="file" name="" id="" disabled/>
				    	</td>
				    </tr>
		  	 </tbody>
		</table>
		<div class="promotion-img col-10 mx-auto">
			<img src="${pageContext.request.contextPath}/resources/images/1300x170.png" alt="" class="img-thumbnail" />
		</div>
		<div class="col-md-10 mx-auto">
            <label for="contents" class="col-form-label"></label>
            <textarea id="summernote" name="editordata"></textarea>
        </div>
        <div class="promotion-detail-btns d-flex justify-content-center col-10 mx-auto mt-5 mb-5">
        	<button type="button" class="promotion-btn btn btn-primary">수정</button>
        	<button type="button" class="promotion-btn btn btn-secondary">삭제</button>
        	<button type="button" class="promotion-btn btn btn-dark">목록</button>
        </div>
	</div>
</form:form>
<script>
$(document).ready(function() {
	$('#summernote')
		.summernote({
		  height: 300,                 // 에디터 높이
		  minHeight: null,             // 최소 높이
		  maxHeight: null,             // 최대 높이
		  focus: false,                  // 에디터 로딩후 포커스를 맞출지 여부
		  lang: "ko-KR",					// 한글 설정
		  placeholder: '최대 2048자까지 쓸 수 있습니다'	//placeholder 설정
		})
		.summernote('disable');
});
</script>
<jsp:include page="/WEB-INF/views/admin/admin-common/footer.jsp"></jsp:include>
