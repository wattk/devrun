<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<fmt:requestEncoding value="utf-8" />

<!-- Header 임포트 -->
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="상세페이지" name="title" />
</jsp:include>


<!-- css임포트 -->
<link
	href="${pageContext.request.contextPath}/resources/css/shop/shopItemDetail.css"
	rel="stylesheet">

<!-- shopHeader 관련 임포트 -->
<jsp:include page="/WEB-INF/views/shop/shopHeader.jsp" />
<link
	href="${pageContext.request.contextPath}/resources/css/shop/shopMain.css"
	rel="stylesheet">


<!-- shopSideBox 관련 임포트 -->
<jsp:include page="/WEB-INF/views/shop/rightSideBox.jsp" />
<%-- 
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/shop/rightSideBox.js"></script> --%>

<!-- body 영역 시작 -->

<sec:authentication property="principal" var="member" />

<div id="shopItemDetailOuterDiv">
	<div id="itemDetailDisplayDiv" class="row">
		<!-- sms 모달 시작-->
		<form:form name="smsFrm" method="POST" action="#">
			<div class="modal" id="exampleModal4" tabindex="-1" role="dialog">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title">재입고 SMS 알람 신청</h5>
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
						<div class="modal-body" id="smsBody">
							<c:if test="${!empty outOfStock}">
								<p>재입고 알림을 받을 상품 옵션을 선택해주세요.</p>
								<select style="height: 35px;" class="col-8" name="smsOption"
									id="smsOption" required>
									<option value="" selected disabled>옵션 선택</option>
									<c:forEach items="${outOfStock}" var="s">
										<option value="${s.detailNo}">${s.optionNo}
											<c:if test="${s.optionContent != null}">
										, ${s.optionContent}
									</c:if>
										</option>
									</c:forEach>
								</select>
								<hr />
								<p>문자 메세지를 받을 전화번호를 입력해주세요.[숫자만 입력]</p>
								<input style="height: 35px;" class="col-8" id="phoneSms"
									name="phoneSms" type="tel" required />
								<p id="checkPhone" data-vaild="N"></p>
							</c:if>
							<c:if test="${empty outOfStock}">
								<p>모든 옵션이 재고가 있습니다.</p>
							</c:if>
						</div>
						<div class="modal-footer text-center">
							<c:if test="${!empty outOfStock}">
								<button type="submit" class="btn btn-primary">신청하기</button>
							</c:if>
							<button type="button" id="smsCloseBtn" class="btn btn-secondary"
								data-dismiss="modal">닫기</button>
						</div>
					</div>
				</div>
			</div>
		</form:form>
		<!-- sms 모달 끝 -->
		<!--리뷰작성모달 시작(부트스트랩)-->
		<form:form name="reviewFrm" method="POST"
			action="${pageContext.request.contextPath}/shop/insertReview"
			enctype="multipart/form-data">
			<div class="modal fade" id="exampleModal3" tabindex="-1"
				role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="exampleModalLabel">리뷰 작성하기</h5>
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
						<div class="modal-body">
							<div class="qm-body1">
								<p>해당상품</p>
								<div class="row" id="qItem">
									<img id="qPIc"
										src="${pageContext.request.contextPath}/resources/upload/product/${product.thumbnail}"
										alt="">
									<p>${product.name}</p>
									<input type="hidden" id="productCodeV" name="productCode"
										value='${product.productCode}' />
									<sec:authorize access="isAuthenticated()">
										<input type="hidden" id="memberNoV" name="memberNo"
											value='<sec:authentication property="principal.memberNo"/>' />
										<input type="hidden" name="id"
											value='<sec:authentication property="principal.id"/>' />
									</sec:authorize>
								</div>
								<p class="mt-3">상품 별점</p>
								<select id="rateSelect" name="rate" class="form-select col-12"
									aria-label="Default select example">
									<option value="5" selected>별점 5점</option>
									<option value="4">별점 4점</option>
									<option value="3">별점 3점</option>
									<option value="2">별점 2점</option>
									<option value="1">별점 1점</option>
								</select>
							</div>
							<div class="m-body2 mt-3">
								<div>
									<div id="rSelectP" class="text-center">
										<p id="choosePicP">사진첨부(선택)</p>
									</div>
									<div class="text-center">
										<input type="file" name="upFile" id="reviewPic"
											onchange='openFile(event)'>
									</div>
								</div>
								<p class="mt-3">리뷰 작성</p>
								<div class="checkboxReport">
									<textarea style="-ms-overflow-style: none;" name="content"
										id="reportText" cols="30" rows="10" maxlength='900' required></textarea>
									<span id="textLength">0/900</span>
								</div>
								<p style="font-size: 12px;">ⓘ 포토리뷰 500P / 글리뷰 100P 적립</p>
							</div>
						</div>
						<div class="modal-footer justify-content-center">
							<button type="submit" class="btn btn-primary col-4">등록하기</button>
							<button type="button" class="btn btn-secondary col-4"
								data-dismiss="modal" onclick="deleteReview();">취소하기</button>
						</div>
					</div>
				</div>
			</div>
		</form:form>
		<!--리뷰작성모달 끝-->
		<!--문의 글 작성 시작(부트스트랩)-->
		<div class="modal fade" id="exampleModal2" tabindex="-1" role="dialog"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel">상품 문의하기</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
				<!--------------- 태영 수정 start ------------------------------>	
					<form 
						action="${pageContext.request.contextPath}/shop/insertQuestionProduct.do"
						method="POST"
						>
												
						<div class="modal-body">
							<div class="qm-body1">
								<p>해당상품</p>
								<div class="row" id="qItem">
									<img id="qPIc"
										src="${pageContext.request.contextPath}/resources/upload/product/${product.thumbnail}"
										alt="">								
									<p>${product.name }</p>
									<input type="hidden" name="productCode" value="${product.productCode }">
								</div>
							</div>
							<div class="m-body2 mt-3">
								<p>문의 사항</p>
								<div class="checkboxReport">
									<span>제목 : </span> <input type="text" name="title" id="qTitle" required>
									<textarea name="content" id="reportText" cols="30" rows="10" required></textarea>
								</div>
							</div>
						</div>
						<div class="" id="qSecret">
							<input type="radio" name="privateYn" id="private" value="Y"> 
							<label for="private">비밀글</label>
							
							<input type="radio" name="privateYn" id="public" value="N"> 
							<label for="public">공개</label>
						</div>
						<div class="modal-footer justify-content-center">
							<button type="submit" class="btn btn-primary col-4">등록하기</button>
							<button type="button" class="btn btn-secondary col-4" data-dismiss="modal">취소하기</button>
						</div>
					</form>
					<!--------------- 태영 수정 end ------------------------------>	
				</div>
			</div>
		</div>
		<!--문의 글 작성 시작(부트스트랩)-->

		<!--신고 모달 시작 (부트스트랩)-->
		<form:form name="reviewReportFrm" method="POST"
			action="${pageContext.request.contextPath}/shop/insertReport">
			<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog"
				aria-labelledby="exampleModalLabel" aria-hidden="true">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="exampleModalLabel">신고하기</h5>
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
						<div class="modal-body">
							<div class="m-body1">
								<p>신고대상 ID 및 내용</p>
								<div>
									<span id="reportId">해당 ID : </span> <span id="hereId"></span>
									<hr id="reportHr">
									<p style="font-weight: bold;">신고 대상 글</p>
									<span id="hereContent"></span> <input type="hidden" name="id"
										id="rId" /> <input type="hidden" name="memberNo"
										id="rMemberNo" /> <input type="hidden" name="targetPkNo"
										id="rReviewNo" /> <input type="hidden" name="reportContent"
										id="rContent" /> <input type="hidden" name="reportRootCate"
										value="PR" />
								</div>
							</div>
							<div class="m-body2 mt-3">
								<p>신고사유</p>
								<div class="checkboxReport">
									<form action="#">
										<table>
											<tr>
												<td><input type="radio" id="check1" name="reasonCate"
													value="1" required> <label for="check1">욕설/비방
														&emsp;&emsp;&emsp;&emsp;</label></td>
												<td><input type="radio" id="check2" name="reasonCate"
													value="2"> <label for="check2">광고/홍보글</label></td>
												<td><input type="radio" id="check3" name="reasonCate"
													value="3"> <label for="check3">음란/선정성</label></td>
											</tr>
											<tr>
												<td><input type="radio" id="check4" name="reasonCate"
													value="4"> <label for="check4">게시글도배</label></td>
												<td><input type="radio" id="check5" name="reasonCate"
													value="5"> <label for="check5">관련없는 이미지/내용
														&emsp;&nbsp; &nbsp; </label></td>
												<td><input type="radio" id="check6" name="reasonCate"
													value="6"> <label for="check6">기타</label></td>
											</tr>
										</table>
										<textarea name="sideNote" id="reportText" cols="30" rows="10"
											maxlength='195' placeholder="상세내용을 기입해주세요(선택)"></textarea>
									</form>
									<p style="font-size: 12px;">ⓘ 신고해주신 내용은 관리자 검토 후 내부정책에 의거
										조치가 진행됩니다.</p>
								</div>
							</div>
						</div>
						<div class="modal-footer justify-content-center">
							<button type="submit" class="btn btn-primary col-4">신고하기</button>
							<button type="button" class="btn btn-secondary col-4"
								data-dismiss="modal" id="deleteReporBtn">취소하기</button>
						</div>
					</div>
				</div>
			</div>
		</form:form>
		<!--신고 모달 끝 (부트스트랩)-->
		<!--리뷰사진확대 모달 시작-->
		<div id="reviewModal" class="review-modal-div ml-12"
			onclick="expandClose()">
			<img id="closeIcon" src="https://i.ibb.co/rmVYp7Z/x-icon.png" alt=""
				onclick="expandClose()"> <img
				src="https://i.ibb.co/XLNWsgC/red-square.jpg" alt=""
				id="reviewExpansion">
		</div>
		<!--리뷰사진확대 모달 끝-->
		<!-- 상품 페이지 시작 -->
		<div id="itemDetailPicDiv" class="row align-items-center">
			<div id="itemDetailBicPicDiv">
				<img
					src="${pageContext.request.contextPath}/resources/upload/product/${product.thumbnail}"
					alt="">
			</div>
		</div>
		<div id="itemDetailInfoDiv"
			data-product-code="${product.productCode }"
			data-price="${product.price }" data-name="${product.name }"
			data-amount="1" data-thumbnail="${product.thumbnail }">
			<div id="itemDetailNameDiv">
				<p>${product.name}</p>
			</div>
			<div id="itemDetailOptionDiv">
				<span id="price"><fmt:formatNumber value="${product.price}"
						pattern="#,###,###" /></span> 원 <br> <span>혜택 : </span><span
					style="color: pink;"><fmt:formatNumber
						value="${product.price / 200}" pattern="#,###,### P" /> </span>적립 <br>
				<span>배송 : </span><span>3,000원</span> <br>
				<div id="jeju">
					<span>제주도/도서산간 지역 4,000원 추가</span> <i id="wishlistBtn"
						class="far fa-heart wishBtn" data-wishyn="N"></i>
				</div>
				<hr>
				<div id="restockDiv">
					<button id="restockModalBtn" type="button" data-toggle="modal"
						data-target="#exampleModal4">
						<i class="far fa-envelope" id="restock"> <span
							id="restockSpan"> &nbsp; 재입고 시 sms 알림</span>
						</i>
					</button>
				</div>
				<select id="detailNo" class="form-select col-12"
					aria-label="Default select example">
					<option selected>옵션선택</option>
					<c:if test="${cartValid ne null }">
						<c:forEach items="${pDetail}" var="pd">
							<option value="${pd.detailNo}"
								data-cart-valid="${fn:contains(cartValid, pd.detailNo)? 1 : 0}"
								<c:if test="${pd.quantity <1}">
									disabled
								</c:if>>${pd.optionNo}
								<c:if test="${pd.optionContent != null}">
									, ${pd.optionContent}
								</c:if>
								<sec:authorize access="hasRole('AM')">
									<span style="font-size: 10px;"> [재고 : ${pd.quantity}]</span>
								</sec:authorize>
								<c:if test="${pd.quantity <1}">
									[품절된 상품입니다]
								</c:if>
							</option>
						</c:forEach>
					</c:if>
					<c:if test="${cartValid eq null }">
						<c:forEach items="${pDetail}" var="pd">
							<option value="${pd.detailNo}"
								<c:if test="${pd.quantity <1}">
									disabled
								</c:if>>${pd.optionNo}
								<c:if test="${pd.optionContent != null}">
									 , ${pd.optionContent}
								</c:if>
								<c:if test="${pd.quantity <1}">
									[품절된 상품입니다]
								</c:if>
							</option>
						</c:forEach>
					</c:if>
				</select>
				<div id="priceDiv" class="mt-3 mb-3">
					<span>주문금액</span><span><fmt:formatNumber
							value="${product.price}" pattern="#,###,### 원" /></span>
				</div>
				<div id="orderBtnDiv" class="text-center row">
					<button type="button" id="cartBtn" class="col-6">장바구니</button>
					<button type="button" id="orderBtn" class="col-6">바로구매</button>

				</div>
			</div>
			<div id="itemDetailOrderDiv"></div>
		</div>
	</div>
	<div id="itemDetailMenuTabDiv">
		<!-- 탭 시작 -->
		<div id="menu-tab">
			<div id="page-wrap" style="width: 1200px;">
				<div class="tabs">
					<!--1번째 탭---->
					<div class="tab">
						<input id="tab-1" checked="checked" name="tab-group-1"
							type="radio" /> <label for="tab-1"><span
							class="tab-span">리뷰 </span></label>
						<div class="content height600">
							<!--상단 갯수 및 선택 옵션 시작-->
							<div class="item-sort-container d-flex justify-content-between">
								<div class="p-4" style="margin-top: 9px;">
									<span id="reviewTotal"></span>
								</div>
								<div class="p-4" id="sortBy">
									<span class="pr-2 pl-2 shop-sort newReview"
										onclick="reviewAll()">최신순</span> <span
										class="pr-2 pl-2 shop-sort" onclick="oldestToNewest()">오래된순
									</span> <input type="hidden" name="oldestToNewest" id="oldestToNewest"
										value="-1" /> <span class="pr-2 pl-2 shop-sort"
										onclick="picReviewOnly()">사진리뷰모아보기</span>
									<sec:authorize access="hasAnyRole('M1','M2')">
										<button type="button" class="btn btn-warning report-btn3"
											data-toggle="modal" data-target="#exampleModal3">리뷰작성하기</button>
									</sec:authorize>
								</div>
							</div>
							<hr>
							<!--상단 갯수 및 선택 옵션 끝-->
							<div id="reviewBefore"></div>
							<!--리뷰시작-->
							<!--리뷰끝-->
						</div>
					</div>
					<!--2번째 탭---->
					<div class="tab">
						<input id="tab-2" name="tab-group-1" type="radio" /> <label
							for="tab-2"><span class="tab-span">문의</span></label>
						<div class="content height600">
							<!--상단 갯수 및 선택 옵션 시작-->
							<div class="item-sort-container d-flex 	justify-content-between">
							
								<div class="p-4" id="sortBy">
									<!--문의 부트스트랩 버튼-->
									<!-- 로그인 했을때만 버튼 노출 -->
									<c:if test="${loginMemberId ne null }">
										<button type="button" class="btn btn-warning 2" data-toggle="modal" data-target="#exampleModal2">문의작성하기</button>
									</c:if>
								</div>
							</div>
							<hr>
							<!--상단 갯수 및 선택 옵션 끝-->
							<!--문의시작-->
							<!-- -------------------------- 태영 문의 파트 시작-------------------------------------- -->
							<div class="question-div forFont">
								<div class="a-question-div">
															
									<c:forEach items="${questionList}" var="ql">	
										<div class="question-answer-container">
											<c:if test="${ql.questionLevel == 1 }">
												<div class="question-container">
													<div class="question-title">
														<p><span id="qTitle">제목 : ${ql.title }</span>
														 | <c:if test="${ql.questionRefNo == 0 }"><span class="answer-no">답변 대기</span></c:if>
														   <c:if test="${ql.questionRefNo != 0 }"><span class="answer-ok">답변 완료</span></c:if>
														 </p>
													</div>
													<div class="question-body">
														<h6><span id="writer">${ql.id}</span> | <fmt:formatDate value="${ql.enrollDate}" pattern="yyyy-MM-dd HH:mm"/></h6>														
														<img id="hr66" src="https://i.ibb.co/pwQZhVY/line.png"><br />													
														<c:if test="${ql.privateYn eq 'Y'.charAt(0) }"><i class="fas fa-lock"></i><span class="private-yn">비공개 글입니다</span><input type="hidden" class="p-yn" value="Y" /></c:if>
											   			<c:if test="${ql.privateYn eq 'N'.charAt(0)}"><i class="fas fa-lock-open"></i><span class="private-yn">공개 글입니다</span><input type="hidden" class="p-yn" value="N" /></c:if>
													</div>
												</div>
												<div class="question-content slide-target">
													<div class="card card-body">
														<p>${ql.content }</p>
													</div>
												</div>
											</c:if>
											<c:if test="${ql.questionLevel == 2 }">
												<div class="answer-container slide-target-answer" >
													<div class="answer-title"></div>
													<br />
													<i class="fas fa-font"></i><span class="admin-title">관리자 | <fmt:formatDate value="${ql.enrollDate}" pattern="yyyy-MM-dd HH:mm"/></span>
													<div class="answer-content">
														<div class="card card-body">
															<p>${ql.content }</p>
														</div>
													</div>
												</div>
											</c:if>
										</div>
									</c:forEach>
								</div>
							</div>
							<!-- -------------------------- 태영 문의 파트 끝------------------------------------- -->
							<!--문의끝-->
						</div>
					</div>
					<!--3번째 탭---->
					<div class="tab">
						<input id="tab-3" name="tab-group-1" type="radio" /> <label
							for="tab-3"><span class="tab-span">배송/환불</span></label>
						<div class="content height600">
							<div id="infoForARefund">
								<div id="firstInfo">
									<h3>반품/교환 사유에 따른 요청 가능 기간</h3>
									<p class="mt-3">1.구매자 단순 변심은 상품 수령 후 7일 이내 (구매자 반품배송비 부담)</p>
									<p>2.표시/광고와 상이, 상품하자의 경우 상품 수령 후 3개월 이내 혹은 표시/광고와 다른 사실을 안
										날로부터 30일 이내. 둘 중 하나 경과 시 반품/교환 불가 (판매자 반품배송비 부담)</p>
								</div>
								<div id="secondInfo">
									<h3>반품/교환 불가능 사유</h3>
									<h5>아래와 같은 경우 반품/교환이 불가능합니다.</h5>
									<p class="mt-3">1.반품요청기간이 지난 경우</p>
									<p>2.구매자의 책임 있는 사유로 상품 등이 멸실 또는 훼손된 경우 (단, 상품의 내용을 확인하기 위하여
										포장 등을 훼손한 경우는 제외)</p>
									<p>3.포장을 개봉하였으나 포장이 훼손되어 상품가치가 현저히 상실된 경우 (예: 식품, 화장품)</p>
									<p>4.구매자의 사용 또는 일부 소비에 의하여 상품의 가치가 현저히 감소한 경우 (라벨이 떨어진 의류
										또는 태그가 떨어진 명품관 상품인 경우)</p>
									<p>5.시간의 경과에 의하여 재판매가 곤란할 정도로 상품 등의 가치가 현저히 감소한 경우 (예: 식품,
										화장품)</p>
									<p>6.고객주문 확인 후 상품제작에 들어가는 주문제작상품</p>
									<p>7.복제가 가능한 상품 등의 포장을 훼손한 경우 (CD/DVD/GAME/도서의 경우 포장 개봉 시)</p>
								</div>
								<hr>
								<div id="ThirdInfo">
									<h3>판매자정보</h3>
									<table class="mt-3">
										<tr>
											<td>상호</td>
											<td>DevRun</td>
										</tr>
										<tr>
											<td>대표자</td>
											<td>CodeName200</td>
										</tr>
										<tr>
											<td>사업장소재지</td>
											<td>서울시 강남구 테헤란로</td>
										</tr>
										<tr>
											<td>고객센터 전화번호 &nbsp&nbsp</td>
											<td>070-1111-1111</td>
										</tr>
										<tr>
											<td>이메일</td>
											<td>devrunlearn@gmail.com</td>
										</tr>
									</table>
								</div>
							</div>
						</div>
					</div>
					<!--4번째 탭---->
					<div class="tab">
						<input id="tab-4" name="tab-group-1" type="radio" /> <label
							for="tab-4"><span class="tab-span">추천</span></label>
						<div class="content height600">
							<div id="recommendedDiv">
								<div class="p-4 ml-4" style="font-family: 'SANJUGotgam';">
									<h2>비슷한 상품</h2>
								</div>
								<div id="recommendedPicDiv" class="d-flex">
									<c:forEach items="${recommendation}" var="r" begin="0" end="2">
										<!-- 상품추천 1건 시작 -->
										<div class="recom-info">
											<img class ="recom-border"
												src="${pageContext.request.contextPath}/resources/upload/product/${r.thumbnail}"
												alt="추천상품이미지">
											<div class="mt-2 forFont2">
												<span style="font-weight: bold; color: midnightblue;">${r.name}</span>
												<br> <span><fmt:formatNumber value="${r.price}"
														pattern="#,###,### 원" /></span> <br> <span></span>
											</div>
										</div>
										<!-- 상품추천 1건 끝 -->
									</c:forEach>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- 탭 끝  -->
	</div>
