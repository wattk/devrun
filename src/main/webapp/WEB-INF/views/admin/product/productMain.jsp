<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<jsp:include page="/WEB-INF/views/admin/admin-common/header.jsp">
	<jsp:param value="상품관리" name="title"/>
</jsp:include>
<style>
.product-img-box{
	width : 6.5rem;
	height : 6.5rem;
}
.product-img{
	width : 100%;
	height : 100%;
	object-fit : cover;
	
}
</style>
<!-- 모달 -->
<div class="modal fade" id="promotionModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="modalProductTitle">옵션</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
	      <div class="modal-body" id="modalOptionList">
	      <table>
	      	<tr><th>옵션</th><th>재고</th></tr>
	      </table>	
	      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal" id="modalCloseBtn">닫기</button>
      </div>
    </div>
  </div>
</div>

<div class="product-container container">
	<h2>상품 관리</h2>	
	<!---------------------- 검색 바 시작 ----------------------------------->
	<div class="report-search-container mt-3">
		<strong class="pr-3">날짜 선택</strong>
		<input type="date" id="startDate" class=" bg-light border-0 small"/>
		<span>~</span>
		<input type="date" id="endDate" class="bg-light border-0 small"/>
		<span id="day" class="badge badge-secondary">오늘</span>
		<span id="week" class="badge badge-secondary">이번주</span>
		<span id="month" class="badge badge-secondary">이번달</span>
		<span id="allDay" class="badge badge-secondary">전체</span>
	</div>
	
	<div class="report-search-container mt-3">
		<div class="input-group w-50">
			<select name="search-type" id="searchType" class=" bg-light border-0 small">
				<option value="All" selected>전체</option>
				<option value="ProductCode">상품 코드</option>
				<option value="Name">상품명</option>
				<option value="Status">공개 여부</option>
			</select>
			
		 	<div id = "searchKeywordContainer">
	    		<div id="searchAll" class="search-type">
		            <form class="search-frm">
		                <input type="hidden" name="searchType" value="all"/>
		                <input type="hidden" name="searchKeyword"  size="25" placeholder="" value="all"/>
		                <input type="hidden" name="startDate" class="start-date"/>	
		                <input type="hidden" name="endDate" class="end-date" />
		                	
		                <button type="button"id="searchBymemberAll" class="btn-blue search-btn">검색</button>		
		            </form>	
		        </div>
		        <div id="searchName" class="search-type other">
		            <form class="search-frm">
		                <input type="hidden" name="searchType" value="name"/>
		                <input type="text" name="searchKeyword" class="t-input" size="25" placeholder="검색할 상품명을 입력하세요." value=""/>
		                <input type="hidden" name="startDate" class="start-date"/>	
		                <input type="hidden" name="endDate" class="end-date" />
		                			
		                <button type="button"id="searchBymemberNo" class="btn-blue search-btn">검색</button>	
		            </form>	
		        </div>
		        <div id="searchProductCode" class="search-type other">
		            <form class="search-frm">
		                <input type="hidden" name="searchType" value="product_code"/>
		                <input type="text" name="searchKeyword" class="t-input" size="25" placeholder="검색할 상품 코드를 입력하세요" value=""/>
		                <input type="hidden" name="startDate" class="start-date"/>	
		                <input type="hidden" name="endDate" class="end-date" />		
		                
		                <button type="button" class="btn-blue search-btn">검색</button>               		
		            </form>	
		        </div>
		               
		        <div id="searchStatus" class="search-type other">
		            <form class="search-frm">
		            	<input type="hidden" name="searchType" value="status"/>
		    				
						<input type="radio" class="btn-check" name="searchKeyword" id="public" value='Y' >
						<label class="btn btn-success" for="public">공개</label>
						
						<input type="radio" class="btn-check" name="searchKeyword" id="private" value='N' >
						<label class="btn btn-success" for="private">비공개</label>
						
						<input type="hidden" name="startDate" class="start-date"/>	
		                <input type="hidden" name="endDate" class="end-date" />		
		                
		                <button type="button" class="btn-blue search-btn">검색</button>		
		            </form>	
		        </div>
		        
			</div>              
		</div>
	</div>

