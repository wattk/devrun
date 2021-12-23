<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!doctype html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<title>1:1 채팅방</title>
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
/* chatListPopup과 동일한 부분 확인 후 css 합칠 시 하나만 기재 */
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

.more-icon {
	cursor: pointer;
}
/* chatListPopup과 동일한 부분 확인 후 css 합칠 시 하나만 기재 끝 */

.msg-input-group {
	box-shadow: 0 0px 0px #888, 0 0px 9px #c7c7c7;
	padding: 8px 0px;
	z-index: 1;
}

/* 사이드 테스트 */
.menu_bg{
	width: 100%;
	height: 100%;
	background: rgba(0,0,0,0.7);
	position: absolute;
	top:0;
	display: none;
	z-index: 2;
}
.sidebar_menu{
	display: none;
	width: 50%;
	/* width: 230px; */
	height: 100%;
	background: #fff;
	position: absolute;
	top:0;
	right: -50%;
	z-index: 3;
}
.close_btn{
	margin: 15px;
}
.close_btn i {
	cursor: pointer;
}
.exit {
	width: 50%;
	bottom: 0;
	right: 0;
	padding: 15px;
	border-top: 1px solid #e4e4e4;
	cursor: pointer;
}

/* 사이드바 회원 프로필 사진*/
.sidebar_menu .member-profile {
	width: 42px;
	border: 1px solid #f1f3f5;
	border-radius: 50%;
}

.sidebar_menu ul {
	list-style: none;
}
.sidebar_menu ul li {
	margin-bottom: 15px;
}
.sidebar_menu .chat-member {
	margin-left: 15px;
}
</style>

</head>
<body>
	
	<div class="chat-wrap">
	
		<!-- 채팅 헤더 -->
		<div class="chat-header position-relative text-center">
			
			<!-- 채팅 상대방 닉네임 -->
			<h2 class="d-inline-block">길동이</h2>
			
			<div class="header-icon d-inline-block position-absolute">

				<!-- 더보기 아이콘 -->
				<i class="fas fa-ellipsis-h more-icon"></i>
				
			</div>
			
		</div>
		<!-- 채팅 헤더 끝 -->
		
		<!-- 메세지 보내기 -->
		<div class="input-group fixed-bottom msg-input-group">
		  <input type="text" id="message" class="form-control" placeholder="메시지를 입력하세요.">
		  <div class="input-group-append" style="padding: 0px;">
		    <button id="sendBtn" class="btn btn-outline-secondary" type="button">Send</button>
		  </div>
		</div>
		<!-- 메세지 보내기 끝 -->
		
		<!-- 사이드 메뉴 -->
		<div class="menu_bg"></div>
		<div class="sidebar_menu">
			<!-- 사이드 메뉴 닫기 -->
			<div class="close_btn text-right">   
				<i class="fas fa-times fa-lg"></i>
			</div>
			<!-- 사이드 메뉴 닫기 끝 -->
			
			<!-- 대화 멤버 -->
			<div class="chat-member">
			
				<p class="font-weight-bold">대화 멤버</p>
				<ul class="pl-0">
					<li>
						<!-- 회원 프로필 사진 -->
						<img src="${pageContext.request.contextPath}/resources/images/blank-profile.png" alt="회원 프로필 사진" class="member-profile"/>
						<!-- 회원 닉네임 -->
						<strong>길동이1</strong>
					</li>
					<li>
						<!-- 회원 프로필 사진 -->
						<img src="${pageContext.request.contextPath}/resources/images/blank-profile.png" alt="회원 프로필 사진" class="member-profile"/>
						<!-- 회원 닉네임 -->
						<strong>길동이2</strong>
					</li>
				</ul>
				
			</div>
			<!-- 대화 멤버 끝-->
			
			<!-- 나가기 아이콘 -->
			<div class="exit position-fixed">
				<i class="fas fa-sign-out-alt fa-lg"></i>
				<span>나가기</span>
			</div>
			<!-- 나가기 아이콘 끝-->
		</div>
		<!-- 사이드 메뉴 끝 -->
		
	</div>

<script>

// 더보기 아이콘 클릭 이벤트 발생
$('.more-icon').on('click', function(){
    $('.menu_bg').show(); 
    /* $('.sidebar_menu').show().animate({
        right:0
    });  */
    $('.sidebar_menu').show().css('right', '0');
});

// 사이드 바 닫기 클릭 이벤트 발생
$('.close_btn i').on('click', function(){
    $('.menu_bg').hide(); 
    /* $('.sidebar_menu').animate({
	        right: '-' + 50 + '%'
	},function(){
	$('.sidebar_menu').hide(); 
	});  */
    $('.sidebar_menu').hide();
});

</script>

</body>
</html>

