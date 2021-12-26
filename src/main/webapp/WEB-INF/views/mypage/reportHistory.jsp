<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<jsp:include page="/WEB-INF/views/mypage/common/header.jsp">
	<jsp:param value="신고 내역" name="title"/>
</jsp:include>

<!-- CSS import -->
<link href="${pageContext.request.contextPath}/resources/css/mypage/reportHistory.css" rel="stylesheet">

		<div class="col-12" id="reportHistory">
			<div class="row">
			
				<article class="col-10" id="info">
		      		<h4 id="breadcrumb"><a href="${pageContext.request.contextPath}/mypage/myinfo.do">나의 정보</a> <i class="bi bi-chevron-right"></i> <span>신고 내역</span></h4>
		       		<hr/>
		       		<p id="reportInfo"><i tabindex="0" class="bi bi-info-circle-fill" data-toggle="popover" data-trigger="hover" title="신고사유 및 운영자 조치" data-content="내가 신고한 글의 신고사유와 운영자 조치 시 내역을 확인하실 수 있습니다."></i> 내가 신고한 글의 신고사유와 운영자 조치 시 내역을 확인하실 수 있습니다.</p>
		       		
		       		<%-- report history --%>
		       		<section id="reportList">
		       			<table class="table">
		       				<%-- 
		       				<c:forEach items="${reportList}" var="reportList">
		       					<tr>
			       					<td>${report.}</td>
			       					<td>${report.}${report.}${report.}</td>
			       					<td>
			       						<i tabindex="0" class="bi bi-info-circle-fill" data-toggle="popover" data-trigger="hover" title="신고사유 및 운영자 조치" data-content="${report.reportContent}${report.memberNo2}"></i>
			       						${report.}${report.}
			       					</td>
			       				</tr>
		       				</c:forEach>
		       				--%>
		       				<c:forEach var="i" begin="1" end="10" step="1">
		       					<tr>
			       					<td class="col-2">닉네임</td>
			       					<td class="col-7">
			       						<div>
				       						<span id="reportType">게시글${i}</span>
				       						<span id="reportContent">게시글 제목입니다</span>
			       						</div>
			       						<span id="reportCategory">
				       						<i class="bi bi-slash-circle"></i>
				       						<span>무단광고/홍보</span>
			       						</span>
			       					</td>
			       					<td class="col-3">
			       						<i tabindex="0" class="bi bi-info-circle-fill" data-toggle="popover" data-trigger="hover" data-html="true" data-content="<div><span>신고사유</span> : 무단광고/홍보</div><div><span>일시</span> : 2021.12.25 11:35:30</div>"></i>
			       						<span>진행중 &nbsp; | &nbsp; 12.25</span> 
			       					</td>
			       				</tr>
			       			</c:forEach>
		       			</table>
	       			</section>
	       			<!-- page navigation -->
		       		
	       		</article>

			</div>
		</div>
		
<script>
$('[data-toggle="popover"]').popover({
	trigger: 'hover'
});
</script>
		
<jsp:include page="/WEB-INF/views/mypage/common/footer.jsp"></jsp:include>