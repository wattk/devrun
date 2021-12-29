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
	      	<p class="addInput"></p>
	      	<strong>출고 예정일 : </strong>
	      	<p id="releaseDate">2021.12.09 09:00 - 21:00</p>
	      </div>
	    </div>
	
	    <div id="collapseOne" class="collapse show" aria-labelledby="headingOne" data-parent="#orderAccordion">
	      <div class="card-body pl-5">
	      	배송지 : 
	      	<div class="input-group mb-3 w-75">
			  <input type="text" id="" class="addInput form-control" placeholder="주소" aria-describedby="addInputBtn" value="${addressList[0].address1}">
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
		  	<p>이름 : ${member.name }</p>
		   	<p>이메일 : ${member.email }</p>
		   	<p>전화번호 : ${member.phone }</p>
		   	<p>상세주소 : 어쩌구동</p>
	      </div>
	    </div>
	    <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#orderAccordion">
	      <div class="card-body">
	      	<ul class="list-group">
			  <li class="address-item list-group-item">이름 : <input type="text" class="order-form-control" name="" id="" /></li>
			  <li class="address-item list-group-item">이메일 : <input type="text" class="order-form-control" name="" id="" /></li>
			  <li class="address-item list-group-item">전화번호 : <input type="text" class="order-form-control" name="" id="" /></li>
			  <li class="address-item list-group-item">상세주소 : <input type="text" class="order-form-control" name="" id="" /></li>
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
		  	  <fmt:formatNumber type="currency">${product.price}</fmt:formatNumber> 원 결제하기 <i class="fas fa-chevron-circle-right"></i>
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
	      <td class="text-right">
	      	<c:choose>
	      		<c:when test="${product.price >= 50000}">
	      			&#8361;0
	      		</c:when>
	      		<c:otherwise>
	      			&#8361;3,000
	      		</c:otherwise>
	      	</c:choose>
		  </td>
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
	      <td class="text-right">
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
			  <input type="number" class="form-control" placeholder="사용 포인트" aria-describedby="basic-addon2">
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
<script>
//주소 검색창 띄우기
$("#addInputBtn").click((e)=>{
	new daum.Postcode({
        oncomplete(data){ //선택시 입력값 세팅
            $(".addInput").val(data.address);
        }
    }).open();
});



//결제창 띄우기
function iamport(){
		//가맹점 식별코드
		IMP.init('imp45870945');
		IMP.request_pay({
		    pg : 'kcp',
		    pay_method : 'card',
		    merchant_uid : 'merchant_' + new Date().getTime(),
		    name : '상품1' , //결제창에서 보여질 이름
		    amount : 100, //실제 결제되는 가격
		    buyer_email : 'devrunlearn@gmail.com',
		    buyer_name : '홍길동',
		    buyer_tel : '010-1234-5678',
		    buyer_addr : '서울 강남구 도곡동',
		    buyer_postcode : '123-456'
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
	        	} else {
	        		alert("결제 실패");
	        	}
	        });
		});
	}
	
$("#orderPaymentBtn").click((e)=>{
	console.log("결제 이벤트 발생");
	iamport();
});

$(document).ready((e)=>{
	let today = new Date();
	const year = today.getFullYear(); 
	const month = today.getMonth() + 1; 
	const date = today.getDate();
	today = (year-2000) + "-" + month + "-" + (date+1);
	
	console.log(today, typeof today);
	$("#releaseDate").text(today + " 09:00 ~ 21:00");
});
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>