</div>




<!-- 위시리스트 로그인 했을 시 비동기 시작 -->
<sec:authorize access="isAuthenticated()">
	<script>
$(document).on('click', '.wishBtn', function(e) {
	
	const $memberNo = ${member.memberNo};
	const $productCode = '${product.productCode}';

	console.log(`$memberNo : \${$memberNo}`);
	console.log(`$productCode : \${$productCode}`);
	
	const wishYn = $(e.target).data("wishyn");
	
	if(wishYn == 'N'){
			$.ajax({
				
				url: "${pageContext.request.contextPath}/shop/wishlistAdd",
				method: "Get",
				data : {
					memberNo:  $memberNo,
					productCode : $productCode 
					
				},
				success(data){
					if(data == 1){
						$(e.target).data('wishyn', 'Y');
						$(e.target).attr('class', 'fas fa-heart wishBtn');							
					}
				},
				error: console.log
		});
	}else{
		$.ajax({
			
			url: "${pageContext.request.contextPath}/shop/wishlistDelete",
			method: "Get",
			data : {
				memberNo:  $memberNo,
				productCode : $productCode 
				
			},
			success(data){
				if(data == 1){
					$(e.target).data('wishyn', 'N');
					$(e.target).attr('class', 'far fa-heart wishBtn');							
				}
			},
			error: console.log
	});
		
		
	}
	
})
</script>
</sec:authorize>
<!-- 위시리스트 로그인 했을 시 비동기 끝 -->

