<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<jsp:include page="/WEB-INF/views/mypage/common/header.jsp">
	<jsp:param value="배송지 관리" name="title"/>
</jsp:include>

<!-- CSS import -->
<link href="${pageContext.request.contextPath}/resources/css/mypage/addressManage.css" rel="stylesheet">

<%-- EL에서 접근하기 위해 VAR속성 지정 --%>
<sec:authentication property="principal" var="member"/>

		<div id="shippingAddress" class="col-12">
			<div class="row">
			
				<article id="info" class="col-10">
		      		<h4 id="breadcrumb"><a href="${pageContext.request.contextPath}/mypage/myinfo.do">나의 정보</a> <i class="bi bi-chevron-right"></i> <span>배송지 관리</span></h4>
		       		<hr/>
		       		
		       		<%-- shipping address list --%>
		       		<section id="addressList">
				       	<table class="table">
				       		<tr>
				       			<th>선택</th>
			     				<th>배송지명</th>
			     				<th>수령인</th>
			     				<th>우편번호</th>
			     				<th>주소</th>
			     				<th>연락처</th>
			     			</tr>
	       					<c:if test="${totalContent ne 0}">
		       					<c:forEach items="${addressList}" var="address">
			     					<tr data-no="${address.addressNo}">
			     						<td><input type="radio" name="addressNo"/></td>
			     						<td>${address.title}</td>
			     						<td>${address.addressee}</td>
			     						<td>${address.postalCode}</td>
			     						<td>${address.address1} ${address.address2}</td>
			     						<td>${address.phone}</td>
			     					</tr>
			     				</c:forEach>
	       					</c:if>
	       					<c:if test="${totalContent eq 0}">
	       						<tr id="noList"><td colspan="6">등록된 주소가 없습니다.</td></tr>
	       					</c:if>
	       				</table>
	       				<!-- pagebar : 등록된 주소가 있는 경우에만 제공 -->
	       				<c:if test="${totalContent ne 0}">${pagebar}</c:if>
     				</section>
	       			
	       			<%-- shipping address detail --%>
	       			<section id="adressDetail">
	       				<h5>배송지정보 추가 / 수정 / 삭제</h5>
		       			<!-- 배송지정보 폼 -->
		       			<form name="addressFrm" method="POST" action="${pageContext.request.contextPath}/mypage/myinfo/addressEnroll.do">
		       				<input type="hidden" name="memberNo" value="${member.memberNo}"/>
			       			<table class="table">
			       				<tr>
			       					<th><label for="title">배송지명</label></th>
			       					<td><input type="text" name="title" id="title" class="form-control col-4" required/></td>
			       				</tr>
			       				<tr>
			       					<th><label for="addressee">수령인</label></th>
			       					<td><input type="text" name="addressee" id="addressee" class="form-control col-4" required/></td>
			       				</tr>
			       				<tr>
			       					<th><label for="postalCode">우편번호</label></th>
			       					<td class="input-group">
			       						<input type="text" name="postalCode" id="postalCode" class="form-control col-3" required/>
			       						<div class="input-group-append">
											<button type="button" id="searchPostcodeBtn">우편번호 검색</button>
										</div>
			       					</td>
			       				</tr>
			       				<tr>
			       					<th><label for="address1">주소</label></th>
			       					<td><input type="text" name="address1" id="address1" class="form-control col-10" required/></td>
			       				</tr>
			       				<tr>
			       					<th><label for="address2">상세주소</label></th>
			       					<td><input type="text" name="address2" id="address2" class="form-control col-10"/></td>
			       				</tr>
			       				<tr>
			       					<th><label for="phone">연락처</label></th>
			       					<td><input type="tel" name="phone" id="phone" class="form-control col-4" required/></td>
			       				</tr>
			       				<tr>
			       					<th><label for="mainYn">기본배송지</label></th>
			       					<td>
			       						<input type="checkbox" name="mainYn" value="Y" id="mainYn"/> 기본 배송지로 설정
			       						<input type="hidden" name="mainYn" value="N" id="mainYnHidden"/>
			       					</td>
			       				</tr>
			       			</table>
			       			<%-- buttons : address enroll / update / delete --%>
		    				<section id="btns" class="col-11 row">
		    					<button type="submit" class="col-4" id="addressEnrollBtn" onclick='addressEnroll(this.form);'>추가</button>
		    					<button type="button" class="col-4" id="addressUpdateBtn" onclick='addressUpdate(this.form);'>수정</button>
		    					<button type="button" class="col-4" id="addressDeleteBtn" onclick='addressDelete(this.form);'>삭제</button>
		    				</section>
		       			</form>
	       			</section>
	       			
	       		</article>

			</div>
		</div>
		
