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
			<form
				id="productFrm" 
				action="${pageContext.request.contextPath}/admin/insertProduct.do"
				method="POST">
				
				<table id="infoTable">
					<tr>
						<th>상품코드</th>
						<td><input type="text" name="productCode" placeholder="상품 코드" value="test_001" required/></td>
					</tr>
					<tr>
						<th>상품이름</th>
						<td><input type="text" name="name" placeholder="상품 이름" value="실험책상"required/></td>
					</tr>
					<tr>
						<th>상품가격</th>
						<td><input type="text" name="price" placeholder="상품 가격" value="10000" required/></td>
					</tr>
					<tr>
						<th>옵션번호</th>
						<td><input type="text" name="optionNo" placeholder="옵션 번호" value="0" /></td>
					</tr>
					<tr>
						<th>옵션 내용</th>
						<td><input type="text" name="optionContent" placeholder="옵션 내용" value="-" /></td>
					</tr>
					<tr>
						<th>제품 단위</th>
						<td><input type="text" name="sku" placeholder="재품 단위" value="개" /></td>
					</tr>
					<tr>
						<th>재고량</th>
						<td><input type="text" name="quantity" placeholder="재고량" value="0" /></td>
					</tr>
					<tr>
						<th>내용</th>
						<td><input type="text" name="content" placeholder="상품 내용" value="-" required/></td>
					</tr>
					<tr>
						<th>상품 상태</th>
						<td>
							<input type="radio" id="public" name="status" value="Y"/>
							<label for="public">공개</label>
							<input type="radio" id="private" name="status" value="N" checked />
							<label for="private">비공개</label> 
						</td>
						
					</tr>
					<tr>
						<th>상품 카테고리</th>
						<td>
							<select id ="largeCategory" class="form-select form-select-lg mb-2" aria-label=".form-select-lg example">
								<option selected>--대분류--</option>
								<option value="ke">키보드</option>
								<option value="mo">마우스</option>
								<option value="ch">의자</option>
								<option value="de">책상</option>
								<option value="ot">기타</option>
							</select>
							
							<select id="smallCategory"  name="childCategoryCode" class="form-select form-select-sm" aria-label=".form-select-sm example">
								<option value="0">소분류</option>
							</select>
						</td>
					</tr>
				</table>
				<input id="submitBtn" type="submit" value="상품등록" />
			</form>
					
		</div>
	</div>
	
</div>


<script>

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


