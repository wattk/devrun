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
			
				<article id="info" class="col-10">
		      		<h4 id="breadcrumb"><a href="${pageContext.request.contextPath}/mypage/myinfo.do">나의 정보</a> <i class="bi bi-chevron-right"></i> <span>프로필 수정</span></h4>
		       		<hr/>
		       		<%-- my profile --%>
		       		<section id="myProfile" class="card">
		       			<div class="card-header">내 프로필</div>
		       			<div class="card-body">
		       				<form name="profileUpdateFrm" action="${pageContext.request.contextPath}/mypage/myinfo/profileUpdate.do" method="POST" enctype="multipart/form-data">
			       				<div class="row">
			       					<%-- profile image : 프로필 이미지가 null일 경우, 기본 이미지 출력 --%>
				       				<article class="col-4">
				     					<c:if test="${member.proPhoto eq null}"><img id="profileImg" src="${pageContext.request.contextPath}/resources/images/common/blank-profile.png" alt=""/></c:if>
								      	<c:if test="${member.proPhoto ne null}"><img id="profileImg" src="${pageContext.request.contextPath}/resources/upload/profilePhoto/${member.proPhoto}" alt=""/></c:if>
								       	<input type="file" name="upFile" id="upFile" class="form-control" accept="image/jpeg, image/jpg, image/png">
								       	<i id="deleteBtn" class="bi bi-x-circle-fill cursor"></i>
			       					</article>
			       					<%-- profile info --%>
			       					<article class="col-7">
			       						<section id="profileInfo">
				       						<div class>
				       							<label for="email">이메일<sup class="text-danger">*</sup></label>
				       							<input type="email" name="email" id="email" class="form-control duplicate-check" value="${member.email}"  placeholder="이메일을 입력해주세요">
				       							<div class="guide-box">
													<span class="guide email-guide ok">사용 가능한 이메일입니다.</span>
													<span class="guide email-guide error text-danger">사용할 수 없는 이메일입니다.</span>
													<span class="guide email-guide duplicate text-danger">중복된 이메일입니다.</span>
													<input type="hidden" id="emailValid" value="1" />
												</div>
				       						</div>
				       						<div>
				       							<label for="url">개인 사이트</label>
				       							<input type="text" name="url" id="url" class="form-control" value="${member.url}" placeholder="개인 사이트 주소를 입력해주세요">
				       						</div>
				       						<div>
				       							<label for="intro">한줄소개</label>
				       							<textarea name="intro" id="intro" class="form-control" placeholder="한줄소개를 입력해주세요">${member.intro}</textarea>
				       						</div>
			       						</section>
			       					</article>
			       				</div>
			       				<hr/>
			       				<div class="row">
			       					<%-- personal info --%>
			       					<article class="col-6">
								        <table id="personalInfo">
								        	<tr>
								        		<td class="col-4"><label for="id">아이디</label></td>
								        		<td class="col-8"><input type="text" name="id" id="id" class="form-control" value="${member.id}" readonly></td>
								        	</tr>
								        	<tr>
								        		<td><label for="password">비밀번호<sup class="text-danger">*</sup></label></td>
								        		<td>
								        			<input type="password" name="password" id="password" class="form-control" required>
								        			<div class="guide-box">
								        				<span class="guide password-guide error text-danger">비밀번호를 입력해 주세요.</span>
													</div>
								        		</td>
								        	</tr>
								        	<!-- <tr>
								        		<td><label for="newPassword">새 비밀번호</label></td>
								        		<td>
								        			<input type="password"  id="newPassword" class="form-control"></td>
								        	</tr> -->
								        	<tr>
								        		<td><label for="nickname">닉네임<sup class="text-danger">*</sup></label></td>
								        		<td>
								        			<input type="text" name="nickname" id="nickname" class="form-control duplicate-check" value="${member.nickname}" maxlength="16" required>
								        			<div class="guide-box">
														<span class="guide nickname-guide ok">사용 가능한 닉네임입니다.</span>
														<span class="guide nickname-guide error text-danger">사용할 수 없는 닉네임입니다.</span>
														<span class="guide nickname-guide duplicate text-danger">중복된 닉네임입니다.</span>
														<input type="hidden" id="nicknameValid"  value="1" />
													</div>
								        		</td>
								        	</tr>
								        	<tr>
								        		<td><label for="name">이름<sup class="text-danger">*</sup></label></td>
								        		<td>
								        			<input type="text" name="name" id="name" class="form-control" value="${member.name}" maxlength="16" required>
								        			<div class="guide-box">
														<span class="guide name-guide error text-danger">이름을 입력해 주세요.</span>
													</div>
								        		</td>
								        	</tr>
								        	<tr>
								        		<td><label for="birthday">생년월일<sup class="text-danger">*</sup></label></td>
								        		<td>
								        			<input type="date" name="birthday" id="birthday" class="form-control" value="<fmt:formatDate value="${member.birthday}" pattern="yyyy-MM-dd"/>" required>
								        			<div class="guide-box">
														<span class="guide birthday-guide error text-danger">생일을 입력해 주세요.</span>
													</div>
								        		</td>
								        	</tr>
								        	<tr>
								        		<td><label for="phone">연락처<sup class="text-danger">*</sup></label></td>
								        		<td>
								        			<input type="tel" name="phone" id="phone" class="form-control" value="${member.phone}" maxlength="11" placeholder="숫자 11자리만 입력해주세요" required>
								        			<div class="guide-box">
														<span class="guide phone-guide error text-danger">연락처를 입력해 주세요.</span>
													</div>
								        		</td>
								        	</tr>
								        </table>
			       					</article>
		    					</div>
		    					<%-- buttons : withdraw / update --%>
		    					<section id="btns" class="col-11 row">
		    						<button type="button" class="col-6 cursor" data-toggle="modal" data-target="#withdrawModal">탈퇴하기</button>
		    						<button type="button" id="profileUpdateBtn" class="col-6 cursor">수정하기</button>
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
		      			<div id="title" class="row col-12">
		      				<h5 id="staticBackdropLabel" class="modal-title">회원탈퇴</h5>
		      			</div>
		        		<i class="bi bi-x cursor" data-dismiss="modal"></i>
		      		</section>
		      		<section class="modal-body">
		      			<form:form name="memberWithdrawalFrm" method="POST" action="${pageContext.request.contextPath}/mypage/myinfo/memberWithdrawal.do">
				      		<div>
					      		<h5>탈퇴 시 유의사항</h5>
				      			<p>회원탈퇴 시 개인정보 및 데브런에서 만들어진 모든 데이터는 보관됩니다.</p>
				      		</div>
			      			<div>
				      			<h5>데브런을 탈퇴하시는 이유는 무엇인가요?</h5>
				      			<p>데브런을 탈퇴하는 이유를 알려주시면 보다 좋은 서비스 제공을 위해 노력하겠습니다.</p>
				      			<select name="reasonCate" id="reasonCate" class="custom-select cursor" required>
									<option value="" disabled selected>탈퇴사유를 선택하세요</option>
									<c:forEach items="${withdrawReasonList}" var="withdrawReason">
								  		<option value="${withdrawReason.reasonCate}">${withdrawReason.reasonName}</option>
								  	</c:forEach>
								</select>
			      			</div>
			      			<div class="form-check">
								<input type="checkbox" id="check" class="form-check-input cursor" required>
							  	<label class="form-check-label" for="check">
							    	해당 내용을 모두 확인하였으며, 회원탈퇴에 동의합니다.
							  	</label>
							</div>
							<div id="passwordCheck">
								<div class="row col-6">
									<label for="password" class="col-4">비밀번호<sup class="text-danger">*</sup></label>
									<input type="password" name="password" id="password" class="form-control col-8" required>
								</div>
							</div>
			      			<div id="withdrawBtn" class="row">
			      				<button type="submit" id="memberWithdrawalBtn" class="col-4 cursor">회원탈퇴</button>
			      			</div>
		      			</form:form>
		      		</section>
		    	</div>
		  	</div>
		</div>		

    </article>