<script>
/* 주소 상세 조회 */
$("tr[data-no]").click((e) => {
	//radio버튼을 클릭하여 value값을 가져오는 코드(-> radio버튼을 체크해야만 정보가 띄워져서 사용하기에 불편했다)
	//input태그에 value값 대신 data-no속성을 지정하여 .data("no")로 가져올 수도 있다.
	//const addressNo = $("input[name=addressNo]:checked").val();
	
	$tr = $(e.target).parents("tr");
	$tr.find("input[name=addressNo]").prop("checked", true); //radio버튼 체크 처리
	const addressNo = $tr.data("no");
	//console.log(addressNo);
	if(!addressNo) return; //addressNo가 undefined라면 조기리턴해서 이하 코드 실행하지 않도록 한다.
	
	$.ajax({
		url: `${pageContext.request.contextPath}/mypage/myinfo/selectOneAddress/\${addressNo}`,
		method: "GET",
		success(data){
			//console.log(data);
			const $frm = $(addressFrm);
			const {title, addressee, postalCode, address1, address2, phone, mainYn} = data;
			$("[name=title]", $frm).val(title);
			$("[name=addressee]", $frm).val(addressee);
			$("[name=postalCode]", $frm).val(postalCode);
			$("[name=address1]", $frm).val(address1);
			$("[name=address2]", $frm).val(address2);
			$("[name=phone]", $frm).val(phone);
			//mainYn값이 Y이면 체크되도록 하고, N이면 체크되지 않도록 한다.
			if(mainYn == "Y") {
				$("[name=mainYn]", $frm).prop("checked", true);
			} else {
				$("[name=mainYn]", $frm).prop("checked", false);
			}
		},
		error(xhr, textStatus, err){
			console.log(xhr, textStatus, err);
			if(xhr.status == 404){
				alert("조회한 주소는 존재하지 않습니다 : " + addressNo);
			}
		}
	});
});

/* Daum 우편번호 검색 API */
$("#searchPostcodeBtn").click(function(){
	//팝업 위치를 지정(화면의 가운데 정렬)
	var width = 430; //팝업의 너비
	var height = 470; //팝업의 높이
	
	new daum.Postcode({
		//생성자에 크기 값을 명시적으로 지정해야 한다.
		width: width, 
	    height: height,
	    
        oncomplete: function(data) {
            //팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            //각 주소의 노출 규칙에 따라 주소를 조합한다.
            //내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기
            var addr = ''; //주소 변수
            var extraAddr = ''; //참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { //사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { //사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            //사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                //법정동명이 있을 경우 추가한다. (법정리는 제외)
                //법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                //건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                //표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                //조합된 참고항목을 해당 필드에 넣는다.
                document.getElementById("address1").value = addr + extraAddr;
            
            } else {
                document.getElementById("address1").value = addr;
            }

            //우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById("postalCode").value = data.zonecode;
            //커서를 상세주소 필드로 이동한다.
            document.getElementById("address2").focus();
        }
	
    }).open({
        left: (window.screen.width / 2) - (width / 2),
        top: (window.screen.height / 2) - (height / 2),
        //팝업창의 상태표시줄에 나오는 타이틀값 설정
        popupTitle: '우편번호 검색', 
        //여러개의 팝업창이 뜨는 것을 방지하기 위해 팝업창의 Key값 설정
        popupKey: 'popup1' 
    });
});

function addressEnroll(frm) {
	/* 유효성검사 : 배송지명, 수령인, 우편번호, 주소, 상세주소, 연락처, 기본배송지 여부 */
	const $title = $("#title");
	if(!/^.{1,}$/.test($title.val())){
		alert("배송지명을 작성해주세요.");
		$title.focus();
		return;
	}
	const $addressee = $("#addressee");
	if(!/^[가-힣]{2,}$/.test($addressee.val())){
		alert("수령인을 작성해주세요.");
		$addressee.focus();
		return;
	}
	const $postalCode = $("#postalCode");
	if(!/^[0-9]{5}$/.test($postalCode.val())){
		alert("우편번호를 작성해주세요.");
		$postalCode.focus();
		return;
	}
	const $address1 = $("#address1");
	if(!/^.{1,}$/.test($address1.val())){
		alert("주소를 작성해주세요.");
		$address1.focus();
		return;
	}
	const $phone = $("#phone");
	$phone.val($phone.val().replace(/[^0-9]/g, "")); //숫자아닌 문자(복수개)제거하기
	if(!/^010[0-9]{8}$/.test($phone.val())){
		alert("연락처를 작성해주세요.");
		$phone.focus();
		return;
	}
	if($("#mainYn").is(":checked")){
		$("#mainYnHidden").prop("disabled", true);
	}
	
	frm.action = `${pageContext.request.contextPath}/mypage/myinfo/addressEnroll.do`;
	frm.submit();
}

function addressUpdate(frm) {
	frm.action = `${pageContext.request.contextPath}/mypage/myinfo/addressUpdate.do`;
	frm.submit();
}

function addressDelete(frm) {
	frm.action = `${pageContext.request.contextPath}/mypage/myinfo/addressDelete.do`;
	frm.submit();
}
</script>


<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<jsp:include page="/WEB-INF/views/mypage/common/footer.jsp"></jsp:include>