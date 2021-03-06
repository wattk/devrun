<%@page import="java.util.List"%>
<%@page import="com.kh.devrun.product.model.vo.Product"%>
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

<link href="${pageContext.request.contextPath}/resources/css/shop/order.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/resources/js/shop/order.js"></script>

<sec:authentication property="principal" var="member"/>

<script>

$(document).ready((e)=>{
	//localStorage에 저장되어 있는 장바구니 아이템 가져와서 뷰단에 뿌려주기
	const item = JSON.parse(localStorage.getItem("cartItems"));
	console.log(item);
	
	if(item.length == 1){
		$(".merchant-title").text(item[0].name);
		$(".thumbnail-box").append(`<img src="${pageContext.request.contextPath }/resources/upload/product/\${item[0].thumbnail}" class="shop-img img-thumbnail img-b">`);
	}
	else{
		$(".merchant-title").text(item[0].name+" 외 "+(item.length - 1)+"건");
		
		if(item.length < 3){
			item.forEach((i, index)=>{
				$(".thumbnail-box").append(`<img src="${pageContext.request.contextPath }/resources/upload/product/\${item[index].productCode}.png" class="shop-img img-thumbnail img-b">`);
			});
		}
		else{
			for(let i = 0; i < 3; i++){
				$(".thumbnail-box").append(`<img src="${pageContext.request.contextPath }/resources/upload/product/\${item[i].productCode}.png" class="shop-img img-thumbnail img-b">`);
			}
			$(".thumbnail-box").append(`<div class="img-b w-25 p-2">...</div>`);
			
		}
	}
	
	let price = 0;
	item.forEach((i, index)=>{
		price += item[index].price*item[index].amount;
		$(document.orderFrm).append(`<input type="hidden" name="detailNo" value="\${item[index].detailNo}" data-buy-count="\${item[index].amount}"/>`);
	});
	console.log(price);
	$("#totalWithoutShipping").html(`&#8361;\${price.toLocaleString()}`);
	$(document.orderFrm).append(`<input type="hidden" name="productPrice" value="\${price}"/>
		<input type="hidden" name="shippingFee" value="\${price >= 50000? 0 : 3000}"/>
		<input type="hidden" name="totalPrice" value="\${price + (price >= 50000? 0 : 3000)-0}"/>
	`);
	
	if(price > 50000){
		$("#shippingFee").html("&#8361;0");
		$("#orderPrice").html("&#8361;"+(price*(0.9)).toLocaleString());
		$("#vat").html("&#8361;"+(price*(0.1)).toLocaleString());
		$("#totalPrice").html("&#8361;"+price.toLocaleString());
		$("#priceInput").html("&#8361;"+price.toLocaleString());
	}
	else{
		$("#shippingFee").html("&#8361;3,000");
		$("#orderPrice").html("&#8361;"+((price+3000)*(0.9)).toLocaleString());
		$("#vat").html("&#8361;"+((price+3000)*(0.1)).toLocaleString());
		$("#totalPrice").html("&#8361;"+(price+3000).toLocaleString());
		$("#priceInput").html("&#8361;"+(price+3000).toLocaleString());
	}
	
	//사용한 후에는 스토리지에서 지워줄 것
	localStorage.removeItem("cartItems");
});
</script>

<div class="row p-5 d-flex justify-content-around order-container">
  <div class="col-7">
  	<div class="accordion" id="orderAccordion">
	  <div class="card">
	    <div class="card-header" id="headingOne">
	      <h5 class="mb-0">
	        <button id="orderOneBtn" class="btn btn-link order-btn" type="button" data-toggle="collapse" data-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
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
			  <input type="hidden" name="postcode" value="${addressList[0].postalCode}" />
			  <div class="input-group-append w-10">
			    <span class="input-group-text cursor" id="addInputBtn">수정</span>
			  </div>
			</div>
			<strong>배송 옵션</strong>
			<div class="delivery-option p-3">
				<i class="fas fa-truck"><strong>일반 배송</strong></i>
				<p class="pt-2 mb-0">택배 배송 : 출고 예정일 3~5일 이내에 배송되며, 2박스 이상으로 분리 배송될 수 있습니다.</p>
			</div>
		    <button
		      id="orderTwoBtn"
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
			  <li class="address-item list-group-item">이름 : <input type="text" class="order-form-control" data-target=".name-input" value="${member.name}" name="" id="nameInput" /></li>
			  <li class="address-item list-group-item">이메일 : <input type="text" class="order-form-control" data-target=".email-input" value="${member.email}" name="" id="emailInput" /></li>
			  <li class="address-item list-group-item">전화번호 : <input type="text" class="order-form-control" data-target=".phone-input" value="${member.phone}" name="" id="phoneInput" /></li>
			  <li class="address-item list-group-item">상세주소 : <input type="text" id="addDetailInput" class="add-detail-input order-form-control" data-target=".add-detail-input" value="${addressList[0].address2}" name="" id="addDetailInput" /></li>
			</ul>
		    <button 
		      id="orderThreeBtn"
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
  	<span class="merchant-title"></span>
  	<div class="thumbnail-box cart-item-img m-0 row d-flex justify-content-start">
  	</div>
    <hr class="w-100"/>
	<table class="table order-tbl">
	  <tbody>
	  	<tr>
	  		<th colspan="2">주문 내역</th>
	  	</tr>
	    <tr>
	      <td>주문 금액(배송비 제외)</td>
	      <td id="totalWithoutShipping" class="text-right"></td>
	    </tr>
	    <tr>
	      <td>전체 배송비</td>
	      <td id="shippingFee" class="text-right">
		  </td>
	    </tr>
	    <tr>
	      <td>주문 금액(부가세 제외)</td>
	      <td id="orderPrice" class="text-right">
	      </td>
	    </tr>
	    <tr>
	      <td>부가세(10%)</td>
	      <td id="vat" class="text-right">
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
			  <input type="number" id="pointValue" class="form-control" placeholder="사용 포인트" aria-describedby="pointBtn" max="${member.point}">
			  <div class="input-group-append w-10">
			    <span class="input-group-text cursor" id="pointBtn">적용</span>
			  </div>
			</div>
	      </td>
	    </tr>
	  </tbody>
	</table>
  </div>
