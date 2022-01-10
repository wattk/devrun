<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>	
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/admin/admin-common/header.jsp">
	<jsp:param value="회원 신고" name="title"/>
</jsp:include>
<link href="${pageContext.request.contextPath }/resources/css/admin/adminManage.css" rel="stylesheet"/>
<div class="report-container">
	<h3 class="m-5">회원 신고</h3>
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

	<div class="member-list">
		<strong class="m-5">회원 신고 내역</strong>
		<table class="admin-tbl table mx-auto mt-3">
		  <thead>
		    <tr>
		      <th scope="col" >번호</th>
		      <th scope="col" >신고분류</th>
		      <th scope="col" >상세사유</th>
		      <th scope="col" >피신고자 번호</th>
		      <th scope="col" >신고자 번호</th>
		      <th scope="col" >신고일</th>
		      <th scope="col" >처리상태</th>
		      <th scope="col" >처리자</th>
		    </tr>
		  </thead>
		  <tbody>
		  <c:if test="${not empty memberList}">
		  	<c:forEach items="${memberList}" var="member" varStatus="vs">
		    <tr class="text-center">
		      <th scope="row">${member.reportNo}</th>
		      <td>${member.reasonName}</td>
		      <td>
		      	<c:if test="${member.sideNote ne null}">
		      	<button type="button" class="btn btn-light" data-bs-toggle="tooltip" data-bs-placement="top" title="${member.sideNote}">
				  확인
				</button>
				</c:if>
				<c:if test="${member.sideNote eq null}">
				  없음
				</c:if>
			  </td>
		      <td>${member.memberNo3}</td>
		      <td>${member.memberNo}</td>
		      <td><fmt:formatDate value="${member.regDate}" pattern="yy-MM-dd"/></td>
		      <td>
		      	<select name="status" id="statusSelect" class=" bg-light border-0 small" data-report-no="${member.reportNo}" data-target-no="${member.memberNo3}">
				 	<option value="PR" ${member.status eq 'PR' ? 'selected' : ''}>처리중</option>
				 	<option value="DR" ${member.status eq 'DR' ? 'selected' : ''}>처리 보류</option>
				 	<option value="CF" ${member.status eq 'CF' ? 'selected' : ''}>처리 완료</option>
				 </select>
		      </td>
		      <td>
		      	<c:if test="${member.memberNo2 ne 0}">
		      	  ${member.memberNo2}
		      	</c:if>
		      	<c:if test="${member.memberNo2 eq 0}">
		      	  미처리
		      	</c:if>
		      </td>
		    </tr>
		    </c:forEach>
		  </c:if>
		  <c:if test="${empty memberList}">
		  	<tr>
				<td colspan="8" class="text-center">회원 신고 내역이 존재하지 않습니다.</td>
			</tr>
		  </c:if>
		  </tbody>
		</table>

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
<jsp:include page="/WEB-INF/views/admin/admin-common/footer.jsp"></jsp:include>
