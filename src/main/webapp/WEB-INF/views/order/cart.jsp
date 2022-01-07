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
<script src="${pageContext.request.contextPath}/resources/js/shop/cart.js"></script>
<div class="row p-5 d-flex justify-content-around order-container">
  <div class="col-7">
  	<h4 class="d-inline">장바구니</h4>
  	<button id="allDeleteBtn" type="button" class="btn btn-secondary">전체삭제</button>
  	<table class="table m-3 pr-3">
	  	<c:if test="${not empty list}">
	  	<c:set var="sum" value="0" />
	  <tbody id="cartBody">
	  	<c:forEach items="${list}" var="cart" varStatus="vs">
	    <tr 
	    	id="${cart.detailNo}"
	    	class="cart-item"
	    	data-product-code = "${cart.product.productCode }"
	    	data-detail-no = "${cart.detailNo}"
	    	data-name = "${cart.product.name }"
	    	data-price = "${cart.product.price }"
	    	data-amount = "${cart.amount}"
	    	data-thumbnail = "${cart.product.thumbnail }">
	      <td rowspan="2">
	      	<input type="checkbox" class="cart-checkbox ml-3" name="" id="" checked/>
		  </td>
	      <td rowspan="2" class="col-3">
	      	<div class="cart-item-img">
		      	<img src="${pageContext.request.contextPath}/resources/upload/product/${cart.product.thumbnail}" alt="" class="img-thumbnail shop-img  img-b" >
	      	</div>
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
	    </c:if>
	    <c:if test="${empty list }">
		  <tbody id="cartBody" style="height: 300px;">
	    	<tr class="text-center mt-5">
	    		<td colspan="4" class="h-100">장바구니에 담긴 상품이 없습니다.</td>
	    	</tr>
	 	 </tbody>
	    </c:if>
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
			if(data.length == 0){
				$("#cartBody").html(`<tr class="text-center mt-5"><td colspan="4">장바구니에 담긴 상품이 없습니다.</td></tr>`);
				$("#cartBody").css("height","300px");
				return;
			}
			let total = 0;
			data.forEach((cart,i)=>{
				console.log(cart.detailNo);
				total += cart.product.price;
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
			$("#total").html("&#8361;"+total);
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
				amount : $cartItems.eq(i).data("amount"),
				thumbnail : $cartItems.eq(i).data("thumbnail")
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
