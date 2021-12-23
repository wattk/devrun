<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!doctype html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<title>채팅</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<!-- bootstrap js: jquery load 이후에 작성할것.-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
<!-- bootstrap css -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">

<!-- Libraries CSS Files -->
<%-- <link href="${pageContext.request.contextPath }/resources/css/font-awesome/css/font-awesome.min.css" rel="stylesheet"> --%>
<script src="https://kit.fontawesome.com/f1def33959.js" crossorigin="anonymous"></script>

<style>
.chat-header {
	width: 100%;
	height: 48px;
	background-color: #1A81FF;
	color: #fff;
	line-height: 48px;
}

.chat-header h2 {
	font-size: 1.1rem;
	font-weight: bold;
	margin-bottom: 0;
}

.chat-header .plus {
	width: 5%;
}

.header-icon {
	right: 20px;
}

.chat-list li:hover {
	cursor: pointer;
	background-color: #f8f9fa;
}

/* 회원 프로필 사진*/
.chat-list .member-profile {
	width: 48px;
	border: 1px solid #f1f3f5;
	border-radius: 50%;
}

.chat-list .time-unread-count {
	top: 12px;
	right: 20px;
}

.chat-list .chat-time {
	color: #959595;
	font-size: 0.8rem;
}

.chat-list .unread-count {
	font-size: 0.7rem;
}

.chat-list .recent-msg {
	font-size: 0.8rem;
}

.chat-list .msg-content {
	padding-left: 60px;
	padding-right: 30px;
}

/* 채팅방 만들기 모달 css */
.chat-wrap h5 {
	font-size: 1rem;
	font-weight: bold;
}

.plus-modal .modal-footer {
	justify-content: center;
}

/* 채팅방 만들기 Modal 내용 부분만 스크롤 관련 css */
/* Important part */
.plus-modal .modal-dialog{
    overflow-y: initial !important
}
.plus-modal .modal-body{
    height: 100%;
    overflow-y: auto;
}
/* 채팅방 만들기 Modal 내용 부분만 스크롤 관련 css 끝*/

.plus-modal .member-profile {
	width: 48px;
	border: 1px solid #f1f3f5;
	border-radius: 50%;
}

.plus-modal li:hover {
	cursor: pointer;
	background-color: #f8f9fa;
}

.plus-modal i {
	top: 27px;
	right: 20px;
	color: #1A81FF;
}
/* 채팅방 만들기 모달 css 끝 */

/* 채팅 차단 멤버 관리 모달 css */
.minus-modal .unblock {
	position: absolute;
    top: 9px;
    right: 15px;
    min-width: 63px;
    border: 1px solid #dedede;
    font-size: 11px;
    line-height: 28px;
    background-color: #fff;
    text-align: center;
    color: #333;
    text-decoration: none;
}

/* 채팅 차단 멤버 관리 모달 css 끝 */
</style>

