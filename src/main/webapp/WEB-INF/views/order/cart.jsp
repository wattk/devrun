<%@page import="com.kh.devrun.shop.model.vo.Cart"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>	
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="장바구니" name="title"/>
</jsp:include>
<link href="${pageContext.request.contextPath}/resources/css/shop/order.css" rel="stylesheet">
<div class="row p-5 d-flex justify-content-around order-container">
  <div class="col-7">
  	<h4 class="d-inline">장바구니</h4>
  	<button id="allDeleteBtn" type="button" class="btn btn-secondary">전체삭제</button>
  	<table class="table m-3 pr-3">
	  <tbody id="cartBody">
	  	<c:set var="sum" value="0" />
	  	<c:forEach items="${list}" var="cart" varStatus="vs">
	    <tr 
	    	id="${cart.detailNo}"
	    	class="cart-item"
	    	data-product-code = "${cart.product.productCode }"
	    	data-detail-no = "${cart.detailNo}"
	    	data-name = "${cart.product.name }"
	    	data-price = "${cart.product.price }"
	    	data-amount = "${cart.amount}">
	      <td rowspan="2">
	      	<input type="checkbox" class="cart-checkbox ml-3" name="" id="" checked/>
		  </td>
	      <td rowspan="2" class="col-3">
	      	<img src="${pageContext.request.contextPath}/resources/upload/product/${cart.product.thumbnail}" alt="" class=" img-b w-75" >
		  </td>
	      <td class="col-5 align-middle ">${cart.product.name}</td>
	      <td class="col-3 align-middle " >
	      	<fmt:formatNumber type="currency">${cart.product.price * cart.amount}</fmt:formatNumber>
	      </td>
	    </tr>
	    <tr>
	      <td colspan="2" class="align-middle text-right">
	      	<input type="number" name="amount" id="" class="col-2 " placeholder="수량" value="${cart.amount}" data-target="${cart.detailNo}"/>
	      	<button type="button" class="cart-delete-btn btn btn-primary" data-cart-no = "${cart.cartNo}">삭제</button>
	      </td>
	    </tr>
	    <c:set var="sum" value="${sum + (cart.product.price * cart.amount)}" />
	    </c:forEach>
	  </tbody>
	</table>
  </div>
  <div class="col-4 m-3 pl-3 pt-5 d-flex flex-column justify-content-start">
	  <strong>주문 내역</strong>
	  <p>5만원 이상 결제 시 배송비 무료입니다.</p>
	  <p>이 금액에는 배송비가 포함되어 있지 않으며, 배송지에 따라 구매가 불가할 수 있습니다.</p>
	  <hr class="w-100"/>
	  <strong>총 주문 금액</strong>
	  <h4 id="total" class="text-right" data-total="${sum}"><fmt:formatNumber type="currency">${sum}</fmt:formatNumber></h4>
	  <button 
	  	type="button" 
	  	id="cartPayBtn" 
	  	class="btn btn-primary w-100 h-25 mt-5">
	  	결제하기 <i class="fas fa-chevron-circle-right"></i>
	  </button>
	  <hr class="w-100"/>
  </div>
</div>
<script>
//체크박스 해제 시 합산 가격 변경
$(".cart-checkbox").change((e)=>{
	const isChecked = $(e.target).prop("checked");
	const $parent = $(e.target).parent().parent();
	const price = $parent.data("price");
	const amount = $parent.data("amount");
	const total = $("#total").data("total");
	
	if(!isChecked){
		const cal = total-(price*amount);
		$("#total").html("&#8361;"+(cal).toLocaleString());
		$("#total").data("total", cal);
	}
	else{
		const cal = total + (price*amount)
		$("#total").html("&#8361;"+(cal).toLocaleString());
		$("#total").data("total", cal);
	}
});

