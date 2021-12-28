/**
 * 주문 페이지
 */
 
$(document).ready(()=>{
//버튼 클릭 시 주문 아코디언 헤더의 상세 내용 숨기거나 드러내기
$(".order-btn").click((e)=>{
	const target = $(e.target).data("target");
	console.log(target);
	
	if(target == '#collapseThree'){
		$("#orderOne").show();
		$("#orderTwo").show();
	}
	else if(target == '#collapseOne'){
		$("#orderOne").hide();
		$("#orderTwo").show();
		
	}
	else if(target == '#collapseTwo'){
		$("#orderOne").show();
		$("#orderTwo").hide();
		
	}
		
});
});

/**
 * 교환/환불/취소 페이지
 */
window.onload = function(){
// 상세사유 입력창 이벤트
$("[name='reasonCode']").change((e) => {
	const $reasonDetail = $(e.target).siblings('div');
	$('.claim-detail').slideUp();
	$reasonDetail.slideDown();
});

//이전, 다음 버튼 클릭 시 탭 변화
$(".claim-btn").click((e) => {
	console.log($(e.target));
	console.log($(e.target).data('target'));
	const target = $(e.target).data('target');
	
	if(target == '#claimThree'){
		$(".claim-container").css('height', '1100px');
	}
	$(".claim-card").removeClass('show');
	$(target).addClass('show');
	window.scrollTo(0,0);
});
}