<!-- 위시리스트 비 로그인 시 비동기 시작 -->
<sec:authorize access="isAnonymous()">
	<script>
$(document).on('click', '.wishBtn', function(e) {
	alert("로그인 후 이용가능합니다.");
	return;

})

</script>
</sec:authorize>
<!-- 위시리스트 비 로그인 시 비동기 끝 -->

<script>
/*리뷰삭제 */

$(document).on('click', '.reviewDelBtn', function(e) {
	var reviewNo =e.target.value;	
	console.log(`삭제할 리뷰 아이디 : \${reviewNo}`);
	
	if(confirm("리뷰를 삭제하시겠습니까?")){
		location.href=`${pageContext.request.contextPath}/shop/reviewDelete.do?reviewNo=\${reviewNo}`;	
	}else{
		 return;
	}
	
	
});

/*사진리뷰만 보기 정렬 시작 */
function picReviewOnly(){
	var $productCode = $(productCodeV).val(); 
	var $div = $('#reviewBefore');
	
	$.ajax({
		
		url: "${pageContext.request.contextPath}/shop/picReviewOnly",
		data: {
			productCode : $productCode
			
		},
		method: "GET",
		success(data){		
			$div.children().detach();
			const s = data["reviewSb"];	
			const t = data["reviewTotal"]; 
			$div.append(s);
			$(reviewTotal).html(`총 \${t} 개`);
			
			
		},
		error: console.log
	});
	
	 
}
/*사진리뷰만 보기 정렬 끝 */


