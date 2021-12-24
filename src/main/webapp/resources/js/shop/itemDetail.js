/**리뷰사진확대모달 시작*/
function expandPic(event) {
 var path = event.target.src;


	
const $reviewModal = $("#reviewModal");
if($reviewModal.css("display","none")) {
	$reviewModal.show();
	$('#reviewExpansion').attr("src",path);

}
}

function expandClose() {
const $reviewModal = $("#reviewModal");
$reviewModal.hide();
}
/**리뷰사진확대모달 끝*/

 /**파일 업로드 시 바로 이미지 보기 시작 **/


 var openFile = function(event) { 
	
	const $picR = $('#choosePicP');
	const picA = '<img id="previewPhoto" src="">';
	$('#choosePicP').next().detach();
	
	$picR.after(picA);

  
	var input = event.target; var reader = new FileReader(); 
	 
 	reader.onload = function(){ 
 		var dataURL = reader.result; 
 		var output = document.getElementById('previewPhoto'); 
 		output.src = dataURL; 
 		}; 
 		
 	if(input.files[0] != null) {
 	reader.readAsDataURL(input.files[0]); 	
	} else{
	$('#choosePicP').next().detach();
	}

  
 	};


/**파일 업로드 시 바로 이미지 보기 끝 **/ 

/*상품리뷰 취소시 다 날리게 시작*/
function deleteReview() {
	$('#reviewPic').val("");
	$('#choosePicP').next().detach();
}
/*상품리뷰 취소시 다 날리게 끝*/