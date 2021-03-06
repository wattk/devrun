<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>	
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/admin/admin-common/header.jsp">
	<jsp:param value="교환/환불/취소 관리" name="title"/>
</jsp:include>
<link href="${pageContext.request.contextPath }/resources/css/admin/adminManage.css" rel="stylesheet"/>
<script src="${pageContext.request.contextPath}/resources/js/admin/orderManage.js"></script>
<!-- 교환/환불 확인 모달 -->
<div class="modal fade" id="orderLogModal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="modalProductTitle">요청 상세</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body" id="modalOrderList">
      	<span id="orderLogModalUid"></span>
      	<br />
		<h5 id="orderLogModalName" class="pb-2 mr-2 d-inline"></h5>
		<span class="order-log-badge badge badge-pill badge-primary"></span>
      	<br />
        <span id="orderLogModalReqDate"></span>
		<ul class="list-group list-group-flush">
		  <li class="list-group-item">
			<table id="orderLogDetailTbl" class=" mt-3 w-100">
			
			</table>
		  </li>
		  <li class="list-group-item text-right">
		 	 <strong>총 주문 가격</strong><span id="orderLogModalTotal" class="pl-2"></span>
		  </li>
		  <li class="list-group-item text-left">
		  	 
		 	 <strong>요청 사유</strong>
		 	 <br />
		 	 <span id="orderLogModalReason" class="pl-2">맘에 안들어서</span>
		  </li>
		</ul>
      </div>
      <div class="modal-footer">
        <button type="button" id="osChangeBtn" class="btn btn-primary" data-dismiss="modal">요청 처리</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>

<!-- 교환/환불/취소 관리 시작 -->
<div class="m-5">
<div class="order-container">
	<h3 class="m-5">교환/환불/취소 내역</h3>
</div>
<div class="pl-3">
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
<strong class="m-5">교환/환불/취소 목록</strong>
<div class="${list.size() > 5 ? 'order-list':'' }">
	<table class="admin-tbl table table-hover mx-auto">
	  <thead>
	    <tr>
	      <th scope="col">주문 번호</th>
	      <th scope="col">회원 번호</th>
	      <th scope="col">상품 처리 상태</th>
	      <th scope="col">총 주문 금액</th>
	      <th scope="col">요청 사유</th>
	      <th scope="col">사유 상세</th>
	      <th scope="col">요청 일자</th>
	      <th scope="col">완료 일자</th>
	    </tr>
	  </thead>
	  <tbody class="order-body" style="-ms-overflow-style: none;">
	  	<c:if test="${empty list}">
	  		<tr class="mx-auto">
	  			<td colspan="8">주문이 없습니다.</td>
	  		</tr>
	  	</c:if>
	  	<c:if test="${not empty list}">
		  	<c:forEach items="${list}" var="m" varStatus="vs">
		    <tr>
		      <td>${m.orderLogUid}</td>
		      <td>${m.memberNo}</td>
		      <td>${m.csStatus eq 'REF'? '환불': m.csStatus eq 'EXC'?'교환':m.csStatus eq 'RET'?'반품':m.csStatus eq 'CAN'?'주문취소':'완료'}</td>
		      <td><fmt:formatNumber type="currency">${m.cost}</fmt:formatNumber></td>
		      <td>${m.reasonCode }</td>
		      <td>${m.reasonDetail }</td>
		      <td><fmt:formatDate value="${m.reqDate}" pattern="yy-MM-dd"/></td>
		      <td><fmt:formatDate value="${m.endDate}" pattern="yy-MM-dd"/></td>
		    </tr>
		    </c:forEach>
	    </c:if>
	  </tbody>
	</table>
</div>

<strong class="m-5">요청 처리 대기</strong>
<div class="${manageList.size() > 5 ? 'order-list':'' } mb-5">
	<table class="admin-tbl table table-hover mx-auto">
	  <thead>
	    <tr>
	      <th scope="col">주문 번호</th>
	      <th scope="col">회원 번호</th>
	      <th scope="col">요청 일자</th>
	      <th scope="col">요청 확인</th>
	    </tr>
	  </thead>
	  <tbody class="order-body order-change-body" style="-ms-overflow-style: none;">
	  	<c:if test="${empty manageList}">
	  		<tr class="mx-auto">
	  			<td colspan="4">요청 대기 중인 주문이 없습니다.</td>
	  		</tr>
	  	</c:if>
	  	<c:forEach items="${manageList}" var="m" varStatus="vs">
		    <tr id="${m.orderLogUid}">
		      <td>${m.orderLogUid}</td>
		      <td>${m.memberNo}</td>
		      <td><fmt:formatDate value="${m.reqDate}" pattern="yy-MM-dd"/></td>
		      <td>
		      	<button 
		      		type="button" 
		      		class="order-log-modal-btn btn btn-secondary" 
		      		data-toggle="modal" 
		      		data-target="#orderLogModal"
		      		data-order-log="${m.orderLogUid}">
		      		주문 확인
		      	</button>
		      </td>
		    </tr>
	    </c:forEach>
	  </tbody>
	</table>
