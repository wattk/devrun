<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<jsp:include page="/WEB-INF/views/mypage/common/header.jsp">
	<jsp:param value="프로필 수정" name="title"/>
</jsp:include>

<!-- CSS import -->
<link href="${pageContext.request.contextPath}/resources/css/mypage/profileUpdate.css" rel="stylesheet">

<%-- EL에서 접근하기 위해 VAR속성 지정 --%>
<sec:authentication property="principal" var="member"/>

		<div class="col-12" id="profileUpdate">
			<div class="row">
			
				<article class="col-10" id="info">
		      		<h4 id="breadcrumb"><a href="${pageContext.request.contextPath}/mypage/myinfo.do">나의 정보</a> <i class="bi bi-chevron-right"></i> <span>프로필 수정</span></h4>
		       		<hr/>
		       		<%-- my profile --%>
		       		<section class="card" id="myProfile">
		       			<div class="card-header">내 프로필</div>
		       			<div class="card-body">
		       				<form name="profileUpdateFrm" action="${pageContext.request.contextPath}/mypage/myinfo/profileUpdate.do" method="POST">
			       				<div class="row">
			       					<%-- profile image : 프로필 이미지가 null일 경우, 기본 이미지 출력 --%>
				       				<article class="col-4">
				     					<c:if test="${member.proPhoto eq null}"><i class="bi bi-person-circle" id="profileImg"></i></c:if>
								      	<c:if test="${member.proPhoto ne null}"><img src="${member.proPhoto}" alt="" id="profileImg"/></c:if>
								       	<input type="file" class="form-control" id="edit" name="proPhoto">
			       					</article>
			       					<%-- profile info --%>
			       					<article class="col-7">
			       						<%-- profile info --%>
			       						<section id="profileInfo">
				       						<div>
				       							<label for="email">이메일</label>
				       							<input type="email" class="form-control" id="email" name="email" value="${member.email}">
				       						</div>
				       						<div>
				       							<label for="url">개인 사이트</label>
				       							<input type="text" class="form-control" id="url" name="url" value="${member.url}">
				       						</div>
				       						<div>
				       							<label for="intro">한줄소개</label>
				       							<textarea class="form-control" id="intro" name="intro">${member.intro}</textarea>
				       						</div>
			       						</section>
								        <hr/>
								        <%-- personal info --%>
								        <table id="personalInfo">
								        	<tr>
								        		<td><label for="id">아이디</label></td>
								        		<td><input type="text" class="form-control" id="id" name="id" value="${member.id}" readonly required></td>
								        	</tr>
								        	<tr>
								        		<td><label for="password">기존 비밀번호</label></td>
								        		<td><input type="password" class="form-control" id="password" name="password" required></td>
								        	</tr>
								        	<tr>
								        		<td><label for="newPassword">새 비밀번호</label></td>
								        		<td><input type="password" class="form-control" id="newPassword" required></td>
								        	</tr>
								        	<tr>
								        		<td><label for="nickname">닉네임</label></td>
								        		<td><input type="text" class="form-control" id="nickname" name="nickname" value="${member.nickname}" required></td>
								        	</tr>
								        	<tr>
								        		<td><label for="name">이름</label></td>
								        		<td><input type="text" class="form-control" id="name" name="name" value="${member.name}" required></td>
								        	</tr>
								        	<tr>
								        		<td><label for="birthday">생년월일</label></td>
								        		<td><input type="date" class="form-control" id="birthday" name="birthday" value="<fmt:formatDate value="${member.birthday}" pattern="yyyy-MM-dd"/>" maxlength="11" required></td>
								        	</tr>
								        	<tr>
								        		<td><label for="phone">전화번호</label></td>
								        		<td><input type="tel" class="form-control" id="phone" name="phone" value="${member.phone}" maxlength="11" required></td>
								        	</tr>
								        </table>
			       					</article>
		    					</div>
		    					<%-- buttons : withdraw / update --%>
		    					<section id="btns" class="col-11 row">
		    						<button class="col-6" type="button" data-toggle="modal" data-target="#withdrawModal">탈퇴하기</button>
		    						<button class="col-6" type="submit" onclick="location.href='${pageContext.request.contextPath}/mypage/myinfo/profileUpdate.do';">수정하기</button>
		    					</section>
	    					</form>
	       				</div>
	       			</section>
	       		</article>

			</div>
		</div>
		
		</section>
		
		<%-- withdraw modal --%>
		<div class="modal fade" id="withdrawModal" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
			<div class="modal-dialog modal-lg">
		    	<div class="modal-content">
		      		<section class="modal-header">
		      			<div class="row col-12" id="title">
		      				<h5 class="modal-title" id="staticBackdropLabel">회원탈퇴</h5>
		      			</div>
		        		<i class="bi bi-x" data-dismiss="modal"></i>
		      		</section>
		      		<section class="modal-body">
			      		<div>
				      		<h5>탈퇴 시 유의사항</h5>
			      			<p>회원탈퇴 시 개인정보 및 데브런에서 만들어진 모든 데이터는 보관됩니다.</p>
			      		</div>
		      			<div>
			      			<h5>데브런을 탈퇴하시는 이유는 무엇인가요?</h5>
			      			<p>데브런을 탈퇴하는 이유를 알려주시면 보다 좋은 서비스 제공을 위해 노력하겠습니다.</p>
			      			<select class="custom-select" required>
								<option disabled selected>탈퇴사유를 선택하세요</option>
							  	<option value="1">아이디 변경 / 재가입 목적</option>
							  	<option value="2">사생활 기록 삭제 목적</option>
							  	<option value="3">서비스 기능 불편</option>
							  	<option value="4">개인정보 및 보안 우려</option>
							  	<option value="5">데브런 이용 안 함</option>
							  	<option value="6">기타</option>
							</select>
		      			</div>
		      			<div class="form-check">
							<input class="form-check-input" type="checkbox" value="" id="agreementCheckbox" required>
						  	<label class="form-check-label" for="agreementCheckbox">
						    	해당 내용을 모두 확인하였으며, 회원탈퇴에 동의합니다.
						  	</label>
						</div>
		      			<div id="withdrawBtn" class="row">
		      				<button type="submit" class="col-4" onclick="location.href='${pageContext.request.contextPath}/mypage/myinfo/withdrawal.do';">회원탈퇴</button>
		      			</div>
		      		</section>
		    	</div>
		  	</div>
		</div>		

    </article>
</main>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>