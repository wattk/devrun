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

<!-- sock.js 추가 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.5.2/sockjs.min.js" integrity="sha512-ayb5R/nKQ3fgNrQdYynCti/n+GD0ybAhd3ACExcYvOR2J1o3HebiAe/P0oZDx5qwB+xkxuKG6Nc0AFTsPT/JDQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<!-- stomp.js 추가 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js" integrity="sha512-iKDtgDyTHjAitUDdLljGhenhPwrbBfqTKWO1mkhSFH3A7blITC9MhYon6SjnMhp4o0rADGw9yAC6EW4t5a4K3g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

<style>
.chat-room-body {
	overflow-y: hidden;
}

/* chatListPopup과 동일한 부분 확인 후 css 합칠 시 하나만 기재 */
.chat-room-wrap {
	flex-direction: column;
	/* 차이여부 확인할 것 - 메시지 입력 창 내리기 위한 과정 중 주석 처리 함 - 이거 없으면 스크롤안됨.*/
	position: fixed;
	/* 차이여부 확인할 것 - 메시지 입력 창 내리기 위한 과정 중 주석 처리 함 끝 */
    top: 0px;
    width: 100%;
    height: 100%;
}

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
	background-color: #fff;
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
	height: 42px;
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

.chat-data-wrap {
	overflow-y: auto;
    overflow-x: hidden;
    flex: 1;
}

.chat-data-wrap li {
	padding: 0.75rem 0rem;
}

.chat-data-wrap .member-profile {
    position: absolute;
	width: 42px;
	height: 42px;
	border: 1px solid #f1f3f5;
	border-radius: 50%;
	cursor: pointer;
	overflow: hidden;
    top: 0;
    left: 0;
}

.chat-data-wrap .nickname {
	font-size: 0.8rem;
	position: absolute;
    max-width: calc(100vw - var(--talk_info-padding));
    top: 2px;
    left: 0;
    line-height: 13px;
    vertical-align: top;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
}

.msg-input-data-wrap {
	flex-direction: column;
	min-height: 0;
	flex: 1;
}

.chat-room-body .receive-msg {
	overflow: hidden;
    display: inline-block;
    position: relative;
    z-index: 0;
    max-width: 100%;
    border-radius: 3px 16px 16px;
    font-size: 0.9rem;
    line-height: 1.33;
    background-color: #f4f4f4;
    word-break: break-all;
    word-break: break-word;
    word-wrap: break-word;
    vertical-align: bottom;
}


.chat-room-body .send-msg {
	overflow: hidden;
    display: inline-block;
    position: relative;
    z-index: 0;
    max-width: 100%;
    font-size: 0.9rem;
    line-height: 1.33;
    word-break: break-all;
    word-break: break-word;
    word-wrap: break-word;
    vertical-align: bottom;
    background-color: #d8ebfb;
    text-align: left;
    float: right;
    border-radius: 16px 16px 3px;
    
}


.chat-data-wrap .msg-p {
	margin: 10px 12px 9px;
}

/* 상대방 메시지 영역의 talk_info */
.receive-msg-wrap {
    position: relative;
    float: left;
    max-width: 70%;
    padding-left: 40px;
}

.receive-msg-wrap .talk-info {
	box-sizing: border-box;
    padding-top: 23px;
    margin-left: 7px;
}

.send-msg-wrap .talk-info {
	float: right;
    margin: 0;
    padding: 0;
    text-align: right;
    position: relative;
    box-sizing: border-box;
}

.receive-msg-wrap .etc {
	position: absolute;
    left: 100%;
    bottom: 0;
    min-width: 105px;
}

.send-msg-wrap .etc {
	position: absolute;
    left: auto;
    right: 100%;
    bottom: 0;
    min-width: 83px;
    line-height: 12px;
    padding-right: 10px;
}

.send-msg-wrap {
	position: relative;
	float: right;
    max-width: 70%;
}

#chatData {
	padding: 8px 16px 8px;
}

.talk-info .fa-ellipsis-v {
	color: #d0d0d0;
	width: 18px;
    text-align: center;
    cursor: pointer;
}

