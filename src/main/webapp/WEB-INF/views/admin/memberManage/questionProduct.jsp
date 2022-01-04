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
									<span>공개 여부 : </span>
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
	    </div>
	</div>
</div>

<!-- modal end -->

<div class="report-container">
	<h3 class="m-5">회원 문의 관리</h3>
</div>


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
			<option value="All" selected>전체</option>
			<option value="MemberNo">회원 번호</option>
			<option value="ProductCode">상품 코드</option>
			<option value="AnswerYn">담변 여부</option>
			<option value="PrivateYn">비밀글 여부</option>
		</select>
		
	 	<div id = "searchKeywordContainer">
    		<div id="searchAll" class="search-type">
	            <form>
	                <input type="hidden" name="searchType" value="all"/>
	                <input type="hidden" name="searchKeyword"  size="25" placeholder="" value="all"/>
	                <button type="submit"id="searchBymemberAll" class="btn-blue search-btn">검색</button>			
	            </form>	
	        </div>
	        <div id="searchMemberNo" class="search-type other">
	            <form>
	                <input type="hidden" name="searchType" value="member_no"/>
	                <input type="text" name="searchKeyword"  size="25" placeholder="검색할 회원 번호를 입력하세요." value=""/>
	                <button type="submit"id="searchBymemberNo" class="btn-blue search-btn">검색</button>			
	            </form>	
	        </div>
	        <div id="searchProductCode" class="search-type other">
	            <form>
	                <input type="hidden" name="searchType" value="product_code"/>
	                <input type="text" name="searchKeyword" size="25" placeholder="검색할 회원 아이디를 입력하세요" value=""/>
	                <button type="submit" class="btn-blue search-btn">검색</button>			
	            </form>	
	        </div>
	        
	        <div id="searchAnswerYn" class="search-type other">
	             <form>
	            	<input type="hidden" name="searchType" value="authority"/>
	    				
					<input type="checkbox" class="btn-check" name="searchKeyword" id="answer1" value="ROLE_M1" >
					<label class="btn btn-success" for="answer1">답변</label>
					
					<input type="checkbox" class="btn-check" name="searchKeyword" id="answer2" value="ROLE_M2" >
					<label class="btn btn-success" for="answer2">미답변</label>
					
	                <button type="submit" class="btn-blue search-btn">검색</button>
	            </form>
	        </div>
	        
	        <div id="searchPrivateYn" class="search-type other">
	            <form action="<%=request.getContextPath()%>/admin/memberFinder">
	            	<input type="hidden" name="searchType" value="authority"/>
	    				
					<input type="checkbox" class="btn-check" name="searchKeyword" id="private1" value="ROLE_M1" >
					<label class="btn btn-success" for="private1">공개</label>
					
					<input type="checkbox" class="btn-check" name="searchKeyword" id="private2" value="ROLE_M2" >
					<label class="btn btn-success" for="private2">비공개</label>
	                <button type="submit" class="btn-blue search-btn">검색</button>		
	            </form>	
	        </div>
	        
	        <div id="searchMemberRole" class="search-type other">
	            <form action="<%=request.getContextPath()%>/admin/memberFinder">
	            	<input type="hidden" name="searchType" value="authority"/>
	            	
			        <input type="checkbox" class="btn-check" name="searchKeyword" id="admin" value="ROLE_AM">
					<label class="btn btn-success" for="admin">관리자</label>
					
					<input type="checkbox" class="btn-check" name="searchKeyword" id="member1" value="ROLE_M1" >
					<label class="btn btn-success" for="member1">지식인</label>
					
					<input type="checkbox" class="btn-check" name="searchKeyword" id="member2" value="ROLE_M2" >
					<label class="btn btn-success" for="member2">일반회원</label>
	                <button type="submit" class="btn-blue search-btn">검색</button>
	            </form>
	        </div>
		</div>
       
       
	</div>
</div>


<br /><hr class="w-100"/><br />
<form:form>
	<div class="review-list">
		<div><strong class="table-title" >회원 문의 내역</strong></div>
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
		    <tbody>
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
				    			<td><button type="button" class="btn btn-warning answer-btn" data-bs-toggle="modal" data-bs-target="#questionModal">답변 대기</button></td>	
			    			</c:when>
			    			<c:when test="${0 ne qu.questionRefNo}">
				    			<td><button type="button" class="btn btn-primary answer-btn" data-bs-toggle="modal" data-bs-target="#questionModal">답변 완료</button></td>	
			    			</c:when>
			    		</c:choose>
			    		
			    	</tr>								 

				</c:if>
		    	</c:forEach>
		  </tbody>
		</table>
	</div>
</form:form>

<script>

	/* 검색 */
	$(searchType).change(function(){
		var searchTypeVal = $(this).val();
		console.log("searchTypeVal = ",searchTypeVal);
		$(".search-type")
			.hide()
			.filter("#search" +searchTypeVal)
			.css("display", "inline-block");
	});
	
	
	/* 답변 버튼 클릭 이벤트  */
	$(".answer-btn").click(e=>{
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

			},
			error:console.log
			
		}); 
	 	
	 	/* 수정하기 클릭 이벤트 */
		$(document).on("click","#answerBtns button",e=>{
			var url = "<%=request.getContextPath()%>/admin/questionProduct/updateQuestionProduct.do"
			var key = "qestionRefNo";
			var value = $("input[name=questionRefNo]").val();
			
			
			sendPost(url,key,value);
					
		});
	});
	
	function sendPost(url,key,value){	

		var form = document.createElement("form");
		form.setAttribute('method','post');
		form.setAttribute('action',url);
		document.charset = "utf-8";

			
		var hiddenField = document.createElement("input");
		hiddenField.setAttribute("type","hidden");
		hiddenField.setAttribute("name",key);
		hiddenField.setAttribute("value",value);
		
		
		form.appendChild(hiddenField);

		document.body.appendChild(form);
	 	form.submit(); 
		
	}	
</script>








<jsp:include page="/WEB-INF/views/admin/admin-common/footer.jsp"></jsp:include>
