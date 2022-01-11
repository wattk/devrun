<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>	
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/admin/admin-common/header.jsp">
	<jsp:param value="" name="title"/>
</jsp:include>
<link href="${pageContext.request.contextPath }/resources/css/admin/adminManage.css" rel="stylesheet"/>

<style>

.faq-search ul li {
	margin: 0 1%;
	background: #f3f3f3;
	border-radius: 0.25rem;
}

.faq-search #faqSearchKeyword {
	width: 300px;
}

</style>
<div class="container">
<div class="faq-container">
	<h3 class="my-5">자주묻는질문 관리</h3>
	
	<div class="faq-search w-50">
	
		<!-- 전체 / 쇼핑몰 / 카테고리 / 기타 선택 -->
		<ul class="nav nav-pills nav-fill my-2">
		  <li class="nav-item">
		    <a class="nav-link ${param.noticeCode eq null || param.noticeCode eq '' ? 'active' : ''}" href="${pageContext.request.contextPath}/admin/customerCenter/faqManage.do?searchKeyword=${param.searchKeyword}">전체</a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link ${param.noticeCode eq 'S' ? 'active' : ''}" href="${pageContext.request.contextPath}/admin/customerCenter/faqManage.do?noticeCode=S&searchKeyword=${param.searchKeyword}">쇼핑몰</a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link ${param.noticeCode eq 'C' ? 'active' : ''}" href="${pageContext.request.contextPath}/admin/customerCenter/faqManage.do?noticeCode=C&searchKeyword=${param.searchKeyword}">커뮤니티</a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link ${param.noticeCode eq 'E' ? 'active' : ''}" href="${pageContext.request.contextPath}/admin/customerCenter/faqManage.do?noticeCode=E&searchKeyword=${param.searchKeyword}">기타</a>
		  </li>
		</ul>
		<!-- 전체 / 쇼핑몰 / 카테고리 / 기타 선택 끝 -->
		<!-- 검색 -->
		<nav class="navbar navbar-light bg-light border my-2 ml-1">
		  <%-- action 속성을 생략하면 해당 페이지를 요청할 때와 같은 방식으로 처리가 된다. --%>
		  <form class="form-inline">
		    <input id="faqSearchKeyword" class="form-control mr-sm-2" type="search" name="searchKeyword" value="${param.searchKeyword}" placeholder="(제목+내용)" aria-label="Search">
		    <button class="btn btn-outline-primary my-2 my-sm-0" type="submit">검색</button>
		  </form>
		</nav>
		<!-- 검색 끝 -->
		
	</div>
	
</div>




<form:form name="faqDeleteFrm" action="${pageContext.request.contextPath}/admin/customerCenter/faqDelete.do" method="post" class="w-100">
	<div class="faq-list col-md-12">
		<span class="my-5">[총 ${totalContent}개]</span>
		<br />
		<strong class="mr-2">선택한 항목을 </strong>
		<button type="button" id="faqListDeleteBtn" class="btn btn-secondary" data-dismiss="modal">삭제</button>
		<table class="admin-tbl table table-hover mx-auto mt-3 text-center checkbox-group">
			<thead>
				<tr>
					<th scope="col" class="text-center">
			      		<input type="checkbox" name="" id="checkAll" class="" />
			      	</th>
			      	<th scope="col">번호</th>
			      	<th scope="col">분류</th>
			      	<th scope="col">제목</th>
			      	<th scope="col">작성일</th>
			      	<th scope="col">글쓴이</th>
				</tr>
			</thead>
			<tbody>
			<c:if test="${not empty faqList}">
				<c:forEach items="${faqList}" var="faq" varStatus="vs">
				    <tr>
				      <td class="text-center">
				      	<input type="checkbox" name="" class="faq-is-checked" data-target="${faq.noticeNo}"/>
				      </td>
				      <td>${totalContent - (((param.cPage eq null ? 1 : param.cPage) - 1) * 10 + vs.index)}</td>
				      <td>${faq.noticeCode eq 'S' ? '쇼핑몰' : faq.noticeCode eq 'C' ? '커뮤니티' : '기타'}</td>
				      <td>
				        <%-- 상세페이지에서 목록 버튼 구현을 위해 noticeCode, searchKeyword, cPage도 넘긴다. --%>
				      	<a href="${pageContext.request.contextPath}/admin/customerCenter/faqDetail.do?faqNo=${faq.noticeNo}&noticeCode=${param.noticeCode}&searchKeyword=${param.searchKeyword}&cPage=${param.cPage}">${faq.title}</a>
				      </td>
				      <td><fmt:formatDate value="${faq.enrollDate}" pattern="yyyy-MM-dd"/></td>
				      <td>${faq.nickname}</td>
				    </tr>
			    </c:forEach>
			</c:if>
			<c:if test="${empty faqList}">
				<tr>
					<td colspan="6" class="text-center">자주묻는질문이 존재하지 않습니다.</td>
				</tr>
			</c:if>
			</tbody>
		</table>
		<div class="text-right">
			<button type="button" class="faq-write-btn btn btn-primary">자주묻는질문 등록</button>
		</div>
		${pagebar}
	</div>
</form:form>
</div>
<script>

// 자주묻는질문 등록 클릭 이벤트
$(".faq-write-btn").click((e)=>{
	location.href = `${pageContext.request.contextPath}/admin/customerCenter/faqEnroll.do`;
});


//체크박스 전체 선택
$(".checkbox-group").on("click", "#checkAll", ((e)=>{
  let checked = $(e.target).is(":checked");

  if(checked){
  	$(e.target).parents(".checkbox-group").find('input:checkbox').prop("checked", true);
  } else {
  	$(e.target).parents(".checkbox-group").find('input:checkbox').prop("checked", false);
  }
}));

//체크박스 개별 선택
$(".faq-is-checked").on("click", ((e)=>{
    let isChecked = true;
    
    $(".faq-is-checked").each((i, item)=>{
        isChecked = isChecked && $(item).is(":checked");
    });
    
    $("#checkAll").prop("checked", isChecked);
}));

$("#faqListDeleteBtn").click((e)=>{
    let isChecked = false;
    
    $(".faq-is-checked").each((i, item)=>{
        isChecked = isChecked || $(item).is(":checked");
        let target = $(item).data("target");
        
        if($(item).is(":checked")){
        	$(item).after(`<input type="hidden" name="noticeNo" value="\${target}"/>`);
        }
    });
    
    if(!isChecked){
    	alert("선택된 자주묻는질문이 없습니다.");
    	return;
    }
	
    console.log("클릭");
    console.log($(document.faqDeleteFrm));
    $(document.faqDeleteFrm).submit();
});

</script>
<jsp:include page="/WEB-INF/views/admin/admin-common/footer.jsp"></jsp:include>