.report-msg {
	font-size: 0.8rem;
	color: #000;
	
}
.report-msg:hover {
	color: #000;
}
.report-dropdown-menu {
	min-width: 8rem;
}

.msg-time, .read-check {
	font-size: 0.7rem;
}

.report-block-modal .member-profile {
	width: 42px;
	height: 42px;
	border: 1px solid #f1f3f5;
	border-radius: 50%;
}

.report-block-btn {
    flex-direction: column;
}


/*신고모달창에 사용한 폰트*/
/* @font-face {
      font-family: 'SANJUGotgam';
      src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2112@1.0/SANJUGotgam.woff') format('woff');
      font-weight: normal;
      font-style: normal;
  }
@font-face {
    font-family: 'NanumSquareRound';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_two@1.0/NanumSquareRound.woff') format('woff');
    font-weight: normal;
    font-style: normal;
} */
/*신고모달창에 사용한 폰트 끝*/


/*신고 모달 css 시작*/
.report-btn{
	width: 58px;
	height: 20px;
	padding: 0 0;
	font-size: 10px;
}
.modal-header{
	background-color: #a400d9;
	color: white;
	border-bottom: 10px solid #e9ecef;
    font-family: 'SANJUGotgam';
}
.modal-body{
	font-family: 'NanumSquareRound';
}
.m-body1 >p, .m-body2 >p{
	font-weight: bold;
}
.m-body1 >div{
	background-color: rgb(209, 209, 209);;
	padding: 10px 10px;
	font-size: 13px;
	height: 150px;
	overflow-y: scroll;
	overflow-x: hidden
}
#reportId{
	font-weight: bold;
}
#reportHr{
	margin-top: 6px;
	margin-bottom: 6px;
    border-color: white;
}
.checkboxReport{
	background-color: rgb(255, 255, 255);
}
.checkboxReport >form{
	margin: auto;
}
#reportText{
	margin-top: 10px;
	resize: none;
	width: 100%;
	height: 130px;
	border-color: white;
	background-color:rgb(209, 209, 209);
}
.checkboxReport label{
	height: 3px;
}
#exampleModal {
    background: rgb(147 144 144 / 74%);
}
.modal-backdrop {
        background-color: rgba(0,0,0,.0001) !important;
}
/*신고 모달 css 끝*/

/* 채팅방에서 신고 모달 추가 css */
#exampleModal td, #memberReportModal td {
	font-size: 0.7rem;
}
/* 채팅방에서 신고 모달 추가 css 끝 */

/* 회원 신고 모달 추가 css */
#memberReportModal .m-body1 >div{
	background-color: rgb(209, 209, 209);;
	padding: 10px 10px;
	font-size: 13px;
	height: 100%;
	overflow-y: visible !important;
	overflow-x: visible !important;
}
/* 회원 신고 모달 추가 css 끝 */

</style>

