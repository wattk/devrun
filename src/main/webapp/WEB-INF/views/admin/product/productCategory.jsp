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



<!-------------- 카테고리 추가 중복검사 모달 -------------->

<!-- Button trigger modal -->
<button id="insertCategoryBtnModal" type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#insertModal">
  Launch demo modal
</button>

<!-- Modal -->
<div class="modal fade" id="insertModal" tabindex="-1" aria-labelledby="insertModalLabel" aria-hidden="true">
	<div class="modal-dialog">
    	<div class="modal-content">
	    	<div class="modal-header">
	      		<h5 class="insert-modal-title" id="insertModalLabel">중복검사</h5>
	      		<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	        </div>
	        <div class="insert-modal-body">     	
	        	<div id="modalInsertTitle" class="modal-insert-container">
	        	<form action="">
		    		<span class="fw600">
		    			<input type="hidden" id="insertTitleCheckNo"/>
		    			<input type="hidden" name="selectInsertKind" class="select-insert-kind" />
		    			<input type="text" id="modalInsertTitleInput" name="modalInsertTitleInput" class="t-input h-40 modal-insert-input" placeholder ="카테고리 이름을 입력하세요." />
		    			<span class="checkDuple"><button type="button"id="insertTitleCheckBtn" class="btn-blue">중복 확인</button></span>  
		    		</span>
	        	</form>
	        	</div>
	        	<div id="modalInsertCode" class="modal-insert-container">
	        	<form action="">
		    		<span class="fw600">
		    			<input type="hidden" id="insertCodeCheckNo"/>
		    			<input type="hidden" name="selectInsertKind" class="select-insert-kind" />
		    			<input type="text" id="modalInsertCodeInput" name="modalInsertCodeInput"  class="t-input h-40 modal-insert-input" placeholder ="카테고리 코드를 입력하세요" />
		    			<span class="checkDuple"><button type="button"id="insertCodeCheckBtn" class="btn-blue">중복 확인</button></span>    
		    		</span>						    		
	        	</form>
	        	</div>
	        </div>
	        <span id="inputData"></span>
	        <span id="insertWarning">
	        </span>
        	<div class="modal-footer">
        		<button type="button"id="useTitleBtn" class="btn-blue useBtn" >사용하기</button>
        		<button type="button"id="useCodeBtn" class="btn-blue useBtn" >사용하기</button>
        		<button type="button" id="cancleTitleBtn" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
        		<button type="button" id="cancleCodeBtn" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
        	</div>
    	</div>
	</div>
</div>


<!----------------   카테고리 추가 모달 끝-------------------------  -->




<!-------------- 카테고리 수정 모달 -------------->

<!-- Button trigger modal -->
<button id="updateBtnModal" type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#updateModal">
  Launch demo modal
</button>

