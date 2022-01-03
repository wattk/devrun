<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>	
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/admin/admin-common/header.jsp">
	<jsp:param value="주문관리" name="title"/>
</jsp:include>
<link href="${pageContext.request.contextPath }/resources/css/admin/adminManage.css" rel="stylesheet"/>
<div class="order-container">
	<h3 class="m-5">주문내역</h3>
</div>
<div class="pl-3">
	<div class="order-search-container mt-5 ml-5">
		<strong class="pr-3">주문 처리 상태</strong>
		<input type="radio" name="orderStatus" id="order0" value="" checked/>
		<label for="order0">전체</label>
		<input type="radio" name="orderStatus" id="order1" value="OR"/>
		<label for="order1">주문</label>
		<input type="radio" name="orderStatus" id="order2" value="PP"/>
		<label for="order2">준비중</label>
		<input type="radio" name="orderStatus" id="order3" value="SS"/>
		<label for="order3">배송 시작</label>
		<input type="radio" name="orderStatus" id="order4" value="SP"/>
		<label for="order4">배송중</label>
		<input type="radio" name="orderStatus" id="order5" value="SC"/>
		<label for="order5">배송 완료</label>
		<input type="radio" name="orderStatus" id="order6" value="OC"/>
		<label for="order6">구매 확정</label>
	</div>
	<div class="order-search-container mt-3 ml-5">
		<strong class="pr-3">상품 처리 상태</strong>
		<input type="radio" name="csStatus" id="cs0" value="" checked/>
		<label for="cs0">전체</label>
		<input type="radio" name="csStatus" id="cs1" value="COM"/>
		<label for="cs1">정상</label>
		<input type="radio" name="csStatus" id="cs2" value="REF"/>
		<label for="cs2">환불</label>
		<input type="radio" name="csStatus" id="cs3" value="EXC"/>
		<label for="cs3">교환</label>
		<input type="radio" name="csStatus" id="cs4" value="RET"/>
		<label for="cs4">반품</label>
		<input type="radio" name="csStatus" id="cs5" value="CAN"/>
		<label for="cs5">주문취소</label>
		<input type="radio" name="csStatus" id="cs6" value="FNI"/>
		<label for="cs6">완료</label>
	</div>
	<div class="order-search-container mt-3 ml-5">
		<strong class="pr-3">날짜 선택</strong>
		<input type="date" name="startDate" id="" class=" bg-light border-0 small"/>
		<span>~</span>
		<input type="date" name="endDate" id="" class="bg-light border-0 small"/>
		<span class="date-badge badge badge-secondary" data-target="today">오늘</span>
		<span class="date-badge badge badge-secondary" data-target="week">이번주</span>
		<span class="date-badge badge badge-secondary" data-target="month">이번달</span>
		<span class="date-badge badge badge-primary" data-target="all">전체</span>
	</div>
	<div class="order-search-container mt-3 ml-5">
	      <div class="input-group w-50">
		 <select name="searchType" id="orderSearch" class=" bg-light border-0 small">
		 	<option value="all" selected>모든 주문 조회</option>
		 	<option value="orderNo">주문번호로 검색</option>
		 	<option value="memberNo">회원번호로 검색</option>
		 </select>
	        <input type="text" name="searchKeyword" class="form-control bg-light border-0 small" placeholder="검색어를 입력하세요." value=""
	            aria-label="Search" aria-describedby="basic-addon2">
	        <div class="input-group-append">
	            <button id="orderSearchBtn" class="btn btn-primary" type="button">
	                <i class="fas fa-search fa-sm"></i>
	            </button>
	        </div>
	      </div>
	</div>
</div>
<hr class="w-100"/>
<div class="order-list">
	<strong class="m-5">주문 목록</strong>
	<table class="admin-tbl table table-hover mx-auto mt-3">
	  <thead>
	    <tr>
	      <th scope="col">주문 번호</th>
	      <th scope="col">회원 번호</th>
	      <th scope="col">주문 일자</th>
	      <th scope="col">주문 상태</th>
	      <th scope="col">상품 처리 상태</th>
	      <th scope="col">사용 포인트</th>
	      <th scope="col">총 상품 금액</th>
	      <th scope="col">배송비</th>
	      <th scope="col">총 주문 금액</th>
	      <th scope="col">요청사항</th>
	    </tr>
	  </thead>
	  <tbody>
	  	<c:forEach items="${list}" var="m" varStatus="vs">
	    <tr>
	      <td>${m.merchantUid}</td>
	      <td>${m.memberNo}</td>
	      <td><fmt:formatDate value="${m.orderDate}" pattern="yy-MM-dd"/></td>
	      <td>${m.orderStatus eq 'OR'? '주문' : m.orderStatus eq 'PP'? '상품준비중': m.orderStatus eq 'SS'?'배송시작':m.orderStatus eq 'SP'?'배송중':m.orderStatus eq 'SC'?'배송완료': '구매확정'}</td>
	      <td>${m.csStatus eq 'COM'? '정상' : m.csStatus eq 'REF'? '환불': m.csStatus eq 'EXC'?'교환':m.csStatus eq 'RET'?'반품':m.csStatus eq 'CAN'?'주문취소':'완료'}</td>
	      <td>${m.pointValue}</td>
	      <td><fmt:formatNumber type="currency">${m.productPrice}</fmt:formatNumber></td>
	      <td><fmt:formatNumber type="currency">${m.shippingFee}</fmt:formatNumber></td>
	      <td><fmt:formatNumber type="currency">${m.totalPrice}</fmt:formatNumber></td>
	      <td>${m.shippingReq}</td>
	    </tr>
	    </c:forEach>
	  </tbody>
	</table>
