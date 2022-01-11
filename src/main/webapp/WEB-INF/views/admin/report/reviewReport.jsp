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
<link href="${pageContext.request.contextPath }/resources/css/admin/adminManage.css" rel="stylesheet"/>
<div class="modal fade" id="reviewModal" tabindex="-1" role="dialog" aria-labelledby="reviewModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="reviewModalLabel">리뷰 상세 내역</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        
      </div>
      <div class="modal-footer">
      	<button type="button" class="btn btn-primary short-cut-btn" data-target-pk-no="">바로가기</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>

<div class="modal fade" id="messageModal" tabindex="-1" role="dialog" aria-labelledby="messageModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="messageModalLabel">메시지 상세 내역</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>

<div class="mx-5">

<div class="report-container">
	<h3 class="my-5">리뷰/메시지 신고</h3>
</div>
<form:form class="m-0">
	<div class="report-search-container mt-5">
		<strong class="pr-3">처리 상태</strong>
		<input type="radio" name="reportStatus" id="report0" />
		<label for="report0">전체</label>
		<input type="radio" name="reportStatus" id="report1" />
		<label for="report1">처리중</label>
		<input type="radio" name="reportStatus" id="report2" />
		<label for="report2">처리 보류</label>
		<input type="radio" name="reportStatus" id="report3" />
		<label for="report3">처리 완료</label>
	</div>
	<div class="report-search-container mt-3">
		<strong class="pr-3">날짜 선택</strong>
		<input type="date" name="" id="" class=" bg-light border-0 small"/>
		<span>~</span>
		<input type="date" name="" id="" class="bg-light border-0 small"/>
		<span class="badge badge-primary">오늘</span>
		<span class="badge badge-secondary">이번주</span>
		<span class="badge badge-secondary">이번달</span>
		<span class="badge badge-secondary">전체</span>
	</div>
	<div class="report-search-container mt-3">
       <div class="input-group w-50">
		 <select name="search-type" id="reviewReportSearch" class=" bg-light border-0 small">
		 	<option value="all" selected>모든 신고 조회</option>
		 	<option value="reportNo">신고번호로 검색</option>
		 	<option value="memberNo">회원번호로 검색</option>
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
<hr class="w-100"/>

	<div class="review-list mb-5">
		<strong>리뷰 신고 내역</strong>
		<table class="admin-tbl table mx-auto mt-3">
		  <thead>
		    <tr>
		      <th scope="col" >번호</th>
		      <th scope="col" >신고분류</th>
		      <th scope="col" >상세사유</th>
		      <th scope="col" >리뷰내용</th>
		      <th scope="col" >피신고자 번호</th>
		      <th scope="col" >신고자 번호</th>
		      <th scope="col" >신고일</th>
		      <th scope="col" >처리상태</th>
		      <th scope="col" >처리자</th>
		    </tr>
		  </thead>
		  <tbody>
		  <c:if test="${not empty reviewList}">
		  	<c:forEach items="${reviewList}" var="review" varStatus="vs">
		    <tr class="text-center">
		      <th scope="row">${review.reportNo}</th>
		      <td>${review.reasonName}</td>
		      <td>
		      	<c:if test="${review.sideNote ne null}">
		      	<button type="button" class="btn btn-light" data-bs-toggle="tooltip" data-bs-placement="top" title="${review.sideNote}">
				  확인
				</button>
				</c:if>
				<c:if test="${review.sideNote eq null}">
				  없음
				</c:if>
			  </td>
		      <td>
		      	<button type="button" class="btn btn-light content-btn" data-toggle="modal" data-target="#reviewModal" data-content="${review.reportContent}" data-target-pk-no="${review.targetPkNo}">확인</button>
		      </td>
		      <td>${review.memberNo3}</td>
		      <td>${review.memberNo}</td>
		      <td><fmt:formatDate value="${review.regDate}" pattern="yy-MM-dd"/></td>
		      <td>
		      	<select name="status" id="statusSelect" class=" bg-light border-0 small" data-report-no="${review.reportNo}" data-target-no="${review.memberNo3}">
				 	<option value="PR" ${review.status eq 'PR' ? 'selected' : ''}>처리중</option>
				 	<option value="DR" ${review.status eq 'DR' ? 'selected' : ''}>처리 보류</option>
				 	<option value="CF" ${review.status eq 'CF' ? 'selected' : ''}>처리 완료</option>
				 </select>
		      </td>
		      <td>
		      	<c:if test="${review.memberNo2 ne 0}">
		      	  ${review.memberNo2}
		      	</c:if>
		      	<c:if test="${review.memberNo2 eq 0}">
		      	  미처리
		      	</c:if>
		      </td>
		    </tr>
		    </c:forEach>
		  </c:if>
		  <c:if test="${empty reviewList}">
		  	<tr>
				<td colspan="9" class="text-center">리뷰 신고 내역이 존재하지 않습니다.</td>
			</tr>
		  </c:if>
		  </tbody>
		</table>

	</div>

	<div class="message-list">
		<strong>메시지 신고 내역</strong>
		<table class="admin-tbl table mx-auto mt-3">
		  <thead>
		    <tr>
		      <th scope="col" >번호</th>
		      <th scope="col" >신고분류</th>
		      <th scope="col" >상세사유</th>
		      <th scope="col" >메시지내용</th>
		      <th scope="col" >피신고자 번호</th>
		      <th scope="col" >신고자 번호</th>
		      <th scope="col" >신고일</th>
		      <th scope="col" >처리상태</th>
		      <th scope="col" >처리자</th>
		    </tr>
		  </thead>
		  <tbody>
		  <c:if test="${not empty messageList}">
		  	<c:forEach items="${messageList}" var="message" varStatus="vs">
		    <tr class="text-center">
		      <th scope="row">${message.reportNo}</th>
		      <td>${message.reasonName}</td>
		      <td>
		      	<c:if test="${message.sideNote ne null}">
		      	<button type="button" class="btn btn-light" data-bs-toggle="tooltip" data-bs-placement="top" title="${message.sideNote}">
				  확인
				</button>
				</c:if>
				<c:if test="${message.sideNote eq null}">
				  없음
				</c:if>
			  </td>
		      <td>
		      	<button type="button" class="btn btn-light content-btn" data-toggle="modal" data-target="#messageModal" data-content="${message.reportContent}" data-target-pk-no="${message.targetPkNo}">확인</button>
		      </td>
		      <td>${message.memberNo3}</td>
		      <td>${message.memberNo}</td>
		      <td><fmt:formatDate value="${message.regDate}" pattern="yy-MM-dd"/></td>
		      <td>
		      	<select name="status" id="statusSelect" class=" bg-light border-0 small" data-report-no="${message.reportNo}" data-target-no="${message.memberNo3}">
				 	<option value="PR" ${message.status eq 'PR' ? 'selected' : ''}>처리중</option>
				 	<option value="DR" ${message.status eq 'DR' ? 'selected' : ''}>처리 보류</option>
				 	<option value="CF" ${message.status eq 'CF' ? 'selected' : ''}>처리 완료</option>
				 </select>
		      </td>
		      <td>
		      	<c:if test="${message.memberNo2 ne 0}">
		      	  ${message.memberNo2}
		      	</c:if>
		      	<c:if test="${message.memberNo2 eq 0}">
		      	  미처리
		      	</c:if>
		      </td>
		    </tr>
		    </c:forEach>
		  </c:if>
		  <c:if test="${empty messageList}">
		  	<tr>
				<td colspan="9" class="text-center">메시지 신고 내역이 존재하지 않습니다.</td>
			</tr>
		  </c:if>
		  </tbody>
		</table>

	</div>
