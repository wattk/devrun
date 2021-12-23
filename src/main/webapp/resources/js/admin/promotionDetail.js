/**
 * 
 */
 
 //썸머노트 작동
$(document).ready(function() {
	
	//이벤트 등록 썸머노트
	$('#summernoteEnroll')
		.summernote({
		  height: 300,                 // 에디터 높이
		  minHeight: null,             // 최소 높이
		  maxHeight: null,             // 최대 높이
		  focus: false,                  // 에디터 로딩후 포커스를 맞출지 여부
		  lang: "ko-KR",					// 한글 설정
		  placeholder: '최대 2048자까지 쓸 수 있습니다'	//placeholder 설정
	});
	
	//이벤트 수정 썸머노트
	$('#summernoteDetail')
		.summernote({
		  height: 300,                 // 에디터 높이
		  minHeight: null,             // 최소 높이
		  maxHeight: null,             // 최대 높이
		  focus: false,                  // 에디터 로딩후 포커스를 맞출지 여부
		  lang: "ko-KR",					// 한글 설정
		  placeholder: '최대 2048자까지 쓸 수 있습니다'	//placeholder 설정
		})
		.summernote('disable');
	
	
	//file 업로드 시 화면에 해당 이미지 띄우기
	$(banner).on("change", (e)=>{
		let file = e.target.files[0];
		
		if(!file.type.match("image.*")){
			alert("이미지 파일만 업로드 가능합니다.");
			$(e.target).val('');
			return;
		}
		
		let reader = new FileReader();
		reader.onload = function(e){
			$(promotionBanner).attr("src", e.target.result);
		}
		reader.readAsDataURL(file);
	});
	
	

	
	//이벤트 기간 지정 시 진행 일수 계산해서 띄우기
	$("#endDate").on("change", (e)=>{
		const startDate = $("#startDate").val();
		const endDate = $(e.target).val();
		
		const start = new Date(startDate).getTime();
		const end = new Date(endDate).getTime();
		
		if(end < start || end < Date.now()){
			alert("잘못된 기간입니다.");
			$(e.target).val('');
			return;
		}
		
		let validMillis = end - start;
		let validDates = validMillis / (1000*60*60*24);
		
		$("#calculateDate").text(validDates);
	});
	
	
	
	//상품 코드 추가 버튼 클릭 시 코드 추가
	$("#productAddBtn").click((e)=>{
		const $codeSearch = $("#productCodeSearch");
		const value = $codeSearch.val();
		const code = value.split("("); 
		const $productList = $("[name = productCode]");
		let isValid = 0;
		
		if($productList.length > 0){
			$productList.each((i, item)=>{
				if($(item).val() == code[0]){
					alert("이미 상품이 존재합니다.");
					isValid = 1;
					return;
				};
			});
		};
		
		if(isValid == 1) return;
		
		$("#productCodeList").append(`<li class="list-group-item">
	${value}<i class="fas fa-times pl-2 product-x-btn text-danger"></i>
	<input type="hidden" name="productCode" value="${code[0]}" />
</li>`);
		$codeSearch.val('');
		
		//상품 x 버튼 클릭 시 list 제외
		$(".product-x-btn").click((e)=>{
			const $li = $(e.target).parent("li");
			console.log($li);
			$li.detach();
		});	
	});
	
	
	
	
								
});