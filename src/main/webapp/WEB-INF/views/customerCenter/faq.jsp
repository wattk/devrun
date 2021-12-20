<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>	

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="자주 묻는 질문" name="title"/>
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

.faq .nav li {
	border-radius: 0.25rem;
	background: #eee;
	margin: 0 1%;
}

.faq .nav li:first-child {
	margin-left: 0;
}

.faq .nav li:last-child {
	margin-right: 0;
}

.faq .navbar {
	justify-content: center;
}

.faq .navbar input {
	width: 260px;
}

.faq table tr {
	cursor: pointer;
}

.faq table .hiddenRow {
	padding: 0 4px !important;
    background-color: #eeeeee;
}
</style>

<div class="container customer-center">
	<div class="row">
		<!-- 사이드 바 -->
		<jsp:include page="/WEB-INF/views/customerCenter/sidebar.jsp"></jsp:include>
		
		<!-- 본문 -->
		<div class="col-sm-9 page faq">
		
			<h2>자주 묻는 질문</h2>
			
			<!-- 검색 -->
			<nav class="navbar navbar-light bg-light border">
			  <form class="form-inline">
			    <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
			    <button class="btn btn-outline-primary my-2 my-sm-0" type="submit">검색</button>
			  </form>
			</nav>
			<!-- 검색 끝 -->
			
			
			<!-- 전체 / 쇼핑몰 / 카테고리 / 기타 선택 -->
			<ul class="nav nav-pills nav-fill my-4">
			  <li class="nav-item">
			    <a class="nav-link active" href="#">전체</a>
			  </li>
			  <li class="nav-item">
			    <a class="nav-link" href="#">쇼핑몰</a>
			  </li>
			  <li class="nav-item">
			    <a class="nav-link" href="#">커뮤니티</a>
			  </li>
			  <li class="nav-item">
			    <a class="nav-link" href="#">기타</a>
			  </li>
			</ul>
			<!-- 전체 / 쇼핑몰 / 카테고리 / 기타 선택 끝 -->
			
			<p class="text-right mt-3 mb-1">총 <span class="text-primary">00</span> 건의 자주 묻는 질문이 있습니다.</p>
			
			<!-- 선택에 따른 값 불러오기 - 아코디언 형식 -->
			<table class="table table-condensed" style="border-collapse:collapse;">
			    <thead>
			        <tr>
			            <th>번호</th>
			            <th>분류</th>
			            <th>제목</th>
			        </tr>
			    </thead>
			    <tbody>
			        <tr data-toggle="collapse" data-target="#demo1" class="accordion-toggle">
			            <td>1</td>
			            <td>쇼핑몰</td>
			            <td>제목제목제목제목제목제목제목제목</td>
			        </tr>
			        <tr >
			            <td colspan="3" class="hiddenRow">
			            	<div class="accordian-body collapse" id="demo1">
			            		내용입니다. 내용입니다. 내용입니다. 내용입니다. 내용입니다. 내용입니다. 내용입니다. 내용입니다. 내용입니다. 내용입니다. 내용입니다. 내용입니다.
			            	</div>
			            </td>
			        </tr>
					
			        <tr data-toggle="collapse" data-target="#demo2" class="accordion-toggle">
			            <td>2</td>
			            <td>커뮤니티</td>
			            <td>제목</td>
			        </tr>
			        <tr>
			            <td colspan="3" class="hiddenRow">
			            	<div id="demo2" class="accordian-body collapse">
			            		내용입니다. 내용입니다. 내용입니다. 내용입니다. 내용입니다. 내용입니다. 내용입니다. 내용입니다. 내용입니다. 내용입니다. 내용입니다. 내용입니다.
			            	</div>
			            </td>
			        </tr>
					
			        <tr data-toggle="collapse" data-target="#demo3" class="accordion-toggle">
			            <td>3</td>
			            <td>기타</td>
			            <td>제목</td>
			        </tr>
			        <tr>
			            <td colspan="3"  class="hiddenRow">
			            	<div id="demo3" class="accordian-body collapse">
			            		내용입니다. 내용입니다. 내용입니다. 내용입니다. 내용입니다. 내용입니다. 내용입니다. 내용입니다. 내용입니다. 내용입니다. 내용입니다. 내용입니다.
			            	</div>
			            </td>
			        </tr>
			
			        <tr data-toggle="collapse" data-target="#demo4" class="accordion-toggle">
			            <td>4</td>
			            <td>쇼핑몰</td>
			            <td>제목</td>
			        </tr>
			        <tr>
			            <td colspan="3"  class="hiddenRow">
			            	<div id="demo4" class="accordian-body collapse">
			            		내용입니다. 내용입니다. 내용입니다. 내용입니다. 내용입니다. 내용입니다. 내용입니다. 내용입니다. 내용입니다. 내용입니다. 내용입니다. 내용입니다.
			            	</div>
			            </td>
			        </tr>
			
			        <tr data-toggle="collapse" data-target="#demo5" class="accordion-toggle">
			            <td>5</td>
			            <td>커뮤니티</td>
			            <td>제목</td>
			        </tr>
			        <tr>
			            <td colspan="3"  class="hiddenRow">
			            	<div id="demo5" class="accordian-body collapse">
			            		내용입니다. 내용입니다. 내용입니다. 내용입니다. 내용입니다. 내용입니다. 내용입니다. 내용입니다. 내용입니다. 내용입니다. 내용입니다. 내용입니다.
			            	</div>
			            </td>
			        </tr>
			        
			        <tr data-toggle="collapse" data-target="#demo6" class="accordion-toggle">
			            <td>6</td>
			            <td>쇼핑몰</td>
			            <td>제목제목제목제목제목제목제목제목</td>
			        </tr>
			        <tr >
			            <td colspan="3" class="hiddenRow">
			            	<div class="accordian-body collapse" id="demo6">
			            		내용입니다. 내용입니다. 내용입니다. 내용입니다. 내용입니다. 내용입니다. 내용입니다. 내용입니다. 내용입니다. 내용입니다. 내용입니다. 내용입니다.
			            	</div>
			            </td>
			        </tr>
					
			        <tr data-toggle="collapse" data-target="#demo7" class="accordion-toggle">
			            <td>7</td>
			            <td>커뮤니티</td>
			            <td>제목</td>
			        </tr>
			        <tr>
			            <td colspan="3" class="hiddenRow">
			            	<div id="demo7" class="accordian-body collapse">
			            		내용입니다. 내용입니다. 내용입니다. 내용입니다. 내용입니다. 내용입니다. 내용입니다. 내용입니다. 내용입니다. 내용입니다. 내용입니다. 내용입니다.
			            	</div>
			            </td>
			        </tr>
					
			        <tr data-toggle="collapse" data-target="#demo8" class="accordion-toggle">
			            <td>8</td>
			            <td>기타</td>
			            <td>제목</td>
			        </tr>
			        <tr>
			            <td colspan="3"  class="hiddenRow">
			            	<div id="demo8" class="accordian-body collapse">
			            		내용입니다. 내용입니다. 내용입니다. 내용입니다. 내용입니다. 내용입니다. 내용입니다. 내용입니다. 내용입니다. 내용입니다. 내용입니다. 내용입니다.
			            	</div>
			            </td>
			        </tr>
			
			        <tr data-toggle="collapse" data-target="#demo9" class="accordion-toggle">
			            <td>9</td>
			            <td>쇼핑몰</td>
			            <td>제목</td>
			        </tr>
			        <tr>
			            <td colspan="3"  class="hiddenRow">
			            	<div id="demo9" class="accordian-body collapse">
			            		내용입니다. 내용입니다. 내용입니다. 내용입니다. 내용입니다. 내용입니다. 내용입니다. 내용입니다. 내용입니다. 내용입니다. 내용입니다. 내용입니다.
			            	</div>
			            </td>
			        </tr>
			
			        <tr data-toggle="collapse" data-target="#demo10" class="accordion-toggle">
			            <td>10</td>
			            <td>커뮤니티</td>
			            <td>제목</td>
			        </tr>
			        <tr>
			            <td colspan="3"  class="hiddenRow">
			            	<div id="demo10" class="accordian-body collapse">
			            		내용입니다. 내용입니다. 내용입니다. 내용입니다. 내용입니다. 내용입니다. 내용입니다. 내용입니다. 내용입니다. 내용입니다. 내용입니다. 내용입니다.
			            	</div>
			            </td>
			        </tr>	
			    </tbody>
			</table>
			<!-- 선택에 따른 값 불러오기 - 아코디언 형식 끝 -->
			
			<%-- 시간 된다면 페이징 까지 해보기 (필수는 아님) --%>
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

<script>
// 작동안함.
/* $('.accordian-body').on('show.bs.collapse', function () {
    $(this).closest("table")
        .find(".collapse.in")
        .not(this)
        .collapse('toggle')
}) */
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>