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
		       		<section id="addressList" class="card">
		       			<div class="card-body">
		       				<div class="row">
				       			<!-- 수신자명, 주소, 우편번호, 연락처 -->
				       			<article class="col-12">
				     				<%--
				     				주소가 있으면
				     				<c:forEach items="${addressList} var="adressList">
				     					<tr>
				     						<th>수신자명</th>
				     						<th>주소</th>
				     						<th>우편번호</th>
				     						<th>연락처</th>
				     					</tr>
				     					<tr>
				     						<td>${address.}</td>
				     						<td>${address.}</td>
				     						<td>${address.}</td>
				     						<td>${address.}</td>
				     					</tr>
				     				</c:forEach>
				     				주소가 없으면
				     				<tr><td colspan="4">주소가 없습니다.</td></tr>
				     				--%>
		       					</article>
			       			</div>
	       				</div>
	       			</section>
	       			
	       			<%-- shipping address detail --%>
	       			<section id="adressDetail">
	       				<h5>배송지정보 추가 / 수정 / 삭제</h5>
		       			<!-- 배송지정보 폼 -->
		       			<form name="addressFrm" method="POST">
		       				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
		       				<input type="hidden" name="memberNo" value="${member.memberNo}"/>
			       			<table class="table">
			       				<tr>
			       					<th><label for="title">배송지명</label></th>
			       					<td><input type="text" name="title" id="title" class="form-control col-4"/></td>
			       				</tr>
			       				<tr>
			       					<th><label for="addessee">수령인</label></th>
			       					<td><input type="text" name="addessee" id="addessee" class="form-control col-4" required/></td>
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
			       					<td><input type="checkbox" name="mainYn" id="mainYn"/> 기본 배송지로 설정</td>
			       				</tr>
			       			</table>
			       			<%-- buttons : address enroll / update / delete --%>
		    				<section id="btns" class="col-11 row">
		    					<button type="button" class="col-4" id="addressEnrollBtn">추가</button>
		    					<button type="button" class="col-4" id="addressUpdateBtn">수정</button>
		    					<button type="button" class="col-4" id="addressDeleteBtn">삭제</button>
		    				</section>
		       			</form>
	       			</section>
	       			
	       		</article>

			</div>
		</div>
		
<script>
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

/* 추가, 수정, 삭제 */
$("#addressEnrollBtn").click((e) => {
	//유효성검사
		
	//기본배송지 value값 설정
	const $mainYn = $("#mainYn")
	if($mainYn.is(":checked"))
		$mainYn.val("Y");
    else
    	$mainYn.val("N");
		
	$(document.addressFrm).action=`${pageContext.request.contextPath}/mypage/myinfo/addressEnroll.do`;
	$(document.addressFrm).submit();
});

/* $(document.addressFrm).action='${pageContext.request.contextPath}/mypage/myinfo/addressUpdate.do';
$(document.addressFrm).action='${pageContext.request.contextPath}/mypage/myinfo/addressDelete.do'; */
</script>


<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<jsp:include page="/WEB-INF/views/mypage/common/footer.jsp"></jsp:include>