<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>	
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/admin/admin-common/header.jsp">
	<jsp:param value="" name="title"/>
</jsp:include>

<!-- Modal -->

<div class="modal fade" id="questionModal" tabindex="-1" aria-labelledby="questionModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-scrollable">
	    <div class="modal-content">
	        <div class="modal-header">
	        	<h5 class="modal-title fw600" id="exampleModalLabel">상품 문의</h5>
	        	<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	        </div>
	        <form name = "insertQuestionFrm"method="post" action="${pageContext.request.contextPath}/admin/questionProduct/insertQuestionProduct.do">	        			    
		        <div class="modal-body" id="answerModalBody">
					<div id="questionContainer">
						<div class="question-top">
							<div>							
								<img id="thumbnail" />	
							</div>
							<div class="modal-product-info">						
								<input type="hidden" name="productCode" id="productCode" value="" />
								<span><input type="text" name="name" id="productName" value="편안한의자" readonly /></span>	
								<span class="price"><input type="text" name="price" id="price" value="100000" /></span>	
							</div>
						</div>
						<hr />
						<div class="question-mid">
							<div class="question-mid-title">
								<input type="hidden" name="questionNo" id="questionNo" />
								<input type="hidden" name="questionRefNo" id="questionRefNo" />
								<input type="hidden" name="memberNo"id="memberNo" />
								<input type="hidden" name="enrollDate"id="enrollDate" />
								<input type="hidden" name="questionLevel"id="questionLevel" />
								<p class="fw600">제목</p>
								<p class="fw600">문의 내용</p>
							</div>
							<div class="question-mid-content">
								<span>
									<input type="text" id="questionTitle" name="title" value="문의 제목" readonly/>
									<!-- <label for="privateYn">비공개</label> -->
									<span>비공개 여부 : </span>
									<span id="PY"></span>
									<input type="hidden" value="N" name ="privateYn" id="privateYn" />																				
								</span>
								<p><textarea readonly id="questionContent" name="content" >졸립군요</textarea> </p>
													
							</div>					
						</div>
					</div>
					<hr />
					<div id ="answrerContainer">
						<div class="answer-mid">
							<div class="answer-title">
								<p class="fw600">답변 내용</p>
							</div>
							<div class="answer-content">
								<textarea id="answer" name="answer"></textarea>
							</div>
						</div>
					</div>
		        </div>
		     
			    <div class="modal-footer">
			    	<span id="answerBtns">
			    	</span>
			        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>			        
		    	</div>
	        </form>
	        <form name ="updateQuestionFrm" id="updateQuestionFrm" method="post" action="${pageContext.request.contextPath}/admin/questionProduct/updateQuestionProduct.do">
	        	<input type="hidden" id="updateTaget" name="questionRefNo" value="" />
	        	<input type="hidden" id="updateAnswer" name="updateAnswer" value="" />      	
	        </form>
	    </div>
	</div>
</div>


<!--------------------------------------------- modal end -------------------------------------------------->


<div class="report-container">
	<h3 class="m-5">회원 문의 관리</h3>
</div>

<div class="report-search-container mt-3 ml-5">
	<strong class="pr-3">날짜 선택</strong>
	<input type="date" id="startDate" class=" bg-light border-0 small"/>
	<span>~</span>
	<input type="date" id="endDate" class="bg-light border-0 small"/>
	<span id="day" class="badge badge-primary">오늘</span>
	<span id="week" class="badge badge-secondary">이번주</span>
	<span id="month" class="badge badge-secondary">이번달</span>
	<span id="allDay" class="badge badge-secondary">전체</span>
</div>

