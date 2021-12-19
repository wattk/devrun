/**
 * 
 */
 
window.onload = function(){
//버튼 클릭 시 아코디언 헤더의 상세 내용 숨기거나 드러내기
$(".order-btn").click((e)=>{
	const target = $(e.target).data("target");
	
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
}