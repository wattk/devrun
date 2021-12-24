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
		       		<%-- shipping address --%>
		       		<section class="card" id="addressList">
		       			<div class="card-body">
		       				<div class="row">
				       			<!-- 수신자명, 주소, 우편번호, 연락처 -->
				       			<article class="col-12">
				     				<%-- <c:forEach items="${addressList} var="adressList">
				     					<tr>
				     						<th>수신자명</th>
				     						<th>주소</th>
				     						<th>우편번호</th>
				     						<th>연락처</th>
				     					</tr>
				     					<tr>
				     						<th>${address.}</th>
				     						<th>${address.}</th>
				     						<th>${address.}</th>
				     						<th>${address.}</th>
				     					</tr>
				     				</c:forEach> --%>
		       					</article>
			       			</div>
	       				</div>
	       			</section>
	       			
	       			<h5>배송지정보 추가 / 수정 / 삭제</h5>
	       			<section class="card" id="adressDetail">
		       			<div class="card-body">
		       				<div class="row">
		       					<!-- 배송지정보 폼 -->
		       					<form name="addressFrm" action="" method="POST">
			       					<table>
			       						<tr>
			       							<td><label for="addessee">수신자명</label></td>
			       							<td><input type="text" class="form-control" id="addessee" name="addessee"/></td>
			       						</tr>
			       						<tr>
			       							<td><label for="postalCode">우편번호</label></td>
			       							<td><input type="text" class="form-control" id="postalCode" name="postalCode"/></td>
			       						</tr>
			       						<tr>
			       							<td><label for="address1">주소</label></td>
			       							<td><input type="text" class="form-control" id="address1" name="address1"/></td>
			       						</tr>
			       						<tr>
			       							<td><label for="address2">상세주소</label></td>
			       							<td><input type="text" class="form-control" id="address2" name="address2"/></td>
			       						</tr>
			       						<tr>
			       							<td><label for="phone">연락처</label></td>
			       							<td><input type="tel" class="form-control" id="phone" name="phone"/></td>
			       						</tr>
			       					</table>
		       					</form>
		       				</div>
	       				</div>
	       			</section>
	       			<section></section>
	       		</article>

			</div>
		</div>
		
<jsp:include page="/WEB-INF/views/mypage/common/footer.jsp"></jsp:include>