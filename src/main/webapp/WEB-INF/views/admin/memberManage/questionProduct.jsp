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

<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-scrollable">
	    <div class="modal-content">
	        <div class="modal-header">
	        	<h5 class="modal-title fw600" id="exampleModalLabel">상품 문의</h5>
	        	<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	        </div>
	        <form name = "insertQuestionFrm"method="post" action="${pageContext.request.contextPath}/admin/questionProduct/insertQuestionProduct.do">	        			    
		        <div class="modal-body">
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
								<input type="hidden" name="qLevel"id="qLevel" />
								<p class="fw600">제목</p>
								<p class="fw600">문의 내용</p>
							</div>
							<div class="question-mid-content">
								<span>
									<input type="text" id="questionTitle" name="title" value="문의 제목" readonly/>
									<label for="privateYn">비공개</label>
									<input type="checkbox" value="N" name ="privateYn" id="privateYn" />							
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
			        <button type="submit" id="completeBtn"class="btn btn-primary">답변 완료</button>
			        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
		    	</div>
	        </form>
	    </div>
	</div>
</div>


<!--------------------- -->

<div class="report-container">
	<h3 class="m-5">회원 문의 관리</h3>
</div>

<form:form>
	<div class="report-search-container mt-3 ml-5">
		<strong class="pr-3">날짜 선택</strong>
		<input type="date" name="" id="" class=" bg-light border-0 small"/>
		<span>~</span>
		<input type="date" name="" id="" class="bg-light border-0 small"/>
		<span class="badge badge-primary">오늘</span>
		<span class="badge badge-secondary">이번주</span>
		<span class="badge badge-secondary">이번달</span>
		<span class="badge badge-secondary">전체</span>
	</div>
	<div class="report-search-container mt-3 ml-5">
       <div class="input-group w-50">
		 <select name="search-type" id="searchType" class=" bg-light border-0 small">
		 	<option value="all" selected>문의 번호</option>
		 	<option value="reportNo">상품 코드</option>
		 	<option value="memberNo">담변 여부</option>
		 	<option value="memberNo">비밀글 여부</option>
		 	<option value="memberNo">문의 레벨</option>
		 </select>
         <input type="text" class="form-control bg-light border-0 small" placeholder="검색어를 입력하세요."
             aria-label="Search" aria-describedby="basic-addon2">
         <div class="input-group-append">
             <button class="btn btn-primary" type="button">
                 <i class="fas fa-search fa-sm"></i>
             </button>
         </div>
       </div>
	</div>
</form:form>

<br /><hr class="w-100"/><br />
<form:form>
	<div class="review-list">
		<div><strong class="table-title" >회원 문의 내역</strong></div>
		<table id="inquiryListTbl" class="admin-tbl table mx-auto mt-3">
		    <thead>
				<tr>
					<th scope="col" >문의 번호</th>
					<th scope="col" >참조 문의 번호</th>
					<th scope="col" >회원 번호</th>
					<th scope="col" >상품 코드</th>
					<th scope="col" >제목</th>
					<th scope="col" >내용</th>
					<th scope="col" >등록일</th>
					<th scope="col" >비밀글 여부</th>
					<th scope="col" >답변</th>
			    </tr>
		    </thead>
		    <tbody>
		    	<c:forEach items ="${questionList}" var="qu">
			    	<%-- <c:if test="${qu.qLevel == 1}"> --%>
			    	<tr>
			    		<td>${qu.questionNo}</td>
			    		<td>${qu.questionRefNo}</td>
			    		<td>${qu.memberNo}</td>
			    		<td>${qu.productCode}</td>
			    		<td>${qu.title}</td>
			    		<td>${qu.content}</td>
			    		<td> <fmt:formatDate value="${qu.enrollDate}" pattern="yyyy-MM-dd"/></td>
			    		<td>${qu.privateYn}</td>	
			    		<td><button type="button" class="btn btn-primary answer-btn" data-bs-toggle="modal" data-bs-target="#exampleModal">답변</button></td>	
			    	</tr>								 
			    	<%-- </c:if> --%>
		    	</c:forEach>
		  </tbody>
		</table>
		<div class="report-save-btn text-right">
			<button type="button" class="btn btn-primary">저장</button>
		</div>
	</div>
</form:form>

<script>
	
	
	/* 답변 버튼 클릭 이벤트  */
	$(".answer-btn").click(e=>{
		var questionNo = $(e.target).parents("tr").children().first().html();
		var productCode  = $(e.target).parents("tr").children().eq(3).html();
		
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
				console.log("qLevel = ",questionProductInfo.qlevel);
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
				
				/* 이상하게 qlevel은 카멜케이싱이 적용이 안돼서 넘어온다  */
				$(".modal-body #qLevel").val(questionProductInfo.qlevel);
			 	$(".modal-body #privateYn").val(questionProductInfo.privateYn); 
			 	if(questionProductInfo.privateYn == 'Y'){
					$(".modal-body #privateYn").attr("checked",true);	
					$(".modal-body #privateYn").val('Y');
			 	}
			 	else{
			 		$(".modal-body #privateYn").attr("checked",false);	
					$(".modal-body #privateYn").val('N');
			 	}
			 	
			 	/* 답변 대입 */
			 	$(".modal-body #answer").val(answer); 
			 	
			 	
										 	
			},
			error:console.log
			
		}); 
		
	});
	
</script>








<jsp:include page="/WEB-INF/views/admin/admin-common/footer.jsp"></jsp:include>
