<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>	
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/admin/admin-common/header.jsp">
	<jsp:param value="블랙리스트 관리" name="title"/>
</jsp:include>
<link href="${pageContext.request.contextPath }/resources/css/admin/adminManage.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath }/resources/css/admin/reportManage.css" rel="stylesheet"/>
<form:form name="BlacklistReleaseFrm" action="${pageContext.request.contextPath}/admin/report/BlacklistRelease.do" method="POST">
<div class="modal fade" id="blacklistModal" tabindex="-1" role="dialog" aria-labelledby="blacklistLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="blacklistLabel">블랙리스트를 해제하시겠습니까?</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
       <p>회원 번호 [ <strong id="memberNo" class="text-danger"></strong> ]</p>
       <p class="mb-0">블랙리스트 해제하시겠습니까?</p>
      </div>
      <input type="hidden" name="memberNo" />
      <input type="hidden" name="blacklistNo" />
      <div class="modal-footer">
        <button type="submit" class="btn btn-primary">해제</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
      </div>
    </div>
  </div>
</div>
</form:form>

<%-- 비고 수정 폼 --%>
<form:form name="noteUpdateFrm" action="${pageContext.request.contextPath}/admin/report/noteUpdate.do" method="POST">
<div class="modal fade" id="noteModal" tabindex="-1" aria-labelledby="noteModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="noteModalLabel">비고 수정</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
          <div class="mb-3">
            <label for="message-text" class="col-form-label">비고</label>
            <textarea class="form-control" id="note" name="note"></textarea>
            <input type="hidden" name="blacklistNo" />
          </div>
      </div>
      <div class="modal-footer">
        <button type="submit" class="btn btn-primary">수정</button>
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>
</form:form>

<div class="report-container">
	<h3 class="m-5">블랙리스트 관리</h3>
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
		 <select name="search-type" id="blacklistReportSearch" class=" bg-light border-0 small">
		 	<option value="memberNo" selected>회원번호로 검색</option>
		 	<option value="note">비고로 검색</option>
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

	<div class="blacklist-list">
		<strong class="m-5">블랙리스트 목록</strong>
		<table class="admin-tbl table mx-auto mt-3">
		  <thead>
		    <tr>
		      <th scope="col" >번호</th>
		      <th scope="col" >회원 번호</th>
		      <th scope="col" >등록일</th>
		      <th scope="col" >해제일</th>
		      <th scope="col" >비고</th>
		      <th scope="col" >블랙리스트 해제</th>
		      <th scope="col" >처리자</th>
		    </tr>
		  </thead>
		  <tbody>
		  <c:if test="${not empty blacklist}">
		  	<c:forEach items="${blacklist}" var="blacklist" varStatus="vs">
		  	
		    <tr class="text-center">
		      <th scope="row">${blacklist.blacklistNo}</th>
		      <td>${blacklist.memberNo}</td>
		      <td><fmt:formatDate value="${blacklist.regDate}" pattern="yy-MM-dd"/></td>
		      <td><fmt:formatDate value="${blacklist.releaseDate}" pattern="yy-MM-dd"/></td>
		      <td><i class="far fa-edit fa-lg edit-icon"  data-bs-toggle="modal" data-bs-target="#noteModal"></i>${blacklist.note}</td>
		      <td>
		      	<c:if test="${empty blacklist.releaseDate}">
		      	<button type="button" class="btn btn-light release-btn" data-toggle="modal" data-target="#blacklistModal" data-member-no="${blacklist.memberNo}" data-blacklist-no="${blacklist.blacklistNo}">해제</button>		      	
		      	</c:if>
		      	<c:if test="${not empty blacklist.releaseDate}">
		      	해제완료
		      	</c:if>
		      </td>
		      <td>
		      	<c:if test="${blacklist.memberNo2 ne 0}">
		      	  ${blacklist.memberNo2}
		      	</c:if>
		      	<c:if test="${blacklist.memberNo2 eq 0}">
		      	  미처리
		      	</c:if>
		      </td>
		    </tr>
		  	</c:forEach>
		  </c:if>
		  <c:if test="${empty blacklist}">
		  	<tr>
				<td colspan="7" class="text-center">블랙리스트 내역이 존재하지 않습니다.</td>
			</tr>
		  </c:if>
		  </tbody>
		</table>

	</div>

<script>
// 해제버튼 클릭 시 해제 모달의 값 넘기기
$(document).on('click', '.release-btn', function(e) {
	const $target = $(e.target);
	// 회원번호
	const memberNo = $(e.target).data('memberNo');
	const blacklistNo = $(e.target).data('blacklistNo');
	
	// 회원번호 관리자를 위한 더블체크 명시하는 부분
	$("#memberNo").text(memberNo);
	
	// 폼의 값 넣기
	const $frm = $(document.BlacklistReleaseFrm);
	$frm.find("[name=memberNo]").val(memberNo);
	$frm.find("[name=blacklistNo]").val(blacklistNo);
});

// 편집 아이콘 클릭 시 발생 - 비고 수정
$(document).on('click', '.edit-icon', function(e) {
	const $target = $(e.target);
	const blacklistNo = $target.parent().siblings('th').text();
	const note = $target.parent().text();
	//console.log(blacklistNo);
	//console.log(note);
	
	$("#note").text(note);
	
	const $frm = $(document.noteUpdateFrm);
	$frm.find("[name=blacklistNo]").val(blacklistNo);
	
})

</script>

<jsp:include page="/WEB-INF/views/admin/admin-common/footer.jsp"></jsp:include>
