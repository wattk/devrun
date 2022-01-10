// 부트스트랩 Tooltips
var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
  return new bootstrap.Tooltip(tooltipTriggerEl)
})

// 신고 대상 글 확인 클릭 시 모달 부분 값 변경
$(document).on('click', '.content-btn', function(e) {
	const $target = $(e.target);
	// 바로가기를 위한 준비 - 신고대상 pk번호를 세팅하기 위함
	const no = $(e.target).data('targetPkNo');

	// 상세 내용
	const content = $target.data("content"); // getter camelcasing으로 참조하기
	
	// 내용 변경
	$(".modal-body").html(content);
	// 바로가기 data-target-pk-no 속성 값 변경하기
	$('.short-cut-btn').data('targetPkNo', no);
	
});


//처리상태 select 바뀔때마다 이벤트발생
$(statusSelect).change((e) => {
	const $target = $(e.target);
	const reportNo = $target.data("reportNo");	// 신고번호. data-속성의 키값을 camelcasing으로 처리
	const targetNo = $target.data("targetNo");	// 피신고자 번호
	const status = $target.val(); // 지금 선택된 값 가져옴
	
	// msg부분을 위한 str 생성
	var str = "";
	if(status == 'PR') {
		str = "처리중";
	} else if(status == 'DR') {
		str = "처리보류";
	} else {
		str = "처리완료"
	}
	
	// jsp의 EL문법과 js의 String Template 충돌. escaping처리 할것.
	const msg = `[${str}]으로 변경하시겠습니까?`;
	if(confirm(msg)){
		// 사용자가 OK하면 해당 폼을 제출한다.
		const $frm = $(document.reportStatusUpdateFrm);
		$frm.find("[name=reportNo]").val(reportNo);
		$frm.find("[name=status]").val(status);
		$frm.find("[name=targetNo]").val(targetNo);
		$frm.submit();
	}
	else {
		// 취소하는 경우
		// 초기값으로 복귀
		// $this.find("[selected]") -> 현재 셀렉트 태그에 원래 selected된 얘를 찾는다. selected 속성이 있는.
		// 그러고 걔의 .prop("selected", true) 을 이용하여 selected속성을 true로 해주세요. 초기값으로 복귀한다.
		// prop()는 속성의 값을 true 혹은 false 로 반환합니다.
		// prop속성은 html의 태그를 js로 제어하는 것이라서 true false로 처리합니다.
		// 원래 selected속성을 찾은다음에 다시 selected 처리하고 있다. find 부분 이건원래 html에 inline으로 작성된 속성을 찾는것이고 .prop으로 자바스크립트 제어함.
		// 구글링 찾은 내용 참고 -> .prop()는 지정한 선택자를 가진 첫번째 요소의 속성값을 가져오거나 속성값을 추가합니다. 주의할 점은 HTML 입장에서의 속성(attribute)이 아닌 JavaScript 입장에서의 속성(property)이라는 것입니다.
		$target.find("[selected]").prop("selected", true); // 이 코드가 없으면 바뀐 값으로 남아있을 텐데 기존 선택된 요소 selected가 있는 태그를 찾아서 실제 처리를 해주었다. 다시한번 selected true처리를 해줌. 
	}
	
});
