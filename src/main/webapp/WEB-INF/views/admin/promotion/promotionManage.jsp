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
<link href="${pageContext.request.contextPath }/resources/css/admin/adminManage.css" rel="stylesheet"/>
<script src="${pageContext.request.contextPath }/resources/js/admin/promotionManage.js"></script>
<div class="modal fade" id="promotionModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="modalProductTitle">이벤트 대상 제품</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body" id="modalProductList">
        
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>
<div class="promotion-container">
	<h3 class="m-5">이벤트 관리</h3>
</div>
<form:form name="promotionDeleteFrm" action="${pageContext.request.contextPath}/admin/promotionDelete.do" method="post">
	<div class="promotion-list">
		<span class="m-5 pl-4">[총 ${fn:length(promotionList)}개]</span>
		<br />
		<strong class="ml-5 mr-2 pl-4">선택한 항목을 </strong>
		<button type="button" id="promotionListDeleteBtn" class="btn btn-secondary" data-dismiss="modal">삭제</button>
		<table class="admin-tbl table table-hover mx-auto mt-3 text-center checkbox-group">
			<thead>
			    <tr>
			      <th scope="col">
			      	<input type="checkbox" name="" id="checkAll" class="" />
			      </th>
			      <th scope="col">번호</th>
			      <th scope="col">이벤트 등록일</th>
			      <th scope="col">이벤트 이름</th>
			      <th scope="col">이벤트 아이템</th>
			      <th scope="col">이벤트 상태</th>
			      <th scope="col">이벤트 시작일</th>
			      <th scope="col">이벤트 종료일</th>
			      <th scope="col">글쓴이</th>
			      <th scope="col">조회수</th>
			    </tr>
			</thead>
			<tbody>
			<c:if test="${not empty promotionList}">
				
				<c:forEach items="${promotionList}" var="promotion" varStatus="vs">
				    <tr>
				      <td>
				      	<input type="checkbox" name="" class="promotion-is-checked" data-target="${promotion.promotionCode}"/>
				      </td>
				      <td>${vs.count}</td>
				      <td><fmt:formatDate value="${promotion.enrollDate}" pattern="yyyy-MM-dd"/></td>
				      <td>
				      	<a href="${pageContext.request.contextPath}/admin/promotionDetail.do?promotionCode=${promotion.promotionCode}">${promotion.name}</a>
				      </td>
				      <td>
				      	<button type="button" class="product-modal-btn btn btn-light" data-toggle="modal" data-target="#promotionModal" data-code="${promotion.promotionCode}">확인</button>
				      </td>
				      <td>${promotion.regular?"정기":"비정기"}</td>
				      <td><fmt:formatDate value="${promotion.startDate}" pattern="yyyy-MM-dd"/></td>
				      <td><fmt:formatDate value="${promotion.endDate}" pattern="yyyy-MM-dd"/></td>
				      <td>${promotion.nickname}</td>
				      <td>${promotion.viewCount}</td>
				    </tr>
			    </c:forEach>
			 </c:if>
			 <c:if test="${empty promotionList}">
			 	<tr>
			 		<td colspan="10">이벤트가 존재하지 않습니다.</td>
			 	</tr>
			 </c:if>
	  	 </tbody>
	</table>
	<div class="text-right">
		<button type="button" class="event-write-btn btn btn-primary">이벤트 등록</button>
	</div>
	</div>
</form:form>
<script>
$(".event-write-btn").click((e)=>{
	location.href = `${pageContext.request.contextPath}/admin/promotionEnroll.do`;
});


$(".product-modal-btn").click((e)=>{
	const promotionCode = $(e.target).data("code");
	
	$.ajax({
		url : `${pageContext.request.contextPath}/admin/findProductList`,
		data : {promotionCode : promotionCode},
		method : "GET",
		success(data){
			console.log(data);
			$(data).each((i, product) => {			
				$("#modalProductList").append(`<p>\${product['PRODUCT_CODE']}(\${product['NAME']})</p>`);
			});
		},
		error : console.log
		
	});
});
</script>
<jsp:include page="/WEB-INF/views/admin/admin-common/footer.jsp"></jsp:include>
