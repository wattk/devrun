<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="마이페이지" name="title"/>
</jsp:include>
<!-- 부트스트랩 아이콘 CDN -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
<!-- 한글 폰트 CDN -->
<link href="https://fonts.googleapis.com/css2?family=Gowun+Dodum&display=swap" rel="stylesheet">
<!-- CSS import -->
<link href="${pageContext.request.contextPath}/resources/css/mypage/mypage.css" rel="stylesheet">

<%-- EL에서 접근하기 위해 VAR속성 지정 --%>
<sec:authentication property="principal" var="member"/>

<main>
	<br/><br/>
	<article class="container" id="tabContent">
		
		<%-- tap button --%>
		<nav id="tabBtns">
			<ul class="nav nav-tabs">
				<li class="nav-item">
				   <a class="nav-link" id="mycommunityTab" href="#mycommunity" role="tab" aria-controls="mycommunity" aria-selected="false">나의 커뮤니티</a>
				</li>
				<li class="nav-item">
				   <a class="nav-link" id="myshoppingTab" href="#myshopping" role="tab" aria-controls="myshopping" aria-selected="false">나의 쇼핑</a>
				</li>
				<li class="nav-item">
				   <a class="nav-link" id="myinfoTab" href="#myinfo" role="tab" aria-controls="myinfo" aria-selected="false">나의 정보</a>
				</li>
				<li class="nav-item">
				   <a class="nav-link active" id="mypageTab" href="#mypage" role="tab" aria-controls="mypage" aria-selected="true">마이페이지</a>
				</li>
			</ul>
		</nav>
		
		<%-- tap container --%>
		<section class="col-12 tab-content" id="tabContainer">
		
			<%-- my page --%>
			<div class="tab-pane fade show active col-12" id="mypage">
				<div class="row">
					
					<!-- member profile -->
					<article class="col-3" id="profile">
						<!-- profile image : 프로필 이미지가 null일 경우, 기본 이미지 출력 -->
					    <section>
				   			<c:if test="${member.proPhoto eq null}"><i class="bi bi-person-circle" id="profileImg"></i></c:if>
					      	<c:if test="${member.proPhoto ne null}"><img src="${member.proPhoto}" alt="" id="profileImg"/></c:if>
					       	<p class="cursor" onclick="location.href='${pageContext.request.contextPath}/mypage/myinfo/';">${member.nickname}님<i class="bi bi-chevron-right"></i></p>
					       	<img src="https://i.ibb.co/HNQhz98/pencil.png" alt="" id="edit" onclick="location.href='${pageContext.request.contextPath}/mypage/myinfo/infoUpdate.do';"/>
					    	<img src="https://i.ibb.co/S7TZCYh/coding.png" alt="" id="badge" onclick="location.href='${pageContext.request.contextPath}/mypage/myinfo/activityBadge.do';"/>
					    </section>
					    <!-- profile info -->
				        <section>
				        	<p><span>이메일</span><br/><span>${member.email}</span></p>
					        <p><span>한줄소개</span><br/><span>${member.intro}</span></p>
					        <button onclick="location.href='${member.url}';">${member.url}</button>
				        </section>
				        <hr/>
				       	<!-- login info / logout button -->
				       	<section class="">
				        	<p><img src="" alt="" />(으)로 로그인</p>
				        	<button class="col-9">로그아웃</button>
				       	</section>
			    	</article>
				     	
		      		<!-- member info -->
			   		<article class="col-9">
		    			<!-- member grade info : total attendance / activity grade / activity badge -->
		       			<section class="card" id="myGrade">
		        			<table class="text-center">
			       				<tr>
			       					<td class="col-4">출석일수</td>
			       					<td class="col-4">활동 등급</td>
			       					<td class="col-4 cursor" onclick="location.href='${pageContext.request.contextPath}/mypage/myinfo/activityBadge.do';">활동 배지</td>
			       				</tr>
			       				<tr>
			       					<!-- 출석일수 -->
			       					<td>일</td>
			       					<!-- 활동 등급 -->
			       					<td>
			       						<img src="https://i.ibb.co/jgyRRVB/badge.png" alt="" />
			       						<span>
			       							<!-- c:if 태그로 회원 권한에 따른 활동 등급명 분기 -->
			       							<c:if test="${member.authorities eq '[ROLE_M1]'}">일반회원</c:if>
			       							<c:if test="${member.authorities eq '[ROLE_M2]'}">지식인</c:if>
			       							<c:if test="${member.authorities eq '[ROLE_AM]'}">관리자</c:if>
			       						</span>
			       					</td>
			       					<!-- 활동 배지 -->
			       					<td class="cursor">
			       						<!-- 대표배지 이미지와 이름 불러오기 -->
			       						<img src="https://i.ibb.co/S7TZCYh/coding.png" alt=""/>
			       						<span>지식인</span>
			       					</td>
			       				</tr>
			       			</table>
		       			</section>
			       			
		       			<!-- member activity info : message / point -->
		       			<section class="row cursor" id="myActivity">
			       			<span class="col-6 row" onclick="location.href='#';">
				       			<span class="bi bi-envelope"> &nbsp; 채팅</span>
				       			<span>건<i class="bi bi-chevron-right"></i></span>
			       			</span>
				       		<span class="col-6 row" onclick="location.href='#';">
					       		<span class="bi bi-coin"> &nbsp; 포인트</span>
					       		<span>사용 가능 ${member.point}포인트<i class="bi bi-chevron-right"></i></span>
				       		</span>
		       			</section>
		       			<!-- event : 최근 등록 이벤트 2개 -->
		       			<section class="row" id="eventBanner">
		       				<img src="https://i.ibb.co/w63RdmJ/2021121515051506481-11934059-1.jpg" alt="" class="col-6" onclick="location.href='#';"/>
		       				<img src="https://i.ibb.co/GFmzFXF/2021120917350947828-11922858-1.jpg" alt="" class="col-6" onclick="location.href='#';"/>
		       			</section>
		       			<!-- member activity info : like / wishList -->
		       			<h5>나의 활동</h5>
		       			<section class="row cursor" id="myActivity">
		       				<span class="col-6 row" onclick="location.href='#';">
		       					<span class="bi bi-heart"> &nbsp; 좋아요</span>
				       			<i class="bi bi-chevron-right"></i>
		       				</span>
				       		<span class="col-6 row" onclick="location.href='#';">
					       		<span class="bi bi-bookmark"> &nbsp; 관심 상품</span>
					       		<i class="bi bi-chevron-right"></i>
				       		</span>
		       			</section>
		       			<!-- event : 최근 등록 이벤트 1개 -->
		    	  		<section class="row" id="eventBanner">
		      				<img src="https://i.ibb.co/GFmzFXF/2021120917350947828-11922858-1.jpg" alt="" class="col-12" onclick="location.href='#';"/>
			       		</section>
			    	</article>
			    	
				</div>
			</div>
			
			<%-- my info --%>
			<div class="tab-pane fade col-12" id="myinfo">
				<div class="row">
					
					<article class="col-10" id="info">
		      			<h4>나의 정보</h4>
		       			<hr/>
		       			<!-- 내 프로필 -->
		       			<section class="card" id="myProfile">
		       				<div class="card-header">내 프로필</div>
		       				<div class="card-body">
		       					<div class="row">
			       					<!-- 프로필 이미지 : 프로필 이미지가 null일 경우, 기본 이미지 출력 -->
			       					<article class="col-3">
				       					<c:if test="${member.proPhoto eq null}"><i class="bi bi-person-circle" id="profileImg"></i></c:if>
								      	<c:if test="${member.proPhoto ne null}"><img src="${member.proPhoto}" alt="" id="profileImg"/></c:if>
								       	<img src="https://i.ibb.co/HNQhz98/pencil.png" alt="" id="edit" onclick="location.href='${pageContext.request.contextPath}/mypage/myinfo/infoUpdate.do';"/>
			       					</article>
			       					<!-- 프로필 내용 -->
			       					<article class="col-9">
			       						<table id="profileInfo">
			       							<caption>${member.nickname}</caption>
								        	<tr><td>이메일</td><td>${member.email}</td></tr>
								        	<tr><td>한줄소개</td><td>${member.intro}</td></tr>
								        	<tr><td>개인 사이트</td><td>${member.url}</td></tr>
								        </table>
								        <hr/>
								        <table id="personalInfo">
								        	<tr><td>아이디</td><td>${member.id}</td></tr>
								        	<tr><td>닉네임</td><td>${member.nickname}</td></tr>
								        	<tr><td>이름</td><td>${member.name}</td></tr>
								        	<tr><td>생년월일</td><td><fmt:formatDate value="${member.birthday}" pattern="yyyy년 MM월 dd일"/></td></tr>
								        	<tr><td>전화번호</td><td>${member.phone}</td></tr>
								        </table>
			       					</article>
		     					</div>
		       					<button class="col-11" type="button" onclick="location.href='${pageContext.request.contextPath}/mypage/myinfo/profileUpdate.do';">수정하기</button>
		       				</div>
		       			</section>
		       			<br/>
		       			<section class="row">
		       				<div class="col-6">
			       				<!-- 배송지 관리 -->
			       				<article class="card" id="myAddress">
			       					<div class="card-header">배송지 관리</div>
				       				<div class="card-body">
				       					<p>내가 저장한 배송지를<br/>관리할 수 있습니다.</p>
				       					<button class="col-4" onclick="location.href='${pageContext.request.contextPath}/mypage/myinfo/shippingAddress.do';">조회하기</button>
				       				</div>
			       				</article>
		       				</div>
		       				<div class="col-6">
			       				<!-- 신고 내역 -->
			       				<article class="card" id="myReport">
			       					<div class="card-header">신고 내역</div>
				       				<div class="card-body">
				       					<p>내가 신고한 내역을<br/>확인할 수 있습니다.</p>
				       					<button class="col-4" onclick="location.href='${pageContext.request.contextPath}/mypage/myinfo/reportHistory.do';">조회하기</button>
				       				</div>
			       				</article>
		       				</div>
		       			</section>
		       		</article>
		       		
				</div>
			</div>
				
			<%-- my shopping --%>
			<div class="tab-pane fade col-12" id="myshopping">
				<div class="row">
				나의 쇼핑
				</div>
			</div>
					
			<%-- my community --%>
			<div class="tab-pane fade col-12" id="mycommunity">
				<div class="row">
				나의 커뮤니티
				</div>
			</div>
		
		</section>		   
        	   
    </article>
