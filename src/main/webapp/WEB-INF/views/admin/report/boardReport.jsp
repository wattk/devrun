<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>	
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/admin/admin-common/header.jsp">
	<jsp:param value="게시물 신고" name="title"/>
</jsp:include>
<link href="${pageContext.request.contextPath }/resources/css/admin/adminManage.css" rel="stylesheet"/>
<div class="modal fade" id="boardModal" tabindex="-1" role="dialog" aria-labelledby="boardModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="boardModalLabel">게시글 신고 상세 내역</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        ...
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>
<div class="report-container">
	<h3 class="m-5">게시물 신고</h3>
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
<form:form>
	<div class="board-list">
		<strong class="m-5">게시물 신고 내역</strong>
		<table class="admin-tbl table mx-auto mt-3">
		  <thead>
		    <tr>
		      <th scope="col" >번호</th>
		      <th scope="col" >신고 회원</th>
		      <th scope="col" >처리 상태</th>
		      <th scope="col" >등록일</th>
		      <th scope="col" >신고 내역</th>
		      <th scope="col" >신고 사유</th>
		      <th scope="col" >신고 내용</th>
		      <th scope="col" >경고 부여</th>
		      <th scope="col" >처리자</th>
		    </tr>
		  </thead>
		  <tbody>
		    <tr class="text-center">
		      <th scope="row">1</th>
		      <td>0</td>
		      <td>
		      	<select name="status" id="" class=" bg-light border-0 small">
				 	<option value="status1" selected>처리중</option>
				 	<option value="status2">처리 보류</option>
				 	<option value="status3">처리 완료</option>
				 </select>
		      </td>
		      <td>0</td>
		      <td>0</td>
		      <td>0</td>
		      <td>
		      	<button type="button" class="btn btn-light" data-toggle="modal" data-target="#boardModal" >확인</button>
		      </td>
		      <td>
		      	<select name="warningYn" id="" class=" bg-light border-0 small">
				 	<option value="Y" selected>Y</option>
				 	<option value="N">N</option>
				 </select>
		      </td>
		      <td>0</td>
		    </tr>
		  </tbody>
		</table>
		<div class="report-save-btn text-right">
			<button type="button" class="btn btn-primary">저장</button>
		</div>
	</div>
</form:form>
<jsp:include page="/WEB-INF/views/admin/admin-common/footer.jsp"></jsp:include>
