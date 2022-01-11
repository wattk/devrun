<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<fmt:requestEncoding value="utf-8"/>
<!-- header include -->
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<!-- sidebar include -->
<jsp:include page="/WEB-INF/views/community/common/communitySidebar.jsp"></jsp:include>
<!-- css -->
<link href="${pageContext.request.contextPath}/resources/css/community/style.css" rel="stylesheet">
<!-- 폰트어썸 CDN -->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.14.0/css/all.css" integrity="sha384-HzLeBuhoNPvSl5KYnjx0BT+WB0QEEqLprO+NBkkk5gbc67FTaL7XIGa2w1L0Xbgc" crossorigin="anonymous">
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
</style>


<!-- 본문 시작 -->
<div class="container-fluid container">
	<div class="row">
		<div class="col-md-12">
			<!-- 헤더 시작 -->
			<div class="row">
				<div class="col-md-12">
					<div class="page-header">
						<h1 class="pt-5">
							<strong>Q&A</strong>
						</h1>
					</div>
				</div>
			</div>
			<!-- 헤더 끝 -->
			
			<hr />
					
			<!-- 검색창 시작-->
			<div class="row py-3 border-bottom m-0 search justify-content-center" id="search-container">
				<select id="searchType" class="custom-select" style="width: 100px; float: right; cursor: pointer;">
				  	<option value="title">제목</option>
				  	<option value="content">내용</option>
				  	<option value="nickname">작성자</option>
				</select>
				<!-- 제목검색 시작 -->
				<div id="search-title" class="search-type">
		            <form class="form-inline search-form"> 
		            	<input type="hidden" name="searchType" value="title" />
						<input class="form-control" type="search" name="searchKeyword" placeholder="Search" aria-label="Search">
						<input type="hidden" name="pageCode" value="2" />
						<button class="btn btn-outline-primary my-2 my-sm-0 search-btn" type="submit" >검색</button>
				  	</form>
		        </div>
		        <!-- 제목검색 종료 -->
		        <!-- 내용검색 시작 -->
		        <div id="search-content" class="search-type">
		            <form class="form-inline search-form"> 
		            	<input type="hidden" name="searchType" value="content" />
						<input class="form-control" type="search" name="searchKeyword" placeholder="Search" aria-label="Search">
						<input type="hidden" name="pageCode" value="2" />
						<button class="btn btn-outline-primary my-2 my-sm-0 search-btn" type="submit" >검색</button>
				  	</form>
		        </div>
		        <!-- 내용검색 종료 -->
		        <!-- 작성자검색 시작 -->
		        <div id="search-nickname" class="search-type">
		            <form class="form-inline search-form"> 
		            	<input type="hidden" name="searchType" value="nickname" />
						<input class="form-control" type="search" name="searchKeyword" placeholder="Search" aria-label="Search">
						<input type="hidden" name="pageCode" value="2" />
						<button class="btn btn-outline-primary my-2 my-sm-0 search-btn" type="submit" >검색</button>
				  	</form>
		        </div>
		        <!-- 작성자검색 종료 -->	
			</div>
			<!-- 검색창 끝 -->
			
			<br />
			
			<!-- 상단 탭 시작 -->	
			<nav>
			  <div class="nav nav-tabs" id="nav-tab" role="tablist">
			    <a class="nav-item nav-link active" id="nav-home-tab" data-toggle="tab" href="#nac-home" role="tab" aria-controls="nav-home" aria-selected="true">최신순</a>
			    <a class="nav-item nav-link" id="nav-comment-tab" data-toggle="tab" href="#nav-profile" role="tab" aria-controls="nav-profile" aria-selected="false" data-value="2">답변많은순</a>
			    <a class="nav-item nav-link" id="nav-like-tab" data-toggle="tab" href="#nav-like" role="tab" aria-controls="nav-contact" aria-selected="false" data-value="2">좋아요순</a>
			    <a class="nav-item nav-link" id="nav-currentComment-tab" data-toggle="tab" href="#nav-like" role="tab" aria-controls="nav-contact" aria-selected="false" data-value="2">최근답변순</a>
			  </div>
			</nav>
			
			<br />
			<!-- 상단 탭 끝 -->
			
		</div>
	</div>
	
	<div id="totalCountContainer">
	 <p>총 게시물 수 : ${totalContent}</p>			  
	</div>
	
	<br />
			
	<!-- 리스트 시작 -->
	<div id="freeboardContainer">
	<table id="tbl-board" class="table table-hover">
		<tr style="background-color: #1A81FF; color: white;">
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
				<tr data-no="${communityEntity.communityNo}" style="cursor: pointer;" class="whynot">
					<td>${communityEntity.communityNo}</td>
					<!-- 답변중 or 답변완료 'Y':답변완료 / 'N':답변중 -->
					<c:if test="${communityEntity.answerYn eq 'Y'}">
						<td id="answerCheck" data-answer-yn="${communityEntity.answerYn}"><span class="badge bg-success" style="color: white;" id="closeJoinYn">답변완료</span>&nbsp;${communityEntity.title}</td>					
					</c:if>
					<c:if test="${communityEntity.answerYn eq 'N'}">
						<td id="answerCheck" data-answer-yn="${communityEntity.answerYn}"><span class="badge bg-success" style="color: white;" id="closeJoinYn">답변중</span>&nbsp;${communityEntity.title}</td>					
					</c:if>
					<td>${communityEntity.nickname}</td>
					<td><fmt:formatDate value="${communityEntity.enrollDate}" pattern="yy-MM-dd"/></td>
					<td><i class="fas fa-heart"></i> ${communityEntity.likeCount}</td>
					<td>${communityEntity.viewCount}</td>
					<td>${communityEntity.commentCount}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>  
	<!-- 리스트 끝 -->
	
	<jsp:include page="/WEB-INF/views/community/common/writeModal.jsp">
		<jsp:param value="" name="title"/>
	</jsp:include>
	
	<!-- 페이징 시작 -->
	<div class="pagebar">
		${pagebar}
	</div>
	<!-- 페이징 끝 -->