/*onload시 비동기 리뷰 조회 시작 */
window.onload = reviewAll;
	   
function reviewAll(){
	const $v = $('#oldestToNewest');
	var $productCode = $(productCodeV).val(); 
	var $div = $('#reviewBefore');
	
	//todayItemStorage 함수 호출
	todayItemStorage();

	$.ajax({
		
		url: "${pageContext.request.contextPath}/shop/review",
		data: {
			productCode : $productCode,
			orderBy: $v.val()
		},
		method: "GET",
		success(data){		
			$div.children().detach();
			const s = data["reviewSb"];	
			const t = data["reviewTotal"]; 
			$div.append(s);
			$(reviewTotal).html(`총 \${t} 개`);
			$v.val("-1");
			
			//위시리스트 check
			const wishCheckYn = data["wishCheckYn"];
			if(wishCheckYn == 1){
				$('#wishlistBtn').data('wishyn', 'Y');
				$('#wishlistBtn').attr('class', 'fas fa-heart wishBtn');							
			}
			
		},
		error : function(xhr, status, err){
            console.log(xhr, status, err);
        }
	});
	
}  

/*onload시 비동기 리뷰 조회 시작 */

/* 리뷰 오래된 순 정렬 기능 시작 */
function oldestToNewest(){
	const $v = $('#oldestToNewest');
	$v.val("1")
	
	reviewAll();
	
}
/* 리뷰 오래된 순 정렬 기능 끝 */

