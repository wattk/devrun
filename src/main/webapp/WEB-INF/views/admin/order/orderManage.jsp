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
<!-- 주문 확인 모달 -->
<div class="modal fade" id="orderModal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="modalProductTitle">주문 상세</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body" id="modalOrderList">
      	<span id="orderModalUid"></span>
			<h5 id="orderModalName" class="pb-2"></h5>
			<ul class="list-group list-group-flush">
			  <li class="list-group-item">
				<table id="orderDetailTbl" class="table mt-3 w-100">
				
				</table>
			  </li>
			  <li class="list-group-item text-right">
			 	 <strong>총 주문 가격</strong><span id="orderModalTotal" class="pl-2"></span>
			  </li>
			</ul>
      </div>
      <div class="modal-footer">
        <button type="button" id="osChangeBtn" class="btn btn-primary" data-dismiss="modal">주문 접수</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>

<!-- 주문 관리 시작 -->
<div class="m-5">
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
<strong class="m-5">주문 목록</strong>
<div class="${list.size() > 5 ? 'order-list':'' } mb-5">
	<table class="admin-tbl table table-hover mx-auto">
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
	    </tr>
	  </thead>
	  <tbody class="order-body" style="-ms-overflow-style: none;">
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
	    </tr>
	    </c:forEach>
	  </tbody>
	</table>
</div>

<strong class="m-5">주문 처리 대기</strong>
<div class="${orList.size() > 5 ? 'order-list':'' } mb-5">
	<table class="admin-tbl table table-hover mx-auto">
	  <thead>
	    <tr>
	      <th scope="col">주문 번호</th>
	      <th scope="col">회원 번호</th>
	      <th scope="col">주문 일자</th>
	      <th scope="col">주문 확인</th>
	    </tr>
	  </thead>
	  <tbody class="order-body order-change-body" style="-ms-overflow-style: none;">
	  	<c:if test="${empty orList}">
	  		<tr class="mx-auto">
	  			<td colspan="4">처리 대기 중인 주문이 없습니다.</td>
	  		</tr>
	  	</c:if>
	  	<c:forEach items="${orList}" var="m" varStatus="vs">
		    <tr id="${m.merchantUid}">
		      <td>${m.merchantUid}</td>
		      <td>${m.memberNo}</td>
		      <td><fmt:formatDate value="${m.orderDate}" pattern="yy-MM-dd"/></td>
		      <td>
		      	<button 
		      		type="button" 
		      		class="order-modal-btn btn btn-secondary" 
		      		data-toggle="modal" 
		      		data-target="#orderModal"
		      		data-merchant="${m.merchantUid}">
		      		주문 확인
		      	</button>
		      </td>
		    </tr>
	    </c:forEach>
	  </tbody>
	</table>
</div>
<strong class="m-5">주문 판매량</strong>
<div class="order-sell-container">
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
	      <td>${todayCnt["CH"]}건</td>
	      <td>${weekCnt["CH"]}건</td>
	      <td>${monthCnt["CH"]}건</td>
	    </tr>
	    <tr>
	      <th scope="row">책상</th>
	      <td>${todayCnt["DE"]}건</td>
	      <td>${weekCnt["DE"]}건</td>
	      <td>${monthCnt["DE"]}건</td>
	    </tr>
	    <tr>
	      <th scope="row">모니터</th>
	      <td>${todayCnt["MN"]}건</td>
	      <td>${weekCnt["MN"]}건</td>
	      <td>${monthCnt["MN"]}건</td>
	    </tr>
	    <tr>
	      <th scope="row">키보드</th>
	      <td>${todayCnt["KE"]}건</td>
	      <td>${weekCnt["KE"]}건</td>
	      <td>${monthCnt["KE"]}건</td>
	    </tr>
	    <tr>
	      <th scope="row">마우스</th>
	      <td>${todayCnt["MO"]}건</td>
	      <td>${weekCnt["MO"]}건</td>
	      <td>${monthCnt["MO"]}건</td>
	    </tr>
	    <tr>
	      <th scope="row">기타용품</th>
	      <td>${todayCnt["OT"]}건</td>
	      <td>${weekCnt["OT"]}건</td>
	      <td>${monthCnt["OT"]}건</td>
	    </tr>
	  </tbody>
	</table>