</div>
</div>
<script>

//주문 통합검색
$("#orderSearchBtn").click((e)=>{
	const csStatus = $("[name=csStatus]:checked").val();
	const searchType = $("[name=searchType]:selected").val();
	const searchKeyword = $("[name=searchKeyword]").val();
	const startDate = $("[name=startDate]").val(); 
	const endDate = $("[name=endDate]").val();
	const time = $(".badge-primary").data("target");
	console.log(orderStatus);
	console.log(csStatus);
	$.ajax({
		url : "${pageContext.request.contextPath}/admin/orderLogSearch",
		method : "GET",
		data : {
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

//요청 상세 모달창에 정보 띄우기
$(".order-log-modal-btn").click((e)=>{
	const orderLogUid = $(e.target).data("orderLog");
	console.log(orderLogUid);
	
	$.ajax({
		url : "${pageContext.request.contextPath}/admin/findOrderLogDetail",
		method : "GET",
		data : {
			orderLogUid : orderLogUid
		},
		success(data){
			console.log(data);
			let reasonCode = "";
			
			let reqDate = new Date(data.orderLog.reqDate); 
			reqDate = reqDate.toISOString().substring(0, 10);
			
			if(data.orderLog.csStatus == 'EXC'){
				if(data.orderLog.processDate == null){
					reasonCode = '교환접수';
				}
				else{
					reasonCode = '교환진행중';
				}
			}
			else if(data.orderLog.csStatus == 'RET'){
				if(data.orderLog.processDate == null){
					reasonCode = '반품접수';
				}
				else{
					reasonCode = '반품진행중';
				}
			}
			
			$("#orderLogModalUid").text(data.orderLog.orderLogUid);
			$("#orderLogModalUid")
				.attr("data-imp-uid", data.imp.impUid)
				.attr("data-amount", data.imp.amount);
				
			$("#orderLogModalName").text(data.imp.name);
			$("#orderLogModalReason").text(data.orderLog.reasonDetail);
			$("#orderLogModalTotal").html("&#8361;"+(data.orderLog.merchant.productPrice+data.orderLog.merchant.shippingFee).toLocaleString());
			$(".order-log-badge").text(reasonCode);
			$(".order-log-badge")
				.attr("data-cs-status", data.orderLog.csStatus)
				.data("valid", data.orderLog.processDate == null? 0 : 1 );
			$("#orderLogModalReqDate").text(reqDate);
			$("#orderLogDetailTbl").html('');
			
			for(let i = 0; i < data.list.length; i++){
				const item = data.list[i];
				$("#orderLogDetailTbl").append(`<tr>
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
							[\${item.name}]
						</strong>
						<br />
						<span class="pl-2"></span>
						<br />
						<span class="pl-2">\${item.buyCount}개 구매</span>
					</td>
				</tr>`);
			}
		},
		error : console.log
	});
});

//주문 접수 클릭 시 교환, 반품이면 진행일자 업데이트, 환불이면 완료일자 업데이트 후 결제 취소
$("#osChangeBtn").click((e)=>{
	const orderLogUid = [$("#orderLogModalUid").text()];
	const impUid = $("#orderLogModalUid").data("impUid");
	const amount = $("#orderLogModalUid").data("amount");
	const csStatus = $(".order-log-badge").data("csStatus");
	const valid = $(".order-log-badge").data("valid");
	const reasonDetail = $("#orderLogModalReason").text();

	let detailList = [];
	const $detailTitle = $(".detail-title");
	const length = $detailTitle.length;
	
	for(let i = 0; i < length; i++){
		detailList[i] = {
				detailNo : $detailTitle.eq(i).data("detailNo"),
				buyCount : $detailTitle.eq(i).data("buyCount")*(-1)
		}
	}
	
	const imp = {
		impUid : impUid,
		amount : amount
	};
	
	console.log(detailList);
	const data = {
			orderLogUid : orderLogUid,
			imp : imp,
			csStatus : csStatus,
			valid : valid,
			detailList : detailList,
			reasonDetail : reasonDetail
		};
	$.ajax({
		url : "${pageContext.request.contextPath}/admin/orderLogUpdate",
		method : "POST",
		dataType : "json",
		contentType : "application/json; charset=utf-8",
		data : JSON.stringify(data),
		success(data){
			console.log(data.msg);
			alert(data.msg);
			if(valid == 1){
				$(`#\${orderLogUid}`).detach();
				if($(".order-change-body").children("tr").length == 0){
					$(".order-change-body").append(`<tr class="mx-auto">
				  			<td colspan="4" class="text-center">요청 대기 중인 주문이 없습니다.</td>
					  		</tr>`);
				}
			}
		},
		error : console.log
	});
	
});
</script>
<jsp:include page="/WEB-INF/views/admin/admin-common/footer.jsp"></jsp:include>