/*신고창 정보 얻기 위해서 시작 */
$(document).on('click', '.report-btn', function(e) {

	 var tr = e.target;
	 
	 const id =tr.dataset.id;
	 const memberNo = tr.dataset.memberNo;
	 const reviewNo = tr.dataset.reviewNo;
	 const content = tr.dataset.content;
	 
	 $(hereId).text(id);
	 $(hereContent).text(content);
	 
	 $(rId).val(id);
	 $(rMemberNo).val(memberNo);
	 $(rReviewNo).val(reviewNo);
	 $(rContent).val(content);
})

/*신고창 정보 얻기 위해서 끝 */


/*좋아요 비동기 시작*/
$(document).on('click', '.likes', function(e) {

	const $productCode = $(productCodeV).val(); 
	const $memberNo =  $(e.target).data('memberNo');	
	const $reviewNo = $(e.target).data('reviewNo');
	const s = $(e.target).data('likesyn');
	
	if(s == 'N'){
		
		$.ajax({
			url: "${pageContext.request.contextPath}/shop/reviewLikeAdd",
			method: "Get",
			data : {
				reviewNo : $reviewNo,
				memberNo:  $memberNo,
				productCode : $productCode 
				
			},
			success(data){
			const result = data["result"];
			const newCountLikes = data["newCountLikes"];
			console.log(`result : \${result}`);
			console.log(`newCountLikes : \${newCountLikes}`);
			
			
			if(result == 1) {
				$(e.target).data('likesyn', 'Y');
				$(e.target).attr('class', 'fas fa-heart likes');			
				console.log($(e.target).data('likesyn'));	
			
				$(e.target).text(newCountLikes);
			}
			},
			error : function(xhr, status, err){
	            console.log(xhr, status, err);
	            alert("로그인 후 이용이 가능합니다.");
	        } 
		});
	}else{
		
		$.ajax({
			url: "${pageContext.request.contextPath}/shop/reviewLikeDelete",
			method: "Get",
			data : {
				reviewNo : $reviewNo,
				memberNo:  $memberNo,
				productCode : $productCode 
				
			},
			success(data){
				const result = data["result"];
				const newCountLikes = data["newCountLikes"];
				console.log(`result : \${result}`);
				console.log(`newCountLikes : \${newCountLikes}`);
			
			if(result == 1) {
				$(e.target).data('likesyn', 'N');
				$(e.target).attr('class', 'far fa-heart likes');		
				console.log($(e.target).data('likesyn'));	
			
				$(e.target).text(newCountLikes);
			}
			
			},
			error : console.log
		});
	}
})