</head>
<body>
	
	<div class="chat-wrap">
	
		<!-- 채팅 헤더 -->
		<div class="chat-header position-relative text-center">
			
			<h2 class="d-inline-block">채팅</h2>
			
			<div class="header-icon d-inline-block position-absolute">
			
				<!-- 1:1 채팅방 만들기 아이콘 -->
				<!-- i trigger modal -->
				<i class="fas fa-plus fa-lg" data-toggle="modal" data-target="#plusModalCenter"></i>
				
				<!-- 차단 멤버 관리 아이콘 -->
				<!-- i trigger modal -->
				<i class="fas fa-user-minus fa-lg ml-2" data-toggle="modal" data-target="#minusModalCenter"></i>
				
				<!-- 설정 아이콘(차단 멤버 관리외에 더 필요할 시 드롭다운으로 만들기) -->
				<!-- <i class="fas fa-cog fa-lg ml-2"></i> -->
				
			</div>
			
		</div>
		<!-- 채팅 헤더 끝 -->
		
		<!-- 채팅방 만들기 Modal - 멤버 검색 -->
		<div class="modal fade plus-modal" id="plusModalCenter" tabindex="-1" role="dialog" aria-labelledby="plusModalCenterTitle" aria-hidden="true">
		  <div class="modal-dialog modal-dialog-centered" role="document">
		    <div class="modal-content">
		      
		      <!-- modal header -->
		      <div class="modal-header">
		        <h5 class="modal-title" id="exampleModalLongTitle">멤버 선택</h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		      <!-- modal header 끝 -->
		      
		      <!-- modal body -->
		      <div class="modal-body">
		      	<!-- 닉네임 검색 -->
				<form class="form-inline my-lg-0">
					<input class="form-control w-75" type="search" placeholder="닉네임 검색" aria-label="Search">
					<button class="btn btn-outline-primary my-2 my-sm-0 w-25" type="submit">검색</button>
				</form>
				<!-- 닉네임 검색 끝 -->
				
				<!-- 닉네임 검색 결과 -->
				
				<ul class="list-group">
				  <li class="list-group-item position-relative">
				  	<!-- 회원 프로필 사진 -->
					<img src="${pageContext.request.contextPath}/resources/images/blank-profile.png" alt="회원 프로필 사진" class="member-profile"/>
					<!-- 회원 닉네임 -->
					<strong class="nickname ml-2">길동이</strong>
					<!-- 선택 시 display 상태 변화 -->
					<i class="fas fa-check-circle position-absolute d-none"></i>
				  </li>
				  
				  <li class="list-group-item position-relative">
				  	<!-- 회원 프로필 사진 -->
					<img src="${pageContext.request.contextPath}/resources/images/blank-profile.png" alt="회원 프로필 사진" class="member-profile"/>
					<!-- 회원 닉네임 -->
					<strong class="nickname ml-2">길동이</strong>
					<!-- 선택 시 display 상태 변화 -->
					<i class="fas fa-check-circle position-absolute d-none"></i>
				  </li>
				  
				  <li class="list-group-item position-relative">
				  	<!-- 회원 프로필 사진 -->
					<img src="${pageContext.request.contextPath}/resources/images/blank-profile.png" alt="회원 프로필 사진" class="member-profile"/>
					<!-- 회원 닉네임 -->
					<strong class="nickname ml-2">길동이</strong>
					<!-- 선택 시 display 상태 변화 -->
					<i class="fas fa-check-circle position-absolute d-none"></i>
				  </li>
				  
				  <li class="list-group-item position-relative">
				  	<!-- 회원 프로필 사진 -->
					<img src="${pageContext.request.contextPath}/resources/images/blank-profile.png" alt="회원 프로필 사진" class="member-profile"/>
					<!-- 회원 닉네임 -->
					<strong class="nickname ml-2">길동이</strong>
					<!-- 선택 시 display 상태 변화 -->
					<i class="fas fa-check-circle position-absolute d-none"></i>
				  </li>
				  
				  <li class="list-group-item position-relative">
				  	<!-- 회원 프로필 사진 -->
					<img src="${pageContext.request.contextPath}/resources/images/blank-profile.png" alt="회원 프로필 사진" class="member-profile"/>
					<!-- 회원 닉네임 -->
					<strong class="nickname ml-2">길동이</strong>
					<!-- 선택 시 display 상태 변화 -->
					<i class="fas fa-check-circle position-absolute d-none"></i>
				  </li>
				  
				  <li class="list-group-item position-relative">
				  	<!-- 회원 프로필 사진 -->
					<img src="${pageContext.request.contextPath}/resources/images/blank-profile.png" alt="회원 프로필 사진" class="member-profile"/>
					<!-- 회원 닉네임 -->
					<strong class="nickname ml-2">길동이</strong>
					<!-- 선택 시 display 상태 변화 -->
					<i class="fas fa-check-circle position-absolute d-none"></i>
				  </li>
				  
				  <li class="list-group-item position-relative">
				  	<!-- 회원 프로필 사진 -->
					<img src="${pageContext.request.contextPath}/resources/images/blank-profile.png" alt="회원 프로필 사진" class="member-profile"/>
					<!-- 회원 닉네임 -->
					<strong class="nickname ml-2">길동이</strong>
					<!-- 선택 시 display 상태 변화 -->
					<i class="fas fa-check-circle position-absolute d-none"></i>
				  </li>
				</ul>
				
				<!-- 닉네임 검색 결과 끝 -->
				
		      </div>
		      <!-- modal body 끝 -->
		      
		      <!-- modal footer -->
		      <div class="modal-footer">
		        <!-- <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button> -->
		        <button type="button" class="btn btn-primary">초대</button>
		      </div>
		      <!-- modal footer 끝 -->
		      
		    </div>
		  </div>
		</div>
		<!-- 채팅방 만들기 Modal 끝 -->
		
		
		<!-- 채팅 차단 멤버 관리 Modal -->
		<div class="modal fade minus-modal" id="minusModalCenter" tabindex="-1" role="dialog" aria-labelledby="minusModalCenterTitle" aria-hidden="true">
		  <div class="modal-dialog modal-dialog-centered" role="document">
		    <div class="modal-content">
		      
		      <!-- modal header -->
		      <div class="modal-header">
		        <h5 class="modal-title" id="exampleModalLongTitle">채팅 차단</h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		      <!-- modal header 끝 -->
		      
		      <!-- modal body -->
		      <div class="modal-body">
				<!-- 채팅 차단 유저 있을 시. 없다면 '1:1 채팅을 차단한 멤버가 없습니다.' 문구 나타난다. -->
				<ul class="list-group">
				  <li class="list-group-item position-relative">
					<!-- 회원 닉네임 -->
					<p class="mb-0">길동이<span>(hong**)</span></p>
					<!-- 차단 해제 -->
					<a href="#" class="unblock">차단해제</a>
				  </li>
				  <li class="list-group-item position-relative">
					<!-- 회원 닉네임 -->
					<p class="mb-0">길동이<span>(hong**)</span></p>
					<!-- 차단 해제 -->
					<a href="#" class="unblock">차단해제</a>
				  </li>
				</ul>
				<!-- 닉네임 검색 결과 끝 -->
				
		      </div>
		      <!-- modal body 끝 -->
		      
		    </div>
		  </div>
		</div>
		<!-- 채팅 차단 멤버 관리 Modal 끝 -->


		<!-- 채팅방 검색 -->
		<form class="form-inline my-lg-0">
			<input class="form-control w-75" type="search" placeholder="채팅방 검색" aria-label="Search">
			<button class="btn btn-outline-primary my-2 my-sm-0 w-25" type="submit">검색</button>
		</form>
		<!-- 채팅방 검색 끝 -->
		
		<!-- 채팅방 리스트 -->
		<div class="chat-list">
		
			<ul class="list-group">
			
				<li class="list-group-item position-relative">
					<!-- 회원 프로필 사진 -->
					<img src="${pageContext.request.contextPath}/resources/images/blank-profile.png" alt="회원 프로필 사진" class="member-profile position-absolute text-left"/>
					
					<div class="msg-content">
					
						<!-- 회원 닉네임 -->
						<strong class="nickname">길동이</strong>
						<!-- 최근 메세지 -->
						<p class="recent-msg mb-0">안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?</p>
						
					
					</div>
					
					<div class="time-unread-count d-inline-block position-absolute text-right">
					
						<!-- 날짜(오늘일 경우 - 오전 9:00 또는 15:00 / 올해일 경우 - 12월 22일 / 올해가 아닐 경우 - 2020.10.14)-->
						<p class="mb-0 chat-time">오전 9:00</p>
						<!-- 안읽음 메세지 -->
						<span class="badge badge-pill badge-danger unread-count">2</span>
						
					</div>

				</li>
				
				<li class="list-group-item position-relative">
					<!-- 회원 프로필 사진 -->
					<img src="${pageContext.request.contextPath}/resources/images/blank-profile.png" alt="회원 프로필 사진" class="member-profile position-absolute text-left"/>
					
					<div class="msg-content">
					
						<!-- 회원 닉네임 -->
						<strong class="nickname">길동이</strong>
						<!-- 최근 메세지 -->
						<p class="recent-msg mb-0">안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?</p>
						
					
					</div>
					
					<div class="time-unread-count d-inline-block position-absolute text-right">
					
						<!-- 날짜(오늘일 경우 - 오전 9:00 또는 15:00 / 올해일 경우 - 12월 22일 / 올해가 아닐 경우 - 2020.10.14)-->
						<p class="mb-0 chat-time">오전 9:00</p>
						<!-- 안읽음 메세지 -->
						<span class="badge badge-pill badge-danger unread-count">2</span>
						
					</div>

				</li>
				
				<li class="list-group-item position-relative">
					<!-- 회원 프로필 사진 -->
					<img src="${pageContext.request.contextPath}/resources/images/blank-profile.png" alt="회원 프로필 사진" class="member-profile position-absolute text-left"/>
					
					<div class="msg-content">
					
						<!-- 회원 닉네임 -->
						<strong class="nickname">길동이</strong>
						<!-- 최근 메세지 -->
						<p class="recent-msg mb-0">안녕하세요?안녕하세요?안녕하세요?안녕하세요?안녕하세요?</p>
						
					
					</div>
					
					<div class="time-unread-count d-inline-block position-absolute text-right">
					
						<!-- 날짜(오늘일 경우 - 오전 9:00 또는 15:00 / 올해일 경우 - 12월 22일 / 올해가 아닐 경우 - 2020.10.14)-->
						<p class="mb-0 chat-time">오전 9:00</p>
						<!-- 안읽음 메세지 -->
						<span class="badge badge-pill badge-danger unread-count">2</span>
						
					</div>

				</li>

			</ul>
		
		</div>
		<!-- 채팅방 리스트 끝 -->
		
	</div>