<!-- Modal -->
<div class="modal fade" id="updateModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content" id="categoryModalContent">
      <div class="modal-header">
        <h5 class="modal-title fw600">수정하기</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body" id="categoryUpdateModalBody">
      	<div id="selectCategoryKindContainer">
      		<select name ="selectCategoryKind" id="selectCategoryKind" class="h-40 t-input">
				<option value="updateTitle">카테고리 이름</option>
				<option value="updateCode">카테고리 코드</option>
			</select>
      	</div>
      	<div id="updateCodeContainer"class="update-category-code modal-select-category">
      	<form 
      		name="updateCodeFrm"
      		onsubmit="return checkFrm()"
      		class="updateFrms"
      	 	action="${pageContext.request.contextPath}/admin/product/updateCategory.do"
      		method="POST"   	
      	>      	
      	    <input type="hidden" name ="updateKind"/>
      		<input type="hidden" id="checkCode" value="0" />
      		<span class="fw600"><input type="text" id="beforeCode" name="beforeCode" class="t-input h-40" placeholder ="변경전 코드" /></span>
      		<span class="fw600"><i class="fas fa-arrow-circle-right fa-2x code-arrow"></i></span>
      		<span class="fw600 "><input type="text" id="updateCategoryCode" name="updateCategoryCode" class="t-input h-40 input-update-data" placeholder ="변경할 코드를 입력하세요"  /></span>
       		<span class="checkDuple"><button type="button"id="checkCodeBtn" class="btn-blue w-70">중복 확인</button></span>   
      	</form>
      	</div>

      	<div id="updateTitleContainer"class="update-category-title modal-select-category">
      	<form
			 name="updateTitleFrm"  
			 class="updateFrms"    		
      		 onsubmit="return checkFrm()"
      		 action="${pageContext.request.contextPath}/admin/product/updateCategory.do"
      		 method="POST"
      		 
      		 >
      		<input type="hidden" name ="updateKind"/>
      		<input type="hidden" id="checkTitle" value="0" />
      		<span class="fw600"><input type="text" id="beforeTitle" name="beforeTitle" class="t-input h-40" placeholder ="변경전 이름" /></span>
      		<span class="fw600"><i class="fas fa-arrow-circle-right fa-2x title-arrow"></i></span>
      		<span class="fw600 "><input type="text" id="updateCategoryTitle" name="updateCategoryTitle" class="t-input h-40 input-update-data" placeholder ="변경할 이름을 입력하세요"  /></span>      	
      		<span class="checkDuple"><button type="button"id="checkTitleBtn" class="btn-blue w-70">중복 확인</button></span>      	
      	</form>
      	</div>
      	<div id="warningText">
      
      	</div>
      </div>
      <div class="modal-footer">
        <button type="button" id="updateBtn" class="btn btn-primary">수정</button>
        <button type="button" id="cancelBtn"class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
      </div>
    </div>
  </div>
</div>


<!-----------------------------------------  -->

<!-------------- 카테고리 삭제 모달 -------------->

<!-- Button trigger modal -->
<button id="deleteBtnModal" type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#deleteModal">
  Launch demo modal
</button>

<!-- Modal -->
<div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title fw600">확인</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body" id="categoryDeleteModalBody">
      	<h5 class="fw600"> <span id="preVal"></span><span id="afterVal"></span>해당 카테고리를 삭제하시겠습니까?</h5>
      </div>
      <div class="modal-footer">
        <button type="button" id="deleteBtn" class="btn btn-primary">삭제</button>
        <button type="button" id="cancelBtn"class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
      </div>
    </div>
  </div>
</div>


<!-----------------------------------------  -->