</head>
<body class="chat-room-body">
	
	<div class="h-100">
	
	
		<div class="chat-room-wrap d-flex">
		
			<!-- 채팅 헤더 -->
			<div class="chat-header position-relative text-center">
				
				<!-- 채팅 상대방 닉네임 -->
				<h2 class="d-inline-block">${receiver.nickname}</h2>
				
				<div class="header-icon d-inline-block position-absolute">
	
					<!-- 더보기 아이콘 -->
					<i class="fas fa-ellipsis-h more-icon"></i>
					
				</div>
				
			</div>
			<!-- 채팅 헤더 끝 -->
			
			<!-- 메시지 대화 내역 & 메시지 보내기 영역 wrap -->
			<div class="msg-input-data-wrap d-flex">
				<!-- 메시지 대화 내역 -->
				<div class="chat-data-wrap">
					<ul class="list-group list-group-flush" id="chatData">
						
						<%-- 대화 내역 리스트 출력 시작 --%>
						<c:forEach items="${list}" var="chatLog">
						
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
									<fmt:formatDate value="${dateValue}" pattern="HH:mm" var="logTime"/>
								</c:when>
								<%-- 올해일 경우 ex. 12/22 15:00 --%>
								<c:when test="${logTimeYear eq nowYear}">
									<fmt:formatDate value="${dateValue}" pattern="MM/dd HH:mm" var="logTime"/>
								</c:when>
								<%-- 이외의 경우 ex. 2020.10.14 --%>
								<c:otherwise>
									<fmt:formatDate value="${dateValue}" pattern="yyyy.MM.dd" var="logTime"/>
								</c:otherwise>
							</c:choose>
							<%-- 조건문 끝 --%>
						
							<li class="list-group-item">
							
								<%-- 본인 메시지인 경우 --%>
								<c:if test="${chatLog.memberNo eq loginMember.memberNo}">
									<!-- 본인 메시지 -->
									<div class="send-msg-wrap">
										<div class="talk-info position-relative">
											<!-- 본인 메시지 내용 -->
											<div class="send-msg">
												<p class="msg-p">${chatLog.msg}</p>
											</div>
											<div class="etc">
												<!-- 읽음 표시 -->
												<span class="read-check d-block"><c:if test="${chatLog.lastCheck ge chatLog.logTime}">읽음</c:if></span>
												<span class="msg-time">${logTime}</span>
											</div>
											<!-- 본인 메시지 내용 끝-->
										</div>
									</div>
									<!-- 본인 메시지 끝 -->
								</c:if>
								
								<%-- 상대방 메시지인 경우 --%>
								<c:if test="${chatLog.memberNo ne loginMember.memberNo}">
									<!-- 상대방 메시지 -->
									<div class="receive-msg-wrap">
										<!-- 회원 프로필 사진 -->
										<%-- 프로필 사진 없는 경우 --%>
										<c:if test="${chatLog.member.proPhoto eq null}">
											<img src="${pageContext.request.contextPath}/resources/images/common/blank-profile.png" alt="회원 프로필 사진" class="member-profile" data-toggle="modal" data-target="#reportBlockModal"/>
										</c:if>
										<%-- 프로필 사진 있는 경우 --%>
								      	<c:if test="${chatLog.member.proPhoto ne null}">
								      		<img src="${pageContext.request.contextPath}/resources/upload/profilePhoto/${chatLog.member.proPhoto}" alt="회원 프로필 사진" class="member-profile" data-toggle="modal" data-target="#reportBlockModal"/>	
								      	</c:if>

										<div class="talk-info position-relative">
											<!-- 회원 닉네임 -->
											<strong class="nickname d-inline-block">${chatLog.member.nickname}</strong>
											<!-- 상대방 메시지 내용 -->
											<div class="receive-msg">
												<p class="msg-p">${chatLog.msg}</p>
											</div>
											<div class="etc">
												<!-- 메시지 신고하기 - 클릭 시 옆으로 드롭다운 만들기 -->
												<i class="fas fa-ellipsis-v" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"></i>
												
												<div class="dropdown-menu report-dropdown-menu">
													<a href="#" class="report-msg d-block text-center" data-toggle="modal" data-target="#exampleModal">메시지 신고하기</a>
												</div>
												
												<span class="msg-time">${logTime}</span>
												
											</div>
											<!-- 상대방 메시지 내용 끝-->
										</div>	
									</div>
									<!-- 상대방 메시지 끝 -->
								</c:if>
								
							</li>
							
						</c:forEach>
						<%-- 대화 내역 리스트 출력 끝 --%>	
							
					</ul>
				</div>
				<!-- 메시지 대화 내역 끝 -->
			
				<!-- 메시지 보내기 -->
				<div class="input-group msg-input-group">
				  <input type="text" id="message" class="form-control" placeholder="메시지를 입력하세요.">
				  <div class="input-group-append" style="padding: 0px;">
				    <button id="sendBtn" class="btn btn-outline-secondary" type="button">Send</button>
				  </div>
				</div>
				<!-- 메시지 보내기 끝 -->
	
			</div>
			
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
							<%-- 프로필 사진 없는 경우 --%>
							<c:if test="${loginMember.proPhoto eq null}">
								<img src="${pageContext.request.contextPath}/resources/images/common/blank-profile.png" alt="회원 프로필 사진" class="member-profile"/>
							</c:if>
							<%-- 프로필 사진 있는 경우 --%>
					      	<c:if test="${loginMember.proPhoto ne null}">
					      		<img src="${pageContext.request.contextPath}/resources/upload/profilePhoto/${loginMember.proPhoto}" alt="회원 프로필 사진" class="member-profile"/>	
					      	</c:if>
							<!-- 회원 닉네임 -->
							<strong>${loginMember.nickname}</strong>
						</li>
						<li>
							<!-- 회원 프로필 사진 -->
							<%-- 프로필 사진 없는 경우 --%>
							<c:if test="${receiver.proPhoto eq null}">
								<img src="${pageContext.request.contextPath}/resources/images/common/blank-profile.png" alt="회원 프로필 사진" class="member-profile"/>
							</c:if>
							<%-- 프로필 사진 있는 경우 --%>
					      	<c:if test="${receiver.proPhoto ne null}">
					      		<img src="${pageContext.request.contextPath}/resources/upload/profilePhoto/${receiver.proPhoto}" alt="회원 프로필 사진" class="member-profile"/>	
					      	</c:if>
							<!-- 회원 닉네임 -->
							<strong>${receiver.nickname}</strong>
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
	
	</div>
	
	
	<!-- 상대방 프로필 사진 클릭 시 Modal -->
	<div class="modal fade report-block-modal" id="reportBlockModal" tabindex="-1" role="dialog" aria-labelledby="reportBlockModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered" role="document">
	    <div class="modal-content">
	      <div class="modal-body">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	        <!-- 회원 프로필 사진 -->
			<%-- 프로필 사진 없는 경우 --%>
			<c:if test="${receiver.proPhoto eq null}">
				<img src="${pageContext.request.contextPath}/resources/images/common/blank-profile.png" alt="회원 프로필 사진" class="member-profile"/>
			</c:if>
			<%-- 프로필 사진 있는 경우 --%>
	      	<c:if test="${receiver.proPhoto ne null}">
	      		<img src="${pageContext.request.contextPath}/resources/upload/profilePhoto/${receiver.proPhoto}" alt="회원 프로필 사진" class="member-profile"/>	
	      	</c:if>
			<!-- 닉네임 -->
			<strong>${receiver.nickname}</strong>
			<!-- 아이디 -->
			<span>
      			<!-- 아이디의 앞 4자리까지 보여 주고 5자리부터 id의 길이만큼 *를 찍어줌 -->
      			(${fn:substring(receiver.id,0,4) }<c:forEach begin="5" end="${fn:length(receiver.id)}" step="1">*</c:forEach>)
      		</span>
			<div class="text-center d-flex report-block-btn mt-4 my-3">
				<button type="button" class="btn btn-secondary d-block member-report-btn mb-3" data-toggle="modal" data-target="#memberReportModal">회원 신고하기</button>
				<button type="button" class="btn btn-secondary d-block block-btn">차단하고 나가기</button>
			</div>
	      </div>
	    </div>
	  </div>
	</div>
	<!-- 상대방 프로필 사진 클릭 시 Modal 끝 -->

	<div>
        <!--메시지 신고 모달 시작 (부트스트랩)-->
        <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">신고하기</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                </div>
                <div class="modal-body">
                    <div class="m-body1">
                        <p>신고대상 ID 및 내용</p>
                        <div>
                            <span id="reportId">해당 ID : </span> watt0930
                            <hr id="reportHr">
                            <p style="font-weight: bold;">신고 대상 글  </p>
                            <span>그지같은깽깽이야 이삐리리삐리리 Lorem ipsum dolor sit amet consectetur adipisicing elit. Nostrum mollitia quo dolorum nobis ut unde commodi blanditiis! Distinctio adipisci quidem, repellendus eum cupiditate at sunt ab iste, voluptates, aperiam alias!</span>
                        </div>
                    </div>
                    <div class="m-body2 mt-3">
                        <p>신고사유</p>
                        <div class="checkboxReport">
                            <form action="#">
                                <table>
                                    <tr>
                                        <td>
                                            <input type="radio" id="check1" name="chch">
                                            <label for="check1">욕설/비방 &emsp;&emsp;&emsp;&emsp;</label>
                                        </td>
                                        <td>
                                            <input type="radio" id="check2" name="chch">
                                            <label for="check2">광고/홍보글</label>
                                        </td>
                                        <td>
                                            <input type="radio" id="check3" name="chch">
                                            <label for="check3">음란/선정성</label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <input type="radio" id="check4" name="chch">
                                            <label for="check4">게시글도배</label>
                                        </td>
                                        <td>
                                            <input type="radio" id="check5" name="chch">
                                            <label for="check5">관련없는 이미지/내용 &emsp;&nbsp; &nbsp; </label>
                                        </td>
                                        <td>													
                                            <input type="radio" id="check6" name="chch">
                                            <label for="check6">기타</label>
                                        </td>
                                    </tr>
                                </table>
                                <textarea name="" id="reportText" cols="30" rows="10"></textarea>
                            </form>
                            <p style="font-size: 12px;">ⓘ 신고해주신 내용은 관리자 검토 후 내부정책에 의거 조치가 진행됩니다.</p>
                        </div>
                    </div>
                </div>
                <div class="modal-footer justify-content-center">
                <button type="button" class="btn btn-primary col-4">신고하기</button>
                <button type="button" class="btn btn-secondary col-4" data-dismiss="modal">취소하기</button>
                </div>
            </div>
            </div>
        </div>
		<!--메시지 신고 모달 끝 (부트스트랩)-->
    </div>
    
    
    
    <div>
        <!--회원 신고 모달 시작 (부트스트랩)-->
        <div class="modal fade" id="memberReportModal" tabindex="-1" role="dialog" aria-labelledby="memberReportModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                <h5 class="modal-title" id="memberReportModalLabel">신고하기</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                </div>
                <div class="modal-body">
                    <div class="m-body1">
                        <p>신고대상 ID</p>
                        <div>
                            <span id="reportId">해당 ID : </span> watt0930
                        </div>
                    </div>
                    <div class="m-body2 mt-3">
                        <p>신고사유</p>
                        <div class="checkboxReport">
                            <form action="#">
                                <table>
                                    <tr>
                                        <td>
                                            <input type="radio" id="check1" name="chch">
                                            <label for="check1">욕설/비방 &emsp;&emsp;&emsp;&emsp;</label>
                                        </td>
                                        <td>
                                            <input type="radio" id="check2" name="chch">
                                            <label for="check2">광고/홍보글</label>
                                        </td>
                                        <td>
                                            <input type="radio" id="check3" name="chch">
                                            <label for="check3">음란/선정성</label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <input type="radio" id="check4" name="chch">
                                            <label for="check4">게시글도배</label>
                                        </td>
                                        <td>
                                            <input type="radio" id="check5" name="chch">
                                            <label for="check5">관련없는 이미지/내용 &emsp;&nbsp; &nbsp; </label>
                                        </td>
                                        <td>													
                                            <input type="radio" id="check6" name="chch">
                                            <label for="check6">기타</label>
                                        </td>
                                    </tr>
                                </table>
                                <textarea name="" id="reportText" cols="30" rows="10"></textarea>
                            </form>
                            <p style="font-size: 12px;">ⓘ 신고해주신 내용은 관리자 검토 후 내부정책에 의거 조치가 진행됩니다.</p>
                        </div>
                    </div>
                </div>
                <div class="modal-footer justify-content-center">
                <button type="button" class="btn btn-primary col-4">신고하기</button>
                <button type="button" class="btn btn-secondary col-4" data-dismiss="modal">취소하기</button>
                </div>
            </div>
            </div>
        </div>
		<!--회원 신고 모달 끝 (부트스트랩)-->
    </div>

