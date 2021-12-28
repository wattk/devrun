<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<jsp:include page="/WEB-INF/views/admin/admin-common/header.jsp">
	<jsp:param value="상품관리" name="title"/>
</jsp:include>

<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.20/summernote-lite.min.js" integrity="sha512-lVkQNgKabKsM1DA/qbhJRFQU8TuwkLF2vSN3iU/c7+iayKs08Y8GXqfFxxTZr1IcpMovXnf2N/ZZoMgmZep1YQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="${pageContext.request.contextPath}/resources/js/summernote/lang/summernote-ko-KR.js"></script>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/summernote/summernote-lite.css">

<div id="productInsertContainer" class="productContainer">
	<h2>상품 정보</h2><br />
	
	<form
		enctype="multipart/form-data"
		id="productFrm" 
		action="${pageContext.request.contextPath}/admin/updateProduct.do"
		onsubmit="return checkFrm"
		method="POST">
		<hr /><br />
	
		<input type="hidden" name="productCode" value="${productCode}" />
		
		
		<div id="formContentTop">
			<h4 class="fw700">상품 이름</h4>
			<input type="text" id="name" class="br"name="name" placeholder="상품 이름" value="${productInfo.name}"required/>
			<input id="submitBtn" type="submit" value="상품 수정" />
		</div><br />
		
		<div id="formContentMid">
			<div id="productImgContainer">	
				<img id ="imgContainer" src="${pageContext.request.contextPath}/resources/upload/product/${productInfo.thumbnail}"/><br />	
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
							<input type="text" name="price" value="<fmt:formatNumber value="${productInfo.price}"pattern="#,###"/>" />	
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
							<input type="text" name="sku" placeholder="재품 단위" value="" required/>
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
				<div id="deleteOptionContainer"></div>
				<table id="optionTable">
					<tr><th>옵션 추가</th><td><button class="btn btn-primary option-add-btn" type="button"><i class="fas fa-plus-square"></i></button></td></tr>
					<c:forEach items="${productDetail }" var="pd">
					<tr>
						<td class="option">DN</td><td><input class="detailNo" name="detailNo" type="text" value="${pd.detailNo}" readonly /></td>
						<td class="option">색상</td><td><input class="option" name="option" type="text" value="${pd.optionNo}" /></td>
						<td class="option">옵션내용</td><td><input class="optionContent"name="optionContent" type="text" value="${pd.optionContent}" /></td>
						<td class="option">재고</td><td><input class="quantity" name="quantity" type="number" value="${pd.quantity}" /></td>
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
				<td class="option">DN</td><td> <input class="detailNo" name="insertDetailNo" type="text" value="" /> </td>
				<td class="option">색상</td><td><input class="option" name="insertOption" type="text" value="red" /></td>
				<td class="option">옵션내용</td><td><input class="optionContent" name="insertOptionContent" type="text" value="-" /></td>
				<td class="option">재고</td><td><input class="quantity" name="insertQuantity" type="text" value="1" /></td>
				<td><button class="btn btn-danger delete-btn" type="button"><i class="fas fa-minus-square"></i></button></td>
			</tr>`);
	}

	else{
		alert("최대 5개까지만 가능합니다");
	}
	
	/* 동적으로 detailNo값 넣어주기  */
	$insertProductDetail = $(".insert-option").parents("tr");
	console.log($insertProductDetail);
 	$lastDetailNo = $("#optionTable").find(".detailNo").eq($("#optionTable").find(".detailNo").length-2).val();
	console.log(Number($lastDetailNo)+1);
	$("#optionTable").find(".detailNo").eq($("#optionTable").find(".detailNo").length-1).val(Number($lastDetailNo)+1);
	
	
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
		$deleteOptionContainer = $("#deleteOptionContainer");
		
		const $detailNo =  $(e.target).parents("tr").children("td").children("input[name=detailNo]");
		console.log($detailNo);
		
		if(trCnt > 2){
			/* console.log($target); */
		$deleteOptionContainer.append($detailNo.attr("name", "deleteDetailNo"));
			
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
	
	/* 이미지 변경시 파일선택 위에 덮어 쓴 span 태그를 감춤  */
	$("#fileName").hide();
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

/* 상품 등록 유효성 검사  */
function checkFrm(){
	
	if($("#imgInput").val() == "") {
		alert("상품 이미지를 선택해주세요");
	    $("#imgInput").trigger("click");
	    return false;
	}
	
	if($("#summernote").value == ""){
		alert("내용을 입력하세요");
		return false;
	}
	
	if($("#smallCategory option").val() == 0){
		alert("상품 분류를 선택해주세요.");
		return false;
	}
}



</script>


<jsp:include page="/WEB-INF/views/admin/admin-common/footer.jsp"></jsp:include>


