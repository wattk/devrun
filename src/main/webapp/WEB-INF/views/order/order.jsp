<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>	
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="order" name="title"/>
</jsp:include>
<!-- 주소 검색 관련 카카오 api -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<!--  iamport 관련 임포트 스크립트 -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>

<link href="${pageContext.request.contextPath }/resources/css/shop/order.css" rel="stylesheet">
<script src="${pageContext.request.contextPath }/resources/js/shop/order.js"></script>
<sec:authentication property="principal" var="member"/>
<div class="row p-5 d-flex justify-content-around order-container">
  <div class="col-7">
  	<div class="accordion" id="orderAccordion">
	  <div class="card">
	    <div class="card-header" id="headingOne">
	      <h5 class="mb-0">
	        <button class="btn btn-link order-btn" type="button" data-toggle="collapse" data-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
		        <span class="badge badge-dark">1</span>
		        배송 정보
	        </button>
	      </h5>
	      <div id="orderOne" class="order-list pl-5 pr-5">
	      	<p><strong>택배 배송 : 출고 예정일 3~5일 이내에 배송되며, 2박스 이상으로 분리 배송될 수 있습니다.</strong></p>
		      	<strong>배송지 : </strong>
	      	<p class="add-input"></p>
	      	<strong>출고 예정일 : </strong>
	      	<p id="releaseDate"></p>
	      </div>
	    </div>
	
	    <div id="collapseOne" class="collapse show" aria-labelledby="headingOne" data-parent="#orderAccordion">
	      <div class="card-body pl-5">
	      	배송지 : 
	      	<div class="input-group mb-3 w-75">
			  <input type="text" id="addInput" class="add-input form-control" placeholder="주소" aria-describedby="addInputBtn" value="${addressList[0].address1}">
			  <div class="input-group-append w-10">
			    <span class="input-group-text " id="addInputBtn">수정</span>
			  </div>
			</div>
			<strong>배송 옵션</strong>
			<div class="delivery-option p-3">
				<i class="fas fa-truck"><strong>일반 배송</strong></i>
				<p class="pt-2 mb-0">택배 배송 : 출고 예정일 3~5일 이내에 배송되며, 2박스 이상으로 분리 배송될 수 있습니다.</p>
			</div>
		    <button 
		  	  type="button" 
		  	  id="orderNextBtn" 
		  	  class="btn btn-primary w-100 h-50 mt-2 order-btn" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="true" aria-controls="collapseTwo">
		  	  다음
		    </button>
	      </div>
	    </div>
	  </div>
	  <div class="card">
	    <div class="card-header" id="headingTwo">
	      <h5 class="mb-0">
	        <button class="btn btn-link collapsed order-btn" type="button" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
		        <span class="badge badge-dark">2</span>
		         주문을 어디로 배송할까요?
	        </button>
	      </h5>
	      <div id="orderTwo" class="order-list pl-5 pr-5">
		  	<p>이름 : <span class="name-input" >${member.name}</span></p>
		   	<p>이메일 : <span class="email-input" >${member.email}</span></p>
		   	<p>전화번호 : <span class="phone-input" >${member.phone}</span></p>
		   	<p>상세주소 : <span class="add-detail-input" >${addressList[0].address2}</span></p>
	      </div>
	    </div>
	    <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#orderAccordion">
	      <div class="card-body">
	      	<ul class="list-group">
			  <li class="address-item list-group-item">이름 : <input type="text" class="order-form-control" data-target=".name-input" value="${member.name}" name="" id="" /></li>
			  <li class="address-item list-group-item">이메일 : <input type="text" class="order-form-control" data-target=".email-input" value="${member.email}" name="" id="" /></li>
			  <li class="address-item list-group-item">전화번호 : <input type="text" class="order-form-control" data-target=".phone-input" value="${member.phone}" name="" id="" /></li>
			  <li class="address-item list-group-item">상세주소 : <input type="text" id="addDetailInput" class="add-detail-input order-form-control" data-target=".add-detail-input" value="${addressList[0].address2}" name="" id="" /></li>
			</ul>
		    <button 
		  	  type="button" 
		  	  id="orderNextBtn" 
		  	  class="btn btn-primary w-100 h-50 mt-2 order-btn" data-toggle="collapse" data-target="#collapseThree" aria-expanded="true" aria-controls="collapseThree">
		  	  다음
		    </button>
	      </div>
	    </div>
	  </div>
	  <div class="card">
	    <div class="card-header" id="headingThree">
	      <h5 class="mb-0">
	        <button class="btn btn-link collapsed order-btn" type="button" data-toggle="collapse" data-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
		        <span class="badge badge-dark">3</span>
		        결제
	        </button>
	      </h5>
	    </div>
	    <div id="collapseThree" class="collapse" aria-labelledby="headingThree" data-parent="#orderAccordion">
	      <div class="card-body">
	        <button 
		  	  type="button" 
		  	  id="orderPaymentBtn" 
		  	  class="btn btn-primary w-100 h-50 mt-2" data-toggle="collapse" data-target="#collapseThree" aria-expanded="true" aria-controls="collapseThree">
		  	  <span id="priceInput"></span> 원 결제하기 <i class="fas fa-chevron-circle-right"></i>
		    </button>
	      </div>
	    </div>
	  </div>
	</div>
  </div>
  <div class="col-4 m-3 pl-3 pt-5 d-flex flex-column justify-content-start">
  	<strong>주문 정보</strong>
  	<div class="row d-flex justify-content-start">
  		<img src="${pageContext.request.contextPath }/resources/upload/product/${product.thumbnail}" alt="" class="img-b w-25 p-2">
  	</div>
    <hr class="w-100"/>
	<table class="table order-tbl">
	  <tbody>
	  	<tr>
	  		<th colspan="2">주문 내역</th>
	  	</tr>
	    <tr>
	      <td>주문 금액(배송비 제외)</td>
	      <td class="text-right"><fmt:formatNumber type="currency">${product.price}</fmt:formatNumber></td>
	    </tr>
	    <tr>
	      <td>전체 배송비</td>
	      	<c:choose>
	      		<c:when test="${product.price >= 50000}">
			      <td id="productPrice" class="text-right">
	      			&#8361;0
				  </td>
	      		</c:when>
	      		<c:otherwise>
			      <td id="productPrice" class="text-right">
	      			&#8361;3,000
				  </td>
	      		</c:otherwise>
	      	</c:choose>
	    </tr>
	    <tr>
	      <td>주문 금액(부가세 제외)</td>
	      <td class="text-right">
	      	<fmt:formatNumber type="currency">
		      	<c:choose>
		      		<c:when test="${product.price >= 50000}">
		      			${product.price*0.9}
		      		</c:when>
		      		<c:otherwise>
		      			${(product.price+3000)*0.9}
		      		</c:otherwise>
		      	</c:choose>
	      	</fmt:formatNumber>
	      </td>
	    </tr>
	    <tr>
	      <td>부가세(10%)</td>
	      <td class="text-right">
	      	<fmt:formatNumber type="currency">
	      		<c:choose>
		      		<c:when test="${product.price >= 50000}">
		      			${product.price*0.1}
		      		</c:when>
		      		<c:otherwise>
		      			${(product.price+3000)*0.1}
		      		</c:otherwise>
		      	</c:choose>
	      	</fmt:formatNumber>
	      </td>
	    </tr>
	  </tbody>
	</table>
	<hr class="w-100"/>
	<table class="table order-tbl">
	  <tbody>
	    <tr>
	      <th>
			총 주문 금액
	      </th>
	      <td class="text-right" id="totalPrice">
	      	<fmt:formatNumber type="currency">
	      		<c:choose>
		      		<c:when test="${product.price >= 50000}">
		      			${product.price}
		      		</c:when>
		      		<c:otherwise>
		      			${product.price+3000}
		      		</c:otherwise>
		      	</c:choose>
	      	</fmt:formatNumber>
		  </td>
	    </tr>
	    <tr>
	      <th class="col-4">
			보유 포인트
	      </th>
	      <td class="col-5">
	      	<input type="text" name="" id="" value="${member.point}" class="form-control w-100" disabled/>
		  </td>
	    </tr>
	    <tr>
	      <th>
			사용 포인트
	      </th>
	      <td class="w-50">
	      	<div class="input-group mb-3 ">
			  <input type="number" id="pointValue" class="form-control" placeholder="사용 포인트" aria-describedby="basic-addon2" value="0">
			  <div class="input-group-append w-10">
			    <span class="input-group-text " id="basic-addon2">적용</span>
			  </div>
			</div>
	      </td>
	    </tr>
	  </tbody>
	</table>
  </div>