<script>

// /chat/chat_mk0L0UJ93P50409 구독
// 1. Stomp Client객체 생성(websocket)
const ws = new SockJS(`http://\${location.host}${pageContext.request.contextPath}/stomp`);
const stompClient = Stomp.over(ws);

// 2. 연결 요청
stompClient.connect({}, (frame) => {
	console.log("Stomp Client Connect : ", frame);
	
	// 3.구독요청
	stompClient.subscribe("/chat/${chatId}", (message) => {
		console.log("message : ", message);
		const obj = JSON.parse(message.body);
		console.log("obj = ", obj);
		const {memberNo, member: {id : id, nickname : nickname, proPhoto : proPhoto}, msg, logTime, lastCheck} = obj;

		// 타임스탬프 날짜 변환 // 채팅 보낸 시간은 당일이므로 시간만 전달 ex) 15:00
		const date = new Date(logTime);
		//const year = date.getFullYear().toString().slice(-2); //년도 뒤에 두자리
		//const month = ("0" + (date.getMonth() + 1)).slice(-2); //월 2자리 (01, 02 ... 12)
		//const day = ("0" + date.getDate()).slice(-2); //일 2자리 (01, 02 ... 31)
		const hour = ("0" + date.getHours()).slice(-2); //시 2자리 (00, 01 ... 23)
		const minute = ("0" + date.getMinutes()).slice(-2); //분 2자리 (00, 01 ... 59)
		//const second = ("0" + date.getSeconds()).slice(-2); //초 2자리 (00, 01 ... 59)
		const returnDate = hour + ":" + minute;
		//console.log(returnDate);
		
		// 프로필 사진 분기 처리
		const photo = (!proPhoto) ? 
				'${pageContext.request.contextPath}/resources/images/common/blank-profile.png' : 
				'${pageContext.request.contextPath}/resources/upload/profilePhoto/' + proPhoto;

		/* loginMember의 memberNo의 따른 수신자 발신자 분기 처리 */
		//console.log("memberNo = ", memberNo);
		//console.log("loginMember의 memberNo = ", ${loginMember.memberNo});
		if(memberNo == ${loginMember.memberNo}) {
			//console.log("발신한 사용자군요!");
			$(chatData).append(`<li class="list-group-item">
<!-- 본인 메시지 -->
<div class="send-msg-wrap">
<div class="talk-info position-relative">	
<!-- 본인 메시지 내용 -->
<div class="send-msg">
<p class="msg-p">\${msg}</p>
</div>
<div class="etc">
<!-- 읽음 표시 -->
<span class="read-check d-block"></span>
<span class="msg-time">\${returnDate}</span>
</div>
<!-- 본인 메시지 내용 끝-->
</div>
</div>
<!-- 본인 메시지 끝 -->
</li>`);
		} else {
			//console.log("수신한 사용자군요!");
			$(chatData).append(`<li class="list-group-item">		
<!-- 상대방 메시지 -->
<div class="receive-msg-wrap">
<!-- 회원 프로필 사진 -->
<img src="\${photo}" alt="회원 프로필 사진" class="member-profile" data-toggle="modal" data-target="#reportBlockModal"/>

<div class="talk-info position-relative">
<!-- 회원 닉네임 -->
<strong class="nickname d-inline-block">\${nickname}</strong>
<!-- 상대방 메시지 내용 -->
<div class="receive-msg">
<p class="msg-p">\${msg}</p>
</div>
<div class="etc">
<!-- 메시지 신고하기 - 클릭 시 옆으로 드롭다운 만들기 -->
<i class="fas fa-ellipsis-v" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"></i>
<div class="dropdown-menu report-dropdown-menu">
<a href="#" class="report-msg d-block text-center" data-toggle="modal" data-target="#exampleModal">메시지 신고하기</a>
</div>
<span class="msg-time">\${returnDate}</span>
</div>
<!-- 상대방 메시지 내용 끝-->
</div>	
</div>
<!-- 상대방 메시지 끝 -->
</li>`);	
			
		}
		/* loginMember의 memberNo의 따른 수신자 발신자 분기 처리 끝 */
		
		// 채팅 입력된 후 최근 내용 확인을 위해 스크롤 하단으로 이동 시키기
		$('.chat-data-wrap').scrollTop($('.chat-data-wrap')[0].scrollHeight);
	});
	
	// 팝업생성, stompClient가 연결되면 chat_member.last_check컬럼을 update한다.
	// 위치주의 : connect된 이후 호출되어야한다.
// 	lastCheck(); 

	// 구독요청 - 읽음 상태 처리
	stompClient.subscribe("/chat/readStatus/${chatId}", (message) => {
		//console.log("message : ", message);
		const obj = JSON.parse(message.body);
		//console.log("readStatus 구독의 obj = ", obj);
		var {chatId, memberNo, readStatus} = obj;
		const $readCheckSpan = $(".send-msg-wrap").find("span.read-check");
		
		// 상대가 읽음 상태라면 span.read-check 부분 text('읽음') 상태로 변환
		if(memberNo != ${loginMember.memberNo} && readStatus == "READ") {
			$readCheckSpan.text('읽음');
		}
		
		
	});
});

