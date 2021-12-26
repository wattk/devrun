<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<jsp:include page="/WEB-INF/views/admin/admin-common/header.jsp">
	<jsp:param value="상품관리" name="title"/>
</jsp:include>

<script src="${pageContext.request.contextPath}/resources/js/summernote/summernote-lite.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/summernote/lang/summernote-ko-KR.js"></script>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/summernote/summernote-lite.css">

<div id="productInsertContainer" class="productContainer">
	<h2>상품 정보</h2><br /><hr /><br />
	
	<form
		enctype="multipart/form-data"
		id="productFrm" 
		action="${pageContext.request.contextPath}/admin/updateProduct.do"
		method="POST">
		
		<input type="hidden" name="productCode" value="${productCode}" />
		
		<div id="formContentTop">
			<h4 class="fw700">상품 이름</h4>
			<input type="text" id="name" class="br"name="name" placeholder="상품 이름" value="${productInfo.name}"required/>
			<input id="submitBtn" type="submit" value="상품 수정" />
		</div><br />
		
		<div id="formContentMid">
			<div id="productImgContainer">
				<div id ="imgContainer">
					<c:choose>
						<c:when test="${null eq productInfo.thumbnail}">
							<img id ="img" src="${pageContext.request.contextPath}/resources/upload/product/sample.png"/><br />
						</c:when>
						<c:when test="${null ne productInfo.thumbnail}">
							<img id ="img" src="${pageContext.request.contextPath}/resources/upload/product/${productInfo.thumbnail}"/><br />
						</c:when>					
					</c:choose>
					
				</div>		
			
				<div>
				<span id="fileName">${productInfo.thumbnail}</span>
					<input type="file" name="upFile" id="imgInput" />				
				</div>
			</div>
			
			<div id ="infoContainer">
				<table id="infoTable">
					<tr>
						<th>상품 가격</th>
						<th>상품 상태</th>
					</tr>
					<tr>
						<td>
							<input type="text" name="price"  value="10000" />	
						</td>
						<td>
								
							<select name ="status" class="form-select form-select-lg mb-2" aria-label=".form-select-lg example">
								<option>-- 상품 상태 --</option>								
								<option value="Y" ${String.valueOf(productInfo.status) == "Y" ? "selected" : ""}>공개</option>	
								<option value="N" ${String.valueOf(productInfo.status) == "N" ? "selected" : ""}>비공개</option>	
							</select>
						</td>
					</tr>	
									
					<tr>
						<th>제품 단위</th>
					</tr>
					<tr>
						<td>
							<input type="text" name="sku" placeholder="재품 단위" value="-" />
						</td>
					</tr>					
					<tr>
						<th>상품 카테고리</th>
					</tr>

					<tr>
						<td>
							<select id ="largeCategory" name="parentCategoryCode"
							 class="form-select form-select-lg mb-2" aria-label=".form-select-lg example"
							 onFocus="this.initialSelect = this.selectedIndex;"
							 onChange="this.selectedIndex = this.initialSelect">
								<option selected value="0">--대분류--</option>
								<option value="ke" ${productInfo.parentCategoryCode == "ke" ? "selected" : ""} >키보드</option>
								<option value="mo" ${productInfo.parentCategoryCode == "mo" ? "selected" : ""}>마우스</option>
								<option value="ch" ${productInfo.parentCategoryCode == "ch" ? "selected" : ""}>의자</option>
								<option value="de" ${productInfo.parentCategoryCode == "de" ? "selected" : ""}>책상</option>
								<option value="ot" ${productInfo.parentCategoryCode == "ot" ? "selected" : ""}>기타</option>
							</select>
						</td>
						<td>
							<select id="smallCategory"  name="childCategoryCode" 
							class="form-select form-select-lg mb-2" aria-label=".form-select-sm example"
							onFocus="this.initialSelect = this.selectedIndex;"
							onChange="this.selectedIndex = this.initialSelect">
								<option value="${productInfo.parentCategoryCode}">${productInfo.childCategoryTitle} </option>			
							</select>
						</td>
					</tr>					
				
				</table>
				<hr />			
				<table id="optionTable">
					<tr><th>옵션 추가</th><td><button class="btn btn-primary option-add-btn" type="button"><i class="fas fa-plus-square"></i></button></td></tr>
					<c:forEach items="${productDetail }" var="pd">
					<tr>
						<td class="option">색상</td><td><input name="option" type="text" value="${pd.optionNo}" /></td>
						<td class="option">옵션내용</td><td><input name="optionContent" type="text" value="${pd.optionContent}" /></td>
						<td class="option">재고</td><td><input name="quantity" type="number" value="${pd.quantity}" /></td>
						<!-- <td><button class="btn btn-primary option-add-btn" type="button"><i class="fas fa-plus-square"></i></button></td> -->
						<td><button class="btn btn-danger delete-btn" type="button"><i class="fas fa-minus-square"></i></button></td>
					</tr>
					</c:forEach>								
				</table>
				<hr /><br />						
				<textarea class="form-control" rows="5" name="content" id="summernote">${productInfo.content}</textarea>
			<!-- infoContainer 끝 -->
			</div>
		<!-- contentMid  끝  -->	
		</div>		
	</form>			
