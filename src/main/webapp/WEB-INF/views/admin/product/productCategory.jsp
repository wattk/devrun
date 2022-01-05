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
					<span class="small-category-title fw-600 ">대분류 이름</span>
					<span class="small-category-title fw-600">대분류 코드</span>
				</div>
				<hr style="margin: 0px;"/>
				<div id="sctableContainer">
				<table id="parentCategoryTbl" class="category-table">
					<c:forEach items="${list}" var="pc">
						<tr>
							<td>${pc.parentCategoryTitle }</td>
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
					<span class="small-category-title fw-600 ">소분류 이름</span>
					<span class="small-category-title fw-600">소분류 코드</span>
				</div>
				<hr style="margin: 0px;"/>
				<div id="sctableContainer">
					<table id="smallCategoryTbl" class="category-table">
						<tr><td>모니터</td><td>mo</td></tr>
						<tr><td>모니터</td></tr>
						<tr><td>모니터</td></tr>
						<tr><td>모니터</td></tr>
						<tr><td>모니터</td></tr>
						<tr><td>모니터</td></tr>
						<tr><td>모니터</td></tr>
						<tr><td>모니터</td></tr>
						<tr><td>모니터</td></tr>
						<tr><td>모니터</td></tr>
						<tr><td>모니터</td></tr>
					</table>				
				</div>
			</div>
		</div>
		<div id="buttonContainer">
			
		</div>
	</div>
	<div class="main-footer">
		<div class="category-title ">
			<button type="button"id="updateCategoryBtn" class="btn-blue w-70">수정</button>	
			<button type="button"id="updateCategoryBtn" class="btn-red w-70">삭제</button>	
		</div>
		<br />
		<div class="insert-category">
			<div class="insert-category-title">
				<i class="fas fa-star-of-life"></i><span class="fw500 fs-23">카테고리 추가</span>
			</div> 
			<div id="insertCategoryBar">
				<select name="selectCategory" id="selectCategory" class="h-40 t-input">
					<option value="largeCategory">대분류</option>
					<option value="smallCategory">소분류</option>
				</select>
				<input type="text" id="insertCategory" class="t-input h-40" />
				<button type="button"id="insertCategoryBtn" class="btn-blue search-btn w-70 h-40">추가</button>	
			</div>
		</div>
	</div>
</div>


<script>

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
			
			$("#smallCategoryTbl").empty();
			var newData;
			
			for(var i = 0; i < childCategoryList.length; i++){
				newData += `<tr>
					<td>\${childCategoryList[i].childCategoryTitle}</td>
					<td>\${childCategoryList[i].childCategoryCode}</td>
				</tr>`
			}
			console.log(newData);
			$("#smallCategoryTbl").append(newData);
		},
		error : console.log
		
	});

	
});



/*  호버 이벤트 */
$(".category-table tbody tr").hover(
	e=>{
		$(e.target).parent("tr").css("background","#0d6efd36");
		$(e.target).parent("tr").css("cursor","pointer");
	},
	e=>{
		$(e.target).parent("tr").css("background","white");
	}
)
</script>


<jsp:include page="/WEB-INF/views/admin/admin-common/footer.jsp"></jsp:include>
