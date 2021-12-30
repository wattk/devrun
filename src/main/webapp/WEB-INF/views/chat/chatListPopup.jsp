<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>	

<%-- EL에서 접근하기 위해 var속성 지정 --%>
<sec:authentication property="principal" var="loginMember"/>

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

<!-- sock.js 추가 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.5.2/sockjs.min.js" integrity="sha512-ayb5R/nKQ3fgNrQdYynCti/n+GD0ybAhd3ACExcYvOR2J1o3HebiAe/P0oZDx5qwB+xkxuKG6Nc0AFTsPT/JDQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<!-- stomp.js 추가 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js" integrity="sha512-iKDtgDyTHjAitUDdLljGhenhPwrbBfqTKWO1mkhSFH3A7blITC9MhYon6SjnMhp4o0rADGw9yAC6EW4t5a4K3g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

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

.chat-header .plus-icon {
	cursor: pointer;
}

.chat-header .block-icon {
	cursor: pointer;
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
	height: 48px;
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
	height: 48px;
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
				<i class="fas fa-plus fa-lg plus-icon" data-toggle="modal" data-target="#plusModalCenter"></i>
				
				<!-- 차단 멤버 관리 아이콘 -->
				<!-- i trigger modal -->
				<i class="fas fa-user-minus fa-lg ml-2 block-icon" data-toggle="modal" data-target="#minusModalCenter"></i>
				
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
				<form class="form-inline my-lg-0" id="searchNicknameFrm">
					<input class="form-control w-75" type="search" name="searchNickname" id="searchNickname" placeholder="닉네임 검색" aria-label="Search">
					<button class="btn btn-outline-primary my-2 my-sm-0 w-25" type="submit">검색</button>
				</form>
				<!-- 닉네임 검색 끝 -->
				
				<!-- 닉네임 검색 결과 -->
				<ul id="nicknameSearchResultList" class="list-group">

				</ul>
				<!-- 닉네임 검색 결과 끝 -->
				
		      </div>
		      <!-- modal body 끝 -->
		      
		      <!-- modal footer -->
		      <div class="modal-footer">
		        <!-- <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button> -->
		        <button type="submit" id="inviteBtn" class="btn btn-primary">초대</button>
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
		
			<ul id="chatList" class="list-group">
			
				<c:forEach items="${list}" var="chatLog">
					
					<li class="list-group-item position-relative" data-chat-id="${chatLog.chatId}">
						<!-- 회원 프로필 사진 --> <%-- 상대방 프로필 사진이 나와야 함 --%>
						<%-- 프로필 사진 없는 경우 --%>
						<c:if test="${chatLog.member.proPhoto eq null}">
							<img src="${pageContext.request.contextPath}/resources/images/common/blank-profile.png" alt="회원 프로필 사진" class="member-profile position-absolute text-left"/>
						</c:if>
						<%-- 프로필 사진 있는 경우 --%>
				      	<c:if test="${chatLog.member.proPhoto ne null}">
				      		<img src="${pageContext.request.contextPath}/resources/upload/profilePhoto/${chatLog.member.proPhoto}" alt="회원 프로필 사진" class="member-profile position-absolute text-left"/>	
				      	</c:if>
						
						<div class="msg-content">
						
							<!-- 회원 닉네임 --> <%-- 상대방 닉네임이 나와야 함 --%>
							<strong class="nickname">${chatLog.member.nickname}</strong>
							<!-- 최근 메세지 -->
							<p class="recent-msg mb-0 msg">${chatLog.msg}</p>
							
						
						</div>
						
						<div class="time-unread-count d-inline-block position-absolute text-right">
						
							<%-- 현재 날짜 --%>
							<c:set var="today" value="<%=new java.util.Date()%>" />
							<!-- 날짜(오늘일 경우 - 오전 9:00 또는 15:00 / 올해일 경우 - 12월 22일 / 올해가 아닐 경우 - 2020.10.14)-->
							<jsp:useBean id="dateValue" class="java.util.Date"/>
							<jsp:setProperty name="dateValue" property="time" value="${chatLog.logTime}"/>
							<fmt:formatDate value="${dateValue}" pattern="yyyyMMdd" var="logTimeDate"/>
							<fmt:formatDate value="${today}" pattern="yyyyMMdd" var="nowDate"/>
							<fmt:formatDate value="${dateValue}" pattern="yyyy" var="logTimeYear"/>
							<fmt:formatDate value="${today}" pattern="yyyy" var="nowYear"/>
							<%-- 조건문 시작 --%>
							<c:choose>
								<%-- 오늘일 경우 ex. 15:00 --%>
								<c:when test="${logTimeDate eq nowDate}">
									<p class="mb-0 chat-time"><fmt:formatDate value="${dateValue}" pattern="HH:mm"/></p>
								</c:when>
								<%-- 올해일 경우 ex. 12월 22일 --%>
								<c:when test="${logTimeYear eq nowYear}">
									<p class="mb-0 chat-time"><fmt:formatDate value="${dateValue}" pattern="MM월 dd일"/></p>
								</c:when>
								<%-- 이외의 경우 ex. 2020.10.14 --%>
								<c:otherwise>
									<p class="mb-0 chat-time"><fmt:formatDate value="${dateValue}" pattern="yyyy.MM.dd"/></p>
								</c:otherwise>
							</c:choose>
							<%-- 조건문 끝 --%>
							<!-- 안읽음 메세지 --> <%-- 임의의 값 넣음 수정할 것 --%>
							<span class="badge badge-pill badge-danger unread-count ${chatLog.unreadCount eq 0 ? 'd-none' : ''}">${chatLog.unreadCount}</span>
							
						</div>
	
					</li>
				
				</c:forEach>

			</ul>
		
		</div>
		<!-- 채팅방 리스트 끝 -->
		
	</div>

<script>

// message받은것 중 logTime(유닉스 시간)을 HH:mm 형태로 return
function dateFormat(date) {
	//let month = date.getMonth() + 1;
	//let day = date.getDate();
	let hour = date.getHours();
	let minute = date.getMinutes();
	//let second = date.getSeconds();

	//month = month >= 10 ? month : '0' + month;
	//day = day >= 10 ? day : '0' + day;
	hour = hour >= 10 ? hour : '0' + hour;
	minute = minute >= 10 ? minute : '0' + minute;
	//second = second >= 10 ? second : '0' + second;

	return hour + ':' + minute;
}

//websocket 연결(SockJS)
const ws = new SockJS(`http://\${location.host}${pageContext.request.contextPath}/stomp`);

// StompClient객체 생성
const stompClient = Stomp.over(ws);

// connect
stompClient.connect({}, (frame) => {
	console.log("Stomp Client Connect : ", frame);
	
	// 구독신청 및 핸들러 등록 // 반드시 커넥트 이후에 실행되도록 콜백함수 안에 작성한다.
	stompClient.subscribe("/chat/chatList", (message) => {
		//console.log("message : ", message);
		
		// type속성으로 MESSAGE(chatLog), LAST_CHECK을 구분한다.
		var obj = JSON.parse(message.body);
		//console.log("obj = ", obj);
/* 		const {chatId, memberNo, member: {id : id, nickname : nickname, proPhoto : proPhoto}, msg, logTime, type} = obj; */
		var {chatId, memberNo, type} = obj;
		//console.log("누가봤습니까?", memberNo);
		
		const $li = $(`li[data-chat-id='\${chatId}']`);
		//console.log("$li = ", $li);
		const $unreadCountSpan = $li.find("span.unread-count");
		
		// 실제 메세지가 온 경우와 LAST_CHECK, READ_STATUS 분기처리한다. - LAST_CHECK 주석함
		switch(type){
		/* LAST_CHECK가 한 일 + 실시간 읽음 처리를 READ_STATUS 가 해준다. */
		/* case "LAST_CHECK" : 
			// 본인이 확인한 경우에만 안읽음 메시지 건수 0처리와 d-none상태 처리
			if(memberNo == ${loginMember.memberNo}){
				$unreadCountSpan.text(0).addClass("d-none");
			}
			break; */
		case "MESSAGE" : 
			var {chatId, memberNo, member: {id : id, nickname : nickname, proPhoto : proPhoto}, msg, logTime, type} = obj;
			const $msgP = $li.find(".msg");
			//console.log("$msgP = ", $msgP);
			$msgP.text(msg); // p.msg 갱신
			const date = new Date(logTime);
			//console.log(dateFormat(date));
			const $chatTimeP = $li.find(".chat-time");
			$chatTimeP.text(dateFormat(date));
	
			// 1. 본인메시지 : 처리없음
			// 2. 상대방메시지 : 안읽음메시지 +1
			if(memberNo != ${loginMember.memberNo}){
				const unreadCountVal = Number($unreadCountSpan.text()) + 1;
				$unreadCountSpan.text(unreadCountVal).removeClass("d-none");
			}

			$li.prependTo($("#chatList")); // 첫번째 자식요소로 추가(이동) // 기존 요소에 적용하면 이동이 된다.
			
			break;
		case "READ_STATUS" : 
			var {chatId, memberNo, readStatus, type} = obj;
			//console.log("오고있음! chatId / memberNo / readStatus / type", chatId, memberNo, readStatus, type);
			// 본인이 읽고 있는 상태인 경우
			if(memberNo == ${loginMember.memberNo} && readStatus == "READ") {
				// 해당하는 채팅방의 안읽음 메시지 건수 0처리와 d-none상태 처리
				$unreadCountSpan.text(0).addClass("d-none");
			}
			break;	
		}

	});	
	
	stompClient.subscribe("/chat/readStatus/${chatId}", (message) => {
		
	});
	
});

// 채팅방 생성을 위한 멤버 선택 - 닉네임 검색 폼
$(searchNicknameFrm).submit((e) => {
	e.preventDefault(); // 폼제출방지
	//console.log(e.target);

	const searchNickname = $("[name=searchNickname]", e.target).val();
	
	// 빈문자열 검색할 경우
	if(searchNickname == '') {
		// 검색 결과 존재할 경우 대비 - 이후 빈 문자열 검색하면 검색 결과 제거
		$("#nicknameSearchResultList").children().remove();
		return;
	}
	
	$.ajax({
		url : `${pageContext.request.contextPath}/chat/searchNickname.do`,
		data : {
			searchNickname : searchNickname
		},
		method : "GET", // GET방식 생략 가능
		success(data) { // 이 안에 들어가는 data는 변수명이다. 다른 이름으로 사용해도 된다. 위의 data : 에서 사용한 부분과 헷갈리지 말자
			//console.log(data);
		
			// 자식 노드 제거 - 검색 클릭 시 추가되는 것 방지
			$("#nicknameSearchResultList").children().remove();
			
			if(Object.keys(data).length == 0) {
				// data 존재하지 않는 경우 '검색결과가 없습니다.' 출력
				$("#nicknameSearchResultList").append(`<p class="text-center my-5">검색결과가 없습니다.</p>`);
			} else {
				// 닉네임 검색 결과 뿌리기
				$(data).each((i, member) => {
					//console.log(member);
					//console.log(member.proPhoto);
					
					// 프로필 사진 분기 처리
					const photo = (!member.proPhoto) ? 
							'${pageContext.request.contextPath}/resources/images/common/blank-profile.png' : 
							'${pageContext.request.contextPath}/resources/upload/profilePhoto/' + member.proPhoto;
					//console.log('photo값은?', photo);

					$("#nicknameSearchResultList").append(`<li class="list-group-item position-relative" data-receiver-no="\${member.memberNo}">
<!-- 회원 프로필 사진 -->
<img src="\${photo}" alt="회원 프로필 사진" class="member-profile"/>
<!-- 회원 닉네임 -->
<strong class="nickname ml-2">\${member.nickname}</strong>
<!-- 선택 시 display 상태 변화 -->
<i class="fas fa-check-circle position-absolute d-none"></i>
</li>`);

				});
			}
		},
		error : console.log
	});
});


// 초대버튼 클릭 후 이벤트 발생
$(document).on('click', '#inviteBtn', function(e) {
	e.preventDefault(); // 폼제출방지
	
	// invite-target 클래스명을 가진 i의 부모 li태그 찾기
	const $li = $('.invite-target').parent();
	//console.log($li);
	
	const receiverNo = $li.data("receiverNo");
	//console.log(receiverNo);
	
	// 회원 선택하지 않고 초대 시 알림창 띄우고 return
	if(!receiverNo) {
		alert('초대할 멤버를 선택해주세요');
		return;
	}
	
	// 비동기 - chat_member 테이블 생성 후 팝업 띄우기(받아온 데이터 중 필요한 것 넘기기)
	$.ajax({
		url : `${pageContext.request.contextPath}/chat/chat.do`,
		data : {
			receiverNo : receiverNo
		},
		method : "POST", // GET방식 생략 가능
		success(chatId) { // 이 안에 들어가는 data는 변수명이다. 다른 이름으로 사용해도 된다. 위의 data : 에서 사용한 부분과 헷갈리지 말자
			//console.log(chatId);

			// 팝업요청 // url 부분 기능 구현 시 수정할 것
			const url = `${pageContext.request.contextPath}/chat/chatRoom.do/\${chatId}`;
			const name = chatId; // 팝업창 Window객체의 name
			const spec = "width=400px, height=600px";
			open(url, name, spec);

			// modal해제 - 멤버 선택 이후 초대 시 기존 모달 처리
			$(plusModalCenter)
				.modal('hide')
				.find('form')[0].reset(); // [0] 실제 js dom객체를 반환
		},
		error : console.log
	});

});


// 채팅방 만들기 Modal 내용 부분만 스크롤 기능 하기
$(document).ready(function () {
    $('head').append('<style type="text/css">.plus-modal .modal-body {max-height: ' + ($('body').height() * 0.9) + 'px;overflow-y: auto;}.modal-open .modal{overflow-y: hidden !important;}</style>');
});

//채팅 차단 멤버 관리 Modal 내용 부분만 스크롤 기능 하기
$(document).ready(function () {
    $('head').append('<style type="text/css">.minus-modal .modal-body {max-height: ' + ($('body').height() * 0.9) + 'px;overflow-y: auto;}.modal-open .modal{overflow-y: hidden !important;}</style>');
});

//채팅방 만들기 Modal 부분
//멤버 선택 li 클릭 시 이벤트 발생 - 우측에 체크 아이콘 d-none 해제, 다른 요소들 d-none 상태
//선택된 회원 찾기 위해 invite-target 클래스 추가 - 초대 부분 이용하기 위함
$(document).on('click', '.plus-modal li', function(e) {

	const $li = $(e.target);
	$li.children('i').removeClass("d-none").addClass("invite-target");
	
	// siblings() 함수는 자신을 제외한 형제 엘리멘트를 찾는다. 형제 엘리먼트의 class를 추가하거나 삭제할 때 많이 사용한다.
	$li.siblings().children('i').addClass("d-none").removeClass("invite-target");
	
});

// 모달 닫을 시 입력값 초기화
$('.plus-modal').on('hidden.bs.modal', function (e) {
	console.log($(this).find('i'));
	$(this).find('form')[0].reset()
	// 멤버 선택 여부 아이콘 체크할 경우 대비 d-none 클래스 추가
	$(this).find('i').addClass("d-none");
	
	// 닉네임 검색 결과 남아있을 시 대비 자식 노드 제거
	$("#nicknameSearchResultList").children().remove();
});

// 채팅방 list 클릭 시 이벤트 발생 - 기능 구현 시 수정할 부분 url 부분 li마다 달라져야 함. 위의 코드 수정할 것
$('.chat-list li').click((e) => {
	const $li = $(e.target).parents("li");
	//console.log($li);
	const chatId = $li.data("chatId"); // getter camelcasing으로 참조하기
	//console.log(chatId);
	
	// 팝업요청 // url 부분 기능 구현 시 수정할 것
	const url = `${pageContext.request.contextPath}/chat/chatRoom.do/\${chatId}`;
	const name = chatId; // 팝업창 Window객체의 name. // 이후에 const name = chatId; 이런식으로 바꿀 것. 수업 코드 참고
	const spec = "width=400px, height=600px";
	open(url, name, spec);
});

</script>

</body>
</html>

