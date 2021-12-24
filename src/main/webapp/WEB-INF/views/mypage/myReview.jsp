<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<jsp:include page="/WEB-INF/views/mypage/common/header.jsp">
	<jsp:param value="마이페이지" name="title"/>
</jsp:include>

<link href="${pageContext.request.contextPath}/resources/css/mypage/myshopping.css" rel="stylesheet">

<%-- EL에서 접근하기 위해 VAR속성 지정 --%>
<sec:authentication property="principal" var="member"/>
<%-- my shopping --%>
<div class="tab-pane fade show active col-15" id="myReviewList">
  <article class="col-9 mx-auto">
	<div class="order-detail-header d-flex justify-content-between">
		<h4 class="order-tab-title">
			나의 후기
		</h4>
		<select class="form-control form-control-sm w-25">
		  <option>최신순</option>
		  <option>조회순</option>
		  <option>좋아요순</option>
		</select>
	</div>
	<section class="review-list " id="myOrder">
		<ul class="list-group list-group-flush">
		  <li class="list-group-item">
			<table class="mt-3">
				<tr class="review-detail-header p-2">
					<td class="col-5">
						<img src="${pageContext.request.contextPath}/resources/images/80x80.jpg" alt="" class="review-img img-thumbnail mr-2"/>
						<strong>[ㅇㅇ키보드]키보드 그레이</strong>
						<span class="ml-2">1개</span>
					</td>
					<td class="col-2 text-right">
						<a href="" class="text-primary "><sup>편집하기</sup></a>
					</td>
				</tr>
				<tr>
				</tr>
				<tr>
					<td class="col-5 text-warning">
						<i class="review-star fas fa-star "></i>
						<i class="review-star fas fa-star"></i>
						<i class="review-star fas fa-star"></i>
						<i class="review-star fas fa-star"></i>
						<i class="review-star fas fa-star"></i>
						<sub class="ml-2 text-dark">2021.12.20</sub>
					</td>
					<td class="col-2 text-right">
						<sub><i class="far fa-eye mr-2"></i>0</sub>
						<sub><i class="far fa-heart mr-2"></i>0</sub>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<p class="p-3">만족합니다 Lorem ipsum dolor sit amet, consectetur adipisicing elit. Repellat soluta id similique cum eius dolor dolores voluptatum maiores tenetur officia nobis adipisci tempora nihil necessitatibus ipsam reiciendis deserunt quam distinctio!</p>
					</td>
				</tr>
			</table>
		  </li>
		  <li class="list-group-item">
			<table class="mt-3">
				<tr class="review-detail-header p-2">
					<td class="col-5">
						<img src="${pageContext.request.contextPath}/resources/images/80x80.jpg" alt="" class="review-img img-thumbnail mr-2"/>
						<strong>[ㅇㅇ키보드]키보드 그레이</strong>
						<span class="ml-2">1개</span>
					</td>
					<td class="col-2 text-right">
						<a href="" class="text-primary "><sup>편집하기</sup></a>
					</td>
				</tr>
				<tr>
				</tr>
				<tr>
					<td class="col-5 text-warning">
						<i class="review-star fas fa-star "></i>
						<i class="review-star fas fa-star"></i>
						<i class="review-star fas fa-star"></i>
						<i class="review-star fas fa-star"></i>
						<i class="review-star fas fa-star"></i>
						<sub class="ml-2 text-dark">2021.12.20</sub>
					</td>
					<td class="col-2 text-right">
						<sub><i class="far fa-eye mr-2"></i>0</sub>
						<sub><i class="far fa-heart mr-2"></i>0</sub>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<p class="p-3">만족합니다 Lorem ipsum dolor sit amet, consectetur adipisicing elit. Repellat soluta id similique cum eius dolor dolores voluptatum maiores tenetur officia nobis adipisci tempora nihil necessitatibus ipsam reiciendis deserunt quam distinctio!</p>
					</td>
				</tr>
			</table>
		  </li>
		</ul>	
	</section>
  </article>
</div>

<jsp:include page="/WEB-INF/views/mypage/common/footer.jsp"></jsp:include>