<script>

// 채팅방 만들기 Modal 내용 부분만 스크롤 기능 하기
$(document).ready(function () {
    $('head').append('<style type="text/css">.plus-modal .modal-body {max-height: ' + ($('body').height() * 0.9) + 'px;overflow-y: auto;}.modal-open .modal{overflow-y: hidden !important;}</style>');
});

//채팅 차단 멤버 관리 Modal 내용 부분만 스크롤 기능 하기
$(document).ready(function () {
    $('head').append('<style type="text/css">.minus-modal .modal-body {max-height: ' + ($('body').height() * 0.9) + 'px;overflow-y: auto;}.modal-open .modal{overflow-y: hidden !important;}</style>');
});

// 채팅방 만들기 Modal 부분
// 멤버 선택 li 클릭 시 이벤트 발생 - 우측에 체크 아이콘 d-none 해제, 다른 요소들 d-none 상태
$(".plus-modal li").click((e) => {
	const $li = $(e.target);
	$li.children('i').removeClass("d-none");
	
	// siblings() 함수는 자신을 제외한 형제 엘리멘트를 찾는다. 형제 엘리먼트의 class를 추가하거나 삭제할 때 많이 사용한다.
	$li.siblings().children('i').addClass("d-none");
});

// 모달 닫을 시 입력값 초기화
$('.plus-modal').on('hidden.bs.modal', function (e) {
	console.log($(this).find('i'));
	$(this).find('form')[0].reset()
	// 멤버 선택 여부 아이콘 체크할 경우 대비 d-none 클래스 추가
	$(this).find('i').addClass("d-none");
});

// 채팅방 list 클릭 시 이벤트 발생 - 기능 구현 시 수정할 부분 url 부분 li마다 달라져야 함. 위의 코드 수정할 것
$('.chat-list li').click((e) => {
	
	// 팝업요청 // url 부분 기능 구현 시 수정할 것
	const url = `${pageContext.request.contextPath}/chat/chatRoom.do`;
	const name = ''; // 팝업창 Window객체의 name. // 이후에 const name = chatId; 이런식으로 바꿀 것. 수업 코드 참고
	const spec = "width=400px, height=600px";
	open(url, name, spec);
});

</script>

</body>
</html>