/*좋아요 비동기 끝*/

/*재입고 sms 전화번호 유효성 검사 시작*/
$("#phoneSms").keyup((e)=>{
	const $phone = $("#phoneSms");
	$phone.val($phone.val().replace(/[^0-9]/g, "")); //숫자아닌 문자(복수개)제거하기
	
	if(!/^010[0-9]{8}$/.test($phone.val())){
    	$('#checkPhone').text('유효하지 않은 전화번호입니다.');
    	$('#checkPhone').attr("data-vaild","N");
	}else{
		$('#checkPhone').text('올바른 형식의 전화번호입니다.');
		$('#checkPhone').attr("data-vaild","Y");
	}
})
 /*재입고 sms 전화번호 유효성 검사 끝*/
 
 
 /*sms 문자보내기 비동기 처리*/
 $(smsFrm).submit((e) => {
	e.preventDefault(); // 폼제출방지
	
	const vaild = $('#checkPhone').data('vaild');
	console.log(`유효성 체크 : \${vaild}`);	
	
	if(vaild == 'N'){
		alert("유효하지 않은 전화번호입니다. 다시 입력해주세요.");
		return;
	}else{
		//전화번호
		const phoneNumber = $(phoneSms).val();
		const detailNo = $("#smsOption option:selected").val();
		const options = $("#smsOption option:selected").text();
		console.log(`전화번호 : \${phoneNumber}`);
		console.log(`detailNo : \${detailNo}`);
		console.log(`productName: ${product.name}`);
		
		const msg = `<p>&#171;${product.name}&#187; 상품의 &#171\${options}&#187; 옵션 재입고 알람 신청이 완료되었습니다.</p>`;
		
		$.ajax({
			url : "${pageContext.request.contextPath}/shop/restock",
			method : "POST",
			data :{
				detailNo : detailNo,
				phoneNumber : phoneNumber,
				productName: '${product.name}',
				productCode: '${product.productCode}'
			},
			success(data){
				if(data ==1){
					$(smsBody).html('');
					$(smsBody).append(msg);
					$('.modal-footer').html('');
					$('.modal-footer').append('<button type="button" id="smsCloseBtn" class="btn btn-secondary" data-dismiss="modal" onclick="reloadSms()">닫기</button>');
					
				}
			},
			error :console.log	
		});
	}
 })
 /*sms 문자보내기 비동기 처리*/
 
 function reloadSms(){
	location.reload();
}

