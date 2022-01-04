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
	<h2>상품 등록</h2><br /><hr /><br />
	
	<form
		enctype="multipart/form-data"
		id ="productFrm"	
		method="POST" 
		action="${pageContext.request.contextPath}/admin/insertProduct.do"
		onsubmit="return checkFrm();"
		>
		
		<div id="formContentTop">
			<h4 class="fw700">상품 이름</h4>
			<input type="text" id="name" class="br"name="name" placeholder="상품 이름" value="실험책상"required/>
			<input id="submitBtn" type="submit" value="상품등록" />
		</div><br />
		

		<div id="formContentMid">
			<div id="productImgContainer">
				<img id ="imgContainer" /><br />
				<div>
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
							<input type="text" name="price" value="10000" />	
						</td>
						<td>
							<select name ="status" class="form-select form-select-lg mb-2" aria-label=".form-select-lg example">
								<option>-- 상품 상태 --</option>
								<option value="Y" selected>공개</option>		
								<option value="N">비공개</option>		
							</select>
						</td>
					</tr>	
									
					<tr>
						<th>제품 단위</th>
					</tr>
					<tr>
						<td>
							<input type="text" name="sku" placeholder="재품 단위" value="개" />
						</td>
					</tr>					
					<tr>
						<th>상품 카테고리</th>
					</tr>

					<tr>
						<td>
							<select id ="largeCategory" name="parentCategoryCode" class="form-select form-select-lg mb-2" aria-label=".form-select-lg example" required>
								<option selected value="0">--대분류--</option>
								<option value="ke">키보드</option>
								<option value="mn">모니터</option>
								<option value="mo">마우스</option>
								<option value="ch">의자</option>
								<option value="de">책상</option>
								<option value="ot">기타</option>
							</select>
						</td>
						<td>
							<select id="smallCategory"  name="childCategoryCode" class="form-select form-select-lg mb-2" aria-label=".form-select-sm example" required>
								<option value="0">소분류</option>
							</select>
						</td>
					</tr>					
				
				</table>
				<hr />			
				<table id="optionTable">			
					<tr>
						<td class="option">색상</td><td><input name="option" type="text" value="black" /></td>
						<td class="option">옵션내용</td><td><input name="optionContent" type="text" value=""/></td>
						<td class="option">재고</td><td><input name="quantity" type="text" value="1" /></td>
						<td><button class="btn btn-primary option-add-btn" type="button"><i class="fas fa-plus-square"></i></button></td>
					</tr>
					
				</table>
				<hr /><br />						
				<textarea class="form-control" rows="5" name="content" id="summernote" ></textarea>
			<!-- infoContainer 끝 -->
			</div>
		<!-- contentMid  끝  -->	
		</div>		
	</form>
			
</div>


<script>

/*  옵션 추가 버튼 */
$(".option-add-btn").click(e=>{
	var trCnt = $("#optionTable tr").length;
	if(trCnt < 5){		
		$(optionTable).append(`<tr>
				<td class="option">색상</td><td><input name="option" type="text" value="red" /></td>
				<td class="option">옵션내용</td><td><input name="optionContent" type="text" value="" /></td>
				<td class="option">재고</td><td><input name="quantity" type="text" value="1" /></td>
				<td><button class="btn btn-danger delete-btn" type="button"><i class="fas fa-minus-square"></i></button></td>
			</tr>`);
	}
	else{
		alert("최대 5개까지만 가능합니다");
		return false;
	}	
	/*  옵션 삭제 버튼  */
	$(".delete-btn").click(e=>{	
		const $target = $(e.target).parents("tr");
		console.log($target);
		$target.remove();
	});
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

let imgs = "";
/* 썸머노트 */
$(document).ready(function() {
	//여기 아래 부분
	$('#summernote').summernote({
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
			url : "${pageContext.request.contextPath}/product/uploadSummernoteImageFile",
			contentType : false,
			processData : false,
			success(data){
				console.log(data);
				//imgs 변수 안에 /filename 추가. /는 구분자
				imgs += "/" + data["filename"];
				$('#summernote').summernote('insertImage', "${pageContext.request.contextPath}/resources/upload/product/productSummerNoteImg/"+data["filename"]);
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
    		url : "${pageContext.request.contextPath}/product/deleteSummernoteImageFile",
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
$(submitBtn).click((e)=>{
    $(window).unbind('beforeunload');
    $(document.promotionEnrollFrm).submit();    
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


