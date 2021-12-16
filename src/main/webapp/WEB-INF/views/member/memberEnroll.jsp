<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="회원가입" name="title"/>
</jsp:include>
<style>
.guide{
	display:none;
}
#member-enroll-container{
	border: 1px solid #000;
	margin-top : 200px;
	width : 450px;
	height : 650px;
}
#member-enroll-table th{
	padding: 10px 5px;
}
#member-enroll-table input:not([type="checkbox"]){
	width : 100%;
}
</style>
<div id="member-enroll-container" class="mx-auto text-center">
	<form action="${pageContext.request.contextPath}/member/memberEnroll.do" name="memberEnrollFrm" method="post">
		<h1 class="text-brand mt-3">Dev<span class="color-b">Run</span></h1>
		<table id="member-enroll-table" class="mx-auto">
			<tr>
				<th>아이디</th>
				<td>
					<div id="memberId-container">
						<input type="text" name="id" id="id" placeholder="4글자 이상" required/>
						<span class="guide ok">사용 가능한 아이디입니다.</span>
						<span class="guide error">사용 중인 아이디입니다.</span>
						<input type="hidden" name="idValid" value="0" />
					</div>
				</td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td>
					<input type="password" name="password" id="password" required/>
				</td>
			</tr>
			<tr>
				<th>비밀번호 확인</th>
				<td>
					<input type="password" name="password" id="passwordCheck" required/>
				</td>
			</tr>
			<tr>
				<th>이름</th>
				<td>
					<input type="text" name="name" id="name" />
				</td>
			</tr>
			<tr>
				<th>닉네임</th>
				<td>
					<input type="text" name="nickname" id="nickname" />
				</td>
			</tr>
			<tr>
				<th>생일</th>
				<td>
					<input type="date" name="birthday" id="birthday" />
				</td>
			</tr>
			<tr>
				<th>이메일</th>
				<td>
					<input type="email" name="email" id="email" />
				</td>
			</tr>
			<tr>
				<th>연락처</th>
				<td>
					<input type="tel" name="phone" id="phone" />
				</td>
			</tr>
			<tr>
				<td colspan="2" class="text-left">
				  <input type="checkbox" id="check_all" class="">
				  <label for="check_all" class="">전체 동의</label>
				</td>
			</tr>
			<tr>
				<td colspan="2" class="text-left">
				  <input type="checkbox" id="check_1" class="normal" >
				  <label for="check_1">개인정보 처리방침 동의</label>
				</td>
			</tr>
			<tr>
				<td colspan="2" class="text-left">
				  <input type="checkbox" id="check_2" class="normal" >
				  <label for="check_2">서비스 이용약관 동의</label>
				</td>
			</tr>
			<tr>
				<td colspan="2" class="text-left">
				  <input type="checkbox" id="check_3" class="normal" name="smsYn">
				  <label for="check_3">마케팅 수신 동의</label>
				</td>
			</tr>
		</table>
		<button type="button" class="btn btn-primary">가입</button>
		<button type="button" class="btn btn-primary">취소</button>
	</form>
</div>
<script>

$(id).keyup((e)=>{
	const $id = $(e.target);
	const $error = $(".guide.error");
	const $ok = $(".guide.ok");
	const $idValid = $(idValid);
	
	
})
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