<div id="productCategoryContainer" class="main-container">
	<div class="main-top">
		<div class="search-title">
			<i class="fas fa-star-of-life"></i><span class="fw-500 fs-25">카테고리</span>
		</div>
		<div class ="search-bar">
		</div>
	</div>
	
	<div class="main-body">
		<div id="categoryContainer">
			<!-- 대분류  -->
			<div class="select-category ">
				<div class="category-box-title">
					<p class="text-center fs-23 mmb-0 fw-600">대분류</p>
				</div>
					<div class="category-box-sub">
					<span class="parent-category-title fw-600 ">대분류 이름</span>
					<span class="parent-category-title fw-600">대분류 코드</span>
				</div>
				<hr style="margin: 0px;"/>
				<div id="prtableContainer">
				<table id="parentCategoryTbl" class="category-table">
					<c:forEach items="${list}" var="pc">
						<tr>
							<td class="c-title">${pc.parentCategoryTitle}</td>
							<td class="c-code">${pc.parentCategoryCode}</td><td><i class="fas fa-angle-right fa-2x"></i></td>
						</tr>
					</c:forEach>
				</table>
				</div>
			</div>
			
			<!-- 소분류 -->
			<div class="select-category">
				<div class="category-box-title">
					<p class="text-center fs-23 mmb-0 fw-600 ">소분류</p>
				</div>
				<div class="category-box-sub">
					<span class="child-category-title fw-600 ">소분류 이름</span>
					<span class="child-category-title fw-600">소분류 코드</span>
				</div>
				<hr style="margin: 0px;"/>
				<div id="chtableContainer">
					<table id="childCategoryTbl" class="category-table">
						<c:forEach items="${cList}" var="pc">
							<tr>
								<td class="c-title">${pc.childCategoryTitle}</td>
								<td class="c-code">${pc.childCategoryCode}</td><td><i class="fas fa-angle-right fa-2x"></i></td>
							</tr>
						</c:forEach>
					</table>				
				</div>
			</div>
		</div>
		<div id="buttonContainer">
			
		</div>
	</div>
	<div class="main-footer">
		<div class="category-title ">
			<form>			
				<button type="button"id="updateCategoryBtn" class="btn-blue w-70">수정</button>	
			</form>
			<form 
				action="${pageContext.request.contextPath }/admin/product/deleteCategory.do"
			 	method="POST"
			 	name="deleteCategoryFrm">
				<input type="hidden" name="deleteChildCategoryCode" id="deleteChildCategoryCode" />
				<input type="hidden" name="deleteParentCategoryCode" id="deleteParentCategoryCode" />
				<button type="button"id="deleteCategoryBtn" class="btn-red w-70">삭제</button>	
			</form>
		</div>
		<br />
		<div class="insert-category">
			<div class="insert-category-title">
				<i class="fas fa-star-of-life"></i><span class="fw500 fs-23">카테고리 추가</span>
			</div> 
			<div id="insertCategoryBar">
				<form
					method="POST" 
					name="insertCategoryFrm"
					action="${pageContext.request.contextPath }/admin/product/insertCategory.do"
					onsubmit="return checkinsertCategory();"
					>
					<select name="selectCategory" name="categoryKind" id="selectCategory" class="h-40 t-input">
						<option value="parentCategory">대분류</option>
						<option value="childCategory">소분류</option>
					</select>
					<span></span>
					
					<input type="hidden" id="insertTitleCheckNoFinal" value="0" />
					<input type="hidden" id="insertCodeCheckNoFinal" value="0" />
					<input type="text" id="insertCategoryTitle" name="categoryTitle" class="t-input h-40" placeholder ="이름을 입력하세요" />
					<input type="text" id="insertCategoryCode" name="categoryCode" class="t-input h-40" placeholder ="코드를 입력하세요"  />
					<button type="button"id="insertCategoryBtn" class="btn-blue search-btn w-70 h-40">등록</button>	
				</form>
			</div>
		</div>
	</div>
</div>

<script>

/* 최종 추가 폼 제출 유효성 검사  */

function checkinsertCategory(){
	
	var insertTitleCheckNoFinal = $("#insertTitleCheckNoFinal").val();
	var insertCodeCheckNoFinal = $("#insertCodeCheckNoFinal").val();
	
	console.log("insertTitleCheckNoFinal = ",insertTitleCheckNoFinal);
	console.log("insertCodeCheckNoFinal = ",insertCodeCheckNoFinal);
	
	if(!(insertTitleCheckNoFinal == "1" && insertCodeCheckNoFinal == "1" )){
		alert("추가할 카테고리의 이름과 코드를 확인해주세요.");
		return false;
	}
	
	return true;
}

/* 버튼 클릭시 최종 카테고리 추가 폼 제출 */
$(insertCategoryBtn).click(e=>{
	$(document.insertCategoryFrm).submit();
});


/* 카테고리 코드 사용하기 버튼 이벤트 */
$(useCodeBtn).click(e=>{
	
	console.log("중복체크 = ", $(modalInsertCodeInput).val());
	// 중복 검사가 완료 됐을때만 작동
	if($(insertCodeCheckNo).val() != "1"){
		alert("중복검사를 해주세요")
		$(modalInsertCodeInput).focus();
	}
	else{

		// 중복검사 한 뒤 이름 입력값을 바꿀경우 checkNo초기화
		
		$(insertModal).modal('hide');
		$(insertCategoryCode).val($(modalInsertCodeInput).val());	
		// 폼 제풀할 때 사용할 checkNo값 +1		
		$(insertCodeCheckNoFinal).val("1");
		
		$("#insertCodeCheckNo").val("0");
	}
	
});
	