//오늘본상품시작
function todayItemStorage(){
	 const productCode = '${todayItemCode}';
	 console.log(`todayItemCode : \${productCode}`);
	 
	 if(productCode == '' || productCode == null || productCode == undefined)
	 	return;
	
    const aViewdItem = {
    	    productCode: productCode,
    	    regDate: Date.now()
    	};
      
    var check = 0;
    var now = Date.now();
    
    // 1. localStorage에 저장
    const todayViewitems = JSON.parse(localStorage.getItem('todayViewitems')) || [];
  	
    if(todayViewitems.length){
        //객체배열 순회
        $.each(todayViewitems, function(i, aViewdItem){  
        	if(aViewdItem != null){
	        	
        		//24시간 지난 건 삭제 때리기
	        	var timeCal = now - aViewdItem.regDate;
	        	if(timeCal > 86400000){
	        	 	todayViewitems.splice(i,1); 
	        	}
	        	
        		//중복된 건 저장 안 되게 처리
	        	if(aViewdItem.productCode == productCode){
	        		check = 1;
	        	}  
        	}
        });
    }

  	if(check == 0){
	    todayViewitems.push(aViewdItem);  		
  	}
    
    //entries배열을 JSON으로 변환
    var jsonTodayViewitems = JSON.stringify(todayViewitems);

    //localStorage에 저장
    localStorage.setItem("todayViewitems", jsonTodayViewitems);
    
}
//오늘본상품끝



