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
<%-- <sec:authentication property="principal" var="member"/> --%>

		<div class="col-12" id="profileUpdate">
			<div class="row">
			
				<article class="col-10" id="info">
		      		<h4 id="breadcrumb"><a href="${pageContext.request.contextPath}/mypage/myinfo.do">나의 정보</a> <i class="bi bi-chevron-right"></i> <span>프로필 수정</span></h4>
		       		<hr/>
		       		<%-- my profile --%>
		       		<section class="card" id="myProfile">
		       			<div class="card-header">내 프로필</div>
		       			<div class="card-body">
		       				<form name="profileUpdateFrm" action="${pageContext.request.contextPath}/mypage/myinfo/profileUpdate.do" method="POST" enctype="multipart/form-data">
			       				<div class="row">
			       					<%-- profile image : 프로필 이미지가 null일 경우, 기본 이미지 출력 --%>
				       				<article class="col-4">
				     					<c:if test="${member.proPhoto eq null}"><img src="${pageContext.request.contextPath}/resources/images/common/blank-profile.png" alt="" id="profileImg"/></c:if>
								      	<c:if test="${member.proPhoto ne null}"><img src="${pageContext.request.contextPath}/resources/upload/profilePhoto/${member.id}.png" alt="" id="profileImg"/></c:if>
								       	<input type="file" class="form-control" id="upFile" name="upFile" accept="image/jpeg, image/jpg, image/png">
								       	<i class="bi bi-x-circle-fill" id="deleteBtn"></i>
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
								        		<td><input type="password" class="form-control" id="password" required></td>
								        	</tr>
								        	<tr>
								        		<td><label for="newPassword">새 비밀번호</label></td>
								        		<td><input type="password" class="form-control" id="newPassword" name="password" required></td>
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
								        		<td><input type="date" class="form-control" id="birthday" name="birthday" value="<fmt:formatDate value="${member.birthday}" pattern="yyyy-MM-dd"/>" required></td>
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
		    						<button type="button" id="profileUpdateBtn" class="col-6">수정하기</button>
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
		      				<button type="button" id="memberWithdrawBtn" class="col-4">회원탈퇴</button>
		      			</div>
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
    if(input.files && input.files[0]) {
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
$("#upFile").change(e => {
    readImage(e.target);
});

/* 프로필 사진 우측하단 X버튼 클릭 시 코드 */
$("#deleteBtn").click(e => {
	//기본 이미지로 미리보기 변경
	$("#profileImg").attr("src", "${pageContext.request.contextPath}/resources/images/common/blank-profile.png");
	//선택 파일 비우기
    $("#upFile").val("");
});

/* 유효성검사 */
 

$(profileUpdateBtn).click((e)=>{
	$profileImg = $("#profileImg").attr("src");
	if($profileImg == "${pageContext.request.contextPath}/resources/upload/profilePhoto/${member.id}.png") {
		$("#upFile").append(`<input type="hidden" name="proPhoto" value="${member.proPhoto}"/>`);
	}
	$(document.profileUpdateFrm).submit();
});

</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>