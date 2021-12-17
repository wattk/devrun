<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>	
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="회원가입" name="title"/>
</jsp:include>
<link href="${pageContext.request.contextPath }/resources/css/member/member.css" rel="stylesheet">
<script src="${pageContext.request.contextPath }/resources/js/member/member.js"></script>
<div class="mx-auto text-center">
	<h1 class="text-brand pt-3 enroll-head">Dev<span class="color-b">Run</span></h1>
	<span class="font-weight-light pb-3 d-block">더 나은 개발라이프를 위한 적절한 해결책</span>
</div>
<div id="memberEnrollContainer" class="mx-auto text-center">
	<form:form action="${pageContext.request.contextPath}/member/memberEnroll.do" name="memberEnrollFrm" method="post" class="p-3">
		<table id="memberEnrollTbl" class="mx-auto">
			<tr>
				<th>아이디<sup class="text-danger">*</sup></th>
				<td>
					<div id="memberId-container">
						<input type="text" name="id" id="id" placeholder="4글자 이상" class="duplicate-check" required/>
						<div class="guide-box">
							<span class="guide id-guide ok">사용 가능한 아이디입니다.</span>
							<span class="guide id-guide error text-danger">사용할 수 없는 아이디입니다.</span>
							<span class="guide id-guide duplicate text-danger">중복된 아이디입니다.</span>
							<input type="hidden" id="idValid" value="0" />
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<th>비밀번호<sup class="text-danger">*</sup></th>
				<td>
					<input type="password" name="password" id="password" required/>
				</td>
			</tr>
			<tr>
				<th>비밀번호 확인<sup class="text-danger">*</sup></th>
				<td>
					<div>
						<input type="password" name="passwordCheck" id="passwordCheck" required/>
						<div class="guide-box">
							<span class="guide password-guide ok">사용 가능한 비밀번호입니다.</span>
							<span class="guide password-guide error text-danger">비밀번호가 일치하지 않습니다.</span>
							<input type="hidden" id="passwordValid" value="0" />
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<th>이름<sup class="text-danger">*</sup></th>
				<td>
					<input type="text" name="name" id="name" required/>
					<div class="guide-box">
						<span class="guide name-guide error text-danger">이름을 입력해 주세요.</span>
					</div>
				</td>
			</tr>
			<tr>
				<th>닉네임<sup class="text-danger">*</sup></th>
				<td>
					<div>
						<input type="text" name="nickname" id="nickname" class="duplicate-check" required/>
						<div class="guide-box">
							<span class="guide nickname-guide ok">사용 가능한 닉네임입니다.</span>
							<span class="guide nickname-guide error text-danger">사용할 수 없는 닉네임입니다.</span>
							<span class="guide nickname-guide duplicate text-danger">중복된 닉네임입니다.</span>
							<input type="hidden" id="nicknameValid"  value="0" />
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<th>생년월일<sup class="text-danger">*</sup></th>
				<td>
					<input type="date" name="birthday" id="birthday" required/>
					<div class="guide-box">
						<span class="guide birthday-guide error text-danger">생일을 입력해 주세요.</span>
					</div>
				</td>
			</tr>
			<tr>
				<th>이메일<sup class="text-danger">*</sup></th>
				<td>
					<div>
						<input type="email" name="email" id="email" class="duplicate-check" required/>
						<div class="guide-box">
							<span class="guide email-guide ok">사용 가능한 이메일입니다.</span>
							<span class="guide email-guide error text-danger">사용할 수 없는 이메일입니다.</span>
							<span class="guide email-guide duplicate text-danger">중복된 이메일입니다.</span>
							<input type="hidden" id="emailValid" value="0" />
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<th>연락처<sup class="text-danger">*</sup></th>
				<td>
					<input type="tel" name="phone" id="phone" placeholder="(-없이)01012345678" required/>
					<div class="guide-box">
						<span class="guide phone-guide error text-danger">연락처를 입력해 주세요.</span>
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="2" class="text-left checkbox-group">
				  <input type="checkbox" id="checkAll" >
				  <label for="checkAll" class="">전체 동의</label>
				  <br />
				  <input type="checkbox" id="check1" class="normal" >
				  <label for="check1"><span class="text-danger">(필수)</span>개인정보 처리방침 동의</label>
				  <br />
				  <input type="checkbox" id="check2" class="normal" >
				  <label for="check2"><span class="text-danger">(필수)</span>서비스 이용약관 동의</label>
				  <br />
				  <input type="checkbox" id="check3" class="normal" name="smsYn" value="Y">
				  <label for="check3"><span>(선택)</span>마케팅 수신 동의</label>
				</td>
			</tr>
		</table>
		<hr />
		<button type="button" id="memberEnrollBtn" class="btn btn-primary">가입</button>
		<button type="button" id="memberEnrollCancelBtn" class="btn btn-primary">취소</button>
	</form:form>
