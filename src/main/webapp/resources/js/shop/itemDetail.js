/**리뷰사진확대모달 시작*/
function expandPic(target) {

	
const $reviewModal = $("#reviewModal");
if($reviewModal.css("display","none")) {
	$reviewModal.show();
}
}

function expandClose() {
const $reviewModal = $("#reviewModal");
$reviewModal.hide();
}
/**리뷰사진확대모달 끝*/

/*상품리뷰 취소시 다 날리게 시작*/
function deleteReview() {
	$('#reviewPic').val("");
	$('#choosePicP').next().detach();
}
/*상품리뷰 취소시 다 날리게 끝*/