<!---------------------- 검색 바 끝 ----------------------------------->
 
	<div id="productListContainer">
		<div id="title" class="box">
			<div id="imgText">
				<span>총 ${totalContent}개의 상품 중</span>
				<span>선택한 항목 [<span id="selectCount">0</span>]개 </span>
			</div>
			<div id="btnContainer">
			<!-- 상품 삭제시 전송할 form -->
			<form
				id="productDelteFrm"
				name="productDelteFrm"
				action="${pageContext.request.contextPath}/admin/deleteProduct.do"
				method="POST">
				<button 
					id="deleteProductBtn"
					class="btn btn-danger" 
					>상품 삭제</button>
			</form>
			<button 
				id="insertProductBtn"
				class="btn btn-primary" 
				type="button"
				onclick="location.href='${pageContext.request.contextPath}/admin/insertProduct.do'"	>상품등록</button>
			</div>
				
		</div>
		<!-- 상품 리스트 테이블 -->
		<table id="productList">
			<thead>
				<tr>
					<th style="width : 1vw;"><input type="checkbox" id="checkAll"/></th>
					<th style="width : 7vw;">이미지</th>
					<th style="width : 10vw;">상품코드</th>
					<th style="width : 15vw;">상품명</th>
					<th style="width : 3vw;">옵션</th>
					<th style="width : 3vw;">상태</th>
					<th style="width : 7vw;">등록일</th>
					<th style="width : 4vw;">조회수</th>
				</tr>
			</thead>
			<tbody id="tbody">
				<c:forEach items="${list}" var="pro" >
				<tr>				
					<td><input type="checkbox"id="select" class="box"/> </td>
					<td class="">
						<div class="product-img-box mx-auto text-center">
							<img id="" class="product-img img-thumbnail" src="${pageContext.request.contextPath}/resources/upload/product/${pro.thumbnail}"/>
						</div>
					</td>
					<td><a href="${pageContext.request.contextPath}/admin/productDetail.do?productCode=${pro.productCode}">${pro.productCode}</a></td>
					<td  class="p-1" style="word-break: keep-all;">${pro.name}</td>
					<td>
						<button type="button" class="option-modal-btn btn btn-light"
						 data-toggle="modal" data-target="#promotionModal" data-code="${pro.productCode}">확인</button>
					</td>
					<td>${pro.status}</td>
					<td><fmt:formatDate value="${pro.regDate}" pattern="yy-MM-dd HH:mm"/></td>
					<td>${pro.viewCount}</td>
				</tr>
				</c:forEach>			
			</tbody>
		</table>
		<br />
		${pagebar}
		
	</div>
	
	
</div>

<script>

// enter 동기 전송 막기
$('input[type="text"]').keydown(function(e) {
	if (event.keyCode === 13) {
		event.preventDefault();

	};
  
});



/* ================  검색 날짜 선택  ================== */

// 날짜 - 전역변수 사용
var startDate;
var endDate;

/* 시작 날짜 선택  */
$("#startDate,#endDate").change(e=>{
	console.log("시작 날짜 선택");
	startDate = $("#startDate").val();
	endDate = $("#endDate").val();
	
	$(".start-date").val(startDate);
	$(".end-date").val(endDate);
	
	console.log("시작 날짜 = ",startDate);
	console.log("종료 날짜 = ",endDate);		
});

// 날짜 벳지 버튼 클릭

$(".badge").click(e=>{
	$(".badge").removeClass("badge-primary").addClass("badge-secondary"); 
	$(e.target).addClass("badge-primary").removeClass("badge-secondary");
});

// 날짜 뱃지 호버
$(".badge").hover(e=>{
	$(e.target).css("cursor","pointer");
});

/* 전체 클릭 시 날짜 초기화 && 전역변수에 담긴 날짜값도 초기화 */
$("#allDay").click(e=>{
	$("#startDate, #endDate").val('');
	startDate = "";
	endDate = "";
	
});