</main>

<script>
/* location.hash로 url 활용 */
$(function(){
	var hash = window.location.hash;
	hash && $('#tabBtns ul.nav-tabs a[href="' + hash + '"]').tab('show');

	$('#tabBtns ul.nav-tabs a').click(function (e) {
		$(this).tab('show');
	    var scrollmem = $('html').scrollTop();
	    window.location.hash = this.hash;
	    $('html').scrollTop(scrollmem);
	});
});

/* $(document).click(function(){
	const $ative = $(".nav-item a.active");
	$ative
		.parents(".nav-item")
		.css("background-color", "#FFFFFF");
}); */

/* $(){
	$("#tabContainer").load("myshopping.jsp");
}); */

/* $(function() {
	// tab operation
	$('.nav-item').click(function() {
		var activeTab = $(this).attr('data-tab');
		$.ajax({
			type : 'GET',                 //get방식으로 통신
			url : activeTab + ".jsp",    //탭의 data-tab속성의 값으로 된 html파일로 통신
			dataType : "html",            //html형식으로 값 읽기
			error : function() {          //통신 실패시
				alert('통신실패!');
			},
			success : function(data) {    //통신 성공시 탭 내용담는 div를 읽어들인 값으로 채운다.
				$('#tabContainer').html(data);
			}
		});
	});
	$('#mypageTab').click();          
}); */
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>