/* 카테고리 이름 사용하기 버튼 이벤트 */
$(useTitleBtn).click(e=>{
	
	console.log("중복체크 = ", $(modalInsertTitleInput).val());
	// 중복 검사가 완료 됐을때만 작동
	if($(insertTitleCheckNo).val() != "1"){
		alert("중복검사를 해주세요")
		$(modalInsertTitleInput).focus();
	}
	else{

		// 중복검사 한 뒤 이름 입력값을 바꿀경우 checkNo초기화
		
		$(insertModal).modal('hide');
		$(insertCategoryTitle).val($(modalInsertTitleInput).val());	
		// 폼 제풀할 때 사용할 checkNo값 +1		
		$(insertTitleCheckNoFinal).val("1");
		
		$("#insertTitleCheckNo").val("0");
	}
	
});

/* 카테고리 이름,코드 중복검사 모달 enter 이벤트 */
$("#modalInsertTitleInput").keydown(e=>{	
	if(e.keyCode == 13){
		$(insertTitleCheckBtn).trigger("click");
		e.preventDefault();		
	}
});

$("#modalInsertCodeInput").keydown(e=>{
	if(e.keyCode == 13){
		$(insertCodeCheckBtn).trigger("click");
		e.preventDefault();		
	}
});


/* 카테고리 등록 코드 중복검사 실시 */
$("#insertCodeCheckBtn").click(e=>{
	var insertCode = $("#modalInsertCodeInput").val();
	
	// 중복검사에 할 때 넣은 값을 넣어줌
	if(!($("#modalInsertCodeInput").val())){
		alert("추가할 코드를 입력해주세요");
		$("#modalInsertCodeInput").focus();
		return;
	}
	
	// 업데이트 할 때 쓴 중복검사 메소드 값들을 그대로 쓰기 위해 key값은 동일하게 
	const obj = {
				"afterUpdateCategoryCode" : insertCode			
			}
	
	$.ajax({
		url :`${pageContext.request.contextPath}/admin/productCategory/checkCategoryCode.do`,
		data:obj,
		contentType : "application/json; charset=utf-8",
		success(data){
			console.log(data);
		
			if(data.result){
				$("#insertCodeCheckNo").val("1");
				$("#insertWarning").html(`<p class="posible">\${data.afterUpdateCategoryCode}은/는 사용 가능한 이름입니다.</p>`);
			}
			else{
				$("#insertCodeCheckNo").val("2");				
				$("#insertWarning").html(`<p class="imposible">\${data.afterUpdateCategoryCode}은/는 이미 사용중인 이름입니다.</p>`);
			}
		},
		error : console.log
	});
	
		
});



/* 카테고리 등록 이름 중복검사 실시 */
$("#insertTitleCheckBtn").click(e=>{
	var insertTitle = $("#modalInsertTitleInput").val();
	
	// 중복검사에 할 때 넣은 값을 넣어줌
	if(!($("#modalInsertTitleInput").val())){
		alert("추가할 이름을 입력해주세요");
		$("#modalInsertTitleInput").focus();
		return;
	}
	
	
	// 업데이트 할 때 쓴 중복검사 메소드 값들을 그대로 쓰기 위해 key값은 동일하게 
	const obj = {
				"afterUpdateCategoryTitle" : insertTitle			
			}
	
	$.ajax({
		url :`${pageContext.request.contextPath}/admin/productCategory/checkCategoryTitle.do`,
		data:obj,
		contentType : "application/json; charset=utf-8",
		success(data){
			console.log(data);
		
			if(data.result){
				$("#insertTitleCheckNo").val("1");
				$("#insertWarning").html(`<p class="posible">\${data.afterUpdateCategoryTitle}은/는 사용 가능한 이름입니다.</p>`);
			}
			else{
				$("#insertTitleCheckNo").val("2");				
				$("#insertWarning").html(`<p class="imposible">\${data.afterUpdateCategoryTitle}은/는 이미 사용중인 이름입니다.</p>`);
			}
		},
		error : console.log
	});
	
		
});