//수량 변경 시 가격 변경
$("[name=amount]").change((e)=>{
	const target = "#"+$(e.target).data("target");
	const originalAmount = $(target).data("amount");
	const checkbox = $(target).find("input:checkbox");
	const isChecked = $(checkbox).prop("checked");
	const amount = $(e.target).val();
	const price = $(target).data("price");
	const total = $("#total").data("total");
	console.log(target);
	console.log(amount);
	
	//체크박스 해제되면 가격 빼기, 체크되면 가격 더하기
	if(isChecked){
		const cal = total + (price*amount)
		$("#total").html("&#8361;"+(cal).toLocaleString());
		$("#total").data("total", cal);
	}
	else{
		const cal = total-(price*amount);
		$("#total").html("&#8361;"+(cal).toLocaleString());
		$("#total").data("total", cal);
	}
	
	if(originalAmount<amount){
		const cal = total + (price*(amount-originalAmount));
		$("#total").html("&#8361;"+(cal).toLocaleString());
		$("#total").data("total", cal);
	}
	else{
		const cal = total - (price*(originalAmount-amount));
		$("#total").html("&#8361;"+(cal).toLocaleString());
		$("#total").data("total", cal);
	}
	$(target).data("amount", amount);
	console.log($(target).data("amount"));
});

//전체 삭제 버튼 클릭 시 장바구니 전체 데이터 삭제
$("#allDeleteBtn, .cart-delete-btn").click((e)=>{
	let $cartBtns;
	if($(e.target).attr("id") == "allDeleteBtn"){
		$cartBtns = $(".cart-delete-btn");
	}
	else{
		$cartBtns = $(e.target);
	}
	let cartNoArr = [];
	for(let i = 0; i < $cartBtns.length; i++){
		cartNoArr[i] = $cartBtns.eq(i).data("cartNo");
	}
	console.log(cartNoArr);
	
	$.ajax({
		url : "${pageContext.request.contextPath}/shop/cartDelete",
		data : {
			cartNoArr : cartNoArr
		},
		dataType : "json",
		method : "POST",
		success(data){
			console.log(data);
			console.log(data.length);
			
			$("#cartBody").html('');
			if(data == null) return;
			data.forEach((cart,i)=>{
				console.log(cart.detailNo);
				$("#cartBody").html(`<tr 
				    	id= "\${cart.detailNo}"
				    	class="cart-item"
				    	data-product-code = "\${cart.product.productCode}"
				    	data-detail-no = "\${cart.detailNo}"
				    	data-name = "\${cart.product.name}"
				    	data-price = "\${cart.product.price}"
				    	data-amount = "\${cart.amount}">
				      <td rowspan="2">
				      	<input type="checkbox" class="cart-checkbox ml-3" name="" id="" checked/>
					  </td>
				      <td rowspan="2" class="col-3">
				      	<img src="${pageContext.request.contextPath}/resources/upload/product/\${cart.product.thumbnail}" alt="" class=" img-b w-75" >
					  </td>
				      <td class="col-5 align-middle ">\${cart.product.name}</td>
				      <td class="col-3 align-middle " >
				      	&#8361;\${(cart.product.price * cart.amount).toLocaleString()}
				      </td>
				    </tr>
				    <tr>
				      <td colspan="2" class="align-middle text-right">
				      	<input type="number" name="amount" id="" class="col-2 " placeholder="수량" value="\${cart.amount}" data-target="\${cart.detailNo}"/>
				      	<button type="button" class="cart-delete-btn btn btn-primary" data-cart-no = "\${cart.cartNo}">삭제</button>
				      </td>
				    </tr>`);
			});
		},
		error : console.log
	}); 
	
	
});

//주문하기 버튼 클릭 시 주문 페이지 이동
$("#cartPayBtn").click((e)=>{
	let cartArr = [];
	const $cartItems = $(".cart-item");
	console.log($cartItems, typeof $cartItems);
	for(let i = 0; i < $cartItems.length; i++){
		let isChecked = $cartItems.eq(i).find("input:checkbox").prop("checked");
		console.log(isChecked);
		
		//체크박스가 해제되어 있다면 정보를 넘기지 않는다.
		if(!isChecked){
			continue;
		}
		let data = {
				productCode : $cartItems.eq(i).data("productCode"),
				detailNo : $cartItems.eq(i).data("detailNo"),
				name : $cartItems.eq(i).data("name"),
				price : $cartItems.eq(i).data("price"),
				amount : $cartItems.eq(i).data("amount")
		};
		console.log(data);
		cartArr.push(data);
	};
	console.log(cartArr);
	localStorage.setItem("cartItems", JSON.stringify(cartArr));
	location.href = "${pageContext.request.contextPath}/order/order";
});
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