/* '오늘' 버튼 클릭 */
$("#day").click(e=>{
	/*  버튼 클릭 시 input 태크에 값을 넣어준 뒤 전역 변수로 선언 된 	var startDate,var endDate 에도 대입 */	
	const now = new Date();
	
	const date = ('0' + now.getDate()).slice(-2);
	const month = ('0' + now.getMonth()+1).slice(-2);
	const year = now.getFullYear();
	const startDateStr = year + '-' + month +'-'+ date;
	
	$("#startDate,#endDate").val(startDateStr);
	startDate = startDateStr;
	endDate = startDateStr;
});

/* '이번주 버튼 클릭' */
	$("#week").click(e=>{

	var currentDay = new Date();  
	
	var theYear = currentDay.getFullYear();
	var theMonth = currentDay.getMonth();
	var theDate  = currentDay.getDate();
	var theDayOfWeek = currentDay.getDay();
	 
	var thisWeek = [];
	 
	for(var i=0; i<7; i++) {
	  var resultDay = new Date(theYear, theMonth, theDate + (i - theDayOfWeek));
	  var yyyy = resultDay.getFullYear();
	  var mm = Number(resultDay.getMonth()) + 1;
	  var dd = resultDay.getDate();
	 
	  mm = String(mm).length === 1 ? '0' + mm : mm;
	  dd = String(dd).length === 1 ? '0' + dd : dd;
	 
	  thisWeek[i] = yyyy + '-' + mm + '-' + dd;
	}
	const startWeek = thisWeek[0];
	const endWeek = thisWeek[6];
	 
	console.log(startWeek);
	console.log(endWeek);

	$("#startDate").val(startWeek);
	$("#endDate").val(endWeek);
	
 	startDate = startWeek;
	endDate = endWeek; 
			
});
	/* '이번달 버튼 클릭' */
	$("#month").click(e=>{
		const now = new Date();	
		const month = new Date();
		month.setMonth(now.getMonth()+2);
		
		
		const dateStr = ('0' + 1).slice(-2);
		const monthStr = ('0' + now.getMonth()+1).slice(-2);
		const nextMonthStr = ('0' + month.getMonth()).slice(-2);
		const yearStr = now.getFullYear();	

		
		const startDateStr = yearStr + '-' + monthStr +'-'+ dateStr;
		const endDateStr = yearStr + '-' + nextMonthStr +'-'+ dateStr;
		
		$("#startDate").val(startDateStr);
		$("#endDate").val(endDateStr);
		
		startDate = startDateStr;
		endDate = endDateStr;
});
	

 
/* ==================  검색창 변경  ======================= */

$(searchType).change(function(e){		
	// 검색타입 바뀔 때 마다 값 초기화
	selectType = $("#searchType").val();
	
	$searchType = "";
	$searchKeyword = "";
	
	var searchTypeVal = $(this).val();
	console.log("searchTypeVal = ",searchTypeVal);
	$(".search-type")
		.hide()
		.filter("#search" +searchTypeVal)
		.css("display", "inline-block");
});

/* =============== 검색 시작 & 검색결과 페이징 ===================*/

/* 전역 변수 */
var selectType = "All";
var $searchType = "";
var $searchKeyword = "";
var cPage;

// 비동기 요청 실행 및 유효성 검사
$(".search-btn").click(e=>{
	const target = $(e.target).parent().children("input[name=searchKeyword]").val();
	console.log("target =",target);
	
	console.log("selectType =",selectType);
	
	/* 검사 pass */
	if(selectType == "All" || selectType == "Status"){
		getPage();
	}
			
	/* 상품 이름로 검색할 때 */
	if(selectType == "Name"){
		console.log("상품 이름으로 검색~");
		
		if(false){
			alert("상품 이름을 확인하세요.");
		}else{
			getPage();
		}
		
	}
	
	/* 상품 코드로 검색할 때 */
	if(selectType == "ProductCode"){
		console.log("상품 코드로 검색.");
		console.log("target =",target);
					
		if(!/^[a-zA-Z0-9]/.test(target)){
			alert("상품 코드를 확인하세요.");
		}else{
			getPage();
		}
	}

	
});