</div>
<form:form name="orderFrm">
	<input type="hidden" name="memberNo" value="${member.memberNo }" />
	<input type="hidden" name="pointValue" value="0"/>
	<input type="hidden" name="productPrice" value="${product.price}"/>
	<input type="hidden" name="shippingFee" value="${product.price >= 50000? 0 : 3000}"/>
	<input type="hidden" name="totalPrice" value="${product.price + (product.price >= 50000? 0 : 3000)-0}"/>
	<input type="hidden" name="detailNo" value="${product.productDetail.detailNo}"/>
</form:form>
<form:form name="paymentFrm">
	<input type="hidden" name="pg" value="" />
	<input type="hidden" name="payWay" value=""/>
	<input type="hidden" name="orderCode" value=""/>
	<input type="hidden" name="payPrice" value=""/>
	<input type="hidden" name="email" value=""/>
	<input type="hidden" name="name" value=""/>
	<input type="hidden" name="phone" value=""/>
	<input type="hidden" name="address" value=""/>
	<input type="hidden" name="postalCode" value=""/>
</form:form>
<script>
//주소 검색창 띄우기
let postcode = '';
$("#addInputBtn").click((e)=>{
	new daum.Postcode({
        oncomplete(data){ //선택시 입력값 세팅
        	console.log(data);
        	postcode = data.zonecode;
            $(".add-input").text(data.address);
            $("#addInput").val(data.address);
            $(".add-detail-input").text('');
            $("#addDetailInput").val('');
        }
    }).open();
});