<div class="report-search-container mt-3 ml-5">
	<div class="input-group w-50">
		<select name="search-type" id="searchType" class=" bg-light border-0 small">
			<option value="All" selected>전체</option>
			<option value="MemberNo">회원 번호</option>
			<option value="ProductCode">상품 코드</option>
			<option value="AnswerYn">담변 여부</option>
			<option value="PrivateYn">비밀글 여부</option>
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
	        <div id="searchMemberNo" class="search-type other">
	            <form class="search-frm">
	                <input type="hidden" name="searchType" value="member_no"/>
	                <input type="text" name="searchKeyword" class="t-input" size="25" placeholder="검색할 회원 번호를 입력하세요." value=""/>
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
	        
	        <div id="searchAnswerYn" class="search-type other">
	             <form class="search-frm">
	            	<input type="hidden" name="searchType" value="answer_yn"/>
	    				
					<input type="radio" class="btn-check" name="searchKeyword" id="Y" value="Y" >
					<label class="btn btn-success" for="Y">답변</label>
					
					<input type="radio" class="btn-check" name="searchKeyword" id="N" value="N" >
					<label class="btn btn-success" for="N">미답변</label>
					
					<input type="hidden" name="startDate" class="start-date"/>	
	                <input type="hidden" name="endDate" class="end-date" />		
					
	                <button type="button" class="btn-blue search-btn">검색</button>
	            </form>
	        </div>        
	        <div id="searchPrivateYn" class="search-type other">
	            <form class="search-frm">
	            	<input type="hidden" name="searchType" value="private_yn"/>
	    				
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

<br /><hr class="w-100"/><br />
		
<form:form>
	<div class="review-list">
		<div><strong class="table-title" >회원 문의 내역</strong></div><br />
	<div id="totalCountContainer"></div>
		<table id="inquiryListTbl" class="admin-tbl table mx-auto mt-3">
		    <thead>
				<tr>
					<th scope="col" >문의 번호</th>
					<th scope="col" >회원 번호</th>
					<th scope="col" >상품 코드</th>
					<th scope="col" >제목</th>
					<th scope="col" >내용</th>
					<th scope="col" >등록일</th>
					<th scope="col" >비밀글 여부</th>
					<th scope="col" >답변</th>
			    </tr>
		    </thead>
		    <tbody id="tbody">
		    	<c:forEach items ="${questionList}" var="qu">
				<c:if test="${qu.questionLevel == 1 }">
			    	<tr>
			    		<td>${qu.questionNo}</td>
			    		<td>${qu.memberNo}</td>
			    		<td>${qu.productCode}</td>
			    		<td>${qu.title}</td>
			    		<td>${qu.content}</td>
			    		<td><fmt:formatDate value="${qu.enrollDate}" pattern="yyyy-MM-dd"/></td>
			    		<td>${qu.privateYn}</td>		    	
			    		<c:choose>
			    			<c:when test="${0 eq qu.questionRefNo}">
				    			<td><button type="button" class="btn btn-warning answer-btn" 
				    				data-bs-toggle="modal" data-bs-target="#questionModal">답변 대기</button></td>	
			    			</c:when>
			    			<c:when test="${0 ne qu.questionRefNo}">
				    			<td><button type="button" class="btn btn-primary answer-btn" 
				    				data-bs-toggle="modal" data-bs-target="#questionModal">답변 완료</button></td>	
			    			</c:when>
			    		</c:choose>
			    		
			    	</tr>								 

				</c:if>
		    	</c:forEach>
		  </tbody>
		</table>
	</div>
	${pagebar}
</form:form>

<script>
	
