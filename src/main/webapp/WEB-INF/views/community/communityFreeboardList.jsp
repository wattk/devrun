<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="" name="title"/>
</jsp:include>
<jsp:include page="/WEB-INF/views/community/common/nav.jsp">
	<jsp:param value="" name="title"/>
</jsp:include>

<!-- 사이드바 css -->
<link href="${pageContext.request.contextPath}/resources/css/community/style.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/community/communityQnAList/bootstrap.min.css" rel="stylesheet">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

<div class="container-fluid">
	<div class="row">
		<div class="col-md-12">
			<div class="row">
				<div class="col-md-12">
					<div class="page-header">
						<h1>
							 Q&A
						</h1>
					</div>
				</div>
			</div>

			<hr>

			<!-- 검색창 -->
			<div class="search-container">
				<div class="col-md-12" >
					<div class="input-group mb-3">
  						<button class="btn btn-outline-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">Dropdown</button>
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
			</div>
			<!-- 검색창 끝 -->

			<hr />
			
			<div class="row">
				<div class="col-md-12">
					<div class="row">
						<div class="col-md-10">
							<div class="tabbable" id="tabs-982750">
								<ul class="nav nav-tabs">
									<li class="nav-item">
										<a class="nav-link active show" href="#tab1" data-toggle="tab">최신순</a>
									</li>
									<li class="nav-item">
										<a class="nav-link" href="#tab2" data-toggle="tab">댓글 많은 순</a>
									</li>
									<li class="nav-item">
										<a class="nav-link" href="#tab4" data-toggle="tab">좋아요 순</a>
									</li>
								</ul>
								<div class="tab-content">
									<div class="tab-pane active" id="panel-432083">
										<p>
											I'm in Section 1.
										</p>
									</div>
									<div class="tab-pane" id="tab2">
										<p>
											Howdy, I'm in Section 2.
										</p>
									</div>
									<div class="tab-pane" id="tab3">
										<p>
											Howdy, I'm in Section 3.
										</p>
									</div>
									<div class="tab-pane" id="tab4">
										<p>
											Howdy, I'm in Section 4.
										</p>
									</div>
								</div>
							</div>
						</div>
						<div class="col-md-2">
							 
							<button type="button" class="btn btn-primary">
								Button
							</button>
						</div>
					</div>

					<div class="row">
						<div class="col-md-5">
							제목
						</div>
						<div class="col-md-1">
							답변여부
						</div>
						<div class="col-md-1">
							등록일
						</div>
						<div class="col-md-1">
							작성자
						</div>
						<div class="col-md-1">
							답변 갯수
						</div>
						<div class="col-md-2">
							<button type="button" class="btn btn-primary">
								답변
							</button>
						</div>
						<div class="col-md-1">
							하트
						</div>
					</div>
				</div>
			</div>

				<!-- 페이징 -->
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
				
		</div>
	</div>
</div>


    <script src="${pageContext.request.contextPath}/resources/js/community/communityQnAList/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/community/communityQnAList/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/community/communityQnAList/scripts.js"></script>
  </body>
</html>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