//상세 정보 입력 시 정보 수정
$(".order-form-control").change((e)=>{
	console.log($(e.target).val());
	const value = $(e.target).val();
	const target = $(e.target).data("target");
	$(target).text(value);
});


//결제창 띄우기
$("#orderPaymentBtn").click((e)=>{
	console.log("결제 이벤트 발생");
	
	//주문 테이블 추가
	const data = new FormData(document.orderFrm);
	$.ajax({
		url : "${pageContext.request.contextPath}/order/orderEnroll",
		data : data,
		contentType : false,
		processData : false,
		method : "POST",
		success(data){
			console.log(data);
			
			//주문 테이블 행 추가가 성공하면 결제 이벤트 진행
			iamport(data);
		},
		error : console.log
	});
	
});

function iamport(data){
	//가맹점 식별코드
	IMP.init('imp45870945');
	IMP.request_pay({
	    pg : 'kcp',
	    pay_method : 'card',
	    merchant_uid : 'MERCHANT_' + new Date().getTime(),
	    name : '${product.name}' , //결제창에서 보여질 이름
	    amount : ${product.price + (product.price >= 50000? 0 : 3000)-0}, //실제 결제되는 가격
	    buyer_email : $(".email-input").text(),
	    buyer_name : $(".name-input").text(),
	    buyer_tel : $(".phone-input").text(),
	    buyer_addr : $(".add-input").text()+$(".add-detail-input").text(),
	    buyer_postcode : postcode
	}, function(rsp) {
		console.log(rsp);
		// 결제검증
		$.ajax({
        	type : "POST",
        	url : "/verifyIamport/" + rsp.imp_uid 
        }).done(function(data) {
        	
        	console.log(data);
        	
        	// 위의 rsp.paid_amount 와 data.response.amount를 비교한후 로직 실행 (import 서버검증)
        	if(rsp.paid_amount == data.response.amount){
	        	alert("결제 및 결제검증완료");
	        	//결제 및 검증 완료 시 결제 테이블 정보 추가 후 주문 정보 디테일 페이지로 리다이렉트
	        	
        	} else {
        		alert("결제 실패");
        	}
        });
	});
}
	


$(document).ready((e)=>{
	let today = new Date();
	const year = today.getFullYear(); 
	const month = today.getMonth() + 1; 
	const date = today.getDate();
	today = (year-2000) + "-" + month + "-" + (date+1);
	
	console.log(today, typeof today);
	$("#releaseDate").text(today + " 09:00 ~ 21:00");
	
	const price = $("#totalPrice").text();
	$("#priceInput").text(price);
});
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