//-------------------------------------------------------구분선-------------------------------------------------------------



//바로구매 버튼 클릭 이벤트 혜진 시작
$("#orderBtn").click((e)=>{
	const detailNo = $("#detailNo").val();
	const $itemDetailInfo = $("#itemDetailInfoDiv");
	let cartArr = [];
	
	let data = {
			productCode : $itemDetailInfo.data("productCode"),
			detailNo : detailNo,
			name : $itemDetailInfo.data("name"),
			price : $itemDetailInfo.data("price"),
			amount : $itemDetailInfo.data("amount"),
			thumbnail : $itemDetailInfo.data("thumbnail")
	};
	console.log(data);
	cartArr.push(data);
	console.log(cartArr);
	localStorage.setItem("cartItems", JSON.stringify(cartArr));
	location.href = "${pageContext.request.contextPath}/order/order";

});
//바로구매 버튼 클릭 이벤트 혜진 끝
//장바구니 버튼 클릭 이벤트 혜진 시작
$("#cartBtn").click((e)=>{
	console.log("클릭 이벤트");
	const detailNo = $("#detailNo").val();
	let cartValid = $(`option[value=\${detailNo}]`).data("cartValid");
	console.log(detailNo);
	
	if($("#memberNoV").val() == null){
		alert("로그인 후 이용 가능합니다.");
		return;
	}
	
	if(detailNo == '옵션선택'){
		alert("옵션을 먼저 선택해 주세요.");
		return;
	}
	
	if(cartValid == 1){
		const cartConfirm = confirm("이미 장바구니 추가된 상품입니다. 장바구니로 이동하시겠습니까?");
		if(cartConfirm){
			location.href = "${pageContext.request.contextPath}/order/cart.do";
			return;
		}
		else{
			return;
		}
	}
	
	$.ajax({
		url : "${pageContext.request.contextPath}/shop/cartEnroll",
		method : "POST",
		data : {
			memberNo : $("#memberNoV").val(),
			detailNo : detailNo,
			amount : 1,
			price : $("#price").data("price")*1
		} ,
		success(data){
			console.log(data);
			if(data == 1){
				cartValid = 1;
				alert("장바구니에 추가되었습니다.");
			}
		},
		error: console.log
	});
});






//-------------------------------------------------------구분선 아래 태영----------------------------------------------------------


// 상품 문의 로그인 검사




// 비밀글 열람에 쓰일 로그인 정보
var loginMemberId = "${loginMemberId}"
var authority = "${authority}"

console.log("로그인 회원의 ID = ",loginMemberId);
console.log("로그인한 회원의 권한 = ",authority);



// 상품 문의 리스트 
$(()=>{
 	$(".slide-target, .slide-target-answer").slideUp(); 
});
 
var $target1;
var $target2;

// 슬라이드를 통해 해당 질문글의 내용과 답변을 보여주게 된다.
var openQuestion = function(ta){
	ta.slideToggle();
}


$(".question-container").click(e=>{
	
	$target1 = $(e.target).parents(".question-container").next();
	$target2 = $(e.target).parents(".question-container").parent().next().children(".slide-target-answer");
	
	console.log($target1);
	console.log($target2);


	/* 클릭과 동시에 로그인 정보 확인하여 비밀글 보호 */
	var $checkYn = $(e.target).parents(".question-answer-container").find(".p-yn").val();
	var $checkLoginId = $(e.target).parents(".question-answer-container").find("#writer").text();
	
	console.log($checkYn);
	console.log($checkLoginId);
	

	/* 열람은 해당글의 작성자나 관리자만 가능*/
	if($checkYn == 'Y'){
		if(authority == "[ROLE_AM]" || $checkLoginId == loginMemberId ){
			openQuestion($target1);
			openQuestion($target2);
		}
		else{
			alert("비밀글로 작성자와 관리자만 열람 가능합니다.");
		}
	}
	else{
		openQuestion($target1);
		openQuestion($target2);
	}		
});







/* hover */
$(".question-answer-container").hover(e=>{
	$(e.target).css("cursor","pointer");
})


</script>
<!-- body 영역 끝 -->


<!-- shopHeader js  -->
<%-- <script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/shop/shopHeader.js"></script> --%>

<!-- itemDetail js -->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/shop/itemDetail.js"></script>


<!-- footer -->
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
