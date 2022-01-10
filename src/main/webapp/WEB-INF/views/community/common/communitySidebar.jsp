<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<fmt:requestEncoding value="utf-8"/>
  <link href="${pageContext.request.contextPath}/resources/css/community/style.css" rel="stylesheet">
<style>
footer{
	padding-left : 195px;
}
.section-footer{
	padding-left : 210px;
}
</style>
  <!-- 사이드바 -->
  <div id="page-wrapper">
    <div id="sidebar-wrapper">
      <ul class="sidebar-nav">
        <%-- <li class="sidebar-brand">
          <a href="${pageContext.request.contextPath}/community/communityMain.do">Community</a>
        </li> --%>
        <li><a href="${pageContext.request.contextPath}/community/communityColumnList.do">칼럼</a></li>
        
        <!-- 관리자(AM) & 지식인(M2)에게만 권한 부여-->
        <%-- <sec:authorize access="hasAnyRole('M2','AM')">
			<li><a href="${pageContext.request.contextPath}/community/communityColumnForm.do">&nbsp;&nbsp;&nbsp;&nbsp;칼럼 글쓰기</a></li>
		</sec:authorize> --%>
		
        <li><a href="${pageContext.request.contextPath}/community/communityQnAList.do">Q&A</a></li>
        <li><a href="${pageContext.request.contextPath}/community/communityStudyList.do">스터디</a></li>
        <li><a href="${pageContext.request.contextPath}/community/communityFreeboardList.do">자유게시판</a></li>
      </ul>
    </div>
<!-- </div> -->
