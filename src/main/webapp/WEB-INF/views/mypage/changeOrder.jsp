<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>	
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="changeOrder" name="title"/>
</jsp:include>
<link href="${pageContext.request.contextPath }/resources/css/shop/order.css" rel="stylesheet">
<script src="${pageContext.request.contextPath }/resources/js/shop/order.js"></script>
<form:form name="orderLogFrm" method="POST" action="${pageContext.request.contextPath}/order/orderLogEnroll">
<input type="hidden" name="merchantUid" value="${merchant.merchantUid }" />
<input type="hidden" name="memberNo" value='<sec:authentication property="principal.memberNo"/>' />
<div class="claim-container p-5 position-relative">
	<h3>교환/환불/취소 신청</h3>
	<div class="card-container ">
		<div id="claimOne" class="claim-card card m-5 position-absolute show">
		  <div class="card-header d-flex justify-content-center">
		  	<div class="claim-text pr-2">
			  	<span class="badge badge-primary">1</span>
			  	<span>주문 선택</span>
		  	</div>
		  	<span class="pr-2 my-auto">─</span>
		  	<div class="claim-text pr-2">
			  	<span class="badge badge-dark">2</span>
			  	<span>사유 선택</span>
		  	</div>
		  	<span class="pr-2 my-auto">─</span>
		  	<div class="claim-text pr-2">
			  	<span class="badge badge-dark">3</span>
			  	<span>해결 방법 선택</span>
		  	</div>
		  </div>
		  <div class="card-body m-4">
		  	<span>${merchant.merchantUid}</span>
		  	<h5>${imp.name }</h5>
		  	<span><fmt:formatDate value="${merchant.orderDate}" pattern="yy-MM-dd"/></span>
	  	  	<table class="claim-table table m-3 pr-3">
			  <tbody>
			    <c:forEach items="${productList}" var="product" varStatus="vs">
				    <tr class="ml-3 mr-3">
				      <td rowspan="" class="col-1">
				      	<img src="${pageContext.request.contextPath}/resources/upload/product/${product.thumbnail}" alt="" class=" img-b w-75" >
					  </td>
				      <td class="col-4 align-middle ">
				      	<strong class="pl-2 align-middle">${product.name}</strong><span class="align-middle pl-3">${product.productDetail.optionNo} ${product.productDetail.optionContent}</span>
				      </td>
				      <td class="col-1">
				      	${product.buyCount}개 구매
				      </td>
				    </tr>
			    </c:forEach>
			    <tr>
			    	<td colspan="3">
					 	<button 
					  	  type="button" 
					  	  id="" 
					  	  class="claim-btn btn btn-primary w-100 h-50 mt-2 order-btn"
					  	  data-target="#claimTwo">
					  	  다음 단계
					    </button>
			    	</td>
			    </tr>
			  </tbody>
		    </table>
		  </div>
		</div>
		<div id="claimTwo" class="claim-card card m-5 position-absolute">
		  <div class="card-header d-flex justify-content-center">
		  	<div class="claim-text pr-2">
			  	<span class="badge badge-dark">1</span>
			  	<span>주문 선택</span>
		  	</div>
		  	<span class="pr-2 my-auto">─</span>
		  	<div class="claim-text pr-2">
			  	<span class="badge badge-primary">2</span>
			  	<span>사유 선택</span>
		  	</div>
		  	<span class="pr-2 my-auto">─</span>
		  	<div class="claim-text pr-2">
			  	<span class="badge badge-dark">3</span>
			  	<span>해결 방법 선택</span>
		  	</div>
		  </div>
		  <div class="card-body m-4">
		  	<h5>어떤 문제가 있나요?</h5>
		  	<ul class="list-group">
			  <li class="list-group-item">
			  	<strong>단순 변심</strong>
			  </li>
			  <li class="list-group-item">
			  	<input type="radio" name="reasonCode" id="reason1" value="C"/>
			  	<label for="reason1">상품이 마음에 들지 않음</label>
			  	<div class="claim-detail text-center">
			  	</div>
			  </li>
			  <li class="list-group-item">
			  	<strong>상품 문제</strong>
			  </li>
			  <li class="list-group-item">
			  	<input type="radio" name="reasonCode" id="reason2" value="P"/>
			  	<label for="reason2">상품이 구성품/부속품이 들어가 있지 않음</label>
			  	<div class="claim-detail text-center">
			  	</div>
			  </li>
			  <li class="list-group-item">
			  	<input type="radio" name="reasonCode" id="reason3" value="D"/>
			  	<label for="reason3">상품이 설명과 다름</label>
			  	<div class="claim-detail text-center">
			  	</div>
			  </li>
			  
			  <li class="list-group-item">
			  	<input type="radio" name="reasonCode" id="reason4" value="P"/>
			  	<label for="reason4">상품이 파손됨/기능 오동작</label>
			  	<div class="claim-detail text-center">
			  	</div>
			  </li>
			</ul>
		  	<hr />
			<div class="d-flex">
				<button 
			  	  type="button" 
			  	  id="" 
			  	  class="claim-btn btn btn-secondary w-50 mt-2 m-2 order-btn"
			  	  data-target="#claimOne">
			  	  이전 단계
			    </button>
				<button 
			  	  type="button" 
			  	  id="" 
			  	  class="claim-btn btn btn-primary w-50 mt-2 m-2 order-btn"
			  	  data-target="#claimThree">
			  	  다음 단계
			    </button>
			</div>
		  </div>
		</div>
		<div id="claimThree" class="claim-card card m-5 position-absolute">
		  <div class="card-header d-flex justify-content-center">
		  	<div class="claim-text pr-2">
			  	<span class="badge badge-dark">1</span>
			  	<span>주문 선택</span>
		  	</div>
		  	<span class="pr-2 my-auto">─</span>
		  	<div class="claim-text pr-2">
			  	<span class="badge badge-dark">2</span>
			  	<span>사유 선택</span>
		  	</div>
		  	<span class="pr-2 my-auto">─</span>
		  	<div class="claim-text pr-2">
			  	<span class="badge badge-primary">3</span>
			  	<span>해결 방법 선택</span>
		  	</div>
		  </div>
		  <div class="card-body m-4">
		  	<div>
		  		<strong>선택한 주문</strong>
		  		<div>
		  			<img src="${pageContext.request.contextPath }/resources/upload/product/${productList[0].thumbnail}" alt="" class="img-b img-thumbnail w-25">
			      	<span class="align-middle pl-3">${imp.name }</span>
		  		</div>
		  		<hr />
		  		<strong>선택한 사유</strong>
		  		<p id="selectReason"></p>
		  	</div>
		  	<hr />
		  	<h5 class="pt-2">어떤 해결 방법을 원하세요?</h5>
	  	  <c:if test="${merchant.orderStatus eq 'OR' or merchant.orderStatus eq 'PP' }">
		  	<ul class="list-group">
		  	  <li class="list-group-item">
			  	<input type="radio" name="csStatus" id="cancel" value="CAN"/>
			  	<label for="exchange" class="m-0">주문취소</label>
			  </li>
			 </ul>
	  	  </c:if>
	  	  <c:if test="${merchant.orderStatus eq 'SS' or merchant.orderStatus eq 'OC' }">
	  	    <ul class="list-group">
		  	  <li class="list-group-item">
			  	<input type="radio" name="csStatus" id="exchange" value="EXC"/>
			  	<label for="exchange" class="m-0">교환</label>
			  </li>
		  	  <li class="list-group-item">
			  	<input type="radio" name="csStatus" id="refund" value="RET"/>
			  	<label for="refund" class="m-0">반품 후 환불</label>
			  </li>
		  	</ul>
		  </c:if>
			<div class="d-flex">
				<button 
			  	  type="button" 
			  	  id="" 
			  	  class="claim-btn btn btn-secondary w-50 mt-2 m-2 order-btn"
			  	  data-target="#claimTwo">
			  	  이전 단계
			    </button>
				<button 
			  	  type="button" 
			  	  id="orderLogEnrollBtn" 
			  	  class="claim-submit-btn btn btn-primary w-50 mt-2 m-2 order-btn">
			  	  신청
			    </button>
			</div>
		  </div>
		</div>
	</div>
</div>
</form:form>
<script>
$("#orderLogEnrollBtn").click((e)=>{
	const orderLogUid = 'ORLG_' + new Date().getTime();
	const data = new FormData(document.orderLogFrm);
	data.append("orderLogUid", orderLogUid);
	const obj = {};
	
	for(const [k,v] of data){
		obj[k] = v;
	}
	const jsonStr = JSON.stringify(obj);
	console.log(jsonStr);
	
	$.ajax({
		url : "${pageContext.request.contextPath}/order/orderLogEnroll",
		data : jsonStr,
		dataType : "json",
		method : "POST",
		contentType : "application/json; charset=utf-8",
		success(data){
			console.log(data);
			if(data.token != null){
				
			}
		},
		error : console.log
		
	});
})
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
