<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<fmt:requestEncoding value="utf-8"/>

<!-- css임포트 -->
<link
    href="${pageContext.request.contextPath}/resources/css/shop/shopItemDetail.css"
    rel="stylesheet">


		


<!--신고 모달 시작 (부트스트랩)-->
<form:form name="communityReportFrm" 
		   method="POST"
		   action="${pageContext.request.contextPath}/community/insertCommunityReport.do">
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
							<!-- 신고대상 ID  -->
							<span id="reportId">해당 ID : </span> <span id="hereId">${communityEntity.nickname}</span> 
							<hr id="reportHr">
							<p style="font-weight: bold;">신고 대상 글</p>
							<!-- 신고대상 게시글 -->
							<span id="hereContent">${communityEntity.content}</span>
							<!-- 신고분야 카테고리 --> 
							<input type="hidden" name="reportRootCate" value="CB" />
							<!-- 회원번호 -->
							<input type="hidden" name="memberNo" value='<sec:authentication property="principal.memberNo" />'>
							<!-- 회원아이디 -->
							<input type="hidden" name="id" value='<sec:authentication property="principal.id" />'>
							<!-- 신고 대상 PK 번호 -->
							<input type="hidden" name="targetPkNo" value="${communityEntity.communityNo}" />
							<!-- 신고 대상 글 -->
							<input type="hidden" name="reportContent" value="${communityEntity.content}" />
							<!-- pageCode -->
							<input type="hidden" name="pageCode" value="${communityEntity.pageCode}" />
						</div>
					</div>
					<div class="m-body2 mt-3">
						<p>신고사유</p>
						<div class="checkboxReport">
							<form action="#">
								<!-- 신고사유 분류번호 -->
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
								<!-- 신고 사유 부가 설명 -->
								<textarea name="sideNote" id="reportText" cols="30" rows="10"
									maxlength='195' placeholder="상세내용을 기입해주세요(선택)"></textarea>
							</form>
							<p style="font-size: 12px;">ⓘ 신고해주신 내용은 관리자 검토 후 내부정책에 의거
								조치가 진행됩니다.</p>
						</div>
					</div>
				</div>
				<div class="modal-footer justify-content-center">
					<button type="button" class="btn btn-primary col-4" id="reportBtn">신고하기</button>
					<button type="button" class="btn btn-secondary col-4"data-dismiss="modal" id="deleteReporBtn">취소하기</button>
				</div>
			</div>
		</div>
	</div>
</form:form>
		
<script>
	$('#reportBtn').click(function(){
		console.log("신고하기 들어오나요");
		
		var reasonCate = $('input[name="reasonCate"]:checked').val();
		console.log(reasonCate); // reasonCate 정상작동 확인
		const reportRootCate = $('input[name="reportRootCate"]').val();
		console.log(reportRootCate); // reportRootCate 정상작동 확인
		const memberNo = $('input[name="memberNo"]').val();
		console.log(memberNo); // memberNo 정상작동 확인
		const id = $('input[name="id"]').val();
		console.log(id); // id 정상작동 확인
		const targetPkNo = $('input[name=targetPkNo]').val();
		console.log(targetPkNo); // targetPkNo(communityNo) 정상작동 확인
		const reportContent = $('input[name=reportContent]').val();
		console.log(reportContent); // reportContent(content) 정상작동 확인
		var sideNote = $("#reportText").val();
		console.log(sideNote); // sideNote 정상작동 확인
		const pageCode =$('input[name="pageCode"]').val();
		console.log("pageCode = " + pageCode); // pageCode 정상작동 확인
		
		// 유효성 검사
		if($('input[name="reasonCate"]:checked').length < 1) {
			alert("신고사유를 선택하세요");
			return false;
		}
		
		$(document.communityReportFrm).submit();
	});
</script>
