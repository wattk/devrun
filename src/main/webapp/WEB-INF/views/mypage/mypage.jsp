<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<jsp:include page="/WEB-INF/views/mypage/common/header.jsp">
	<jsp:param value="마이페이지" name="title"/>
</jsp:include>

<!-- CSS import -->
<link href="${pageContext.request.contextPath}/resources/css/mypage/mypage.css" rel="stylesheet">

<%-- EL에서 접근하기 위해 VAR속성 지정 --%>
<sec:authentication property="principal" var="member"/>

			<%-- my page --%>
			<div id="mypage" class="col-12">
				<div class="row">
					
					<!-- member profile -->
					<article id="profile" class="col-3">
						<!-- profile image : 프로필 이미지가 null일 경우, 기본 이미지 출력 -->
					    <section>
				   			<c:if test="${member.proPhoto eq null}"><img src="${pageContext.request.contextPath}/resources/images/common/blank-profile.png" alt="" id="profileImg"/></c:if>
							<c:if test="${member.proPhoto ne null}"><img src="${pageContext.request.contextPath}/resources/upload/profilePhoto/${member.id}.png" alt="" id="profileImg"/></c:if>
					       	<p class="cursor" onclick="location.href='${pageContext.request.contextPath}/mypage/myinfo.do';">${member.nickname}님<i class="bi bi-chevron-right"></i></p>
					       	<img src="https://i.ibb.co/HNQhz98/pencil.png" alt="" id="edit" class="cursor" onclick="location.href='${pageContext.request.contextPath}/mypage/myinfo/profileUpdate.do';"/>
					    	<img src="https://i.ibb.co/S7TZCYh/coding.png" alt="" id="badge" class="cursor" onclick="location.href='${pageContext.request.contextPath}/mypage/myinfo/activityBadge.do';"/>
					    </section>
					    <!-- profile info -->
				        <section>
				        	<!-- 이메일 -->
				        	<p>
				        		<span>이메일</span><br/>
				        		<span>
					        		<c:if test="${member.email eq null}">-</c:if>
					        		<c:if test="${member.email ne null}">${member.email}</c:if>
				        		</span>
				        	</p>
				        	<!-- 한줄소개 -->
					        <p>
					        	<span>한줄소개</span><br/>
					        	<span>
					        		<c:if test="${member.intro eq null}">-</c:if>
					        		<c:if test="${member.intro ne null}">${member.intro}</c:if>
					        	</span>
					        </p>
					        <!-- 개인 웹 주소 -->
					        <c:if test="${member.url eq null}"><button id="url">아직 개인주소가 없습니다.</button></c:if>
					        <c:if test="${member.url ne null}"><button id="url" onclick="location.href='${member.url}';">${member.url}</button></c:if>
				        </section>
				        <hr/>
				       	<!-- logout button -->
				       	<section>
				       		<form:form
					    		method="POST"
					    		action="${pageContext.request.contextPath}/member/memberLogout.do">
					        	<button type="submit" class="col-9 cursor">로그아웃</button>
				        	</form:form>
				       	</section>
			    	</article>
				     	
		      		<!-- member info -->
			   		<article class="col-9">
		    			<!-- member grade info : total attendance, activity grade, activity badge -->
		       			<section id="myGrade" class="card">
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
			       			
		       			<!-- member activity info : chat, point -->
		       			<section id="myShopping" class="activity row cursor">
		       				<span class="col-6 row" onclick="chatList();">
				       			<span class="bi bi-envelope"> &nbsp; 채팅</span>
				       			<span>${totalUnreadCount}건<i class="bi bi-chevron-right"></i></span>
			       			</span>
		       				<span class="col-6 row" onclick="location.href='${pageContext.request.contextPath}/mypage/myPoint.do';">
					       		<span class="bi bi-coin"> &nbsp; 포인트</span>
					       		<span>사용 가능 ${member.point}포인트<i class="bi bi-chevron-right"></i></span>
				       		</span>
		       			</section>
		       			<!-- member activity info : wishList -->
		       			<section id="myChat" class="activity col-6 row cursor">
			       			<span class="col-12 row" onclick="location.href='${pageContext.request.contextPath}/member/wishlist.do';">
					       		<span class="bi bi-bookmark"> &nbsp; 관심 상품</span>
					       		<i class="bi bi-chevron-right"></i>
				       		</span>
		       			</section>
		       			<!-- member activity info : postList, likeList -->
		       			<h5>나의 활동</h5>
		       			<section id="myActivity" class="activity row cursor">
				       		<span class="col-6 row" onclick="location.href='${pageContext.request.contextPath}/mypage/mycommunity/postList.do';">
					       		<span class="bi bi-journal-text"> &nbsp; 내가 쓴 글</span>
					       		<i class="bi bi-chevron-right"></i>
				       		</span>
				       		<span class="col-6 row" onclick="location.href='${pageContext.request.contextPath}/mypage/mycommunity/likeList.do';">
		       					<span class="bi bi-heart"> &nbsp; 좋아요</span>
				       			<i class="bi bi-chevron-right"></i>
		       				</span>
		       			</section>
		       			<!-- event : 최근 이벤트 한개 불러오기 -->
		    	  		<section id="eventBanner" class="row">
		      				<img src="${pageContext.request.contextPath}/resources/upload/promotion/${promotion.promotionCode}.png" alt="" id="profileImg" class="col-12"/>
			       		</section>
			    	</article>
			    	
				</div>
			</div>

<jsp:include page="/WEB-INF/views/mypage/common/footer.jsp"></jsp:include>
