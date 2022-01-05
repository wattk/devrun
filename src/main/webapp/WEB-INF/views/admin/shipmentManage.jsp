<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>	
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/admin/admin-common/header.jsp">
	<jsp:param value="배송관리" name="title"/>
</jsp:include>
<link href="${pageContext.request.contextPath }/resources/css/admin/adminManage.css" rel="stylesheet"/>
<!-- 배송 조회 모달 -->
<div class="modal fade" id="shipmentModal" tabindex="-1" role="dialog" aria-labelledby="shipmentModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="modalProductTitle">배송 조회</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body" id="modalProductList">
        <div class="shipment-info mx-auto text-center">
        	<span class="tracking-no-badge badge badge-pill badge-light">운송장 번호</span>
        	<h5 id="modalTrackingNo"></h5>
        	<i class="tracking-icon fas fa-shipping-fast"></i>
        	<br />
        	<span id="trackingStatus"></span>
        </div>
        <hr />
       	<ul id="tracking-info" class="list-group ">
		</ul>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>

<!-- 배송 관리 본문 시작 -->
<div class="shipment-container">
	<h3 class="m-5">배송내역</h3>
</div>
<form:form>
	<div class="shipment-search-container mt-5 ml-5">
		<strong class="pr-3">날짜 선택</strong>
		<input type="date" name="startDate" id="" class=" bg-light border-0 small"/>
		<span>~</span>
		<input type="date" name="endDate" id="" class="bg-light border-0 small"/>
		<span class="date-badge badge badge-secondary" data-target="today">오늘</span>
		<span class="date-badge badge badge-secondary" data-target="week">이번주</span>
		<span class="date-badge badge badge-secondary" data-target="month">이번달</span>
		<span class="date-badge badge badge-primary" data-target="all">전체</span>
	</div>
	<div class="shipment-search-container mt-3 ml-5">
       <div class="input-group w-50">
		 <select name="searchType" id="shipmentSearch" class=" bg-light border-0 small">
		 	<option value="all" selected>모든 주문 조회</option>
		 	<option value="shipmentNo">배송번호로 검색</option>
		 	<option value="trackingNo">송장번호로 검색</option>
			<option value="merchantUid">주문번호로 검색</option>
		 </select>
         <input type="text" name="searchKeyword" class="form-control bg-light border-0 small" placeholder="검색어를 입력하세요."
             aria-label="Search" aria-describedby="basic-addon2">
         <div class="input-group-append">
             <button id="shipmentSearchBtn" class="btn btn-primary" type="button">
                 <i class="fas fa-search fa-sm"></i>
             </button>
         </div>
       </div>
	</div>
</form:form>
<hr class="w-100"/>
<div class="shipment-list">
	<strong class="m-5">배송 목록</strong>
	<table class="admin-tbl table table-hover mx-auto mt-3">
	  <thead>
	    <tr>
	      <th scope="col">배송 번호</th>
	      <th scope="col">송장 번호</th>
	      <th scope="col">주문 번호/변동 기록 번호</th>
	      <th scope="col">발송 일자</th>
	    </tr>
	  </thead>
	  <tbody id="shipmentBody">
	  	<c:if test="${empty shipmentList }">
	  		<tr class="mx-auto">
	  			<td colspan="4">배송 기록이 없습니다.</td>
	  		</tr>
	  	</c:if>
	  	<c:if test="${not empty shipmentList }">
	  		<c:forEach items="${shipmentList}" var="s" varStatus="vs">
			    <tr>
			      <td>${s.shipmentNo}</td>
			      <td><span id="${s.trackingNo}" class="tracking-no" data-toggle="modal" data-target="#shipmentModal" >${s.trackingNo}</span></td>
			      <td>${s.merchantUid}</td>
			      <td><fmt:formatDate value="${s.shipmentDate}" pattern="yy-MM-dd"/> </td>
			    </tr>
	  		</c:forEach>
	  	</c:if>
	  </tbody>
	</table>