</div>
</div>
<script>
/* ---------------------------------------------- 게시글 상세보기 기능 시작 ---------------------------------------------- */
/**
 * event boubling 기반 핸들링
 * tr 에서 핸들링 > td에서 발생 및 전파
 */
$("tr[data-no]").click((e) => {
	console.log(e.target);
	console.log("해당 no = " + $(e.target).data("no"));
	// tr 태그를 찾는 작업 --> 이벤트 타겟의 부모중의 tr태그를 찾아주세요.
	const $tr = $(e.target).parents("tr");
	console.log("해당 tr = " + $tr);
	const communityNo = $tr.data("no");
	console.log("해당 communityNo = " + communityNo);
	
	location.href = `${pageContext.request.contextPath}/community/communityDetail/\${communityNo}`; // \$ "EL이 아니라 JavaScript $다."를 표시
});

/* ---------------------------------------------- 게시글 상세보기 기능 종료 ---------------------------------------------- */
 
/* ---------------------------------------------- 검색된 게시글 상세보기 기능 시작 ---------------------------------------------- */

$(document).on("click", ".whynot", function(e){ 
	console.log(e.target);
	console.log("해당 no = " + $(e.target).data("no"));
	// tr 태그를 찾는 작업 --> 이벤트 타겟의 부모중의 tr태그를 찾아주세요.
	const $tr = $(e.target).parents("tr");
	console.log("해당 tr = " + $tr);
	const communityNo = $tr.data("no");
	console.log("해당 communityNo = " + communityNo);

	location.href = `${pageContext.request.contextPath}/community/communityDetail/\${communityNo}`; // \$ "EL이 아니라 JavaScript $다."를 표시
});


