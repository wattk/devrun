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
<style>
.guide{
	display:none;
}
#memberEnrollContainer{
	border: 1px solid #000;
	width : 450px;
	height : 700px;
}
#memberEnrollTbl th{
	padding: 10px 5px;
}
#memberEnrollTbl td{
	width : 230px;
}
#memberEnrollTbl input:not([type="checkbox"]){
	width : 100%;
}
</style>
<div class="mx-auto text-center">
	<h1 class="text-brand mt-3">Dev<span class="color-b">Run</span></h1>
	<span class="font-weight-light">더 나은 개발라이프를 위한 적절한 해결책</span>
</div>
<div id="memberEnrollContainer" class="mx-auto text-center">
	<form:form action="${pageContext.request.contextPath}/member/memberEnroll.do" name="memberEnrollFrm" method="post" class="p-3">
		<table id="memberEnrollTbl" class="mx-auto">
			<tr>
				<th>아이디<sup class="text-danger">*</sup></th>
				<td>
					<div id="memberId-container">
						<input type="text" name="id" id="id" placeholder="4글자 이상" class="duplicate-check" required/>
						<span class="guide id-guide ok">사용 가능한 아이디입니다.</span>
						<span class="guide id-guide error text-danger">사용할 수 없는 아이디입니다.</span>
						<span class="guide id-guide duplicate text-danger">중복된 아이디입니다.</span>
						<input type="hidden" id="idValid" value="0" />
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
						<input type="password" name="password" id="passwordCheck" required/>
						<span class="guide password-guide ok">사용 가능한 비밀번호입니다.</span>
						<span class="guide password-guide error text-danger">비밀번호가 일치하지 않습니다.</span>
						<input type="hidden" id="passwordValid" value="0" />
					</div>
				</td>
			</tr>
			<tr>
				<th>이름</th>
				<td>
					<input type="text" name="name" id="name" />
				</td>
			</tr>
			<tr>
				<th>닉네임<sup class="text-danger">*</sup></th>
				<td>
					<div>
						<input type="text" name="nickname" id="nickname" class="duplicate-check" />
						<span class="guide nickname-guide ok">사용 가능한 닉네임입니다.</span>
						<span class="guide nickname-guide error text-danger">사용할 수 없는 닉네임입니다.</span>
						<span class="guide nickname-guide duplicate text-danger">중복된 닉네임입니다.</span>
						<input type="hidden" id="nicknameValid"  value="0" />
					</div>
				</td>
			</tr>
			<tr>
				<th>생년월일</th>
				<td>
					<input type="date" name="birthday" id="birthday" />
				</td>
			</tr>
			<tr>
				<th>이메일<sup class="text-danger">*</sup></th>
				<td>
					<div>
						<input type="email" name="email" id="email" class="duplicate-check"/>
						<span class="guide email-guide ok">사용 가능한 이메일입니다.</span>
						<span class="guide email-guide error text-danger">사용할 수 없는 이메일입니다.</span>
						<span class="guide email-guide duplicate text-danger">중복된 이메일입니다.</span>
						<input type="hidden" id="emailValid" value="0" />
					</div>
				</td>
			</tr>
			<tr>
				<th>연락처</th>
				<td>
					<input type="tel" name="phone" id="phone" placeholder="(-없이)01012345678"/>
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
				  <input type="checkbox" id="check3" class="normal" name="smsYn">
				  <label for="check3"><span>(선택)</span>마케팅 수신 동의</label>
				</td>
			</tr>
		</table>
		<hr />
		<button type="button" id="memberEnrollBtn" class="btn btn-primary">가입</button>
		<button type="button" class="btn btn-primary">취소</button>
	</form:form>
</div>
<script>
//체크박스 전체 선택
$(".checkbox-group").on("click", "#checkAll", ((e)=>{
  let checked = $(e.target).is(":checked");

  if(checked){
  	$(e.target).parents(".checkbox-group").find('input').prop("checked", true);
  } else {
  	$(e.target).parents(".checkbox-group").find('input').prop("checked", false);
  }
}));

//체크박스 개별 선택
$(".checkbox-group").on("click", ".normal", ((e)=>{
    let isChecked = true;
    
    $(".checkbox-group .normal").each((e)=>{
        isChecked = isChecked && $(e.target).is(":checked");
    });
    
    $("#checkAll").prop("checked", isChecked);
}));


//아이디, 닉네임, 이메일 유효성 검사 & 중복 검사
$(".duplicate-check").keyup((e)=>{
	const $target = $(e.target);
	const val = $target.prop("id");
	
	const $error = $(`.\${val}-guide.error`);
	const $ok = $(`.\${val}-guide.ok`);
	const $duplicate = $(`.\${val}-guide.duplicate`);
	const $valid = $(`#\${val}Valid`);
	const data = {
			value : $target.val(),
			checkKeyword : val
	};
	console.log(data);
	const jsonData = JSON.stringify(data);
	
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
	$.ajax({
		url : `${pageContext.request.contextPath}/member/checkEnrollDuplicate`,
		data : data,
		contentType : "application/json; charset=utf-8",
		method : "GET",
		success(data){
			console.log(data);
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
	const idValid = $(idValid).val();
	const passwordValid = $(passwordValid).val();
	const nicknameValid = $(nicknameValid).val();
	const emailValid = $(emailValid).val();
	const check1 = $(check1).is(":checked");
	const check2 = $(check2).is(":checked");
	
	if(idValid != 1)
		$(id).focus(); return;
	if(passwordValid != 1)
		$(password).focus(); return;
	if(nicknameValid != 1)
		$(nickname).focus(); return;
	if(emailValid != 1)
		$(email).focus(); return;
	if(check1) alert("개인정보 처리방침 동의는 필수입니다."); return;
	if(check2) alert("서비스 이용약관 동의는 필수입니다."); return;
	
	$(document.memberEnrollFrm).submit();
	
});
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