/* 카테고리 등록 중복검사 모달 띄우기 */ 
$("#insertCategoryTitle ,#insertCategoryCode").focusin(e=>{
	$(insertWarning).html("");
	
	if(e.target.id == "insertCategoryTitle"){
		$(modalInsertTitle).show();	
		$(useTitleBtn).show();
		$(cancleTitleBtn).show();
		
		$(modalInsertCode).hide();
		$(useCodeBtn).hide();
		$(cancleCodeBtn).hide();
	}
	if(e.target.id == "insertCategoryCode"){
		$(modalInsertCode).show();		
		$(useCodeBtn).show();
		$(cancleCodeBtn).show();
		
		$(modalInsertTitle).hide();		
		$(useTitleBtn).hide();
		$(cancleTitleBtn).hide();
	}
	
	$(insertCategoryBtnModal).trigger("click");
});


//=======================================================================================================


var checkNo;

/*업데이트 처리 */
$("#updateBtn").click(e=>{
	// checkNo 값 넣을때 사용
	var kind = $(selectCategoryKind).val();
	
	console.log($(selectCategoryKind).val());
	
	// checkNo 값 세팅
	if(kind =="updateTitle"){
		checkNo = $(checkTitle).val();	
	}
	else{
		checkNo = $(checkCode).val();
	}
	
	// checkNo 값 세팅 후 제출
	if(kind == "updateTitle"){
		$(updateTitleFrm).submit();
	}
	else{
		$(updateCodeFrm).submit();		
	}
	
	
			
});

/* 업데이트 유효성 검사 */
function checkFrm(){
	console.log("checkNo = ",checkNo);
	
	if(!$(beforeTitle).val()){
		alert("변경 대상을 선택 또는 입력해주세요");
		$(beforeTitle).focus();
		return false;
	}
	
	if(checkNo == "2"){
		alert("입력값을 변경해주세요.");
		$(".input-update-data").focus();
		return false;
	}
	else if(checkNo != "1"){
		alert("중복 검사를 해주세요.");
		$(".input-update-data").focus();
		return false;
	}
	else{
		return true;
	}
	return true;
}




/* 업데이트 할 종류 선택에 따른 화면처리 */
$(selectCategoryKind).change(e=>{
	// 선택한 카테고리도 form에 같이 제출 
	$("input[name=updateKind]").val($("#selectCategoryKind").val());
	
	/* 업데이트 유효성 검사에 쓸 숫자 초기화 */
	checkNo = "0";
	var selectCategoryKind = $("#selectCategoryKind").val();
	$(".modal-select-category")
		.hide()
		.filter("#"+ selectCategoryKind +"Container")
		.css("display", "flex");
	$("#warningText").html('');
	
	
});

/* 업데이트 코드 값 중복검사 실시 */
$("#checkCodeBtn").click(e=>{
		
	var afterUpdateCategoryCode = $("#updateCategoryCode").val();
	
	if(!($("#updateCategoryCode").val())){
		alert("변경할 이름을 입력해주세요");
		$("#updateCategoryCode").focus();
		return;
	}	
	
	console.log("afterUpdateCategoryCode = ",afterUpdateCategoryCode);
	
	const obj = {
				"afterUpdateCategoryCode" : afterUpdateCategoryCode,		
			}
	
	
	$.ajax({
		url :`${pageContext.request.contextPath}/admin/productCategory/checkCategoryCode.do`,
		data:obj,
		contentType : "application/json; charset=utf-8",
		success(data){
			console.log(data);
			if(data.result){
				$(".code-arrow").css("color","blue");
				$("#warningText").html(`<p class="posible">사용 가능한 코드입니다.</p>`);
				$("#checkCode").val("1");
			}
			else{
				$("#checkCode").val("2");
				$(".code-arrow").css("color","red");				
				$("#warningText").html(`<p class="imposible">이미 사용중인 코드입니다.</p>`);
			}
		},
		error : console.log
	});
	
		
});

