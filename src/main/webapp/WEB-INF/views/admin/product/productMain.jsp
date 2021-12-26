<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<jsp:include page="/WEB-INF/views/admin/admin-common/header.jsp">
	<jsp:param value="상품관리" name="title"/>
</jsp:include>

<!-- 모달 -->
<div class="modal fade" id="promotionModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="modalProductTitle">옵션</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
	      <div class="modal-body" id="modalOptionList">
	      <table>
	      	<tr><th>옵션</th><th>재고</th></tr>
	      </table>	
	      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal" id="modalCloseBtn">닫기</button>
      </div>
    </div>
  </div>
</div>

<div class="productContainer">
	<h2>상품 관리</h2>
 
	<div id="productListContainer">
		<div id="title" class="box">
			<div id="imgText">
				<span>총 ${totalContent}개의 상품 중</span>
				<span>선택한 항목 [<span id="selectCount">0</span>]개 </span>
			</div>
			<div id="btnContainer">
			<!-- 상품 삭제시 전송할 form -->
			<form
				id="productDelteFrm"
				name="productDelteFrm"
				action="${pageContext.request.contextPath}/admin/deleteProduct.do"
				method="POST">
				<button 
					id="deleteProductBtn"
					class="btn btn-danger" 
					>상품 삭제</button>
			</form>
			<button 
				id="insertProductBtn"
				class="btn btn-primary" 
				type="button"
				onclick="location.href='${pageContext.request.contextPath}/admin/insertProduct.do'"	>상품등록</button>
			</div>
				
		</div>
		<!-- 상품 리스트 테이블 -->
		<table id="productList">
			<tr>
				<th><input type="checkbox" id="checkAll"/></th>
				<th>이미지</th>
				<th>상품코드</th>
				<th>상품명</th>
				<th>옵션</th>
				<th>상태</th>
				<th>등록일</th>
				<th>조회수</th>
			</tr>
			<c:forEach items="${list}" var="pro" >
			<tr>				
				<td><input type="checkbox"id="select" class="box"/> </td>
				<td><img id="thumbnail" src="${pageContext.request.contextPath}/resources/upload/product/${pro.thumbnail}"/></td>
				<td><a href="${pageContext.request.contextPath}/admin/productDetail.do?productCode=${pro.productCode}">${pro.productCode}</a></td>
				<td>${pro.name}</td>
				<td>
					<button type="button" class="option-modal-btn btn btn-light"
					 data-toggle="modal" data-target="#promotionModal" data-code="${pro.productCode}">확인</button>
				</td>
				<td>${pro.status}</td>
				<td><fmt:formatDate value="${pro.regDate}" pattern="yy-MM-dd HH:mm"/></td>
				<td>${pro.viewCount}</td>
			</tr>
			</c:forEach>
			
		</table>
		<br />
		${pagebar}
		
	</div>
	
	
</div>

<script>
$(()=>{
	let checkedProduct;

		
		
	$(modalCloseBtn).click(e=>{
		$("#modalOptionList table").html(`<tr><th>옵션</th><th>재고량</th></tr>`);
	});
	
	/* 모달 관련 */
	$(".option-modal-btn").click((e)=>{
		const productCode = $(e.target).data("code");
		console.log(productCode);
		$.ajax({
			 url : `${pageContext.request.contextPath}/admin/findProductOption`,
			data : {productCode : productCode},
			method : "GET",
			success(data){
				console.log(data);
				$(data).each((i, productDetail) => {
					$("#modalOptionList table").append(`<tr></tr><tr><td>\${productDetail.optionNo}</td><td>\${productDetail.quantity}</td></tr>`);
				});						
			},
			error : console.log		
		});
	});	
	
	
	
	/*  호버 이벤트 */
	$("#productList tr").hover(
		e=>{
			$(e.target).parent("tr").css("background","#0d6efd36");
		},
		e=>{
			$(e.target).parent("tr").css("background","white");
		}
	)
	
	/* 전체 선택/해제  */
	$(checkAll).change(e=>{
		console.log($("#checkAll").prop("checked"));
		if($("#checkAll").prop("checked")){
			$(".box").prop("checked",true);		
		}
		else{
			$(".box").prop("checked",false);	
		}
		
	});
	
	/* 게시물 선택 */
	$(".box, #checkAll ").change(e=>{
		checkCount = $(".box:checked").length;
		$(selectCount).html(checkCount);
		
		console.log($(".box").length-1 , $(".box:checked").length);
		
		if( $(".box").length-1 == $(".box:checked").length ){
			$("#checkAll").prop("checked",true);
			console.log("전부 체크");
		}
		else{
			$("#checkAll").prop("checked",false);
		}	
		
		// 상품 삭제 : check되어 있는 tr의 product_code값을 가져온뒤 input hidden 값으로 form태그안에 넣어준다 .
		checkedProduct = $(".box:checked").parents("tr").children().eq(2).text();
		console.log(checkedProduct);
		$("#productDelteFrm").append(`<input type="hidden" name="productCodes" value="\${checkedProduct}" />`)
		
		
		
				
		
		
	});
	
});
</script>

<jsp:include page="/WEB-INF/views/admin/admin-common/footer.jsp"></jsp:include>