console.log("interval첫시작!")
var interval = setInterval(callback, 1000);

function callback(){
	//console.log("콜백시작!")
	readStatus("READ");
}

/**
 * 팝업창이 활성화(focus)되면 chat_member.last_check컬럼을 update한다.
 */
// 다른곳 갔다가 팝업 페이지로 포커스를 다시 할 때에도 chat_member.last_check컬럼을 update되어야 한다.
$(window).focus((e) => {
	console.log("WINDOW FOCUS");
//	lastCheck();
	console.log("interval재시작!")
	interval = setInterval(callback, 1000);
});

/**
 * 팝업창 포커스 잃었을 경우 이벤트 발생, setInterval 중단
 */
$(window).blur((e) => {
	console.log("WINDOW BLUR");
	console.log("interval중단요청!")
	clearInterval(interval);
	readStatus("UNREAD");
});

/**
 * 윈도우창 닫을 때 이벤트 발생, setInterval 중단
 */
$(window).on("beforeunload", function() {
	console.log("interval중단요청!")
	clearInterval(interval);
	return readStatus("UNREAD");
});

// 채팅 Send 클릭 시 이벤트 발생
$(sendBtn).click((e) => {
	
	if(!$(message).val()) return; // 유효성 검사
	
	const member = {
		nickname : "${loginMember.nickname}",
		id : "${loginMember.id}",
		proPhoto : "${loginMember.proPhoto}"
	};
	
	const obj = {
		chatId : "${chatId}",
		memberNo : "${loginMember.memberNo}",
		member : member,
		msg : $(message).val(),
		logTime : Date.now(),
		type: "MESSAGE"
	};
	console.log(obj);
	stompClient.send("/app/chat/${chatId}", {}, JSON.stringify(obj));
	$(message).val(''); // #message 초기화
});