/* 업데이트 이름 중복검사 실시 */
$("#checkTitleBtn").click(e=>{
	var afterUpdateCategoryTitle = $("#updateCategoryTitle").val();
	
	if(!($("#updateCategoryTitle").val())){
		alert("변경할 이름을 입력해주세요");
		$("#updateCategoryTitle").focus();
		return;
	}
	
	console.log("afterUpdateCategoryTitle = ",afterUpdateCategoryTitle);
	
	const obj = {
				"afterUpdateCategoryTitle" : afterUpdateCategoryTitle			
			}
	
	$.ajax({
		url :`${pageContext.request.contextPath}/admin/productCategory/checkCategoryTitle.do`,
		data:obj,
		contentType : "application/json; charset=utf-8",
		success(data){
			console.log(data);
			if(data.result){
				$("#checkTitle").val("1");
				$(".code-arrow").css("color","blue");
				$("#warningText").html(`<p class="posible">사용 가능한 이름입니다.</p>`);
			}
			else{
				$("#checkTitle").val("2");
				$(".code-arrow").css("color","red");				
				$("#warningText").html(`<p class="imposible">이미 사용중인 이름입니다.</p>`);
			}
		},
		error : console.log
	});
	
		
});



/* 업데이트전의 값을 띄우는데 사용할 전역 변수  */
var updateCategoryCode;
var updateCategoryTitle;


/* 업데이트 버튼 클릭시 모달로 값 입력 */
$(updateCategoryBtn).click(e=>{
	// 모달을 다시 띄울 시 입력되있던 체크 번호 0으로 초기화 및 알림 텍스트 초기화
	$(checkCode).val("0");
	$(checkTitle).val("0");
	$(".posible, .imposible").html("");
	
	$(updateBtnModal).trigger("click");
	
	// updateKind값 세팅
	$("input[name=updateKind]").val($("#selectCategoryKind").val());
	
	$("#beforeCode").val(updateCategoryCode);
	$("#beforeTitle").val(updateCategoryTitle);
	
});

/* 업데이트전의 값을 띄우는데 사용할 전역 변수 값 세팅  */
$(document).on("click","#categoryContainer td",e=>{
	updateCategoryCode = $(e.target).parent("tr").find(".c-code").text();
	updateCategoryTitle = $(e.target).parent("tr").find(".c-title").text();
	
	console.log("updateCategoryCode = ",updateCategoryCode);
	console.log("updateCategoryTitle = ",updateCategoryTitle);
});


/* 삭제하기 버튼 클릭시 모달로 확인  */
$("#deleteCategoryBtn").click(e=>{
	$(deleteBtnModal).trigger("click");
});
/* 삭제버튼 클릭시 삭제 진행 */
$("#deleteBtn").click(e=>{
	$(deleteCategoryFrm).submit();
});

/* 삭제할 때 사용할 전역 변수 */
var usingParentCategoryCode;
var usingParentCategoryTile;

var usingChildCategoryCode;
var usingChildCategoryTitle;

/* 요소 선택시 삭제를 위해 해당 값들을 세팅해준다. */
$(document).on("click","#prtableContainer td",e=>{
	
	usingParentCategoryCode = $(e.target).parent("tr").find(".c-code").text();
	usingParentCategoryTitle = $(e.target).parent("tr").find(".c-title").text();
	
	/* console.log("타겟 parentCode =",usingParentCategoryCode); */
	
	/* 해당 form 내의 input 에 값 대입 */
	$("#updateParentCategoryCode, #deleteParentCategoryCode").val(usingParentCategoryCode);
	
});

