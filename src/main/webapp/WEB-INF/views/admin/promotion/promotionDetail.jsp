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
<script src="${pageContext.request.contextPath }/resources/js/admin/promotionDetail.js"></script>
<div class="container">
<div class="promotion-container">
	<h3 class="mt-5 ml-5">이벤트 관리</h3>
	<strong class="ml-5 pl-2">이벤트 상세보기</strong>
</div>
	<div class="event-list">
		<hr />
		<strong class=" pl-5">이벤트 정보</strong>
		<form:form name="promotionUpdateFrm" action="${pageContext.request.contextPath}/admin/promotionUpdate.do" method="post" enctype="multipart/form-data">
			<input type="hidden" name="promotionCode" value="${promotion.promotionCode}" />
			<table id="promotionDetailTbl" class="admin-tbl table mx-auto mt-3 col-md-12">
				<tbody>
				    <tr>
				    	<th>이벤트 등록일</th>
				    	<td>
				    		<input type="date" name="enrollDate" id="" value='<fmt:formatDate value="${promotion.enrollDate}" pattern="yyyy-MM-dd"/>' disabled/>
				    	</td>
				    </tr>
				    <tr>
				    	<th>이벤트 이름</th>
				    	<td>
				    		<input type="text" name="name" id="" class="promotion-input w-50" value="${promotion.name}" disabled/>
				    	</td>
				    </tr>
				    <tr>
				    	<th>진행 기간</th>
				    	<td>
				    		<input type="date" name="startDate" id="startDate" class="promotion-input" value='<fmt:formatDate value="${promotion.startDate}" pattern="yyyy-MM-dd"/>' disabled/>
				    		<span>~</span>
				    		<input type="date" name="endDate" id="endDate" class="promotion-input" value='<fmt:formatDate value="${promotion.endDate}" pattern="yyyy-MM-dd"/>' disabled/>
				    		<span>총 <span id="calculateDate"></span>일</span>
				    	</td>
				    </tr>
				    <tr>
				    	<th>조회수</th>
				    	<td>
				    		${promotion.viewCount}
				    	</td>
				    </tr>
				    <tr>
				    	<th>정기 이벤트 유무</th>
				    	<td>
				    		<input type="checkbox" name="isRegular" id="" class="promotion-input" ${promotion.regular? 'checked':''} disabled/>
				    	</td>
				    </tr>
				    <tr>
				    	<th>글쓴이</th>
				    	<td>
				    		${promotion.nickname}
				    	</td>
				    </tr>
				    <tr>
				    	<th>해당 이벤트 아이템</th>
				    	<td id="productContainer">
				    		<div class="d-flex">
					    		<input type="text" id="productCodeSearch" class="bg-light border-0 small promotion-input" placeholder="상품번호를 입력하세요." disabled>
					             <button id="productAddBtn" class="btn btn-primary promotion-input" type="button" disabled>
					                 <i class="fas fa-plus-square"></i>
					             </button>
				    		</div>
				    		<ul id="productCodeList" class="list-group">
				    			<c:forEach items="${promotion.productList}" var="product" varStatus="vs">
				    			<li class="list-group-item">
									${product.productCode} (${product.name})<i class="product-x-btn fas fa-times pl-2 text-danger"></i>
									<input type="hidden" name="" value="${product.productCode}" />
								</li>
				    			</c:forEach>
							</ul>
				    	</td>
				    </tr>
				    <tr>
				    	<th>배너 파일</th>
				    	<td>
				    		<input type="file" name="upFile" id="banner" class="promotion-input" disabled/>
				    		<input type="hidden" name="banner" value="${promotion.banner }" />
				    	</td>
				    </tr>
		  	 	</tbody>
			</table>
			<div class="promotion-img col-12 mx-auto">
				<img src="${pageContext.request.contextPath}/resources/upload/promotion/${promotion.banner}" alt="" class="img-thumbnail" />
			</div>
			<div class="col-md-12 mx-auto">
	            <label for="contents" class="col-form-label"></label>
	            <textarea id="summernoteDetail" name="sideNote">${promotion.sideNote}</textarea>
	        </div>
		</form:form>
        <div id="promotionDetailBtns" class="d-flex justify-content-center col-10 mx-auto mt-5 mb-5">
        	<button type="button" id="promotionEditBtn" class="promotion-btn btn btn-primary">수정</button>
        	<button type="button" id="promotionDeleteBtn" class="promotion-btn btn btn-secondary">삭제</button>
        	<button type="button" id="promotionCancelBtn" class="promotion-btn btn btn-dark" onclick="location.href='${pageContext.request.contextPath}/admin/promotionManage.do'">목록</button>
        </div>
        <form:form name="promotionDeleteFrm" action="${pageContext.request.contextPath}/admin/promotionDelete.do" method="post">
        	<input type="hidden" name="promotionCode" value="${promotion.promotionCode}" />
        </form:form>
	</div>
</div>
<script>
//수정 버튼 클릭 시 비활성화 풀기 & 수정 버튼 등록 버튼으로 변경하고 삭제/목록 버튼 대신 취소 버튼 만들기
$(promotionEditBtn).click((e)=>{
	const $inputArr = $('#promotionDetailTbl .promotion-input');
	$inputArr.each((i, item)=>{
		$(item).prop('disabled', false);
	});
	$('#summernoteDetail').summernote('enable');
	
	$(promotionDetailBtns)
		.html('')
		.append(`<button type="button" id="promotionUpdateBtn" class="promotion-btn btn btn-primary">등록</button>
	        	<button type="button" id="promotionResetBtn" class="promotion-btn btn btn-secondary" onclick="location.reload(true);">취소</button>`);
	
	//상품 x 버튼 클릭 시 list 제외
	$(".product-x-btn").click((e)=>{
		const $li = $(e.target).parent("li");
		const $product = $(e.target).siblings("input:hidden");
		console.log($li);
		console.log($product);
		$("#productContainer").append($product.attr("name", "deleteProductCode"));
		$li.detach();
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
	
	
	//등록 버튼 클릭 시 form 제출
	$(promotionUpdateBtn).click((e)=>{
		$(document.promotionUpdateFrm).submit();	
	});
});

//삭제 버튼 클릭 시 이벤트 삭제
$(promotionDeleteBtn).click((e)=>{
	$(document.promotionDeleteFrm).submit();
});


//이벤트 기간 계산 후 넣기
$(document).ready((e)=>{
	const startDate = $("#startDate").val();
	const endDate = $("#endDate").val();
	
	const start = new Date(startDate).getTime();
	const end = new Date(endDate).getTime();
	
	let validMillis = end - start;
	let validDates = validMillis / (1000*60*60*24);
	
	$("#calculateDate").text(validDates);
});


</script>
<jsp:include page="/WEB-INF/views/admin/admin-common/footer.jsp"></jsp:include>
