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
		       		<p id="reportInfo"><i tabindex="0" class="bi bi-info-circle-fill" data-toggle="popover" data-trigger="hover" title="신고사유 및 운영자 조치" data-content="내가 신고한 내역의 신고사유와 신고일시를 확인하실 수 있습니다."></i> 내가 신고한 내역의 신고사유와 신고일시를 확인하실 수 있습니다.</p>
		       		
		       		<%-- report history --%>
		       		<section id="reportList">
		       			<table class="table">
		       				<c:if test="${reportList ne null}">
		       					<c:forEach items="${reportList}" var="report">
			     					<tr>
			     						<td class="col-9">
			     							<div>
					       						<span id="reportType">
													<c:if test="${report.reportRootCate eq 'CB'}">게시글</c:if>
													<c:if test="${report.reportRootCate eq 'CR'}">댓글</c:if>
													<c:if test="${report.reportRootCate eq 'MB'}">회원</c:if>
													<c:if test="${report.reportRootCate eq 'MM'}">쪽지</c:if>
													<c:if test="${report.reportRootCate eq 'PR'}">상품 리뷰</c:if>
												</span>
					       						<span id="reportContent">&nbsp;${report.reportContent}</span>
				       						</div>
				       						<span id="reportCategory" class="col-3">
					       						<i class="bi bi-slash-circle"></i>
					       						<span>${report.reasonName}</span>
				       						</span>
			     						</td>
			     						<td class="col-3">
				       						<i tabindex="0" class="bi bi-info-circle-fill" data-toggle="popover" data-trigger="hover" data-html="true" data-content="
				       							<div><span>신고사유</span> : ${report.reasonName}</div>
				       							<div><span>신고일시</span> : <fmt:formatDate value="${report.regDate}" pattern="yyyy.MM.dd HH:mm:ss"/></div>">
				       						</i>
				       						<span id="reportStatus">
				       							<c:if test="${report.status eq 'PR'}">진행중</c:if>
				       							<c:if test="${report.status eq 'DR'}">신고 불승인</c:if>
				       							<c:if test="${report.status eq 'CF'}">신고 승인</c:if>
				       							<span>|</span>
				       							<c:if test="${report.confirmDate eq null}">-</c:if>
				       							<c:if test="${report.confirmDate ne null}"><fmt:formatDate value="${report.confirmDate}" pattern="yy.MM.dd"/></c:if>	
				       						</span> 
				       					</td>
			     					</tr>
			     				</c:forEach>
	       					</c:if>
	       					<c:if test="${reportList eq null}">
	       						<tr id="noList"><td>신고 내역이 없습니다.</td></tr>
	       					</c:if>
		       			</table>
	       			</section>
	       			<!-- page navigation -->
	       			${pagebar}
	       		</article>

			</div>
		</div>
		
<script>
$('[data-toggle="popover"]').popover({
	trigger: 'hover'
});
</script>
		
<jsp:include page="/WEB-INF/views/mypage/common/footer.jsp"></jsp:include>