</div>
	
	<%-- 처리상태 변경을 위한 폼 태그 --%>
	<%-- 처리상태 처리중, 처리보류, 처리완료(PR/DR/CF)와 신고번호, 피신고자 번호(경고부여를 위함) 보낸다.--%>
	<form:form
		name="reportStatusUpdateFrm"
		action="${pageContext.request.contextPath}/admin/report/reportStatusUpdate.do"
		method="post">
			<input type="hidden" name="reportNo" />
			<input type="hidden" name="status" />
			<input type="hidden" name="targetNo" />
	</form:form>

<script src="${pageContext.request.contextPath }/resources/js/admin/reportManage.js"></script>
<script>

// 바로가기 클릭 시 상세 화면 새창열기 비동기
$(document).on('click', '.short-cut-btn', function(e) {
	// pk번호를 이용하여 리뷰 글의 상품코드를 구해와서 새창으로 해당 리뷰신고글이 존재하는 상품상세글 띄운다.
	const $target = $(e.target);
	const no = $target.data('targetPkNo');
	
	$.ajax({
		url : `${pageContext.request.contextPath}/admin/report/searchProductCode.do`,
		method : "GET", // GET방식 생략 가능
		data : {
			no : no
		},
		success(productCode) {
			// 조회된 데이터가 있는 경우 
			console.log(productCode);
			if(productCode.length > 0) {
				// 상품코드를 이용하여 새창으로 상품상세글 띄우기
				window.open(`${pageContext.request.contextPath}/shop/itemDetail/\${productCode}`, 'newWindow');
			}
		},
		error : console.log
	});
	
});

</script>
<jsp:include page="/WEB-INF/views/admin/admin-common/footer.jsp"></jsp:include>