/* search 입력값 전역변수에 대입  */
$("input[name=searchKeyword]").change(e=>{		
	console.log($(e.target).parent().children("input[name=searchType]").val());
	console.log($(e.target).val()); 
	
	$searchType = $(e.target).parent().children("input[name=searchType]").val();
 	$searchKeyword = $(e.target).val() ;
});

/* search 변경시 전역 변수에 대입 */
$(searchType).change(e=>{
	console.log($(e.target));		
	var target = "search"+$(e.target).val();
			
	$searchType= $("#"+target+"").find("input[name=searchType]").val();
	$searchKeyword = $("#"+target+"").find("input[name=searchKeyword]").val();
});

/* 검색 form 전송 및 페이징 함수 */
function getPage(cPage){
	
	searchType = $searchType;
	searchKeyword =  $searchKeyword;
	var cPage;
			
	console.log(searchType);
	console.log(searchKeyword);
	
	
	const search = {
		"startDate" : startDate,
		"endDate" : endDate,
		"searchType" : $searchType,
		"searchKeyword" : $searchKeyword,
		"cPage" : cPage
	};
	
	console.log(search);
	
	$.ajax({
		url:`${pageContext.request.contextPath}/admin/product/searchProduct.do`,
		data:search,
		contentType:"application/json; charset=utf-8",
		success(data){
			console.log(data);
			$("#tbody").html(data["productStr"]);
			$(".pagebar").detach();
			$("#productList").after(data["pagebar"]);
			$(imgText).html(`<span class="countTitle">검색된 상품 수 : </span> <span class="countContent">\${data["totalContent"]}</span>`)			
		},
		error:console.log			
	});
}




/* ----------------------------------------------------------------- */

$(()=>{
	let checkedProduct;

		
		
	$(modalCloseBtn).click(e=>{
		$("#modalOptionList table").html(`<tr><th>옵션</th><th>재고량</th></tr>`);
	});
	
	/* 모달 관련 */
	$(document).on("click",".option-modal-btn",(e)=>{
		const productCode = $(e.target).data("code");
		console.log(productCode);
		$.ajax({
			 url : `${pageContext.request.contextPath}/admin/findProductOption`,
			data : {productCode : productCode},
			method : "GET",
			success(data){
				console.log(data);
				$(data).each((i, productDetail) => {
					$("#modalOptionList table").append(`<tr></tr><tr><td>\${productDetail.optionNo}</td><td>\${productDetail.quantity}</td></tr>`);
				});						
			},
			error : console.log		
		});
	});	
	
	
	
	/*  호버 이벤트 */
	$("#productList tr").hover(
		e=>{
			$(e.target).parent("tr").css("background","#0d6efd36");
		},
		e=>{
			$(e.target).parent("tr").css("background","white");
		}
	)
	
	/* 전체 선택/해제  */
	$(checkAll).change(e=>{
		console.log($("#checkAll").prop("checked"));
		if($("#checkAll").prop("checked")){
			$(".box").prop("checked",true);		
		}
		else{
			$(".box").prop("checked",false);	
		}
		
	});
	
	/* 게시물 선택 */
	$(".box, #checkAll ").change(e=>{
		checkCount = $(".box:checked").length;
		$(selectCount).html(checkCount);
		
		console.log($(".box").length-1 , $(".box:checked").length);
		
		if( $(".box").length-1 == $(".box:checked").length ){
			$("#checkAll").prop("checked",true);
			console.log("전부 체크");
		}
		else{
			$("#checkAll").prop("checked",false);
		}	
		
		// 상품 삭제 : check되어 있는 tr의 product_code값을 가져온뒤 input hidden 값으로 form태그안에 넣어준다 .
		checkedProduct = $(".box:checked").parents("tr").children().eq(2).text();
		console.log(checkedProduct);
		$("#productDelteFrm").append(`<input type="hidden" name="productCodes" value="\${checkedProduct}" />`)
		

	});
	
});
</script>

<jsp:include page="/WEB-INF/views/admin/admin-common/footer.jsp"></jsp:include>


