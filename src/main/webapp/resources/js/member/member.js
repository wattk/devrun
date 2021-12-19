/**
 * 
 */
 window.onload = function(){
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
};