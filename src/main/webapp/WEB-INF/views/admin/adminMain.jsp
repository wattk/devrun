<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<jsp:include page="/WEB-INF/views/admin/admin-common/header.jsp">
	<jsp:param value="admin" name="title"/>
</jsp:include>
<!-- 구글 차트 js import -->
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

			<!-- 내용의 윗 부분 -->
			<div id="contentTop" class="content row">
							
				<!-- 일 매출 알림표 -->
	            <div class="col-xl-3 col-md-6 mb-4">
	                <div class="card border-left-primary shadow h-100 py-2">
	                    <div class="card-body">
	                        <div class="row no-gutters align-items-center">
	                            <div class="col mr-2">
	                                <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
	                                    일매출</div>
	                                <div class="h5 mb-0 font-weight-bold text-gray-800"><fmt:formatNumber pattern="###,###">${cntList.dailySales }</fmt:formatNumber> 원</div>
	                            </div>
	                            <div class="col-auto">
	                                <i class="fas fa-dollar-sign fa-2x text-gray-300"></i>
	                            </div>
	                        </div>
	                    </div>
	                </div>
	            </div>
				<!-- 월 매출 알림표 -->
                <div class="col-xl-3 col-md-6 mb-4">
                    <div class="card border-left-primary shadow h-100 py-2">
                        <div class="card-body">
                            <div class="row no-gutters align-items-center">
                                <div class="col mr-2">
                                    <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                                        월매출</div>
                                    <div class="h5 mb-0 font-weight-bold text-gray-800"><fmt:formatNumber pattern="###,###">${cntList.monthlySales }</fmt:formatNumber> 원</div>
                                </div>
                                <div class="col-auto">
                                    <i class="fas fa-dollar-sign fa-2x text-gray-300"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
				<!-- 접수 대기중인 문의 -->
                <div class="col-xl-3 col-md-6 mb-4">
                    <div class="card border-left-primary shadow h-100 py-2">
                        <div class="card-body">
                            <div class="row no-gutters align-items-center">
                                <div class="col mr-2">
                                    <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                                        접수 대기중인 문의</div>
                                    <div class="h5 mb-0 font-weight-bold text-gray-800">${cntList.questionProducts } 건</div>
                                </div>
                                <div class="col-auto">
                                    <i class="fas fa-comments fa-2x text-gray-300"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
				<!-- 총 게시글 수 -->
                <div class="col-xl-3 col-md-6 mb-4">
                    <div class="card border-left-primary shadow h-100 py-2">
                        <div class="card-body">
                            <div class="row no-gutters align-items-center">
                                <div class="col mr-2">
                                    <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                                        총 게시글 수</div>
                                    <div class="h5 mb-0 font-weight-bold text-gray-800"><fmt:formatNumber pattern="###,###">${cntList.communities }</fmt:formatNumber> 개</div>
                                </div>
                                <div class="col-auto">
                                    <i class="fas fa-calendar fa-2x text-gray-300"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
            <!-- 내용 윗부분 끝  -->    
			</div>

			<!-- 내용의 중간 부분 1  -->					
			<div id="contentMid1"class="content">					
				<!--  매출 현황  -->
				<div class="row-xl-8 col-lg-8 mid">
	                <div class="card shadow mb-4">
	                    <!-- Card Header -->
	                    <div
	                        class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
	                        <h6 class="m-0 font-weight-bold text-primary">매출 현황</h6>                                 
	                    </div>
	                    <!-- Card Body -->
	                    <div class="card-body">
	                        <div class="chart-area">
	                            <canvas id="myAreaChart"> </canvas>
	                        </div>
	                    </div>
	                </div>
                </div> 
				<!--  회원 현황  -->
				<div class="row-xl-8 col-lg-4 mid">
	                <div class="card shadow mb-4">
	                    <!-- Card Header -->
	                    <div
	                        class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
	                        <h6 class="m-0 font-weight-bold text-primary">회원 현황</h6>                                 
	                    </div>
	                    <!-- Card Body -->
	                    <div class="card-body">
	                        <div class="chart-area" id="memberCount">
	                        	<div class="d-flex align-items-center">
		                            <h3 class="pr-4">누적 회원 수 </h3>
		                            <h4 class="text-right"><fmt:formatNumber pattern="###,###">${cntList.totalMembers }</fmt:formatNumber> 명</h4>
	                        	</div>
	                        	<div class="d-flex align-items-center">
		                            <h3 class=" pr-4">신규 회원 수  </h3>
		                            <h4 class="text-right"><fmt:formatNumber pattern="###,###">${cntList.newMembers }</fmt:formatNumber> 명</h4>
	                        	</div>
	                        	<div class="d-flex align-items-center">
		                            <h3 class=" pr-4">차단된 회원 수  </h3>
		                            <h4 class="text-right"><fmt:formatNumber pattern="###,###">${cntList.blacklistMembers }</fmt:formatNumber> 명</h4>
	                        	</div>
	                        </div>
	                    </div>
	                </div>
                </div>
			<!-- 내용의 중간 부분 1 끝  -->			
			</div>
			
			<!-- 내용의 중간 부분 2  -->					
			<div id="contentMid2"class="content">
				<!--  일일 배송 통계  -->
				<div class="row-xl-8 col-lg-6 mid">
	                <div class="card shadow mb-4">
	                    <!-- Card Header -->
	                    <div
	                        class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
	                        <h6 class="m-0 font-weight-bold text-primary">일일 배송 통계</h6>                                 
	                    </div>
	                    <!-- Card Body -->
	                    <div class="card-body">
	                        <div class="chart-pie pt-4 pb-2">
	                            <%-- <canvas id="myPieChart"></canvas> --%>                                      
								<!--Div that will hold the pie chart-->
								<div id="chart_div"></div>									 
							</div>
	                        <div class="mt-4 text-center small">
	                            <span class="mr-2">
	                                <i class="fas fa-circle text-primary"></i> 배송
	                            </span>
	                            <span class="mr-2">
	                                <i class="fas fa-circle text-warning"></i> 교환
	                            </span>
	                            <span class="mr-2">
	                                <i class="fas fa-circle text-info"></i> 반품
	                            </span>
	                            <span class="mr-2">
	                                <i class="fas fa-circle text-dark"></i> 환불
	                            </span>
	                            <span class="mr-2">
	                                <i class="fas fa-circle text-secondary"></i> 접수
	                            </span>
	                            <span class="mr-2">
	                                <i class="fas fa-circle text-success"></i> 완료
	                            </span>
	                        </div>
	                    </div>
	                </div>	                
                </div>
				<!--  게시판 방문자 수  -->
				<div class="row-xl-8 col-lg-6 mid">
	                <div class="card shadow mb-4">
	                    <!-- Card Header -->
	                    <div
	                        class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
	                        <h6 class="m-0 font-weight-bold text-primary">게시판 방문자 수</h6>                                 
	                    </div>
	                    <!-- Card Body -->
	                    <div class="card-body">
	                        <div class="chart-pie pt-4 pb-2">
	                            <canvas id="myPieChart"></canvas>
	                        </div>
	                        <div class="mt-4 text-center small">
	                            <span class="mr-2">
	                                <i class="fas fa-circle text-primary"></i> 칼럼
	                            </span>
	                            <span class="mr-2">
	                                <i class="fas fa-circle text-success"></i> Q&A
	                            </span>
	                            <span class="mr-2">
	                                <i class="fas fa-circle text-info"></i> 스터디
	                            </span>
	                            <span class="mr-2">
	                                <i class="fas fa-circle text-warning"></i> 자유
	                            </span>
	                        </div>
	                    </div>
	                </div>
                </div>
			<!-- 내용의 중간 부분 2 끝 -->		
			</div>
			<!-- 내용의 아래 부분  -->		
			<div id="contentFoot" class="content">
				<!--  게시판 게시글 수 -->
				<div class="row-xl-8 col-lg-12 mid">
	                <div class="card shadow mb-4">
	                    <!-- Card Header -->
	                    <div
	                        class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
	                        <h6 class="m-0 font-weight-bold text-primary">게시판 게시글 수</h6>                                 
	                    </div>
	                    <!-- Card Body -->
	                    <div class="card-body">
	                        <div class="chart-area">
	                            <canvas id="myAreaChart"> </canvas>
	                        </div>
	                    </div>
	                </div>
            	</div>
			</div>		
<script>
	google.charts.load('current', {packages: ['corechart', 'line']});
	google.charts.setOnLoadCallback(drawCharts);
	
	function drawCharts(){
		//비동기 통해 chart 관련 json data 불러오기
		$.ajax({
			url : "${pageContext.request.contextPath}/chart/findMainChart",
			method : "GET",
			success(data){
				console.log(data);
			},
			error : console.log
		});
	}
	
	}
</script>
<script src="https://apis.google.com/js/client.js?onload=authorize"></script>				
<jsp:include page="/WEB-INF/views/admin/admin-common/footer.jsp"></jsp:include>
        