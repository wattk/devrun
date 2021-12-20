<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<jsp:include page="/WEB-INF/views/admin/admin-common/header.jsp">
	<jsp:param value="상품관리" name="title"/>
</jsp:include>

<div id="productInsertContainer" class="productContainer">
	<h2>상품 등록</h2>
	<div id=imgInfoContainer>
		<div id="productImg">
			-
		</div>
		<div id="productInfo" >
			<div>
				<h3 class="fw600">[상품 코드] 상품명</h3>
			</div><hr />
			
			<table id="infoTable">
				<tr>
					<th>상품가격</th>
					<td><input type="text" placeholder="상품 가격"/></td>
				</tr>
				<tr>
					<th>내용</th>
					<td><input type="text" placeholder="상품 내용"/></td>
				</tr>
				<tr>
					<th>상품 상태</th>
					<td>
						<input type="radio" name="status" id="public" />
						<label for="public">공개</label>
						<input type="radio" name="status" id="private" />
						<label for="private">비공개</label> 
					</td>
					
				</tr>
				<tr>
					<th>상품 카테고리</th>
					<td>
						<select class="form-select form-select-lg mb-2" aria-label=".form-select-lg example">
							<option selected>대분류</option>
							<option value="keyboard">키보드</option>
							<option value="mouse">마우스</option>
							<option value="chair">의자</option>
							<option value="desk">책상</option>
							<option value="other">기타</option>
						</select>
						
						<select class="form-select form-select-sm" aria-label=".form-select-sm example">
							<option value="0">소분류</option>
						</select>
					</td>
				</tr>
			</table>
					
		</div>
	</div>
	
	
</div>


<jsp:include page="/WEB-INF/views/admin/admin-common/footer.jsp"></jsp:include>


