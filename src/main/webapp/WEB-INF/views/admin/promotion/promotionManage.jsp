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
<div class="container">
<div class="promotion-container">
	<h3 class="m-5">이벤트 관리</h3>
</div>
<form:form name="promotionDeleteFrm" action="${pageContext.request.contextPath}/admin/promotionDelete.do" method="post">
	<div class="promotion-list">
		<span class="">[총 ${fn:length(promotionList)}개]</span>
		<br />
		<strong class="mr-2">선택한 항목을 </strong>
		<button type="button" id="promotionListDeleteBtn" class="btn btn-secondary" data-dismiss="modal">삭제</button>
		<table class="admin-tbl table table-hover mx-auto mt-3 text-center checkbox-group">
			<thead>
			    <tr>
			      <th scope="col" style="width : 1vw;">
			      	<input type="checkbox" name="" id="checkAll" class="" />
			      </th>
			      <th scope="col" style="width : 3vw;">번호</th>
			      <th scope="col" style="width : 7vw;">이벤트 등록일</th>
			      <th scope="col" style="width : 10vw;">이벤트 이름</th>
			      <th scope="col" style="width : 7vw;">이벤트 아이템</th>
			      <th scope="col" style="width : 6vw;">이벤트 상태</th>
			      <th scope="col" style="width : 7vw;">이벤트 시작일</th>
			      <th scope="col" style="width : 7vw;">이벤트 종료일</th>
			      <th scope="col" style="width : 6vw;">글쓴이</th>
			      <th scope="col" style="width : 4vw;">조회수</th>
			    </tr>
			</thead>
			<tbody>
			<c:if test="${not empty promotionList}">
				
				<c:forEach items="${promotionList}" var="promotion" varStatus="vs">
				    <tr>
				      <td>
				      	<input type="checkbox" name="" class="promotion-is-checked" data-target="${promotion.promotionCode}"/>
				      </td>
				      <td class="text-center">${vs.count}</td>
				      <td><fmt:formatDate value="${promotion.enrollDate}" pattern="yyyy-MM-dd"/></td>
				      <td style="word-break : keep-all;">
				      	<a href="${pageContext.request.contextPath}/admin/promotionDetail.do?promotionCode=${promotion.promotionCode}">${promotion.name}</a>
				      </td>
				      <td class="text-center">
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
</div>
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

$("#promotionListDeleteBtn").click((e)=>{
    let isChecked = false;
    
    $(".promotion-is-checked").each((i, item)=>{
        isChecked = isChecked || $(item).is(":checked");
        let target = $(item).data("target");
        
        if($(item).is(":checked")){
        	$(item).after(`<input type="hidden" name="promotionCode" value="\${target}"/>`);
        }
    });
    
    if(!isChecked){
    	alert("선택된 이벤트가 없습니다.");
    	return;
    }
	
    console.log("클릭");
    console.log($(document.promotionDeleteFrm));
    $(document.promotionDeleteFrm).submit();
});
</script>
<jsp:include page="/WEB-INF/views/admin/admin-common/footer.jsp"></jsp:include>
