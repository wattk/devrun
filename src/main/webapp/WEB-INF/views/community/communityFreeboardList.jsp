<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="" name="title"/>
</jsp:include>
<jsp:include page="/WEB-INF/views/community/common/communitySidebar.jsp">
	<jsp:param value="" name="title"/>
</jsp:include>
<link href="${pageContext.request.contextPath}/resources/css/community/style.css" rel="stylesheet">
<!-- 폰트어썸 CDN -->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.14.0/css/all.css" integrity="sha384-HzLeBuhoNPvSl5KYnjx0BT+WB0QEEqLprO+NBkkk5gbc67FTaL7XIGa2w1L0Xbgc" crossorigin="anonymous">
<!-- include summernote css/js -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.20/summernote-lite.min.css" integrity="sha512-ZbehZMIlGA8CTIOtdE+M81uj3mrcgyrh6ZFeG33A4FHECakGrOsTPlPQ8ijjLkxgImrdmSVUHn1j+ApjodYZow==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.20/summernote-lite.min.js" integrity="sha512-lVkQNgKabKsM1DA/qbhJRFQU8TuwkLF2vSN3iU/c7+iayKs08Y8GXqfFxxTZr1IcpMovXnf2N/ZZoMgmZep1YQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="${pageContext.request.contextPath }/resources/js/summernote/lang/summernote-ko-KR.js"></script>

<style>
.input-group {
	justify-content: center;
}
td, th {
	text-align: center;	
}

/* 타입별 검색 - 제목 */
div#search-title {
	display: inline-block;
}

/* 타입별 검색 - 내용 */
div#search-content {
	display: none;
}

/* 타입별 검색 - 작성자(별명) */
div#search-nickname {
	display: none;
}

.modal-dialog.modal-80size {
  width: 100%;
  height: 100%;
  margin: 0;
  padding: 0;
}

    
</style>

<script>

// summernote 웹 에디터 로딩
$(document).ready(function(){
	$('#summernote').summernote({
		height: 300, // 에디터 높이
		minHeight: null, // 최소 높이
		maxHeight: null, // 최대 높이
		focus: true, // 에디터 로딩 후 포커스를 맞출 지 여부
		lang: "ko-KR", // 한글 설정
		placeholder: "내용을 입력해 주세요"  // placeholder 설정
	});
});

// 글쓰기 폼으로 이동
function goWriteForm(){
	location.href = "${pageContext.request.contextPath}/community/communityWriteForm.do";
}

// 게시글 상세보기로 이동
/**
 * event boubling 기반 핸들링
 * tr 에서 핸들링 > td에서 발생 및 전파
 */
$(() => {
	$("tr[data-no]").click((e) => {
		console.log(e.target);
		console.log($(e.target).data("no"));
		// tr 태그를 찾는 작업 --> 이벤트 타겟의 부모중의 tr태그를 찾아주세요.
		const $tr = $(e.target).parents("tr");
		const communityNo = $tr.data("no");
		
		location.href = `${pageContext.request.contextPath}/community/communityFreeboardDetail/\${communityNo}`; // \$ "EL이 아니라 JavaScript $다."를 표시
		

	});
});
 



</script>


