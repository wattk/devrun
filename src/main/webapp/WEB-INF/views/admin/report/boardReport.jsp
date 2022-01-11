<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>	
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/admin/admin-common/header.jsp">
	<jsp:param value="게시물/댓글 신고" name="title"/>
</jsp:include>
<link href="${pageContext.request.contextPath }/resources/css/admin/adminManage.css" rel="stylesheet"/>
<div class="modal fade" id="boardModal" tabindex="-1" role="dialog" aria-labelledby="boardModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="boardModalLabel">게시글 상세 내역</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary short-cut-btn board-short-cut-btn" data-target-pk-no="">바로가기</button>
        <button type="button" class="btn btn-primary short-cut-btn comment-short-cut-btn" data-target-pk-no="">바로가기</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>

<div class="mx-5">

<div class="report-container">
	<h3 class="m-5">게시물/댓글 신고</h3>
</div>
<form:form>
	<div class="report-search-container mt-5 ml-5">
		<strong class="pr-3">처리 상태</strong>
		<input type="radio" name="reportStatus" id="report0" />
		<label for="report0">전체</label>
		<input type="radio" name="reportStatus" id="report1" />
		<label for="report1">진행중</label>
		<input type="radio" name="reportStatus" id="report2" />
		<label for="report2">처리 보류</label>
		<input type="radio" name="reportStatus" id="report3" />
		<label for="report3">처리 완료</label>
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

	<div class="board-list">
		<strong class="m-5">게시물 신고 내역</strong>
		<table class="admin-tbl table mx-auto mt-3">
		  <thead>
		    <tr>
		      <th scope="col" >번호</th>
		      <th scope="col" >신고분류</th>
		      <th scope="col" >상세사유</th>
		      <th scope="col" >게시물내용</th>
		      <th scope="col" >피신고자 번호</th>
		      <th scope="col" >신고자 번호</th>
		      <th scope="col" >신고일</th>
		      <th scope="col" >처리상태</th>
		      <th scope="col" >처리자</th>
		    </tr>
		  </thead>
		  <tbody>
		  <c:if test="${not empty boardList}">
		  	<c:forEach items="${boardList}" var="board" varStatus="vs">
		    <tr class="text-center">
		      <th scope="row">${board.reportNo}</th>
		      <td>${board.reasonName}</td>
		      <td>
		      	<c:if test="${board.sideNote ne null}">
		      	<button type="button" class="btn btn-light" data-bs-toggle="tooltip" data-bs-placement="top" title="${board.sideNote}">
				  확인
				</button>
				</c:if>
				<c:if test="${board.sideNote eq null}">
				  없음
				</c:if>
			  </td>
		      <td>
		      	<button type="button" class="btn btn-light content-btn board-content-btn" data-toggle="modal" data-target="#boardModal" data-content="${board.reportContent}" data-target-pk-no="${board.targetPkNo}">확인</button>
		      </td>
		      <td>${board.memberNo3}</td>
		      <td>${board.memberNo}</td>
		      <td><fmt:formatDate value="${board.regDate}" pattern="yy-MM-dd"/></td>
		      <td>
		      	<select name="status" id="statusSelect" class=" bg-light border-0 small" data-report-no="${board.reportNo}" data-target-no="${board.memberNo3}">
				 	<option value="PR" ${board.status eq 'PR' ? 'selected' : ''}>처리중</option>
				 	<option value="DR" ${board.status eq 'DR' ? 'selected' : ''}>처리 보류</option>
				 	<option value="CF" ${board.status eq 'CF' ? 'selected' : ''}>처리 완료</option>
				 </select>
		      </td>
		      <td>
		      	<c:if test="${board.memberNo2 ne 0}">
		      	  ${board.memberNo2}
		      	</c:if>
		      	<c:if test="${board.memberNo2 eq 0}">
		      	  미처리
		      	</c:if>
		      </td>
		    </tr>
		    </c:forEach>
		  </c:if>
		  <c:if test="${empty boardList}">
		  	<tr>
				<td colspan="9" class="text-center">게시물 신고 내역이 존재하지 않습니다.</td>
			</tr>
		  </c:if>
		  </tbody>
		</table>

	</div>


	<div class="board-list">
		<strong class="m-5">댓글 신고 내역</strong>
		<table class="admin-tbl table mx-auto mt-3">
		  <thead>
		    <tr>
		      <th scope="col" >번호</th>
		      <th scope="col" >신고분류</th>
		      <th scope="col" >상세사유</th>
		      <th scope="col" >댓글내용</th>
		      <th scope="col" >피신고자 번호</th>
		      <th scope="col" >신고자 번호</th>
		      <th scope="col" >신고일</th>
		      <th scope="col" >처리상태</th>
		      <th scope="col" >처리자</th>
		    </tr>
		  </thead>
		  <tbody>
		  <c:if test="${not empty commentList}">
		  	<c:forEach items="${commentList}" var="comment" varStatus="vs">
		    <tr class="text-center">
		      <th scope="row">${comment.reportNo}</th>
		      <td>${comment.reasonName}</td>
		      <td>
		      	<c:if test="${comment.sideNote ne null}">
		      	<button type="button" class="btn btn-light" data-bs-toggle="tooltip" data-bs-placement="top" title="${comment.sideNote}">
				  확인
				</button>
				</c:if>
				<c:if test="${comment.sideNote eq null}">
				  없음
				</c:if>
			  </td>
		      <td>
		      	<button type="button" class="btn btn-light content-btn comment-content-btn" data-toggle="modal" data-target="#boardModal" data-content="${comment.reportContent}" data-target-pk-no="${comment.targetPkNo}">확인</button>
		      </td>
		      <td>${comment.memberNo3}</td>
		      <td>${comment.memberNo}</td>
		      <td><fmt:formatDate value="${comment.regDate}" pattern="yy-MM-dd"/></td>
		      <td>
		      	<select name="status" id="statusSelect" class=" bg-light border-0 small" data-report-no="${comment.reportNo}" data-target-no="${comment.memberNo3}">
				 	<option value="PR" ${comment.status eq 'PR' ? 'selected' : ''}>처리중</option>
				 	<option value="DR" ${comment.status eq 'DR' ? 'selected' : ''}>처리 보류</option>
				 	<option value="CF" ${comment.status eq 'CF' ? 'selected' : ''}>처리 완료</option>
				 </select>
		      </td>
		      <td>
		      	<c:if test="${comment.memberNo2 ne 0}">
		      	  ${comment.memberNo2}
		      	</c:if>
		      	<c:if test="${comment.memberNo2 eq 0}">
		      	  미처리
		      	</c:if>
		      </td>
		    </tr>
		    </c:forEach>
		  </c:if>
		  <c:if test="${empty commentList}">
		  	<tr>
				<td colspan="9" class="text-center">댓글 신고 내역이 존재하지 않습니다.</td>
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
// 게시물&댓글 신고내역의 각각의 내용 확인 버튼 클릭 시 모달 내용 중 해당하는 바로가기 버튼 보이기 다른 바로가기 버튼 제거 
$(document).on('click', '.board-content-btn', function(e) {
	
	$('.board-short-cut-btn').removeClass("d-none");
	$('.comment-short-cut-btn').addClass("d-none");

});
$(document).on('click', '.comment-content-btn', function(e) {
	
	$('.comment-short-cut-btn').removeClass("d-none");
	$('.board-short-cut-btn').addClass("d-none");

});