/* ---------------------------------------------- 검색된 게시글 상세보기 기능 종료 ---------------------------------------------- */

/* ---------------------------------------------- 타입별 검색 기능 시작 ---------------------------------------------- */
/**
 * searchType별 change 이벤트 핸들러를 이용해서 해당 div만 보여주고 나머지는 감춘다.
 */
$("#searchType").change(function(e){
	// e.target 이벤트 발생객체 -> #searchtype
	const type = $(e.target).val();
	console.log(type);
	
	// 검색타입 바뀔 때 마다 값 초기화
	$searchType = "";
	$searchKeyword = "";
	
	// 1. .search-type 감추기 --> 해당 div 세개가 모두 감춰진다.
	$(".search-type").hide();
	
	// 2. #search-${type} 보여주기(display:inline-block)
	//console.log(`#search-\${type}`);
	//console.log($(`#search-\${type}`));
	// .show는 해당 태그의 원래 디스플레이 속성으로 보여주게되므로 .css로 임의로 지정한다.
	$(`#search-\${type}`).css("display", "inline-block");
});

 
/* serach 입력값 대입 */
$("input[name=searchKeyword]").change(e => {
	//console.log("searchType = " + $(e.target).parent().children("input[name=searchType]").val());
	//console.log("searchKeyword = " + $(e.target).val());
	
	$searchType = $(e.target).parent().children("input[name=searchType]").val();
	$pageCode = $(e.target).parent().children("input[name=pageCode]").val();
	$searchKeyword = $(e.target).val();
});

/* 전역 변수*/
var $searchType = "";
var $searchKeyword = "";


/* 검색 결과 페이징 */
function getPage(cPage){
	const $btn = (".search-btn");
		
	searchType = $searchType;
	pageCode = $pageCode;
	searchKeyword = $searchKeyword;
	var cPage;
	
	console.log("searchType = " + searchType);
	console.log("pageCode = " + pageCode);
	console.log("searchKeyword = " + searchKeyword);
	
	const search = {
			"searchType" : $searchType,
			"pageCode" : $pageCode,
			"searchKeyword" : $searchKeyword,
			"cPage" : cPage
	};
	
	console.log(search);
	
	$.ajax({
		url : "${pageContext.request.contextPath}/community/communityFinder.do",
		data : search,
		constentType : "application/json; charset=utf-8",
		success(data){
			console.log("search = " + data);
			
			$("#tbody").html(data["freeboardStr"]);
			$(".pagebar").detach();
			$("#freeboardContainer").after(data["pagebar"]);
			$("#totalCountContainer").html(`<span class="countTitle">검색된 게시물 수 : </span> <span class"countContent">\${data["totalContent"]}</span>`)
		},
		error:console.log
	});
	
}

$(".search-btn").click(e => {
	e.preventDefault();
	getPage();
});
/* ---------------------------------------------- 타입별 검색 기능 종료 ---------------------------------------------- */
 
/* ---------------------------------------------- 타입별 페이지 기능 시작 ---------------------------------------------- */
$("#nav-home-tab").click((e) =>{
	console.log("도착했나요?");
	location.href=`${pageContext.request.contextPath}/community/communityQnAList.do`;
});
/* ---------------------------------------------- 타입별 페이지 기능 종료 ---------------------------------------------- */

/* ---------------------------------------------- 좋아요순 페이지 기능 시작 ---------------------------------------------- */
/* 전역 변수 */
var $pageCode = "";

