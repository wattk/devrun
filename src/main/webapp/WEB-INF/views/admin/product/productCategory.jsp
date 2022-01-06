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



<!-------------- 카테고리 수정 모달 -------------->

<!-- Button trigger modal -->
<button id="updateBtnModal" type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#updateModal">
  Launch demo modal
</button>

<!-- Modal -->
<div class="modal fade" id="updateModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title fw600">확인</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      	<div class="update-category-code">
      		<span class="fw600"><input type="text" id="beforeCode" name="beforeCode" class="t-input h-40" placeholder ="변경전 코드" readonly /></span>
      		<span class="fw600"><i class="fas fa-arrow-circle-right fa-2x"></i></span>
      		<span class="fw600"><input type="text" id="updateCategoryCode" name="updateCategoryCode" class="t-input h-40" placeholder ="변경할 코드를 입력하세요"  /></span>
      	</div>
      	<div class="update-category-title">
      		<span class="fw600"><input type="text" id="beforeTitle" name="beforeTitle" class="t-input h-40" placeholder ="변경전 이름" readonly /></span>
      		<span class="fw600"><i class="fas fa-arrow-circle-right fa-2x"></i></span>
      		<span class="fw600"><input type="text" id="updateCategoryCode" name="updateCategoryCode" class="t-input h-40" placeholder ="변경할 이름을 입력하세요"  /></span>      	
      	</div>
      </div>
      <div class="modal-footer">
        <button type="button" id="deleteBtn" class="btn btn-primary">삭제</button>
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
      <div class="modal-body">
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
			<i class="fas fa-star-of-life"></i><span class="fw-500 fs-25">카테고리 검색</span>
		</div>
		<div class ="search-bar">
			<div class="report-search-container mb-0">
		       <div class="input-group w-50">
		         <input type="text" class="form-control bg-light border-0 small" placeholder="검색어를 입력하세요."
		             aria-label="Search" aria-describedby="basic-addon2">
		         <div class="input-group-append">
		             <button class="btn btn-primary" type="button">검색</button>
		         </div>
		       </div>
			</div>
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
							<td class="c-title">${pc.parentCategoryTitle }</td>
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
								<td class="c-title"> ${pc.childCategoryTitle }</td>
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
			<form action="${pageContext.request.contextPath }/admin/product/updateCategory.do" method="POST">
				<input type="hidden" name="updateChildCategoryCode" id="updateChildCategoryCode" />
				<input type="hidden" name="updateParentCategoryCode" id="updateParentCategoryCode" />
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
				<form method="POST" action="${pageContext.request.contextPath }/admin/product/insertCategory.do">
					<select name="selectCategory" name="categoryKind" id="selectCategory" class="h-40 t-input">
						<option value="parentCategory">대분류</option>
						<option value="childCategory">소분류</option>
					</select>
					<span></span>
					<input type="text" id="insertCategoryTitle" name="categoryTitle" class="t-input h-40" placeholder ="이름을 입력하세요" />
					<input type="text" id="insertCategoryCode" name="categoryCode" class="t-input h-40" placeholder ="코드를 입력하세요"  />
					<button type="submit"id="insertCategoryBtn" class="btn-blue search-btn w-70 h-40">추가</button>	
				</form>
			</div>
		</div>
	</div>
</div>

<script>

/* 업데이트 값 중복검사 실시 */
$("#updateCategoryCode").keyup(e=>{
	console.log("ㅋㅋㅋㅋㅋㅋㅋㅋ");
});

/* 업데이트전의 값을 띄우는데 사용할 전역 변수  */
var updateCategoryCode;
var updateCategoryTitle;


/* 업데이트 버튼 클릭시 모달로 값 입력 */
$(updateCategoryBtn).click(e=>{
	$(updateBtnModal).trigger("click");
	
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
