<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="" name="title"/>
</jsp:include>
<jsp:include page="/WEB-INF/views/community/common/communitySidebar.jsp">
	<jsp:param value="" name="title"/>
</jsp:include>
<!--  <link href="${pageContext.request.contextPath}/resources/css/community/communityMain/style.css" rel="stylesheet"> -->


<div class="container-fluid">
	<div class="row">
		<div class="col-md-12">
		
			<!-- 헤더 -->
			<div class="row">
				<div class="col-md-12">
					<div class="page-header">
						<h1>
							<strong>커뮤니티 검색</strong>
						</h1>
					</div>
				</div>
			</div>
			<!-- 헤더 끝 -->
	
			<hr>

			<!-- 검색창 시작-->
			<div class="search-container">
				<div class="col-md-12 mx-auto w-50">
					<div class="input-group mx-auto ">
						<button class="btn btn-outline-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">전체</button>
						<ul class="dropdown-menu">
							<li><a class="dropdown-item" href="#">제목</a></li>
							<li><a class="dropdown-item" href="#">아이디</a></li>
							<li><a class="dropdown-item" href="#">내용</a></li>
						</ul>
						<input type="text" class="form-control" aria-label="Text input with dropdown button">
						<button type="button" class="btn btn-outline-primary">검색</button>
					</div>
				</div>
			</div>
			<!-- 검색창 끝 -->
			
			<hr>
			<br>

			<!-- Dev_news 시작 -->
			<div class="row">
				<div class="col-md-12">
					<h2>
						<strong>Dev_news</strong>
					</h2>
				</div>
			</div>

			<br>
			<hr>
			<br>

			<!-- Dev_news 썸네일 시작-->
			<div class="row">
				<div class="col-md-12">
					<div class="row">
						<div class="col-md-4">
							<div class="card">
								<img class="card-img-top" alt="Bootstrap Thumbnail First" src="https://www.layoutit.com/img/people-q-c-600-200-1.jpg">
								<div class="card-block">
									<h5 class="card-title">
										Card title
									</h5>
									<p class="card-text">
										Cras justo odio, dapibus ac facilisis in, egestas eget quam. Donec id elit non mi porta gravida at eget metus. Nullam id dolor id nibh ultricies vehicula ut id elit.
									</p>
									<p>
										<a class="btn btn-primary" href="#">Action</a> <a class="btn" href="#">Action</a>
									</p>
								</div>
							</div>
						</div>
						<div class="col-md-4">
							<div class="card">
								<img class="card-img-top" alt="Bootstrap Thumbnail Second" src="https://www.layoutit.com/img/city-q-c-600-200-1.jpg">
								<div class="card-block">
									<h5 class="card-title">
										Card title
									</h5>
									<p class="card-text">
										Cras justo odio, dapibus ac facilisis in, egestas eget quam. Donec id elit non mi porta gravida at eget metus. Nullam id dolor id nibh ultricies vehicula ut id elit.
									</p>
									<p>
										<a class="btn btn-primary" href="#">Action</a> <a class="btn" href="#">Action</a>
									</p>
								</div>
							</div>
						</div>
						<div class="col-md-4">
							<div class="card">
								<img class="card-img-top" alt="Bootstrap Thumbnail Third" src="https://www.layoutit.com/img/sports-q-c-600-200-1.jpg">
								<div class="card-block">
									<h5 class="card-title">
										Card title
									</h5>
									<p class="card-text">
										Cras justo odio, dapibus ac facilisis in, egestas eget quam. Donec id elit non mi porta gravida at eget metus. Nullam id dolor id nibh ultricies vehicula ut id elit.
									</p>
									<p>
										<a class="btn btn-primary" href="#">Action</a> <a class="btn" href="#">Action</a>
									</p>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- Dev_news 끝-->
			
			<br>
			<hr>
			<br>

			<!-- 인기 게시물 시작 -->
			<div class="row">
				<div class="col-md-12">
					<h2>
						<strong>인기 게시물</strong>
					</h2>
				</div>
			</div>
			

			<br>
			<hr>
			<br>

			<div class="row">
				<div class="col-md-4">
					<div class="card">
						<img class="card-img-top" alt="Bootstrap Thumbnail First" src="https://www.layoutit.com/img/people-q-c-600-200-1.jpg">
						<div class="card-block">
							<h5 class="card-title">
								Card title
							</h5>
							<p class="card-text">
								Cras justo odio, dapibus ac facilisis in, egestas eget quam. Donec id elit non mi porta gravida at eget metus. Nullam id dolor id nibh ultricies vehicula ut id elit.
							</p>
							<p>
								<a class="btn btn-primary" href="#">Action</a> <a class="btn" href="#">Action</a>
							</p>
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="card">
						<img class="card-img-top" alt="Bootstrap Thumbnail Second" src="https://www.layoutit.com/img/city-q-c-600-200-1.jpg">
						<div class="card-block">
							<h5 class="card-title">
								Card title
							</h5>
							<p class="card-text">
								Cras justo odio, dapibus ac facilisis in, egestas eget quam. Donec id elit non mi porta gravida at eget metus. Nullam id dolor id nibh ultricies vehicula ut id elit.
							</p>
							<p>
								<a class="btn btn-primary" href="#">Action</a> <a class="btn" href="#">Action</a>
							</p>
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="card">
						<img class="card-img-top" alt="Bootstrap Thumbnail Third" src="https://www.layoutit.com/img/sports-q-c-600-200-1.jpg">
						<div class="card-block">
							<h5 class="card-title">
								Card title
							</h5>
							<p class="card-text">
								Cras justo odio, dapibus ac facilisis in, egestas eget quam. Donec id elit non mi porta gravida at eget metus. Nullam id dolor id nibh ultricies vehicula ut id elit.
							</p>
							<p>
								<a class="btn btn-primary" href="#">Action</a> <a class="btn" href="#">Action</a>
							</p>
						</div>
					</div>
				</div>
			</div>

			<br>

			<div class="row">
				<div class="col-md-4">
					<div class="card">
						<img class="card-img-top" alt="Bootstrap Thumbnail First" src="https://www.layoutit.com/img/people-q-c-600-200-1.jpg">
						<div class="card-block">
							<h5 class="card-title">
								Card title
							</h5>
							<p class="card-text">
								Cras justo odio, dapibus ac facilisis in, egestas eget quam. Donec id elit non mi porta gravida at eget metus. Nullam id dolor id nibh ultricies vehicula ut id elit.
							</p>
							<p>
								<a class="btn btn-primary" href="#">Action</a> <a class="btn" href="#">Action</a>
							</p>
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="card">
						<img class="card-img-top" alt="Bootstrap Thumbnail Second" src="https://www.layoutit.com/img/city-q-c-600-200-1.jpg">
						<div class="card-block">
							<h5 class="card-title">
								Card title
							</h5>
							<p class="card-text">
								Cras justo odio, dapibus ac facilisis in, egestas eget quam. Donec id elit non mi porta gravida at eget metus. Nullam id dolor id nibh ultricies vehicula ut id elit.
							</p>
							<p>
								<a class="btn btn-primary" href="#">Action</a> <a class="btn" href="#">Action</a>
							</p>
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="card">
						<img class="card-img-top" alt="Bootstrap Thumbnail Third" src="https://www.layoutit.com/img/sports-q-c-600-200-1.jpg">
						<div class="card-block">
							<h5 class="card-title">
								Card title
							</h5>
							<p class="card-text">
								Cras justo odio, dapibus ac facilisis in, egestas eget quam. Donec id elit non mi porta gravida at eget metus. Nullam id dolor id nibh ultricies vehicula ut id elit.
							</p>
							<p>
								<a class="btn btn-primary" href="#">Action</a> <a class="btn" href="#">Action</a>
							</p>
						</div>
					</div>
				</div>
			</div>

			<br>
			<hr>
			<br>
			
			<!-- 리스트형 게시글 -->
			<div class="row">
				<div class="col-md-12">
					<table class="table">
						<thead>
							<tr>
								<th>
									#
								</th>
								<th>
									Product
								</th>
								<th>
									Payment Taken
								</th>
								<th>
									Status
								</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>
									1
								</td>
								<td>
									TB - Monthly
								</td>
								<td>
									01/04/2012
								</td>
								<td>
									Default
								</td>
							</tr>
							<tr class="table-active">
								<td>
									1
								</td>
								<td>
									TB - Monthly
								</td>
								<td>
									01/04/2012
								</td>
								<td>
									Approved
								</td>
							</tr>
							<tr class="table-success">
								<td>
									2
								</td>
								<td>
									TB - Monthly
								</td>
								<td>
									02/04/2012
								</td>
								<td>
									Declined
								</td>
							</tr>
							<tr class="table-warning">
								<td>
									3
								</td>
								<td>
									TB - Monthly
								</td>
								<td>
									03/04/2012
								</td>
								<td>
									Pending
								</td>
							</tr>
							<tr class="table-danger">
								<td>
									4
								</td>
								<td>
									TB - Monthly
								</td>
								<td>
									04/04/2012
								</td>
								<td>
									Call in to confirm
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			
			<br>

			<!-- 페이징 시작 -->
			<div>
				<nav aria-label="...">
					<ul class="pagination">
						<li class="page-item disabled">
							<span class="page-link">Previous</span>
						</li>
						<li class="page-item"><a class="page-link" href="#">1</a></li>
						<li class="page-item active" aria-current="page">
							<span class="page-link">2</span>
						</li>
						<li class="page-item"><a class="page-link" href="#">3</a></li>
						<li class="page-item">
							<a class="page-link" href="#">Next</a>
						</li>
					</ul>
				</nav>
			</div>
			<!-- 페이징 끝 -->
			
		</div>
	</div>
</div>
</div>

<script src="${pageContext.request.contextPath}/resources/js/community/communityMain/scripts.js"></script>
	
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
