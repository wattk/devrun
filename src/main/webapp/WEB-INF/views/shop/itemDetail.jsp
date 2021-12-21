<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>	
<fmt:requestEncoding value="utf-8"/>

<!-- Header 임포트 -->
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="shopMain" name="title"/>
</jsp:include>


<!-- css임포트 -->
<link href="${pageContext.request.contextPath}/resources/css/shop/shopItemDetail.css" rel="stylesheet">

<!-- shopHeader 관련 임포트 -->
<jsp:include page="/WEB-INF/views/shop/shopHeader.jsp"/>
<link href="${pageContext.request.contextPath}/resources/css/shop/shopMain.css" rel="stylesheet">


<!-- shopSideBox 관련 임포트 -->
<jsp:include page="/WEB-INF/views/shop/rightSideBox.jsp"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/shop/rightSideBox.js"></script>


	<!-- body 영역 시작 -->
    <div id="shopItemDetailOuterDiv">
		<div id="itemDetailDisplayDiv">
			<div id="itemDetailPicDiv">
                <div id="itemDetailSmallPicDiv">
                </div>
                <div id="itemDetailBicPicDiv">
                </div>
			</div>
			<div id="itemDetailInfoDiv">
				<div id="itemDetailNameDiv">
				</div>
				<div id="itemDetailOptionDiv">
				</div>
				<div id="itemDetailOrderDiv">
				</div>
			</div>
		</div>
		<div id="itemDetailMenuTabDiv">
			<!-- 탭 시작 -->
				  <div id="menu-tab">
				    <div id="page-wrap" style="width: 1400px;">
				      <div class="tabs">
				        <!--1번째 탭---->
				        <div class="tab">
				          <input id="tab-1" checked="checked" name="tab-group-1" type="radio" />
				          <label for="tab-1">리뷰</label>
				          <div class="content">
				            <p><a href="#">Retour Acceuil</a></p>
				          </div>
				        </div>
				        <!--2번째 탭---->
				        <div class="tab">
				          <input id="tab-2" name="tab-group-1" type="radio" /> 
				          <label for="tab-2">문의</label>
				          <div class="content">
				            <p>Exemple, une image, du texte</p>
				          </div>
				        </div>
				        <!--3번째 탭---->
				        <div class="tab">
				          <input id="tab-3" name="tab-group-1" type="radio" /> 
				          <label for="tab-3">배송/환불</label>
				          <div class="content">
				            <p>Exemple, une image, et une video...</p>
				          </div>
				        </div>
				        <!--4번째 탭---->
				        <div class="tab">
				          <input id="tab-4" name="tab-group-1" type="radio" />
				          <label for="tab-4">추천</label>
				          <div class="content">
				            <p>Une vid&eacute;o de Constance..!</p>
				          </div>
				        </div>
				      </div>
				    </div>
				  </div>
			<!-- 탭 끝  -->
		</div>
	</div>
	<!-- body 영역 끝 -->	
	

<!-- shopHeader js  -->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/shop/shopHeader.js"></script>
<!-- footer -->
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
	
	