<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>	

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="공지사항" name="title"/>
</jsp:include>

<style>
/* 고객센터 본문 */
.customer-center {
	margin-top: 145px;
}

.customer-center h2 {
	font-size: 1.375rem;
	color: #414141;
	font-weight: 700;
}

.customer-center .search {
	border-top: 2px solid #414141;
}

.customer-center .search-form > input {
	width: 85%;
}

.customer-center .search-form > button {
	margin-left: 1%;
	width: 14%;
}

</style>

<div class="container customer-center">
	<div class="row">
		<!-- 사이드 바 -->
		<jsp:include page="/WEB-INF/views/customerCenter/sidebar.jsp"></jsp:include>
		
		<!-- 본문 -->
		<div class="col-sm-9 page">
			<h2>공지사항</h2>
			
			<!-- 검색 -->
			<div class="row py-3 border-bottom m-0 search">
			
				<div class="col-sm-3">
					<!-- 검색타입 -->
					<select id="searchType" class="custom-select">
					  	<option value="title">제목</option>
					  	<option value="content">내용</option>
					</select>	
				</div>
				
				<div class="col-sm-9">
					<!-- 검색창 -->
					<form class="form-inline search-form">
						<input class="form-control" type="search" placeholder="Search" aria-label="Search">
						<button class="btn btn-outline-primary my-2 my-sm-0" type="submit">검색</button>
				  	</form>
				</div>
			
			</div>
			<!-- 검색 끝 -->
			
			<p class="text-right mt-3 mb-1">총 00개</p>

			<!-- 공지사항 게시판 -->
			<table class="table table-hover">
				<thead>
					<tr>
						<th scope="col">번호</th>
						<th scope="col">제목</th>
						<th scope="col">등록일</th>
						<th scope="col">조회수</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<th scope="row">10</th>
						<td><a href="${pageContext.request.contextPath}/customerCenter/noticeDetail.do">Mark</a></td>
						<td>Otto</td>
						<td>@mdo</td>
					</tr>
					<tr>
						<th scope="row">9</th>
						<td>Jacob</td>
						<td>Thornton</td>
						<td>@fat</td>
					</tr>
					<tr>
						<th scope="row">8</th>
						<td>Larry the Bird</td>
						<td>Thornton</td>
						<td>@twitter</td>
					</tr>
					<tr>
						<th scope="row">7</th>
						<td>Mark</td>
						<td>Otto</td>
						<td>@mdo</td>
					</tr>
					<tr>
						<th scope="row">6</th>
						<td>Jacob</td>
						<td>Thornton</td>
						<td>@fat</td>
					</tr>
					<tr>
						<th scope="row">5</th>
						<td>Larry the Bird</td>
						<td>Thornton</td>
						<td>@twitter</td>
					</tr>
					<tr>
						<th scope="row">4</th>
						<td>Mark</td>
						<td>Otto</td>
						<td>@mdo</td>
					</tr>
					<tr>
						<th scope="row">3</th>
						<td>Jacob</td>
						<td>Thornton</td>
						<td>@fat</td>
					</tr>
					<tr>
						<th scope="row">2</th>
						<td>Larry the Bird</td>
						<td>Thornton</td>
						<td>@twitter</td>
					</tr>
					<tr>
						<th scope="row">1</th>
						<td>Mark</td>
						<td>Otto</td>
						<td>@mdo</td>
					</tr>
				</tbody>
			</table>
			<!-- 공지사항 게시판 끝 -->
			
			<!-- 페이징 -->
			<nav aria-label="..." class="mx-auto text-center">
			  <ul class="pagination justify-content-center">
			    <li class="page-item">
			      <a class="page-link" href="#" aria-label="Previous">
			        <span aria-hidden="true">&laquo;</span>
			        <span class="sr-only">Previous</span>
			      </a>
			    </li>
			    <li class="page-item active"><a class="page-link" href="#">1</a></li>
			    <li class="page-item ">
			      <a class="page-link" href="#">2</a>
			    </li>
			    <li class="page-item"><a class="page-link" href="#">3</a></li>
				<li class="page-item">
			      <a class="page-link" href="#" aria-label="Next">
			        <span aria-hidden="true">&raquo;</span>
			        <span class="sr-only">Next</span>
			      </a>
			    </li>
			  </ul>
			</nav>
			<!-- 페이징 끝 -->

		</div>
		<!-- 본문 끝 -->
	</div>

</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>