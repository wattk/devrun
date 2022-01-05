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
			<h3 class="fw500">카테고리 검색</h3>
		</div>
		<div class ="search-bar">
			<div class="report-search-container mt-3">
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
					<p class="text-center">대분류</p>
				</div>
				<div class="category-box-content">
					<div class="large-category"><p>모니터</p></div>
					<div class="large-category"><p>키보드</p></div>
					<div class="large-category"><p>마우스</p></div>
					<div class="large-category"><p>책상</p></div>
					<div class="large-category"><p>의자</p></div>					
					<div class="large-category"><p>기타상품</p></div>					
				</div>
			</div>
			
			<!-- 소분류 -->
			<div class="select-category">
				<div class="category-box-title">
					<p class="text-center">소분류</p>
				</div>
				<div class="category-box-sub">
					<span class="small-category-title text-center">소분류 이름</span>
					<span class="small-category-title text-center">소분류 코드</span>
				</div>
				<div class="category-box-content">
					<div class="small-category"><p>모니터</p></div>
					<div class="small-category"><p>키보드</p></div>
					<div class="small-category"><p>마우스</p></div>
					<div class="small-category"><p>책상</p></div>
					<div class="small-category"><p>의자</p></div>					
					<div class="small-category"><p>기타상품</p></div>					
				</div>				
			</div>
		</div>
		<div id="buttonContainer">
		</div>
	</div>
	
	<div class="main-footer">
		<div class="category-title ">
		</div>
		<div class="insert-category">
		</div>
	</div>
</div>


<script>
	
</script>


<jsp:include page="/WEB-INF/views/admin/admin-common/footer.jsp"></jsp:include>
