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
			<div id="itemDetailDisplayDiv" class="row">
				<!--리뷰작성모달 시작(부트스트랩)-->
					<form:form
					name="reviewFrm"
					method="POST"
					action="${pageContext.request.contextPath}/shop/review.do"
					enctype="multipart/form-data">
						<div class="modal fade" id="exampleModal3" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
							<div class="modal-dialog" role="document">
							<div class="modal-content">
								<div class="modal-header">
								<h5 class="modal-title" id="exampleModalLabel">리뷰 작성하기</h5>
								<button type="button" class="close" data-dismiss="modal" aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
								</div>
								<div class="modal-body">
									<div class="qm-body1">
										<p>해당상품</p>
										<div class="row" id="qItem">
											<img id="qPIc" src="https://i.ibb.co/gm7H77f/square.png" alt="">
											<p>삼성 오로라 갤럭시 마우스 2021년 버전</p>
											<input type="hidden" name="productCode" value="332">
											<sec:authorize access="isAuthenticated()">
												<input type="hidden" name="memberNo" value='<sec:authentication property="principal.memberNo"/>' />
												<input type="hidden" name="id" value='<sec:authentication property="principal.id"/>' />
											</sec:authorize>
										</div>
										<p class="mt-3">상품 별점</p>
										<select id="rateSelect" name="rate" class="form-select col-12" aria-label="Default select example">
											<option value="5" selected> 별점 5점 </option>
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
												<input type="file" name="upFile" id="reviewPic" onchange='openFile(event)'>
											</div>
										</div>
										<p class="mt-3">리뷰 작성</p>
										<div class="checkboxReport">
											<textarea style="-ms-overflow-style: none;" name="content" id="reportText" cols="30" rows="10" maxlength='900' required></textarea>
											<span id="textLength">0/900</span>
										</div>
										<p style="font-size: 12px;">ⓘ 포토리뷰 500P / 글리뷰 100P 적립</p>
									</div>
								</div>
								<div class="modal-footer justify-content-center">
								<button type="submit" class="btn btn-primary col-4">등록하기</button>
								<button type="button" class="btn btn-secondary col-4" data-dismiss="modal" onclick="deleteReview();">취소하기</button>
								</div>
							</div>
							</div>
						</div>
					</form:form>
				<!--리뷰작성모달 끝-->
				<!--문의 글 작성 시작(부트스트랩)-->
					<div class="modal fade" id="exampleModal2" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
						<div class="modal-dialog" role="document">
						<div class="modal-content">
							<div class="modal-header">
							<h5 class="modal-title" id="exampleModalLabel">상품 문의하기</h5>
							<button type="button" class="close" data-dismiss="modal" aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
							</div>
							<div class="modal-body">
								<div class="qm-body1">
									<p>해당상품</p>
									<div class="row" id="qItem">
										<img id="qPIc" src="https://i.ibb.co/gm7H77f/square.png" alt="">
										<p>삼성 오로라 갤럭시 마우스 2021년 버전</p>
										<input type="hidden" name="product_code">
									</div>
								</div>
								<div class="m-body2 mt-3">
									<p>문의 사항</p>
									<div class="checkboxReport">
										<span>제목 : </span>
										<input type="text"name="" id="qTitle" required>
										<textarea  name="" id="reportText" cols="30" rows="10" required></textarea>
									</div>
								</div>
							</div>
							<div class="" id="qSecret">
								<input type="checkbox" name="postSecret" id="">
								<label for="postSecret">비밀글 여부</label>
	
							</div>
							<div class="modal-footer justify-content-center">
							<button type="button" class="btn btn-primary col-4">등록하기</button>
							<button type="button" class="btn btn-secondary col-4" data-dismiss="modal">취소하기</button>
							</div>
						</div>
						</div>
					</div>
				<!--문의 글 작성 시작(부트스트랩)-->
	
				<!--신고 모달 시작 (부트스트랩)-->
					<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
						<div class="modal-dialog" role="document">
						<div class="modal-content">
							<div class="modal-header">
							<h5 class="modal-title" id="exampleModalLabel">신고하기</h5>
							<button type="button" class="close" data-dismiss="modal" aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
							</div>
							<div class="modal-body">
								<div class="m-body1">
									<p>신고대상 ID 및 내용</p>
									<div>
										<span id="reportId">해당 ID : </span> watt0930
										<hr id="reportHr">
										<p style="font-weight: bold;">신고 대상 글  </p>
										<span>그지같은깽깽이야 이삐리리삐리리 Lorem ipsum dolor sit amet consectetur adipisicing elit. Nostrum mollitia quo dolorum nobis ut unde commodi blanditiis! Distinctio adipisci quidem, repellendus eum cupiditate at sunt ab iste, voluptates, aperiam alias!</span>
									</div>
								</div>
								<div class="m-body2 mt-3">
									<p>신고사유</p>
									<div class="checkboxReport">
										<form action="#">
											<table>
												<tr>
													<td>
														<input type="radio" id="check1" name="chch">
														<label for="check1">욕설/비방 &emsp;&emsp;&emsp;&emsp;</label>
													</td>
													<td>
														<input type="radio" id="check2" name="chch">
														<label for="check2">광고/홍보글</label>
													</td>
													<td>
														<input type="radio" id="check3" name="chch">
														<label for="check3">음란/선정성</label>
													</td>
												</tr>
												<tr>
													<td>
														<input type="radio" id="check4" name="chch">
														<label for="check4">게시글도배</label>
													</td>
													<td>
														<input type="radio" id="check5" name="chch">
														<label for="check5">관련없는 이미지/내용 &emsp;&nbsp; &nbsp; </label>
													</td>
													<td>													
														<input type="radio" id="check6" name="chch">
														<label for="check6">기타</label>
													</td>
												</tr>
											</table>
											<textarea name="" id="reportText" cols="30" rows="10"></textarea>
										</form>
										<p style="font-size: 12px;">ⓘ 신고해주신 내용은 관리자 검토 후 내부정책에 의거 조치가 진행됩니다.</p>
									</div>
								</div>
							</div>
							<div class="modal-footer justify-content-center">
							<button type="button" class="btn btn-primary col-4">신고하기</button>
							<button type="button" class="btn btn-secondary col-4" data-dismiss="modal">취소하기</button>
							</div>
						</div>
						</div>
					</div>
				<!--신고 모달 끝 (부트스트랩)-->
				<!--리뷰사진확대 모달 시작-->
				<div id="reviewModal" class="review-modal-div ml-12" onclick="expandClose()">
					<img id="closeIcon" src="https://i.ibb.co/rmVYp7Z/x-icon.png" alt="" onclick="expandClose()">
					<img src="https://i.ibb.co/XLNWsgC/red-square.jpg" alt="" id="reviewExpansion">
				</div>
				<!--리뷰사진확대 모달 끝-->
				<div id="itemDetailPicDiv" class="row align-items-center">
					<div id="itemDetailBicPicDiv">
						<img src="https://i.ibb.co/gm7H77f/square.png" alt="">
					</div>
				</div>
				<div id="itemDetailInfoDiv">
					<div id="itemDetailNameDiv">
						<p>[국내공식정품] G304 WIRELESS 무선 게이밍 마우스</p>
					</div>
					<div id="itemDetailOptionDiv">
						<span>59,590</span>원
						<br><span>혜택 : </span><span style="color:pink;">180p </span>적립
						<br><span>배송 : </span><span>무료배송</span>
						<br>
						<div id="jeju">
							<span>제주도/도서산간 지역 4,000원 추가</span>
							<i class="far fa-heart"></i>
						</div>
						<hr>
						<select class="form-select col-12" aria-label="Default select example">
							<option selected>옵션선택</option>
							<option value="1">One</option>
							<option value="2">Two</option>
							<option value="3">Three</option>
						</select>
						<div id="priceDiv" class="mt-3 mb-3">
							<span>주문금액</span><span>40,000</span>
						</div>
						<div id="orderBtnDiv" class="text-center row">
							<button type="button" class="btn btn-primary col-6">장바구니</button>
							<button type="button" class="btn btn-secondary col-6">바로구매</button>
						</div>
					</div>
					<div id="itemDetailOrderDiv">
					</div>
				</div>
			</div>
			<div id="itemDetailMenuTabDiv">
				<!-- 탭 시작 -->
					  <div id="menu-tab">
						<div id="page-wrap" style="width: 1200px;">
						  <div class="tabs">
							<!--1번째 탭---->
							<div class="tab">
							  <input id="tab-1" checked="checked" name="tab-group-1" type="radio" />
							  <label for="tab-1"><span class="tab-span">리뷰 </span></label>
							  <div class="content height600" >
								<!--상단 갯수 및 선택 옵션 시작-->
								<div class="item-sort-container d-flex justify-content-between">
								  <div class="p-4" style="margin-top: 9px;">총 ${reviewTotal}개</div>
								  <div class="p-4" id="sortBy">
									<span class="pr-2 pl-2 shop-sort">최신순</span>
									<span class="pr-2 pl-2 shop-sort">오래된순 </span>
									<span class="pr-2 pl-2 shop-sort">사진리뷰모아보기</span>
									<sec:authorize access="hasAnyRole('M1','M2')">
										<button type="button" class="btn btn-warning report-btn3" data-toggle="modal" data-target="#exampleModal3">리뷰작성하기</button>	
									</sec:authorize>
								  </div>
								</div>
								<hr>
								<!--상단 갯수 및 선택 옵션 끝-->
								<div></div>
								<!--리뷰시작-->
								<c:if test="${reviewList != null}">
									<c:forEach items="${reviewList}" var="l">
										<div class="aReviewDiv forFont">
										  <div class="shop-review row">
											<div class="reviewProfile">
											  <img class="rounded-circle mt-3" src="https://i.ibb.co/L6xBDk1/profile.png"  alt="">
											</div> 
											<div class="reviewContent ml-3">
											<c:forEach var="i" begin="1" end="${l.rate}">
											  <i class="fas fa-star"></i>
											</c:forEach>
											  <br><span>${l.id}</span> | <span> <fmt:formatDate value="${l.regDate}" pattern="yyyy년MM월dd일 HH:mm:ss"/></span> | 
											  <!-- Button trigger modal -->
											  <button type="button" class="btn btn-primary report-btn" data-toggle="modal" data-target="#exampleModal">신고</button>
											  <br><span>상품옵션 : </span> <span>핑크</span>
											  <div class="reviewP mt-3">
											  ${l.content}
											  </div>  
											</div>
											<!-- 리뷰 첨부파일 있을 시에만 사진 띄우기 처리 시작 -->
											<c:if test="${l.attach.reviewAttachNo != 0}">
												<div class="reviewPhoto">
												  <img src="${pageContext.request.contextPath}/resources/upload/review/${l.attach.renamedFilename}" alt="" onclick="expandPic(event)">
												  <div  class="reviewLikeBtn text-center border border-success rounded mt-1">
													<i class="far fa-heart">3</i>
												  </div>
												</div>
											</c:if>
											<!-- 리뷰 첨부파일 있을 시에만 사진 띄우기 처리 끝 -->
										  </div>
										</div>
									</c:forEach>
								</c:if>
								<c:if test="${empty  reviewList}">
									<span id="reviewNone">등록된 리뷰가 없습니다.</span>
								</c:if>
								<!--리뷰끝-->
							  </div>
							</div>
							<!--2번째 탭---->
							<div class="tab">
							  <input id="tab-2" name="tab-group-1" type="radio" /> 
							  <label for="tab-2"><span class="tab-span">문의</span></label>
							  <div class="content height600">
								<!--상단 갯수 및 선택 옵션 시작-->
								<div class="item-sort-container d-flex 	justify-content-between">
								  <div class="p-4"><button type="button" class="btn btn-danger">내 문의 보기</button></div>
								  <div class="p-4" id="sortBy">
									<span class="pr-2 pl-2 shop-sort">최신순</span>
									<span class="pr-2 pl-2 shop-sort">오래된순</span>
									<!--문의 부트스트랩 버튼-->
									<button type="button" class="btn btn-warning report-btn2" data-toggle="modal" data-target="#exampleModal2">문의작성하기</button>							  
								  </div>
								</div>
								<hr>
								<!--상단 갯수 및 선택 옵션 끝-->
								<!--문의시작-->
								<div class="question-div forFont">
								  <div class="a-question-div">
									<!--문의 한 건 시작-->
									<div class="customer-Q">
										<!--아코디언 시작-->
										<p>
											<a class="" data-toggle="collapse" href="#collapseExample" aria-expanded="false" aria-controls="collapseExample">
											<span class="sub">제목: 배송 언제 오나요?</span> | <span>답변완료</span>
											<br>
											<span>greendory</span> | <span>2021년 12월 25일 12시30분</span> <br>
	
											<img id ="hr66" src="https://i.ibb.co/pwQZhVY/line.png"> <br>
	
										  <i class="fab fa-quora"></i> <span>비밀글입니다.</span>
										</a>
									  </p>
									  <div class="collapse" id="collapseExample">
										<div class="card card-body">
										  Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident.
										</div>
										<div class="admin-a mt-3">
										  <i class="fas fa-font"></i> <span>관리자</span> | <span>2021년 12월 25일 12시30분</span>
										  <P class="card card-body">배송 출고 완료되어 3일 이내 도착예정입니다. </P>
										</div>
									  </div>
									  <!--아코디언 끝-->
									</div>
									<!--문의 한 건 끝-->
									<!--문의 한 건 시작-->
									<div class="customer-Q">
										<!--아코디언 시작-->
										<p>
											<a class="" data-toggle="collapse" href="#collapseExample2" aria-expanded="false" aria-controls="collapseExample">
											<span class="sub">제목: 배송 언제 오나요?</span> | <span>답변대기</span>
											<br>
											<span>greendory</span> | <span>2021년 12월 25일 12시30분</span> <br>
	
											<img id ="hr66" src="https://i.ibb.co/pwQZhVY/line.png"> <br>
	
										  <i class="fab fa-quora"></i> <span>비밀글입니다.</span>
										</a>
									  </p>
									  <div class="collapse" id="collapseExample2">
										<div class="card card-body">
										  Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident.
										</div>
										<div class="admin-a mt-3">
										  <i class="fas fa-font"></i> <span>관리자</span> | <span>2021년 12월 25일 12시30분</span>
										  <P class="card card-body">- 답변이 등록 되지 않았습니다.- </P>
										</div>
									  </div>
									  <!--아코디언 끝-->
									</div>
									<!--문의 한 건 끝-->
								  </div>
								</div>
								<!--문의끝-->
							  </div>
							</div>
							<!--3번째 탭---->
							<div class="tab">
							  <input id="tab-3" name="tab-group-1" type="radio" /> 
							  <label for="tab-3"><span class="tab-span">배송/환불</span></label>
							  <div class="content height600">
								<div id="infoForARefund">
								  <div id="firstInfo">
									<h3>반품/교환 사유에 따른 요청 가능 기간</h3>
									<p class="mt-3">1.구매자 단순 변심은 상품 수령 후 7일 이내 (구매자 반품배송비 부담)</p>
									<p>2.표시/광고와 상이, 상품하자의 경우 상품 수령 후 3개월 이내 혹은 표시/광고와 다른 사실을 안 날로부터 30일 이내.
									  둘 중 하나 경과 시 반품/교환 불가 (판매자 반품배송비 부담)</p>
								  </div>
								  <div id="secondInfo">
									<h3>반품/교환 불가능 사유</h3>
									<h5>아래와 같은 경우 반품/교환이 불가능합니다.</h5>
									<p class="mt-3">1.반품요청기간이 지난 경우</p>
									<p>2.구매자의 책임 있는 사유로 상품 등이 멸실 또는 훼손된 경우 (단, 상품의 내용을 확인하기 위하여 포장 등을 훼손한 경우는 제외)</p>
									<p>3.포장을 개봉하였으나 포장이 훼손되어 상품가치가 현저히 상실된 경우 (예: 식품, 화장품)</p>
									<p>4.구매자의 사용 또는 일부 소비에 의하여 상품의 가치가 현저히 감소한 경우 (라벨이 떨어진 의류 또는 태그가 떨어진 명품관 상품인 경우)</p>
									<p>5.시간의 경과에 의하여 재판매가 곤란할 정도로 상품 등의 가치가 현저히 감소한 경우 (예: 식품, 화장품)</p>
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
							  <input id="tab-4" name="tab-group-1" type="radio" />
							  <label for="tab-4"><span class="tab-span">추천</span></label>
							  <div class="content height600">
								<div id="recommendedDiv">
								  <div class="p-4 ml-4" style="font-family: 'SANJUGotgam';"><h2>비슷한 상품</h2></div>
								  <div id="recommendedPicDiv" class="d-flex">
									<div class="recom-info">
									  <img src="https://i.ibb.co/gm7H77f/square.png" alt="">
									  <div class="ml-4 mt-2 forFont2">
										<span style="font-weight: bold; color: midnightblue;">삼성 광선 마우스 332L</span>
										<br><span>25,800</span>
										<br><span>리뷰23</span>
									  </div>
									</div>
									<img src="https://i.ibb.co/gm7H77f/square.png" alt="">
									<img src="https://i.ibb.co/gm7H77f/square.png" alt="">
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
	<!-- body 영역 끝 -->	
			

<!-- shopHeader js  -->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/shop/shopHeader.js"></script>

<!-- itemDetail js -->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/shop/itemDetail.js" ></script>


<!-- footer -->
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
	
	