<!-- 본문 시작 -->
<div class="container-fluid">
	<div class="row">
		<div class="col-md-12">
			<!-- 헤더 시작 -->
			<div class="row">
				<div class="col-md-12">
					<div class="page-header">
						<h1>
							<strong>자유게시판</strong>
						</h1>
					</div>
				</div>
			</div>
			<!-- 헤더 끝 -->
			
			<hr />
					
			<!-- 검색창 시작-->
			<div class="row py-3 border-bottom m-0 search justify-content-center" id="search-container">
				<select id="searchType" class="custom-select" style="width:100px; float:right;">
				  	<option value="title">제목</option>
				  	<option value="content">내용</option>
				  	<option value="nickname">작성자</option>
				</select>
				<div id="search-title" class="search-type">
		            <form class="form-inline search-form"> 
		            	<input type="hidden" name="searchType" value="title" />
						<input class="form-control" type="search" name="searchKeyword" placeholder="Search" aria-label="Search" name="searchKeyword">
						<button class="btn btn-outline-primary my-2 my-sm-0 search-btn" type="submit">검색</button>
				  	</form>
		        </div>
		        <div id="search-content" class="search-type">
		            <form
		            	class="form-inline search-form" 
		            	action="${pageContext.request.contextPath}/community/communityFreeboardFinder">
		            	<input type="hidden" name="searchType" value="content" />
						<input class="form-control" type="search" name="searchKeyword" placeholder="Search" aria-label="Search" name="searchKeyword">
						<button class="btn btn-outline-primary my-2 my-sm-0 search-btn" type="submit">검색</button>
				  	</form>
		        </div>
		        <div id="search-nickname" class="search-type">
		            <form 
		            	class="form-inline search-form" 
		            	action="${pageContext.request.contextPath}/community/communityFreeboardFinder">
		            	<input type="hidden" name="searchType" value="nickname" />
						<input class="form-control" type="search" name="searchKeyword" placeholder="Search" aria-label="Search" name="searchKeyword">
						<button class="btn btn-outline-primary my-2 my-sm-0 search-btn" type="submit">검색</button>
				  	</form>
		        </div>	
			</div>
			<!-- 검색창 끝 -->
			
			<!-- 상단 탭 시작 -->	
			<nav>
			  <p>총<span id="freeboardSize">${totalContent}</span>개의 게시물이 있습니다.</p>
			  <div class="nav nav-tabs" id="nav-tab" role="tablist">
			    <a class="nav-item nav-link active" id="nav-home-tab" data-toggle="tab" href="#nav-home" role="tab" aria-controls="nav-home" aria-selected="true">최신순</a>
			    <a class="nav-item nav-link" id="nav-profile-tab" data-toggle="tab" href="#nav-profile" role="tab" aria-controls="nav-profile" aria-selected="false">댓글 많은 순</a>
			    <a class="nav-item nav-link" id="nav-contact-tab" data-toggle="tab" href="#nav-contact" role="tab" aria-controls="nav-contact" aria-selected="false">좋아요 순</a>
			  </div>
			</nav>
			<div class="tab-content" id="nav-tabContent">
			  <div class="tab-pane fade show active" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab">...</div>
			  <div class="tab-pane fade" id="nav-profile" role="tabpanel" aria-labelledby="nav-profile-tab">...</div>
			  <div class="tab-pane fade" id="nav-contact" role="tabpanel" aria-labelledby="nav-contact-tab">...</div>
			</div>
			<!-- 상단 탭 끝 -->
			
		</div>
	</div>
	
	
	<!-- 리스트 시작 -->
	<div id="freeboardContainer">
	<table id="tbl-board" class="table table-striped table-hover">
		<tr>
			<th class="col-1">번호</th>
			<th class="col-3">제목</th>
			<th class="col-1">작성자</th>
			<th class="col-1">작성일</th>
			<th class="col-1">좋아요</th> 
			<th class="col-1">조회수</th>
			<th class="col-1">답변개수</th>
		</tr>
		
		<!-- 반복접근할 요소 : items="${list} -->
		<!-- 꺼내면 cmmunityEntity니까 communityEntity라는 이름으로 사용 -->
		<tbody id = "tbody">
			<c:forEach items="${list}" var="communityEntity">
				<tr data-no="${communityEntity.communityNo}">
					<td>${communityEntity.communityNo}</td>
					<td>${communityEntity.title}</td>
					<td>${communityEntity.nickname}</td>
					<td><fmt:formatDate value="${communityEntity.enrollDate}" pattern="yy-MM-dd HH:mm"/></td>
					<td><i class="fas fa-heart"></i> ${communityEntity.likeCount}</td>
					<td>${communityEntity.viewCount}</td>
					<td>만들어야함</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>  
	<!-- 리스트 끝 -->
	
	<!-- 글쓰기 버튼 -->
	<div style="float: right">
	<button class="btn btn-primary" data-toggle="modal" data-target="#bs-example-modal-lg">글쓰기</button>
	</div>
	</div>
	
	<!-- 게시판 글쓰기 모달 시작 -->
	<div class="modal fade" id="bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-lg">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h6 class="modal-title" id="myLargeModalLabel"><strong>커뮤니티</strong></h6>
	      </div>
	      <br />
	      <div class="row justify-content-center">
		      <div>
		      	<button type="button" class="btn btn-primary">Q&A</button>
		      </div>
		      &nbsp;
		      <div>
		      	<button type="button" class="btn btn-primary">스터디</button>
		      </div>
		      &nbsp;
		      <div>
		      	<button type="button" class="btn btn-primary">자유게시판</button>
		      </div>
	      </div>
	      <div class="modal-body">
	      <p><strong>제목</strong></p>
	      <hr />
			<div class="input-group flex-nowrap">
			  <input type="text" class="form-control" placeholder="제목을 입력해주세요." aria-label="Username" aria-describedby="addon-wrapping">
			</div>
		  <br />	
		  <p><strong>태그</strong></p>
		  <hr />
		  	<div class="input-group flex-nowrap">
			  <span class="input-group-text" id="addon-wrapping">#</span>
			  <input type="text" class="form-control" placeholder="태그를 설정해주세요." aria-label="Username" aria-describedby="addon-wrapping">
			</div>
		  <br />	
		  <p><strong>내용</strong></p>
		  <hr />	
			<div class="input-group flex-nowrap">
				<textarea class="form-control" rows="5" name="content" id="summernote"></textarea>
			</div>
	      </div>
	      <div class="modal-footer justify-content-center">
			<button type="submit" class="btn btn-primary col-4">저장</button>
			<button type="button" class="btn btn-secondary col-4"data-dismiss="modal" id="deleteReporBtn">취소</button>
		  </div>
	    </div>
	  </div>
	</div>
	
	<!-- 페이징 시작 -->
	<div>
		${pagebar}
	</div>
	<!-- 페이징 끝 -->