</main>

<script>
/* 프로필 미리보기 */
function readImage(input) {
    //input 태그에 파일이 있는 경우
    if(input.files && input.files[0]){
    	//파일을 읽기 위한 FileReader 객체 생성
        const reader = new FileReader();
        //파일 읽어들이기를 성공해 이미지가 로드된 경우 호출되는 이벤트 핸들러
        reader.onload = e => {
        	//읽어들인 파일내용을 이미지 태그의 src속성에 지정
        	$("#profileImg").attr("src", e.target.result);
        }
        //reader가 파일내용을 읽어 dataURL형식의 문자열로 저장
        reader.readAsDataURL(input.files[0]);
    }
}
//input file에 change 이벤트 부여
//파일 양식으로 이미지를 선택(값이 변경)했을 때 처리하는 코드
$("#upFile").change((e) => {
    readImage(e.target);
});

/* 프로필 X 버튼 클릭 시 */
$("#deleteBtn").click((e) => {
	//미리보기를 기본 이미지로 변경
	$("#profileImg").attr("src", "${pageContext.request.contextPath}/resources/images/common/blank-profile.png");
	//선택 파일 제거
    $("#upFile").val("");
});



/* 회원가입 참고 : 닉네임, 이메일 유효성 검사 & 중복 검사 */
$(".duplicate-check").keyup((e) => {
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
	if(val == "nickname"){
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
		url : `${pageContext.request.contextPath}/mypage/myinfo/profileUpdate/checkDuplicate`,
		data : data,
		contentType : "application/json ; charset=utf-8",
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

/* 수정 버튼 클릭 시 프로필 수정 */
$(profileUpdateBtn).click((e)=>{
	
	/* 회원가입 참고 : 폼 유효성 검사 & 빈값 검사 */
	const emailValid = $("#emailValid").val();
	const nicknameValid = $("#nicknameValid").val();
	
	if(emailValid != 1){
		$(".guide.email-guide.error").show();
		$(email).focus(); 
		return;
	}
	if(nicknameValid != 1){
		$(".guide.nickname-guide.error").show();
		$(nickname).focus(); 
		return;
	}
	
	const $password = $("#password");
	if(!/^.{1,}$/.test($password.val())){
		$(".guide.password-guide.error").show();
		$password.focus(); 
		return;
	}
	const $memberNickname = $("#nickname");
	if(!/^.{1,}$/.test($memberNickname.val())){
		$(".guide.nickname-guide.error").show();
		$memberNickname.focus();
		return;
	}
	const $memberName = $("#name");
	if(!/^[가-힣]{2,}$/.test($memberName.val())){
		$(".guide.name-guide.error").show();
		$memberName.focus();
		return;
	}
	const $phone = $("#phone");
	$phone.val($phone.val().replace(/[^0-9]/g, "")); //숫자아닌 문자(복수개)제거하기
	if(!/^010[0-9]{8}$/.test($phone.val())){
		$(".guide.phone-guide.error").show();
		$phone.focus();
		return;
	}
	
	const profileImgSrc = $("#profileImg").attr("src");
	const profileImgPath = "${pageContext.request.contextPath}/resources/upload/profilePhoto/${member.id}.png";
	if(profileImgSrc == profileImgPath)
		$("#upFile").append(`<input type="hidden" name="proPhoto" value="${member.proPhoto}"/>`);
	
	$(document.profileUpdateFrm).submit();
});



/* 회원탈퇴 동의약관 체크 시 비밀번호 입력창 제공 */
$("#check").change(function() {
    if($("#check").is(":checked")) 
    	$("#passwordCheck").slideDown();
    else
    	$("#passwordCheck").slideUp();
});

/* 탈퇴 버튼 클릭 시 회원탈퇴 */
$(memberWithdrawalBtn).click((e)=>{
	//탈퇴사유, 동의약관, 비밀번호 유효성검사
	if(($("#reason").val() == '')) return;
	else if(($("#check").val() == '')) return;
	else if(($("#password").val() == '')) return;
	$(document.memberWithdrawalFrm).submit();
});
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>