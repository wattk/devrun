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
<link href="${pageContext.request.contextPath}/resources/css/mypage/shippingAddress.css" rel="stylesheet">

<%-- EL에서 접근하기 위해 VAR속성 지정 --%>
<sec:authentication property="principal" var="member"/>

		<div class="col-12" id="shippingAddress">
			<div class="row">
			
				<article class="col-10" id="info">
		      		<h4 id="breadcrumb"><a href="${pageContext.request.contextPath}/mypage/myinfo.do">나의 정보</a> <i class="bi bi-chevron-right"></i> <span>배송지 관리</span></h4>
		       		<hr/>
		       		
		       		<%-- shipping address list --%>
		       		<section class="card" id="addressList">
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
		       			<form name="addressFrm" action="" method="POST">
			       			<table class="table">
			       				<tr>
			       					<th><label for="addessee">수신자명</label></th>
			       					<td><input type="text" class="form-control col-4" id="addessee" name="addessee"/></td>
			       				</tr>
			       				<tr>
			       					<th><label for="postalCode">우편번호</label></th>
			       					<td class="input-group">
			       						<input type="text" class="form-control col-3" id="postalCode" name="postalCode"/>
			       						<div class="input-group-append">
											<button>우편번호 검색</button>
										</div>
			       					</td>
			       				</tr>
			       				<tr>
			       					<th><label for="address1">주소</label></th>
			       					<td><input type="text" class="form-control col-10" id="address1" name="address1"/></td>
			       				</tr>
			       				<tr>
			       					<th><label for="address2">상세주소</label></th>
			       					<td><input type="text" class="form-control col-10" id="address2" name="address2"/></td>
			       				</tr>
			       				<tr>
			       					<th><label for="phone">연락처</label></th>
			       					<td><input type="tel" class="form-control col-4" id="phone" name="phone"/></td>
			       				</tr>
			       			</table>
			       			<%-- buttons : address enroll / update / delete --%>
		    				<section id="btns" class="col-11 row">
		    					<button class="col-4" type="submit" onclick="location.href='${pageContext.request.contextPath}/mypage/myinfo/addressEnroll.do';">추가</button>
		    					<button class="col-4" type="submit" onclick="location.href='${pageContext.request.contextPath}/mypage/myinfo/addressUpdate.do';">수정</button>
		    					<button class="col-4" type="submit" onclick="location.href='${pageContext.request.contextPath}/mypage/myinfo/addressDelete.do';">삭제</button>
		    				</section>
		       			</form>
	       			</section>
	       			
	       		</article>

			</div>
		</div>
		
<jsp:include page="/WEB-INF/views/mypage/common/footer.jsp"></jsp:include>