</div>

<script>
	// 모든 함수에서 사용 할 option 갯수
	let trCnt;
/*  옵션 추가 버튼 */
$(".option-add-btn").click(e=>{
	trCnt = $("#optionTable tr").length;
	console.log(trCnt);
	if(trCnt < 6){		
		$(optionTable).append(`<tr>
				<td class="option">색상</td><td><input name="option" type="text" value="red" /></td>
				<td class="option">옵션내용</td><td><input name="optionContent" type="text" value="-" /></td>
				<td class="option">재고</td><td><input name="quantity" type="text" value="1" /></td>
				<td><button class="btn btn-danger delete-btn" type="button"><i class="fas fa-minus-square"></i></button></td>
			</tr>`);
	}

	else{
		alert("최대 5개까지만 가능합니다");
	}	
	
	/* 동적으로 추가된 옵션 삭제 버튼  */
	$(".delete-btn").click(e=>{	
		const $target = $(e.target).parents("tr");
		trCnt = $("#optionTable tr").length;
		console.log(trCnt);
		
		if(trCnt > 2){
			console.log($target);
			$target.remove();			
		}
		
	});
});
	/*  페이지 내의 정적옵션 삭제 버튼  */
	$(".delete-btn").click(e=>{
		const $target = $(e.target).parents("tr");
		trCnt = $("#optionTable tr").length;
		console.log(trCnt);
		
		if(trCnt > 2){
			console.log($target);
			$target.remove();			
		}else{
			alert("최소 한개의 옵션은 존재해야만 합니다.");
			return false;
		}		
	});




/* 파일 업로드 화면 띄우기  */
$(imgInput).on("change", (e)=>{
	let file = e.target.files[0];
	
	if(!file.type.match("image.*")){
		alert("이미지 파일만 업로드 가능합니다.");
		$(e.target).val('');
		return;
	}
	
	let reader = new FileReader();
	reader.onload = function(e){
		$(imgContainer).attr("src", e.target.result);
	}
	reader.readAsDataURL(file);
});


/* 썸머노트 */
$(document).ready(function() {
	//여기 아래 부분
	$('#summernote').summernote({
		  height: 300,                 // 에디터 높이
		  minHeight: null,             // 최소 높이
		  maxHeight: null,             // 최대 높이
		  focus: true,                  // 에디터 로딩후 포커스를 맞출지 여부
		  lang: "ko-KR",					// 한글 설정
		  placeholder: '최대 2048자까지 쓸 수 있습니다'	//placeholder 설정
          
	});
});


$("#smallCategory").change(e=>{
	const value = e.target.value;
	console.log(value);	
});


$("#largeCategory").change((e)=>{	
	const value = e.target.value;
	/* console.log(value); */
	
	const obj={"value" : value};
	
	$.ajax({
		url:`${pageContext.request.contextPath}/admin/selectCategory`,
		data:obj,
		contentType : "application/json; charset=utf-8",
		method : "GET",
		success(data){
			for(var i = 0; i < data.list.length; i++){
				const {childCategoryTitle,childCategoryCode} = data["list"][i];
				/* console.log(childCategoryTitle,childCategoryCode); */
				$("#smallCategory").append(`<option value=\${childCategoryCode}>\${childCategoryTitle}</option>`);		
			}						
		},
		error:console.log
	});	
	$("#smallCategory").html("");
	
});
</script>


<jsp:include page="/WEB-INF/views/admin/admin-common/footer.jsp"></jsp:include>


