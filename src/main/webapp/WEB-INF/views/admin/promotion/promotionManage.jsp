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
<div class="promotion-container">
	<h3 class="m-5">이벤트 관리</h3>
</div>
<form:form>
	<div class="promotion-list">
		<span class="m-5 pl-4">[총 3개]</span>
		<br />
		<strong class="ml-5 mr-2 pl-4">선택한 항목을 </strong>
		<button type="button" class="btn btn-secondary" data-dismiss="modal">삭제</button>
		<table class="admin-tbl table table-hover mx-auto mt-3 text-center">
			<thead>
			    <tr>
			      <th scope="col">
			      	<input type="checkbox" name="eventCheck" id="" class="event-check" />
			      </th>
			      <th scope="col">번호</th>
			      <th scope="col">이벤트 등록일</th>
			      <th scope="col">이벤트 이름</th>
			      <th scope="col">이벤트 아이템</th>
			      <th scope="col">이벤트 상태</th>
			      <th scope="col">이벤트 시작일</th>
			      <th scope="col">이벤트 종료일</th>
			      <th scope="col">글쓴이</th>
			      <th scope="col">조회수</th>
			    </tr>
			</thead>
			<tbody>
			    <tr>
			      <td>
			      	<input type="checkbox" name="eventCheck" id="" class="event-check" />
			      </td>
			      <td>0</td>
			      <td>0</td>
			      <td>
			      	<a href="${pageContext.request.contextPath}/admin/promotionDetail.do">이벤트 123</a>
			      </td>
			      <td>
			      	<button type="button" class="btn btn-light" data-toggle="modal" data-target="#boardModal" >확인</button>
			      </td>
			      <td>0</td>
			      <td>0</td>
			      <td>0</td>
			      <td>0</td>
			      <td>0</td>
			    </tr>
	  	 </tbody>
	</table>
	<div class="text-right">
		<button type="button" class="event-write-btn btn btn-primary">글쓰기</button>
	</div>
	</div>
</form:form>
<script>
$(".event-write-btn").click((e)=>{
	location.href = `${pageContext.request.contextPath}/admin/promotionEnroll.do`;
});
</script>
<jsp:include page="/WEB-INF/views/admin/admin-common/footer.jsp"></jsp:include>