</div>
<div class="order-list">
	<strong class="m-5">처리할 주문</strong>
	<table class="admin-tbl table table-hover mx-auto mt-3">
	  <thead>
	    <tr>
	      <th scope="col" class="col-3">상태 변경</th>
	      <th scope="col" class="col-5">건수</th>
	      <th scope="col" class="col-5">금액</th>
	    </tr>
	  </thead>
	  <tbody>
	    <tr>
	      <th scope="row">주문 → 상품 준비중</th>
	      <td>0</td>
	      <td>0</td>
	    </tr>
	    <tr>
	      <th scope="row">상품 준비중 → 배송 시작</th>
	      <td>0</td>
	      <td>0</td>
	    </tr>
	    <tr>
	      <th scope="row">배송 시작 → 배송중</th>
	      <td>0</td>
	      <td>0</td>
	    </tr>
	    <tr>
	      <th scope="row">배송중 → 배송 완료</th>
	      <td>0</td>
	      <td>0</td>
	    </tr>
	    <tr>
	      <th scope="row">배송 완료 → 구매 확정</th>
	      <td>0</td>
	      <td>0</td>
	    </tr>
	  </tbody>
	</table>
</div>
<div class="order-list">
	<strong class="m-5">주문 판매량</strong>
	<table class="admin-tbl table table-hover mx-auto mt-3">
	  <thead>
	    <tr>
	      <th scope="col" class="col-2">품목</th>
	      <th scope="col" class="col-3">일간</th>
	      <th scope="col" class="col-3">주간</th>
	      <th scope="col" class="col-3">월간</th>
	    </tr>
	  </thead>
	  <tbody>
	    <tr>
	      <th scope="row">의자</th>
	      <td>0</td>
	      <td>0</td>
	      <td>0</td>
	    </tr>
	    <tr>
	      <th scope="row">책상</th>
	      <td>0</td>
	      <td>0</td>
	      <td>0</td>
	    </tr>
	    <tr>
	      <th scope="row">모니터</th>
	      <td>0</td>
	      <td>0</td>
	      <td>0</td>
	    </tr>
	    <tr>
	      <th scope="row">키보드</th>
	      <td>0</td>
	      <td>0</td>
	      <td>0</td>
	    </tr>
	    <tr>
	      <th scope="row">마우스</th>
	      <td>0</td>
	      <td>0</td>
	      <td>0</td>
	    </tr>
	    <tr>
	      <th scope="row">기타용품</th>
	      <td>0</td>
	      <td>0</td>
	      <td>0</td>
	    </tr>
	  </tbody>
	</table>
</div>
<script>
//주문 검색 날짜 배지 클릭에 따른 날짜 지정
$(".date-badge").click((e)=>{
	const $startDate = $("[name=startDate]"); 
	const $endDate = $("[name=endDate]"); 
	$(".date-badge")
		.removeClass("badge-primary")
		.addClass("badge-secondary");
	$(e.target)
		.removeClass("badge-secondary")
		.addClass("badge-primary");
	
	if($(e.target).data("target") == 'today'){
		let now = new Date();
		$startDate.val(formatDate(now));
        $endDate.val(formatDate(now));
	}
	else if($(e.target).data("target") == 'week'){
		let now = new Date(); 
        let nowDayOfWeek = now.getDay(); 
        let nowDay = now.getDate(); 
        let nowMonth = now.getMonth(); 
        let nowYear = now.getYear(); 
        nowYear += (nowYear < 2000) ? 1900 : 0; 
        let weekStartDate = new Date(nowYear, nowMonth, nowDay - nowDayOfWeek); 
        let weekEndDate = new Date(nowYear, nowMonth, nowDay + (6 - nowDayOfWeek));
        $startDate.val(formatDate(weekStartDate));
        $endDate.val(formatDate(weekEndDate));
	}
	else if($(e.target).data("target") == 'month'){
		let now = new Date();
	    let nowYear = now.getYear();
	    nowYear += (nowYear < 2000) ? 1900 : 0; 
	    let firstDate = new Date(nowYear,now.getMonth(), 1);
	    let lastDate = new Date(nowYear,now.getMonth()+1, 0);
        $startDate.val(formatDate(firstDate));
        $endDate.val(formatDate(lastDate));
	}
	else if($(e.target).data("target") == 'all'){
		$startDate.val('');
        $endDate.val('');
	}
});

function formatDate(date) {
    let d = new Date(date),
        month = '' + (d.getMonth() + 1),
        day = '' + d.getDate(),
        year = d.getFullYear();

    if (month.length < 2) 
        month = '0' + month;
    if (day.length < 2) 
        day = '0' + day;

    return [year, month, day].join('-');
}

//주문 통합검색
$("#orderSearchBtn").click((e)=>{
	const orderStatus = $("[name=orderStatus]:checked").val();
	const csStatus = $("[name=csStatus]:checked").val();
	const searchType = $("[name=searchType]:selected").val();
	const searchKeyword = $("[name=searchKeyword]").val();
	const startDate = $("[name=startDate]").val(); 
	const endDate = $("[name=endDate]").val(); 
	console.log(orderStatus);
	console.log(csStatus);
	$.ajax({
		url : "${pageContext.request.contextPath}/admin/orderSearch",
		method : "GET",
		data : {
			orderStatus : orderStatus,
			csStatus : csStatus,
			searchType : searchType,
			searchKeyword : searchKeyword,
			startDate : startDate,
			endDate : endDate
		},
		success(data){
			console.log(data);
		},
		error : console.log
	});
});
</script>
<jsp:include page="/WEB-INF/views/admin/admin-common/footer.jsp"></jsp:include>