//게시물 바로가기 클릭 시 상세 화면 새창열기
$(document).on('click', '.short-cut-btn', function(e) {
	// pk번호를 이용하여 게시물 상세 띄우기
	const $target = $(e.target);
	const no = $target.data('targetPkNo');
	
	window.open(`${pageContext.request.contextPath}/community/communityDetail/\${no}`, 'newWindow');
	
});

//댓글 바로가기 클릭 시 상세 화면 새창열기 비동기
$(document).on('click', '.short-cut-btn', function(e) {
	// pk번호를 이용하여 댓글의 게시글번호를 구해와서 새창으로 해당 댓글신고글이 존재하는 게시글상세글 띄운다.
	const $target = $(e.target);
	const no = $target.data('targetPkNo');
	
	$.ajax({
		url : `${pageContext.request.contextPath}/admin/report/searchCommunityNo.do`,
		method : "GET", // GET방식 생략 가능
		data : {
			no : no
		},
		success(communityNo) {
			// 조회된 데이터가 있는 경우 
			console.log(communityNo);
			if(communityNo > 0) {
				// 상품코드를 이용하여 새창으로 상품상세글 띄우기
				window.open(`${pageContext.request.contextPath}/community/communityDetail/\${communityNo}`, 'newWindow');
			}
		},
		error : console.log
	});
	
});

</script>
<jsp:include page="/WEB-INF/views/admin/admin-common/footer.jsp"></jsp:include>
