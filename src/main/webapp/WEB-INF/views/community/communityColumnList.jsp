<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>	
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/community/common/communitySidebar.jsp"></jsp:include>
        
<div class="container-fluid container">
	<div class="row">
		<div class="col-md-12">
		
			<!-- 헤더 -->
			<div class="row">
				<div class="col-md-12">
					<div class="page-header">
						<h1 class="mt-5">
							<strong class="navbar-brand text-brand">Dev<span class="color-b">Run</span> Community</strong>
						</h1>
					</div>
				</div>
			</div>
			<!-- 헤더 끝 -->
			
			<hr>

			<!-- carousel -->
			<div class="row">
				<div class="col-md-12">
					<div class="carousel slide" id="carousel-335818">
						<ol class="carousel-indicators">
							<li data-slide-to="0" data-target="#carousel-335818">
							</li>
							<li data-slide-to="1" data-target="#carousel-335818" class="active">
							</li>
							<li data-slide-to="2" data-target="#carousel-335818">
							</li>
						</ol>
						<div class="carousel-inner">
							<div class="carousel-item">
								<img class="d-block w-100" alt="Carousel Bootstrap First" src="${pageContext.request.contextPath}/resources/images/column1.PNG">
							</div>
							<div class="carousel-item active">
								<img class="d-block w-100" alt="Carousel Bootstrap Second" src="${pageContext.request.contextPath}/resources/images/column2.png">
							</div>
							<div class="carousel-item">
								<img class="d-block w-100" alt="Carousel Bootstrap Third" src="${pageContext.request.contextPath}/resources/images/column3.png">
							</div>
						</div> <a class="carousel-control-prev" href="#carousel-335818" data-slide="prev"><span class="carousel-control-prev-icon"></span> <span class="sr-only">Previous</span></a> <a class="carousel-control-next" href="#carousel-335818" data-slide="next"><span class="carousel-control-next-icon"></span> <span class="sr-only">Next</span></a>
					</div>
				</div>
			</div>

			<br>
			<hr>
			<br>

			<section class="section-services section-t5 pb-5">
			    <div class="container">
			      <div class="row">
			        <div class="col-md-12">
			          <div class="title-wrap d-flex justify-content-between">
			            <div class="title-box">
			              <h2 class="title-a">Best Column</h2>
			            </div>
			          </div>
			        </div>
			      </div>
			      <div class="row">
			      	<c:if test="${not empty bestList}">
				  		<c:forEach items="${bestList}" var="c" varStatus="vs">
					        <div class="col-md-4">
								<div class="card" style="height:330px;">
									<c:if test="${c.thumbnail eq null}">
										<img class="card-img-top p-5" alt="" src="${pageContext.request.contextPath}/resources/images/logo-devrun.png">
									</c:if>
									<c:if test="${c.thumbnail ne null}">
										<img class="card-img-top" alt="" src="${pageContext.request.contextPath}/resources/upload/community/${c.thumbnail}">
									</c:if>
									<div class="card-block p-3">
										<h3 class="card-title">
											<a href="${pageContext.request.contextPath}/community/communityDetail/${c.communityNo}">${c.title}</a>
										</h3>
										<p class="card-text">
											<span>${fn:substring(c.content,0,30)}</span>
										</p>
									</div>
								</div>
							</div>
				  		</c:forEach>
				  	</c:if>
				  	<c:if test="${empty bestList}">
					    <div class="mx-auto text-align">
					    	<h4>등록된 칼럼이 없습니다.</h4>
					    </div>
				  	</c:if>
			      </div>
			    </div>
			  </section>

			<br>
			
			<div id="columnContainer">
				<table id="tbl-board" class="table table-hover">
					<tr style="background-color: #1A81FF; color: white;">
						<th class="col-1">번호</th>
						<th class="col-3">제목</th>
						<th class="col-1">작성자</th>
						<th class="col-1">작성일</th>
						<th class="col-1">좋아요</th> 
						<th class="col-1">조회수</th>
						<th class="col-1">댓글개수</th>
					</tr>
					
					<!-- 반복접근할 요소 : items="${list} -->
					<!-- 꺼내면 cmmunityEntity니까 communityEntity라는 이름으로 사용 -->
					<tbody id = "tbody">
						<c:if test="${not empty list}">
						<c:forEach items="${list}" var="communityEntity">
							<tr data-no="${communityEntity.communityNo}" style="cursor: pointer;" class="whynot">
								<td>${communityEntity.communityNo}</td>
								<td><a href="${pageContext.request.contextPath}/community/communityDetail/${communityEntity.communityNo}">${communityEntity.title}</a></td>
								<td>${communityEntity.nickname}</td>
								<td><fmt:formatDate value="${communityEntity.enrollDate}" pattern="yy-MM-dd"/></td>
								<td><i class="fas fa-heart"></i> ${communityEntity.likeCount}</td>
								<td>${communityEntity.viewCount}</td>
								<td>${communityEntity.commentCount}</td>
							</tr>
						</c:forEach>
						</c:if>
						<c:if test="${empty list}">
							<tr class="mx-auto text-center">
								<td colspan="7" >등록된 칼럼이 없습니다.</td>
							</tr>
						</c:if>
					</tbody>
				</table>
				<sec:authorize access="hasRole('M2')">
					<div style="float: right">
					<button class="btn btn-primary" onclick="location.href='${pageContext.request.contextPath}/community/communityColumnForm.do'">글쓰기</button>
					</div>
				</sec:authorize>

			<!-- 페이징 -->
			<div>
				${pagebar}
			</div>

		</div>
	</div>
</div>
</div>


<script src="${pageContext.request.contextPath}/resources/js/community/communityColumnList/scripts.js"></script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