/*-----------------------------------*/
	 // 날짜 뱃지 호버
	$(".badge").hover(e=>{
		$(e.target).css("cursor","pointer");
	});

	// 날짜 벳지 버튼 클릭	
	$(".badge").click(e=>{
		$(".badge").removeClass("badge-primary").addClass("badge-secondary"); 
		$(e.target).addClass("badge-primary").removeClass("badge-secondary");
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
		
			
	/*---------------------------------------*/
	
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

	
	/* 답변 버튼 클릭 이벤트  */
	$(document).on("click",".answer-btn",e=>{
		
		var questionNo = $(e.target).parents("tr").children().first().html();
		var productCode  = $(e.target).parents("tr").children().eq(2).html();
		
		console.log(questionNo);
		console.log(productCode);
		
		var obj = {
			"questionNo" : questionNo,
			"productCode" : productCode
		};
		
	 	$.ajax({
			url :`${pageContext.request.contextPath}/admin/questionProduct/selectQuestion.do`,
			data : obj,
			contentType : "application/json; charset=utf-8",
			success(data){
				console.log(data.questionProductInfo);
				var questionProductInfo = data.questionProductInfo;
				var answer = data.answer;
				var imgUrl = `${pageContext.request.contextPath}/resources/upload/product/\${questionProductInfo.thumbnail}`;
				
				console.log(imgUrl);
				console.log("questionNo = ",questionProductInfo.questionNo);
				console.log("questionLevel = ",questionProductInfo.questionLevel);
				console.log("privateYn = ",questionProductInfo.privateYn);
				console.log("answer = ",answer);
				
						
				/* 모달창 input태그들에 값 대입 */
				$(".modal-body #questionNo").val(questionProductInfo.questionNo);
				$(".modal-body #questionRefNo").val(questionProductInfo.questionRefNo);
				$(".modal-body #productName").val(questionProductInfo.name);
				$(".modal-body #productCode").val(questionProductInfo.productCode);
				
				/* 이미지 경로 동적으로 넣어주기 */
				$(".modal-body #thumbnail").attr("src",imgUrl);
				
				$(".modal-body #price").val(questionProductInfo.price);
				$(".modal-body #enrollDate").val(questionProductInfo.enrollDate);
				$(".modal-body #questionTitle").val(questionProductInfo.title);
				$(".modal-body #memberNo").val(questionProductInfo.memberNo);
				$(".modal-body #questionContent").val(questionProductInfo.content);
				
				$(".modal-body #questionLevel").val(questionProductInfo.questionLevel); 
			 	$(".modal-body #privateYn").val(questionProductInfo.privateYn); 
			 	if(questionProductInfo.privateYn == 'Y'){					
			 		$("#PY").html("O");
		 			$(".modal-body #privateYn").val('Y'); 
			 	}
			 	else{
			 		$("#PY").html("X");
					$(".modal-body #privateYn").val('N');
			 	}
			 	
			 	/* 답변 대입 */
			 	$(".modal-body #answer").val(answer);
			 	
			 	if(answer == "no"){
			        $(answerBtns).html(`<button type="submit" id="completeBtn"class="btn btn-primary">답변 하기</button>`); 	  		 		
			 	}else{			 		
			        $(answerBtns).html(`<button type="button" id="updateAnswer"class="btn btn-primary">수정 하기</button>`); 	  		 		
			 	}
			 	
			 	/* 수정할 답변의 번호 */
			 	if(questionProductInfo.questionRefNo != 0){
				 	$(updateTaget).val(questionProductInfo.questionRefNo);		 		
			 	}

			},
			error:console.log
			
		}); 
	 	
	});
 	/* 수정하기 클릭 이벤트 */
	$(document).on("click","#updateAnswer",e=>{
		/* 수정한 답변 내용 넣어주기 */
		$(updateAnswer).val($(answer).val());
		$("#updateQuestionFrm").submit();
	});
	/*  호버 이벤트 */
	$(document).ready(function(){

	    $(document).on({
	        mouseenter: function (e) {
	        	$(e.target).parent("tr").css("background","#0d6efd36");
	    		$(e.target).parent("tr").css("cursor","pointer");

	        },
	        mouseleave: function (e) {
	    		$(e.target).parent("tr").css("background","white");
	        }

	    },"#inquiryListTbl tbody tr");

	});

	// 검색 & 검색결과 페이징
	
	/* 검색창 변경 */
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
	
	
	/* 전역 변수 */
	var selectType = "All";
	/* $searchType은 form안의 input=name값 */
	var $searchType = "";
	var $searchKeyword = "";
	var cPage;
	
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
			url:`${pageContext.request.contextPath}/admin/qustionProduct/searchQuestion.do`,
			data:search,
			contentType:"application/json; charset=utf-8",
			success(data){
							
				$("#tbody").html(data["questionStr"]);
				$(".pagebar").detach();
				$("#inquiryListTbl").after(data["pagebar"]);
				$(totalCountContainer).html(`<span class="countTitle">검색된 게시물 수 : </span> <span class="countContent">\${data["totalContent"]}</span>`)			
			},
			error:console.log			
		});
	}
		
	// 비동기 요청 실행 및 유효성 검사
	$(".search-btn").click(e=>{
	
		const target = $(e.target).parent().children("input[name=searchKeyword]").val();
		console.log("target =",target);
		
		console.log("selectType =",selectType);
		
		/* 검사 pass */
		if(selectType == "All" || selectType == "PrivateYn" || selectType == "AnswerYn"){
			getPage();
		}
				
		/* 회원 번호로 검색할 때 */
		if(selectType == "MemberNo"){
			console.log("번호로 검색~");
			
			if(!/[0-9]/.test(target)){
				alert("회원 번호를 확인하세요.");
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
	
	
	
	
</script>








<jsp:include page="/WEB-INF/views/admin/admin-common/footer.jsp"></jsp:include>