</div>
</div>

<script>
//타입별 검색
/**
 * searchType별 change 이벤트 핸들러를 이용해서 해당 div만 보여주고 나머지는 감춘다.
 */
$("#searchType").change(function(e){
	// e.target 이벤트 발생객체 -> #searchtype
	const type = $(e.target).val();
	console.log(type);
	
	// 1. .search-type 감추기 --> 해당 div 세개가 모두 감춰진다.
	$(".search-type").hide();
	
	// 2. #search-${type} 보여주기(display:inline-block)
	//console.log(`#search-\${type}`);
	//console.log($(`#search-\${type}`));
	// .show는 해당 태그의 원래 디스플레이 속성으로 보여주게되므로 .css로 임의로 지정한다.
	$(`#search-\${type}`).css("display", "inline-block");
});

$(".search-btn").click((e) => {
	//console.log(".search-btn 되나요");
	//console.log($(e.target));
	//e.target = .searh-btn
	e.preventDefault();
	
	var $searchType = $(e.target).parent().children("input[name=searchType]").val();
	var $searchKeyword = $(e.target).parent().children("input[name=searchKeyword]").val();
	
	//console.log($searchType);
	//console.log($searchKeyword);
	
	const search = {
		"searchType" : $searchType,
		"searchKeyword" : $searchKeyword
	};
	
	console.log(search);
	
	$.ajax({
		url : "${pageContext.request.contextPath}/community/communityFreeboardFinder.do",
		data : search,
		method : "GET",
		success(res){
			console.log(res);
			//.html() : 선택한 요소 안의 내용을 가져오거나, 다른 내용으로 바꾼다.
		 	$("#tbody").html(res["freeboardStr"]);
			$("#freeboardSize").text(res["totalContent"]);
			$(".pagebar").detach();
			$("#freeboardContainer").after(res["pagebar"]);
		},
		error: console.log
	});
});


</script>

<script src="${pageContext.request.contextPath}/resources/js/community/communityQnAList/scripts.js"></script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
