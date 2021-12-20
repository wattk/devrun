<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
/* 사이드바 */
.sidenav h2 {
	border-bottom: 4px solid #1f1f1f;
	margin: 0;
	padding: 30px 0 25px;
	color: #fff;
	background-color: #1467CC;
	font-size: 1.8rem;
    text-align: center;
}

.sidenav .list-group-item {
	padding: 0.2rem;	
}

.sidenav .nav {
	border: 1px solid #e5e5e5;
}

.sidenav ul > li:first-child {
	border-top: none;
}
</style>

<!-- 사이드바 시작 -->
	<nav class="col-sm-3 sidenav">
		<h2>고객센터</h2>
		<ul class="nav flex-column list-group list-group-flush">
			<li class="nav-item list-group-item">
				<a class="nav-link active" href="${pageContext.request.contextPath}/customerCenter/noticeList.do">공지사항</a>
			</li>
			<li class="nav-item list-group-item">
				<a class="nav-link" href="${pageContext.request.contextPath}/customerCenter/faq.do">자주 묻는 질문</a>
			</li>
		</ul>
	</nav>
<!-- 사이드바 끝 -->


