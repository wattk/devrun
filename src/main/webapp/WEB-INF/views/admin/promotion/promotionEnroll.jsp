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
	<strong class="ml-5 pl-2">이벤트 등록</strong>
</div>
<form:form>
	<div class="event-list">
		<hr />
		<strong class="ml-5 pl-5">이벤트 정보</strong>
			<table id="promotionDetailTbl" class="admin-tbl table mx-auto mt-3 col-md-10">
				<tbody>
				    <tr>
				    	<th>이벤트명</th>
				    	<td>
				    		<input type="text" name="name" id="name" class="bg-light border-0 small" />
				    	</td>
				    </tr>
				    <tr>
				    	<th>이벤트 기간</th>
				    	<td>
				    		<input type="date" name="startDate" id="startDate" class="bg-light border-0 small"/>
				    		<span>~</span>
				    		<input type="date" name="endDate" id="endDate" class="bg-light border-0 small"/>
				    		<span>총 <span id="calculateDate"></span>일</span>
				    		<input type="hidden" name="validDates" id="validDates" disabled />
				    	</td>
				    </tr>
				    <tr>
				    	<th>해당 이벤트 아이템</th>
				    	<td >
				    		<div class="d-flex">
					    		<input type="text" id="productCodeSearch" class="bg-light border-0 small" placeholder="상품번호를 입력하세요."
						             aria-label="Search" aria-describedby="basic-addon2">
						         <div class="input-group-append">
						             <button class="btn btn-primary" type="button">
						                 <i class="fas fa-plus-square"></i>
						             </button>
						         </div>
				    		</div>
				    		<ul class="list-group">
							  <li class="list-group-item">
							  </li>
							</ul>
				    	</td>
				    </tr>
				    <tr>
				    	<th>배너 파일</th>
				    	<td>
				    		<input type="file" name="banner" id="banner" />
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
            <textarea id="summernote" name="sideNote"></textarea>
        </div>
        <div id="promotionDetailBtns" class="d-flex justify-content-center col-10 mx-auto mt-5 mb-5">
        	<button type="button" id="promotionEnrollBtn" class="promotion-btn btn btn-primary">등록</button>
	        <button type="button" id="promotionResetBtn" class="promotion-btn btn btn-secondary">취소</button>
        </div>
	</div>
</form:form>
<script>
//썸머노트 작동
$(document).ready(function() {
	$('#summernote')
		.summernote({
		  height: 300,                 // 에디터 높이
		  minHeight: null,             // 최소 높이
		  maxHeight: null,             // 최대 높이
		  focus: false,                  // 에디터 로딩후 포커스를 맞출지 여부
		  lang: "ko-KR",					// 한글 설정
		  placeholder: '최대 2048자까지 쓸 수 있습니다'	//placeholder 설정
		});
	
	//file 업로드 시 화면에 해당 이미지 띄우기
	$(banner).on("change", (e)=>{
		let file = e.target.files[0];
		
		if(!file.type.match("image.*")){
			alert("이미지 파일만 업로드 가능합니다.");
			$(e.target).val('');
			return;
		}
		
		let reader = new FileReader();
		reader.onload = function(e){
			$(promotionBanner).attr("src", e.target.result);
		}
		reader.readAsDataURL(file);
	});
	
	
	//취소 버튼 클릭 시 디테일창으로
	$(promotionResetBtn).click((e)=>{
		location.href = "${pageContext.request.contextPath}/admin/promotionDetail.do";
	});
	
	//이벤트 기간 지정 시 진행 일수 계산해서 띄우기
	$("#endDate").on("change", (e)=>{
		const startDate = $("#startDate").val();
		const endDate = $(e.target).val();
		
		const start = new Date(startDate).getTime();
		const end = new Date(endDate).getTime();
		
		if(end < start || end < Date.now()){
			alert("잘못된 기간입니다.");
			$(e.target).val('');
			return;
		}
		
		let validMillis = end - start;
		let validDates = validMillis / (1000*60*60*24);
		
		$("#calculateDate").text(validDates);
	});
	
	//상품번호 autocomplete
	$(productCodeSearch).autocomplete({
		source(request, response){
			const {term : searchCode} = request;
			$.ajax({
				url : "${pageContext.request.contextPath}/admin/promotionAutocomplete",
				data : {searchCode},
				success(data){
					console.log(data);
				},
				error : console.log
			});
		}
	});
	
	
	//등록 버튼 클릭 시 form 제출
	$(promotionEnrollBtn).click((e)=>{
		
	});										
});




</script>
<jsp:include page="/WEB-INF/views/admin/admin-common/footer.jsp"></jsp:include>