$(document).on("click","#chtableContainer td",e=>{
	
	usingChildCategoryCode = $(e.target).parent("tr").find(".c-code").text();
	usingChildCategoryTitle = $(e.target).parent("tr").find(".c-title").text();
	console.log("타겟 childCode =",usingChildCategoryCode);
	
	/* 해당 form 내의 input 에 값 대입 */
	$("#updateChildCategoryCode, #deleteChildCategoryCode").val(usingChildCategoryCode);
	
});


/* 카테고리 추가 대소분류 구분 */
$(selectCategory).change(e=>{
	var target = $(e.target).val();
	console.log(target == 'childCategory');

	if(target == 'childCategory'){	
		
		var categoryStr = `<option>---대분류 선택---</option>`;
		/* 비동기 요청을 보내 대분류 값 받아오기 */
			$.ajax({
				url :`${pageContext.request.contextPath}/admin/productCategory/selectParentCategory.do`,
				contentType : "application/json; charset=utf-8",
				success(data){
					const parentCategoryList = data.parentCategoryList;
					console.log(parentCategoryList.length);
					
					$("#selectCategory").next().html(`
						<select name="selectParentCategory" id="selectParentCategory" class="h-40 t-input">								
						</select>`);
					
					for(var i = 0; i < parentCategoryList.length; i++){
						categoryStr += `<option value="\${parentCategoryList[i].parentCategoryCode}">\${parentCategoryList[i].parentCategoryTitle}</option>/>`
					}
					
					console.log(categoryStr);
					$("#selectCategory").next().find("select").html(categoryStr);
				},
				error : console.log			
			});		
					
			}else{
				$("#selectCategory").next().html('');
			}

	/* 소분류 코드를 선택하면 대분류를 선택한 뒤 parentCode 값을 전역변수에 넣어 chileCategory 등록할 때 사용 */
	$(document).on("change","#selectParentCategory",e=>{
		console.log($(e.target).val());		
	});	
});

/* 소분류 이름 코드 비동기로 가져오기 */
$("#parentCategoryTbl td").click(e=>{
	const code = $(e.target).parent("tr").find(".c-code").text();
	
	var obj = {"code": code}
	
	$.ajax({
		url :`${pageContext.request.contextPath}/admin/productCategory/searchChildCategory.do`,
		data : obj,
		contentType : "application/json; charset=utf-8",
		success(data){
			console.log(data);	
			const childCategoryList = data.childCategoryList;
			
			$("#childCategoryTbl").empty();
			var newData;
			
			for(var i = 0; i < childCategoryList.length; i++){
				newData += `<tr>
					<td class="c-title">\${childCategoryList[i].childCategoryTitle}</td>
					<td class="c-code">\${childCategoryList[i].childCategoryCode}</td>
				</tr>`
			}
			console.log(newData);
			$("#childCategoryTbl").append(newData);
		},
		error : console.log		
	});
	
});

/*  호버 이벤트 */
$(document).ready(function(){
	
    $(document).on({
        mouseenter: function (e) {
        	$(e.target).parent("tr").css("background","#0d6efd36");
    		$(e.target).parent("tr").css("cursor","pointer");
    		
    		// 클릭 시 ho 클래스 추가하여 호버 고정효과를 줌
    		$(document).on("click",".category-table td",e=>{				
    			$(e.target).parent("tr").addClass("ho");
    		});
    		// 다른 항목 선택시 기존 선택항목 제거
    		$(document).on("click",".category-table td",e=>{				
    			$(e.target).parent("tr").siblings().removeClass("ho");						
    		});
    		
    		$(document).on("dblclick",".category-table td",e=>{				
    			$(e.target).parent("tr").removeClass("ho");
    		});
        },
        mouseleave: function (e) {
    		$(e.target).parent("tr").css("background","white");
        }
    },".category-table tr");
	

    
});



</script>


<jsp:include page="/WEB-INF/views/admin/admin-common/footer.jsp"></jsp:include>
