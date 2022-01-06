/**
 * 주문 페이지
 */
 
$(document).ready(()=>{
let today = new Date();
const year = today.getFullYear(); 
const month = today.getMonth() + 1; 
const date = today.getDate();
today = (year-2000) + "-" + month + "-" + (date+1);

console.log(today, typeof today);
$("#releaseDate").text(today + " 09:00 ~ 21:00");

const price = $("#totalPrice").text();
$("#priceInput").text(price);

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


//주소 검색창 띄우기
$("#addInputBtn").click((e)=>{
	new daum.Postcode({
        oncomplete(data){ //선택시 입력값 세팅
        	console.log(data);
        	$("[name=postcode]").val(data.zonecode);
            $(".add-input").text(data.address);
            $("#addInput").val(data.address);
            $(".add-detail-input").text('');
            $("#addDetailInput").val('');
        }
    }).open();
});

//상세 정보 입력 시 정보 수정
$(".order-form-control").change((e)=>{
	console.log($(e.target).val());
	const value = $(e.target).val();
	const target = $(e.target).data("target");
	$(target).text(value);
});

//사용 포인트 입력 시 결제 금액 변경
$("#pointBtn").click((e)=>{
	const use = $(e.target).val();
	$("[name=pointValue]").val(use);
	const total = $("[name=totalPrice]").val() - use;
	$("[name=totalPrice]").val(total);
	$("#priceInput").text(total);
});



});

/**
 * 교환/환불/취소 페이지
 */
window.onload = function(){
// 상세사유 입력창 이벤트
$("[name='reasonCode']").change((e) => {
	const $reasonDetail = $(e.target).siblings('div');
	$('.claim-detail')
		.slideUp()
		.html('');
	$reasonDetail
		.append(`<textarea name="reasonDetail" id="" cols="75" rows="5" class="w-100" placeholder="*필수입력"></textarea>`)
		.slideDown();
	const content = $(e.target).siblings("label").text();
	console.log(content);
	$("#selectReason").text(content);
});

//이전, 다음 버튼 클릭 시 탭 변화
$(".claim-btn").click((e) => {
	console.log($(e.target));
	console.log($(e.target).data('target'));
	const target = $(e.target).data('target');
	
	if(target == '#claimThree'){
		if($("[name=reasonDetail]").val().length == 0 || $("[name=reasonCode]").val() == ''){
			alert("사유를 입력해 주세요");
			return;
		}
		$(".claim-container").css('height', '1100px');
	}
	$(".claim-card").removeClass('show');
	$(target).addClass('show');
	window.scrollTo(0,0);
});

//주문 변경 신청 시 폼 제출
$("#orderLogEnrollBtn").click((e)=>{
	const orderLogUid = 'ORLG_' + new Date().getTime();
	$("[name=orderLogUid]").val(orderLogUid);
	$(document.orderLogFrm).submit();
});
}