/* 검색 결과 페이징 */
function likeGetPage(cPage){
	console.log($('#nav-like-tab').data('value'));
	const $pageCode = $('#nav-like-tab').data('value');
	
	pageCode = $pageCode;
	var cPage;
	
	console.log("pageCode = " + pageCode);
	
	// 객체로 담아서 보내야한다.
	const likeSearch = {"pageCode" : $pageCode,
					    "cPage" : cPage
					   };
	
	console.log(likeSearch);
	
	$.ajax({
		url : "${pageContext.request.contextPath}/community/likeBoard.do",
		data : likeSearch,
		contentType : "application/json; charset=utf-8",
		success(data){
			console.log("ajaxData = " + data);
			
			$("#tbody").html(data["likeBoardStr"]);
			$(".pagebar").detach();
			$("#freeboardContainer").after(data["pagebar"]);
			$("#totalCountContainer").html(`<span class="countTitle">총 게시물 수 : </span> <span class"countContent">\${data["totalContent"]}</span>`)
		},
		error:console.log
	});
	
}

$("#nav-like-tab").click(e => {
	e.preventDefault();
	likeGetPage();
});
/* ---------------------------------------------- 좋아요순 페이지 기능 종료 ---------------------------------------------- */	
/* ---------------------------------------------- 답변순 페이지 기능 시작 ---------------------------------------------- */

/* 전역 변수 */
var $pageCode = "";

/* 검색 결과 페이징 */
function commentGetPage(cPage){
	console.log($('#nav-comment-tab').data('value'));
	const $pageCode = $('#nav-comment-tab').data('value');
	
	pageCode = $pageCode;
	var cPage;
	
	console.log("pageCode = " + pageCode);
	
	// 객체로 담아서 보내야한다.
	const commentSearch = {"pageCode" : $pageCode,
					       "cPage" : cPage
					   	  };
	
	console.log(commentSearch);
	console.log("commentSearch");
	
	$.ajax({
		url : "${pageContext.request.contextPath}/community/commentBoard.do",
		data : commentSearch,
		contentType : "application/json; charset=utf-8",
		success(data){
			console.log("ajaxData = " + data);
			
			$("#tbody").html(data["commentBoardStr"]);
			$(".pagebar").detach();
			$("#freeboardContainer").after(data["pagebar"]);
			$("#totalCountContainer").html(`<span class="countTitle">총 게시물 수 : </span> <span class"countContent">\${data["totalContent"]}</span>`)
		},
		error:console.log
	});	
}
$("#nav-comment-tab").click(e => {
	e.preventDefault();
	commentGetPage();
});
/* ---------------------------------------------- 답변순 페이지 기능 종료 ---------------------------------------------- */

/* ---------------------------------------------- 최근답변순 페이지 기능 시작 ---------------------------------------------- */

/* 전역 변수 */
var $pageCode = "";

/* 검색 결과 페이징 */
function currentCommentGetPage(cPage){
	console.log($('#nav-currentComment-tab').data('value'));
	const $pageCode = $('#nav-currentComment-tab').data('value');
	
	pageCode = $pageCode;
	var cPage;
	
	console.log("pageCode = " + pageCode);
	
	// 객체로 담아서 보내야한다.
	const currentCommentSearch = {
						   		  "pageCode" : $pageCode,
					              "cPage" : cPage
					   	  		 };
	
	console.log(currentCommentSearch);
	console.log("currentCommentSearch");
	
	$.ajax({
		url : "${pageContext.request.contextPath}/community/currentCommentBoard.do",
		data : currentCommentSearch,
		contentType : "application/json; charset=utf-8",
		success(data){
			console.log("ajaxData = " + data);
			
			$("#tbody").html(data["currentCommentBoardStr"]);
			$(".pagebar").detach();
			$("#freeboardContainer").after(data["pagebar"]);
			$("#totalCountContainer").html(`<span class="countTitle">총 게시물 수 : </span> <span class"countContent">\${data["totalContent"]}</span>`)
		},
		error:console.log
	});	
}
$("#nav-currentComment-tab").click(e => {
	e.preventDefault();
	currentCommentGetPage();
});
/* ---------------------------------------------- 최근답변순 페이지 기능 종료 ---------------------------------------------- */


</script>
				
<script src="${pageContext.request.contextPath}/resources/js/community/communityQnAList/scripts.js"></script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
