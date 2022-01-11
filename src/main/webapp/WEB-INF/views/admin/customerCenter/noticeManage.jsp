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
<link href="${pageContext.request.contextPath}/resources/css/admin/adminManage.css" rel="stylesheet"/>

<div class="container">
<div class="notice-container">
	<h3 class="my-5">공지사항 관리</h3>
	
	<!-- 검색 -->
	<div class="notice-search row py-3 search col-md-9">
	
		<div class="col-sm-2 p-0">
			<!-- 검색타입 -->
			<select id="searchType" class="custom-select">
			  	<option value="title" ${param.searchType eq 'title' ? 'selected' : ''}>제목</option>
			  	<option value="content" ${param.searchType eq 'content' ? 'selected' : ''}>내용</option>
			</select>	
		</div>

		<div class="col-sm-10">
			<!-- 검색창 -->
			<div class="form-inline search-form">
				<input id="noticeSearchKeyword" class="form-control mr-2" type="search" name="searchKeyword" value="${param.searchKeyword}" placeholder="검색어를 입력해 주세요" aria-label="Search">
				<button class="btn btn-outline-primary my-2 my-sm-0 search-btn" type="button">검색</button>
		  	</div>
		</div>
	
	</div>
	<!-- 검색 끝 -->
	
</div>
<form:form name="noticeDeleteFrm" action="${pageContext.request.contextPath}/admin/customerCenter/noticeDelete.do" method="post" class="w-100">
	<div class="notice-list">
		<span class="my-5">[총 ${totalContent}개]</span>
		<br />
		<strong class="mr-2">선택한 항목을 </strong>
		<button type="button" id="noticeListDeleteBtn" class="btn btn-secondary" data-dismiss="modal">삭제</button>
		<table class="admin-tbl table table-hover mx-auto mt-3 text-center checkbox-group">
			<thead>
				<tr>
					<th scope="col" class="text-center">
			      		<input type="checkbox" name="" id="checkAll"  />
			      	</th>
			      	<th scope="col">번호</th>
			      	<th scope="col">제목</th>
			      	<th scope="col">작성일</th>
			      	<th scope="col">글쓴이</th>
			      	<th scope="col">조회수</th>
				</tr>
			</thead>
			<tbody>
			<c:if test="${not empty noticeList}">
				<c:forEach items="${noticeList}" var="notice" varStatus="vs">
				    <tr>
				      <td class="text-center">
				      	<input type="checkbox" name="" class="notice-is-checked" data-target="${notice.noticeNo}"/>
				      </td>
				      <td>${totalContent - (((param.cPage eq null ? 1 : param.cPage) - 1) * 10 + vs.index)}</td>
				      <td>
				      	<a href="${pageContext.request.contextPath}/admin/customerCenter/noticeDetail.do?noticeNo=${notice.noticeNo}&searchType=${param.searchType}&searchKeyword=${param.searchKeyword}&cPage=${param.cPage}">${notice.title}</a>
				      </td>
				      <td><fmt:formatDate value="${notice.enrollDate}" pattern="yyyy-MM-dd"/></td>
				      <td>${notice.nickname}</td>
				      <td>${notice.viewCount}</td>
				    </tr>
			    </c:forEach>
			</c:if>
			<c:if test="${empty noticeList}">
				<tr>
					<td colspan="6" class="text-center">공지사항이 존재하지 않습니다.</td>
				</tr>
			</c:if>
			</tbody>
		</table>
		<div class="text-right">
			<button type="button" class="notice-write-btn btn btn-primary">공지사항 등록</button>
		</div>
		${pagebar}
	</div>
</form:form>
</div>
<script>
//검색 버튼 클릭 이벤트
$('.search-btn').click((e) => {
	// 검색타입
	const searchType =  $('#searchType').val();
	// 검색어
	const searchKeyword = $(noticeSearchKeyword).val(); 
	//console.log("searchType? " + searchType);
	//console.log("searchKeyword? " + searchKeyword);
	
	location.href = `${pageContext.request.contextPath}/admin/customerCenter/noticeManage.do?searchType=\${searchType}&searchKeyword=\${searchKeyword}`;
});

// 검색어 입력 시 엔터 치면 click 핸들러 호출
$(noticeSearchKeyword).keyup((e) => {
	// 엔터치면 전송하게 해주세요.
	if(e.keyCode == 13){
		$('.search-btn').trigger('click'); // click 핸들러 호출!
	}
});

// 공지사항 등록 클릭 이벤트
$(".notice-write-btn").click((e)=>{
	location.href = `${pageContext.request.contextPath}/admin/customerCenter/noticeEnroll.do`;
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
$(".notice-is-checked").on("click", ((e)=>{
    let isChecked = true;
    
    $(".notice-is-checked").each((i, item)=>{
        isChecked = isChecked && $(item).is(":checked");
    });
    
    $("#checkAll").prop("checked", isChecked);
}));

$("#noticeListDeleteBtn").click((e)=>{
    let isChecked = false;
    
    $(".notice-is-checked").each((i, item)=>{
        isChecked = isChecked || $(item).is(":checked");
        let target = $(item).data("target");
        
        if($(item).is(":checked")){
        	$(item).after(`<input type="hidden" name="noticeNo" value="\${target}"/>`);
        }
    });
    
    if(!isChecked){
    	alert("선택된 공지사항이 없습니다.");
    	return;
    }
	
    console.log("클릭");
    console.log($(document.noticeDeleteFrm));
    $(document.noticeDeleteFrm).submit();
});

</script>
<jsp:include page="/WEB-INF/views/admin/admin-common/footer.jsp"></jsp:include>