</div>
<div class="shipment-list">
	<strong class="ml-5 mr-2">송장 번호 입력</strong>
	<table class="admin-tbl table table-hover mx-auto mt-3">
	  <thead>
	    <tr>
	      <th scope="col" class="col-3">주문 번호/변동 기록 번호</th>
	      <th scope="col" class="col-2">회원 번호</th>
	      <th scope="col" class="col-2">주문 일자</th>
	      <th scope="col" class="col-5">송장 번호 입력</th>
	    </tr>
	  </thead>
	  <tbody id="orderBody">
	  	<c:if test="${empty merchantList}">
	  		<tr class="mx-auto">
	  			<td colspan="4">처리 대기 중인 주문이 없습니다.</td>
	  		</tr>
	  	</c:if>
	  	<c:forEach items="${merchantList}" var="m" varStatus="vs">
		    <tr id="${m.merchantUid}">
		      <td>${m.merchantUid}</td>
		      <td>${m.memberNo}</td>
		      <td><fmt:formatDate value="${m.orderDate}" pattern="yy-MM-dd"/></td>
		      <td class="text-left">
		      	<input 
		      		type="text" 
		      		name="shipmentNo" 
		      		id="${m.merchantUid}" 
		      		class="form-control bg-light border-0 small" 
		      		placeholder="송장번호를 입력하세요"/>
		      	<span class="shipment-alert text-danger">운송장 번호는 10자리 또는 12자리입니다.</span>
		      </td>
		    </tr>
	    </c:forEach>
	  </tbody>
	</table>
	<div class="text-right">
		<button
			id="shipmentSaveBtn"
	   		type="button" 
	   		class="btn btn-secondary mr-5"> 
	   		저장
	   	</button>
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

//배송 통합검색
$("#orderSearchBtn").click((e)=>{
	const searchType = $("[name=searchType]:selected").val();
	const searchKeyword = $("[name=searchKeyword]").val();
	const startDate = $("[name=startDate]").val(); 
	const endDate = $("[name=endDate]").val();
	const time = $(".badge-primary").data("target");
	console.log(orderStatus);
	console.log(csStatus);
	$.ajax({
		url : "${pageContext.request.contextPath}/admin/shipmentSearch",
		method : "GET",
		data : {
			searchType : searchType,
			searchKeyword : searchKeyword,
			startDate : startDate,
			endDate : endDate
		},
		success(data){
			console.log(data);
			$("#shipmentBody").html(data.shipmentStr);
		},
		error : console.log
	});
});

//송장번호 유효성 검사
$("[name=shipmentNo]").on('change keyup paste',(e)=>{
	const value = $(e.target).val();
	const $alert = $(e.target).siblings("span");
	
	if(value == ''){
		$alert.hide();
		return;
	}
	
	if(!/^(\d{10}|\d{12})$/.test(value)){
		$alert.show();
	}
	else{
		$alert.hide();
		
	}
});

//송장번호 등록 메소드
$("#shipmentSaveBtn").click((e)=>{
	const $shipmentNos = $("[name=shipmentNo]");
	const shipmentArr = new Array();
	const merchantUid = new Array();
	
	for(let i = 0; i < $shipmentNos.length; i++){
		const value = $shipmentNos.eq(i).val();
		if(value == ''){
			continue;
		}
		
		merchantUid.push($shipmentNos.eq(i).attr("id"));
		shipmentArr.push({
			merchantUid : $shipmentNos.eq(i).attr("id"),
			shipmentNo : value
		});
	}
	
	const data = {
			merchantUid : merchantUid,
			shipmentArr : shipmentArr
	};
	
	console.log(shipmentArr);
	
	$.ajax({
		url : "${pageContext.request.contextPath}/admin/enrollShipmentNo",
		method : "POST",
		dataType : "json",
		contentType : "application/json; charset=utf-8",
		data : JSON.stringify(data),
		success(data){
			console.log(data);
			if(data.inputValid == 1){
				alert(data.msg);
				for(let i = 0; i < merchantUid.length; i++){
					$(`#\${merchantUid[i]}`).detach();
				}
			}
		},
		error : console.log
	});
});
$(".tracking-no").click((e)=>{
	const trackingNo = $(e.target).attr("id");
	
	$.ajax({
		//배송 추적 api로 송장번호 전달
		url : "https://apis.tracker.delivery/carriers/kr.cjlogistics/tracks/"+trackingNo,
		method : "GET",
		success(data){
			console.log(data);
			$("#modalTrackingNo").text(trackingNo);
			$("#trackingStatus").text(data.state.text);
			
			$("#tracking-info").html('');
			(data.progresses).forEach((progress, index)=>{
				console.log(progress);
				console.log(progress.time);
				//날짜 포맷 yyyy-MM-dd HH:mm:ss로 변경
				let today = new Date(progress.time); 
				today.setHours(today.getHours() + 9); 
				today = today.toISOString().replace('T', ' ').substring(0, 19);

				$("#tracking-info")
					.prepend(`<li class="list-group-item">
					<strong class="tracking-location">\${progress.location.name}</strong><span>\${progress.status.text}</span>
					<br />
					<span class="tracking-date">\${today}</span>
				</li>`);
			});
		},
		error(){
			$("#modalTrackingNo").text(trackingNo);
			$("#tracking-info").html('');
			
			$("#tracking-info")
				.prepend(`<li class="list-group-item text-center">
				<strong class="tracking-location">존재하지 않는 송장번호입니다.</strong>
			</li>`);
		}
	});
});
</script>
<jsp:include page="/WEB-INF/views/admin/admin-common/footer.jsp"></jsp:include>