// 메시지 입력 시 엔터 치면 click 핸들러 호출
$(message).keyup((e) => {
	// 엔터치면 전송하게 해주세요.
	if(e.keyCode == 13){
		$(sendBtn).trigger('click'); // click 핸들러 호출!
	}
});

/**
 * 채팅방 마지막 확인시각을 메시지로 발행 -> db chat_member.last_check update
 */
/* const lastCheck = () => {
	let data = {
		chatId : "${chatId}",
		memberNo : "${loginMember.memberNo}",
		lastCheck : Date.now(),
		type : "LAST_CHECK"
	};
	
	stompClient.send("/app/lastCheck", {},JSON.stringify(data));
		
}; */

/**
 * 채팅방 마지막 확인시각과 읽고 있는지 여부 메시지로 발행 -> 채팅방 읽음 처리 체크를 위함 + 기존 lastCheck 처리한 일 추가함
 */
const readStatus = (status) => {
	let data = {
		chatId : "${chatId}",
		memberNo : "${loginMember.memberNo}",
		lastCheck : Date.now(),
		readStatus : status,
		type : "READ_STATUS"
	};
	
	stompClient.send("/app/chat/readStatus/${chatId}", {},JSON.stringify(data));
};

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


// '차단하고 나가기' 클릭 시 이벤트 발생 - 기능 구현 추가할 것
$('.block-btn').click((e) => {
	console.log("안녕!");
	confirm(`대화를 차단하시겠습니까?
기존 대화 내용이 삭제되고, 
채팅방에서 자동으로 나가게 됩니다.`);
});

//'나가기' 클릭 시 이벤트 발생 - 기능 구현 추가할 것
$('.exit').click((e) => {
	console.log("안녕!");
	confirm(`채팅방을 나가시겠습니까?
대화방은 목록에서 삭제되고 대화 내용을 다시 볼 수 없습니다.`);
});

</script>

</body>
</html>

