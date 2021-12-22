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
			<!--신고 모달 시작-->
			<!--신고 모달 끝-->
	
			<!--리뷰작성모달 시작-->
			<!--리뷰작성모달 끝-->
	
			<!--문의 글 작성 시작-->
			<!--문의 글 작성 끝-->
	
	
	
	
	
	
			<div id="itemDetailDisplayDiv" class="row">
				<!--리뷰사진확대 모달 시작-->
				<div id="reviewModal" class="review-modal-div" style="position: absolute;">
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
							  <label for="tab-1"><span class="tab-span">리뷰 </span><span class="tab-span">22</span></label>
							  <div class="content height600" >
								<!--상단 갯수 및 선택 옵션 시작-->
								<div class="item-sort-container d-flex justify-content-between">
								  <div class="p-4" style="margin-top: 9px;">총 465개</div>
								  <div class="p-4" id="sortBy">
									<span class="pr-2 pl-2 shop-sort">최신순</span>
									<span class="pr-2 pl-2 shop-sort">오래된순 </span>
									<span class="pr-2 pl-2 shop-sort">사진리뷰모아보기</span>
									<button type="button" class="btn btn-warning">리뷰작성</button>
								  </div>
								</div>
								<hr>
								<!--상단 갯수 및 선택 옵션 끝-->
								<div></div>
								<!--리뷰시작-->
								<div class="aReviewDiv forFont">
								  <div class="shop-review row">
									<div class="reviewProfile">
									  <img class="rounded-circle mt-1" src="https://i.ibb.co/L6xBDk1/profile.png"  alt="">
									</div> 
									<div class="reviewContent ml-3">
									  <i class="fas fa-star"></i>
									  <i class="fas fa-star"></i>
									  <i class="fas fa-star"></i>
									  <i class="fas fa-star"></i>
									  <i class="fas fa-star"></i>
									  <br><span>greendory</span> | <span>21.11.06</span> | <a href="">신고</a>
									  <br><span>상품옵션 : </span> <span>핑크</span>
									  <div class="reviewP mt-3">
										너무 좋아요 Lorem, ipsum dolor sit amet consectetur adipisicing elit. Minus deserunt perferendis aspernatur dolores aliquid labore laborum id aut beatae nulla, a sequi reiciendis placeat, quia corrupti voluptatum accusantium vel voluptas. Lorem ipsum dolor, sit amet consectetur adipisicing elit. Saepe, a error? Expedita harum accusantium provident praesentium consectetur at autem in dicta facere, dolor rem nesciunt repudiandae saepe. Ducimus, expedita eveniet. Lorem ipsum, dolor sit amet consectetur adipisicing elit. Perspiciatis veniam, id, libero, vel molestiae recusandae sunt quod debitis nam ut laudantium ducimus quas accusantium assumenda eligendi. Eaque, est. Unde, tenetur.
										Lorem ipsum dolor sit amet, consectetur adipisicing elit. Delectus quo dignissimos, sed corrupti obcaecati soluta earum veritatis, tempora necessitatibus alias culpa ratione vel officia ex fugiat. Ex vitae laboriosam voluptatem.
									  </div>  
									</div>
									<div class="reviewPhoto">
									  <img src="https://i.ibb.co/gm7H77f/square.png" alt="" onclick="expandPic()">
									  <div  class="reviewLikeBtn text-center border border-success rounded mt-1">
										<i class="far fa-heart">3</i>
									  </div>
									</div>
								  </div>
								</div>
								<!--리뷰끝-->
								<div class="aReviewDiv forFont">
									<div class="shop-review row">
									  <div class="reviewProfile">
										<img class="rounded-circle mt-1" src="https://i.ibb.co/L6xBDk1/profile.png"  alt="">
									  </div> 
									  <div class="reviewContent ml-3">
										<i class="fas fa-star"></i>
										<i class="fas fa-star"></i>
										<i class="fas fa-star"></i>
										<i class="fas fa-star"></i>
										<i class="fas fa-star"></i>
										<br><span>greendory</span> | <span>21.11.06</span> | <a href="">신고</a>
										<br><span>상품옵션 : </span> <span>핑크</span>
										<div class="reviewP mt-3">
										  너무 좋아요 Lorem, ipsum dolor sit amet consectetur adipisicing elit. Minus deserunt perferendis aspernatur dolores aliquid labore laborum id aut beatae nulla, a sequi reiciendis placeat, quia corrupti voluptatum accusantium vel voluptas. Lorem ipsum dolor, sit amet consectetur adipisicing elit. Saepe, a error? Expedita harum accusantium provident praesentium consectetur at autem in dicta facere, dolor rem nesciunt repudiandae saepe. Ducimus, expedita eveniet. Lorem ipsum, dolor sit amet consectetur adipisicing elit. Perspiciatis veniam, id, libero, vel molestiae recusandae sunt quod debitis nam ut laudantium ducimus quas accusantium assumenda eligendi. Eaque, est. Unde, tenetur.
										  Lorem ipsum dolor sit amet, consectetur adipisicing elit. Delectus quo dignissimos, sed corrupti obcaecati soluta earum veritatis, tempora necessitatibus alias culpa ratione vel officia ex fugiat. Ex vitae laboriosam voluptatem.
										</div>  
									  </div>
									  <div class="reviewPhoto">
										<img src="https://i.ibb.co/gm7H77f/square.png" alt="" onclick="expandPic()">
										<div  class="reviewLikeBtn text-center border border-success rounded mt-1">
										  <i class="far fa-heart">3</i>
										</div>
									  </div>
									</div>
								  </div>
								<div class="aReviewDiv forFont">
									<div class="shop-review row">
									  <div class="reviewProfile">
										<img class="rounded-circle mt-1" src="https://i.ibb.co/L6xBDk1/profile.png" alt="">
									  </div> 
									  <div class="reviewContent ml-3">
										<i class="fas fa-star"></i>
										<i class="fas fa-star"></i>
										<i class="fas fa-star"></i>
										<i class="fas fa-star"></i>
										<i class="fas fa-star"></i>
										<br><span>greendory</span> | <span>21.11.06</span> | <a href="">신고</a>
										<br><span>상품옵션 : </span> <span>핑크</span>
										<div class="reviewP mt-3">
										  너무 좋아요
										</div>  
									  </div>
									  <div class="reviewPhoto">
										<img src="https://i.ibb.co/gm7H77f/square.png" alt="" onclick="expandPic()">
										<div  class="reviewLikeBtn text-center border border-success rounded mt-1">
										  <i class="far fa-heart">3</i>
										</div>
									  </div>
									</div>
								  </div>
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
									<button type="button" class="btn btn-warning">문의글작성하기</button>
								  </div>
								</div>
								<hr>
								<!--상단 갯수 및 선택 옵션 끝-->
								<!--문의시작-->
								<div class="question-div forFont">
								  <div class="a-question-div">
									<!--문의 한 건 시작-->
									<div class="customer-Q">
									  <span class="sub">제목: 배송 언제 오나요?</span> | <span>답변완료</span>
									  <br>
									  <span>greendory</span> | <span>2021년 12월 25일 12시30분</span>
									  <br>
									  <!--아코디언 시작-->
									  <p>
										<a class="" data-toggle="collapse" href="#collapseExample" aria-expanded="false" aria-controls="collapseExample">
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
	
	