</div>

<form:form name="orderFrm">
	<input type="hidden" name="memberNo" value="${member.memberNo}" />
	<input type="hidden" name="pointValue" value="0"/>
</form:form>
<script>

//결제창 띄우기
$("#orderPaymentBtn").click((e)=>{
	console.log("결제 이벤트 발생");
	
	//주소 및 상세정보(이메일 제외) 미입력시 결제 불가
	if($("#addInput").val() == ''){
		alert("주소를 입력해주세요.");
		$("#orderOneBtn").click();
		$("#addInput").focus();
		return;
	}
	
	if($("#nameInput").val() == ''){
		alert("수령인을 입력해 주세요.");
		$("#orderTwoBtn").click();
		$("#nameInput").focus();
		return;
	}
	if($("#phoneInput").val() == ''){
		alert("연락처를 입력해 주세요.");
		$("#orderTwoBtn").click();
		$("#phoneInput").focus();
		return;
	}
	if($("#addDetailInput").val() == ''){
		alert("상세주소를 입력해 주세요.");
		$("#orderTwoBtn").click();
		$("#addDetailInput").focus();
		return;
	}
	
	const merchantUid = 'MERC_' + new Date().getTime();

	
	//주문 테이블 추가
	let formData = new FormData(document.orderFrm);
	formData.append("merchantUid", merchantUid);
	
	const obj = {};
	
	for(const [k,v] of formData){
		obj[k] = v;
	}
	//detailNo
	const $detailNo = $("[name=detailNo]", $(document.orderFrm));
	const detailNo = $detailNo
						.toArray()
						.map((no, i)=>{
							var reformat = {detailNo : no.value,
											merchantUid : merchantUid,
											buyCount : $(no).data("buyCount")};
							return reformat;
							});
	obj.merchantDetailList = detailNo;
	
	console.log(obj);
	const jsonStr = JSON.stringify(obj);
	console.log(jsonStr);
	
	$.ajax({
		url : "${pageContext.request.contextPath}/order/orderEnroll",
		data : jsonStr,
		contentType : "application/json; charset=utf-8",
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
	    merchant_uid : data.merchantUid,
	    name : $(".merchant-title").text(), //결제창에서 보여질 이름
	    amount : 200, //실제 결제되는 가격
	    //amount : $("[name=totalPrice]").val(), //실제 결제되는 가격
	    buyer_email : $(".email-input").text(),
	    buyer_name : $(".name-input").text(),
	    buyer_tel : $(".phone-input").text(),
	    buyer_addr : $(".add-input").text()+$(".add-detail-input").val(),
	    buyer_postcode : $("[name=postcode]").val()
	}, function(rsp) {
		console.log(rsp);
		// 결제검증
		$.ajax({
        	type : "POST",
        	url : "${pageContext.request.contextPath}/verifyIamport/" + rsp.imp_uid 
        }).done(function(data) {
        	
        	console.log(data);
        	
        	// 위의 rsp.paid_amount 와 data.response.amount를 비교한후 로직 실행 (import 서버검증)
        	if(rsp.paid_amount == data.response.amount){
	        	console.log("결제 및 결제검증완료");
	        	//결제 및 검증 완료 시 결제 테이블 정보 추가 후 주문 정보 디테일 페이지로 리다이렉트
	        	let value = {
	        		impUid : rsp.imp_uid,
	        		merchantUid : rsp.merchant_uid,
	        		name : data.response.name,
	        		payMethod : data.response.payMethod,
	        		pgProvider : data.response.pgProvider,
	        		amount : data.response.amount,
	        		buyerAddr : data.response.buyerAddr,
	        		buyerEmail : data.response.buyerEmail,
	        		buyerName : data.response.buyerName,
	        		buyerPostcode : data.response.buyerPostcode,
	        		buyerPhone : data.response.buyerTel
	        	};
	        	value = JSON.stringify(value);
	        	console.log(value);
	        	
	        	
	        	$.ajax({
	        		url : "${pageContext.request.contextPath}/order/impEnroll",
	        		data : value,
	        		method : "POST",
	        		contentType : "application/json; charset=utf-8",
	        		success(data){
	        			console.log(data);
	        			location.href = `${pageContext.request.contextPath}\${data}`;
	        		},
	        		error : console.log
	        	});
	        	
	        	
        	} else {
        		alert("결제에 실패하였습니다.");
        	}
        });
	});
}
	
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
