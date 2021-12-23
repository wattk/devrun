<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<jsp:include page="/WEB-INF/views/admin/admin-common/header.jsp">
	<jsp:param value="상품관리" name="title"/>
</jsp:include>

<c:if test="${not empty msg}">
<script>
	alert("${msg}");
</script>
</c:if>

<div class="productContainer">
	<h2>상품 관리</h2>
	
	<div id="productListContainer">
		<div id="title" class="box">
			<div id="imgText">
				<span>선택한 항목 [ 0 ]개 </span>
			</div>
			<button 
				id="insertProductBtn"
				class="btn btn-primary" 
				type="button"
				onclick="location.href='${pageContext.request.contextPath}/admin/insertProduct.do'"	>상품등록</button>
		</div>
		<!-- 상품 리스트 테이블 -->
		<table id="productList">
			<tr>
				<th><input type="checkbox"/></th>
				<th>이미지</th>
				<th>상품명</th>
				<th>옵션번호</th>
				<th>재고</th>
				<th>상태</th>
				<th>카테고리 코드</th>
				<th>등록일</th>
				<th>조회수</th>
			</tr>
			<c:forEach items="${list}" var="pro" >
			<tr>				
				<td><input type="checkbox"id="select" class="box"/> </td>
				<td><img id="thumbnail" src="${pageContext.request.contextPath}/resources/upload/product/${pro.thumbnail}"/></td>
				<td>${pro.name}</td>
				<td>${pro.optionNo}</td>
				<td>${pro.quantity}</td>
				<td>${pro.status}</td>
				<td>${pro.childCategoryCode}</td>
				<td><fmt:formatDate value="${pro.regDate}" pattern="YYYY/mm/dd hh:mm"/></td>
				<td>${pro.viewCount}</td>
			</tr>
			</c:forEach>
			
		</table>
		
	</div>
	
	
</div>

<script>
	
</script>

<jsp:include page="/WEB-INF/views/admin/admin-common/footer.jsp"></jsp:include>