</div>
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
        let nowDay = now.getDate(); 
        let nowMonth = now.getMonth(); 
        let nowYear = now.getYear(); 
        nowYear += (nowYear < 2000) ? 1900 : 0; 
		$startDate.val(formatDate(now));
        $endDate.val(formatDate(new Date(nowYear, nowMonth, nowDay, 11, 59, 59)));
	}
	else if($(e.target).data("target") == 'week'){
		let now = new Date(); 
        let nowDayOfWeek = now.getDay(); 
        let nowDay = now.getDate(); 
        let nowMonth = now.getMonth(); 
        let nowYear = now.getYear(); 
        nowYear += (nowYear < 2000) ? 1900 : 0; 
        let weekStartDate = new Date(nowYear, nowMonth, nowDay - nowDayOfWeek); 
        let weekEndDate = new Date(nowYear, nowMonth, nowDay + (6 - nowDayOfWeek), 11, 59, 59);
        $startDate.val(formatDate(weekStartDate));
        $endDate.val(formatDate(weekEndDate));
	}
	else if($(e.target).data("target") == 'month'){
		let now = new Date();
	    let nowYear = now.getYear();
	    nowYear += (nowYear < 2000) ? 1900 : 0; 
	    let firstDate = new Date(nowYear,now.getMonth(), 1);
	    let lastDate = new Date(nowYear,now.getMonth()+1, 0, 11, 59, 59);
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
	const time = $(".badge-primary").data("target");
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
			$("#orderBody").html(data.merchantStr);
		},
		error : console.log
	});
});

//주문 상세 모달창에 정보 띄우기
$(".order-modal-btn").click((e)=>{
	const merchantUid = $(e.target).data("merchant");
	
	$.ajax({
		url : "${pageContext.request.contextPath}/admin/findMerchantDetail",
		method : "GET",
		data : {
			merchantUid : merchantUid
		},
		success(data){
			console.log(data);
			$("#orderModalTotal").html("&#8361;"+data.merchant.totalPrice.toLocaleString());
			$("#orderModalName").text(data.imp.name);
			$("#orderModalUid").text(data.merchant.merchantUid);
			$("#orderDetailTbl").html('');
			
			for(let i = 0; i < data.list.length; i++){
				const item = data.list[i];
				$("#orderDetailTbl").append(`<tr>
					<td rowspan="2" class="orderModalImg ">
						<img src="${pageContext.request.contextPath}/resources/upload/product/\${item.thumbnail}" alt=""class=" img-thumbnail"/>
					</td>
				</tr>
				<tr>
					<td class=" text-left">
						<strong 
							class="detail-title pl-2" 
							data-detail-no="\${item.productDetail.detailNo}"
							data-buy-count="\${item.buyCount}">
							\${item.name}
						</strong>
						<br />
						<span class="pl-2">\${item.productDetail.optionNo} \${item.productDetail.optionContent == null? '' : item.productDetail.optionContent}</span>
						<br />
						<span class="pl-2">\${item.buyCount}개 구매</span>
					</td>
				</tr>
				<tr>
				<td class=" text-right" colspan="2">
					<span class="pl-2">현재 재고 : \${item.productDetail.quantity}개</span>
				</td>
			</tr>`);
			}
		},
		error : console.log
	});
});

//주문 접수 클릭 시 주문 상태 업데이트, 상품 재고 -1
$("#osChangeBtn").click((e)=>{
	const merchantUid = [$("#orderModalUid").text()];
	let detailList = [];
	const $detailTitle = $(".detail-title");
	const length = $detailTitle.length;
	
	for(let i = 0; i < length; i++){
		detailList[i] = {
				detailNo : $detailTitle.eq(i).data("detailNo"),
				buyCount : $detailTitle.eq(i).data("buyCount")
		}
	}
	
	console.log(detailList);
	console.log(merchantUid, typeof merchantUid);
	const data = {
			uidArr : merchantUid,
			keyword : 'order_status',
			value : 'PP',
			detailList : detailList,
			target : 'merchantUid'
		};
	$.ajax({
		url : "${pageContext.request.contextPath}/admin/orderUpdate",
		method : "POST",
		dataType : "json",
		contentType : "application/json; charset=utf-8",
		data : JSON.stringify(data),
		success(data){
			alert("주문이 정상적으로 접수되었습니다.");
			$(`#\${merchantUid}`).detach();
			if($(".order-change-body").children("tr").length == 0){
				$(".order-change-body").append(`<tr class="mx-auto">
			  			<td colspan="4" class="text-center">처리 대기 중인 주문이 없습니다.</td>
				  		</tr>`);
			}
		},
		error : console.log
	});
	
});
			
</script>
<jsp:include page="/WEB-INF/views/admin/admin-common/footer.jsp"></jsp:include>