</div>
<script>
//아이디, 닉네임, 이메일 유효성 검사 & 중복 검사
$(".duplicate-check").keyup((e)=>{
	const $target = $(e.target);
	const val = $target.prop("id");
	
	//입력값이 공란이면 안내문 숨기기
	if($target.val() == ''){
		$(".guide").hide();
		return;
	}
	
	const $error = $(`.\${val}-guide.error`);
	const $ok = $(`.\${val}-guide.ok`);
	const $duplicate = $(`.\${val}-guide.duplicate`);
	const $valid = $(`#\${val}Valid`);
	const data = {
			value : $target.val(),
			checkKeyword : val
	};
	const jsonData = JSON.stringify(data);
	
	//val값에 따른 유효성 검사
	if(val == "id"){
		if(!/^[a-zA-Z0-9]{4,}$/.test($target.val())){
			$(".guide").hide();
			$error.show();
			$valid.val(0);
			return;
		}
	}
	else if(val == "nickname"){
		if(!/^[가-힣]{2,}$/.test($target.val())){
			$(".guide").hide();
			$error.show();
			$valid.val(0);
			return;
		}
	}
	else if(val == "email"){
		if(!(/^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/).test($target.val())){
			$(".guide").hide();
			$error.show();
			$valid.val(0);
			return;
		};
	}
	
	//비동기 중복 검사
	$.ajax({
		url : `${pageContext.request.contextPath}/member/checkEnrollDuplicate`,
		data : data,
		contentType : "application/json; charset=utf-8",
		method : "GET",
		success(data){
			const {available} = data;
			if(available){
				$ok.show();
				$error.hide();
				$duplicate.hide();
				$valid.val(1);
			}
			else{
				$duplicate.show();
				$error.hide();
				$ok.hide();
				$valid.val(0);
			}
		},
		error : console.log
	});
});

//비밀번호 일치 확인
$("[name=password]").keyup((e)=>{
	const password1 = $(password).val();
	const password2 = $(passwordCheck).val();
	
	//비밀번호, 비밀번호 확인 중 하나라도 공란이면 안내문구 숨기기
	if(password1 == '' || password2 == ''){
		$(".guide").hide();
		return;
	}
	
	const $error = $(".password-guide.error");
	const $ok = $(".password-guide.ok");
	const $valid = $("#passwordValid");
	
	if(password1 != password2){
		$error.show();
		$ok.hide();
		$valid.val(0);
	}
	else{
		$error.hide();
		$ok.show();
		$valid.val(1);
	}
	
});

//가입 버튼 클릭 시 회원가입
$(memberEnrollBtn).click((e)=>{
	const idValid = $("#idValid").val();
	const passwordValid = $("#passwordValid").val();
	const nicknameValid = $("#nicknameValid").val();
	const emailValid = $("#emailValid").val();
	const check1 = $("#check1").is(":checked");
	const check2 = $("#check2").is(":checked");
	const check3 = $("#check3").is(":checked");
	
	if(idValid != 1){
		$(".guide.id-guide.error").show();
		$(id).focus(); 
		return;
	}
	if(passwordValid != 1){
		$(".guide.password-guide.error").show();
		$(password).focus(); 
		return;
	}
	if(nicknameValid != 1){
		$(".guide.nickname-guide.error").show();
		$(nickname).focus(); 
		return;
	}
	if(emailValid != 1){
		$(".guide.email-guide.error").show();
		$(email).focus(); 
		return;
	}

	const $memberName = $("#name");
	if(!/^[가-힣]{2,}$/.test($memberName.val())){
		$(".guide.name-guide.error").show();
		$memberName.focus();
		return;
	}
	
	const $phone = $("#phone");
	$phone.val($phone.val().replace(/[^0-9]/g, ""));//숫자아닌 문자(복수개)제거하기
	if(!/^010[0-9]{8}$/.test($phone.val())){
		$(".guide.phone-guide.error").show();
		$phone.focus();
		return;
	}
	
	if(!check1){
		alert("개인정보 처리방침 동의는 필수입니다."); 
		return;
	}
	if(!check2){
		alert("서비스 이용약관 동의는 필수입니다."); 
		return;
	}
	
	$(document.memberEnrollFrm).submit();
	
});

//취소 버튼 클릭 시 뒤로 가기
$(memberEnrollCancelBtn).click((e)=>{
	window.history.back();
});

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
