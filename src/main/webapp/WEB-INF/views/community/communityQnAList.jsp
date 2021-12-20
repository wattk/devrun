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

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Bootstrap 4, from LayoutIt!</title>

    <meta name="description" content="Source code generated using layoutit.com">
    <meta name="author" content="LayoutIt!">

	<!-- 사이드바 css -->
	<link href="${pageContext.request.contextPath}/resources/css/community/style.css" rel="stylesheet">
	
    <link href="${pageContext.request.contextPath}/resources/css/community/communityQnAList/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/community/style.css" rel="stylesheet">

  </head>
  <body>

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
			<br>

			<!-- 검색창 -->
			<div class="row">
				<div class="col-md-12">
					<div class="input-group mb-3">
						<button class="btn btn-outline-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">전체</button>
						<ul class="dropdown-menu">
							<li><a class="dropdown-item" href="#">답변완료</a></li>
							<li><a class="dropdown-item" href="#">미답변</a></li>
							<li><a class="dropdown-item" href="#">Something else here</a></li>
							<li><hr class="dropdown-divider"></li>
							<li><a class="dropdown-item" href="#">Separated link</a></li>
						</ul>
						<input type="text" class="form-control" aria-label="Text input with dropdown button">
						<button type="button" class="btn btn-outline-primary">검색</button>
					</div>
				</div>
			</div>

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
										<a class="nav-link" href="#tab2" data-toggle="tab">최근답변순</a>
									</li>
									<li class="nav-item">
										<a class="nav-link" href="#tab3" data-toggle="tab">답변 많은 순</a>
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
