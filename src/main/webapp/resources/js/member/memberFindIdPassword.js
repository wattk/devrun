// 처음 로딩 시 아이디 찾기 또는 비밀번호 찾기 탭 활성화 결정
$(document).ready(function(){
	
	// 탭 구분
	const tab = (window.location.search).slice(-2);
	
	if(tab == 'pw') {
		$("#pills-id-tab").removeClass('active');
		$("#pills-pw-tab").addClass('active');
		$("#pills-id").removeClass('show active');
		$("#pills-pw").addClass('show active');
	} else {
		$("#pills-id-tab").addClass('active');
		$("#pills-pw-tab").removeClass('active');
		$("#pills-id").addClass('show active');
		$("#pills-pw").removeClass('show active');
	}
	
});

// Javascript에서 contextPath를 구하기
function getContextPath() {
    return window.location.pathname.substring(0, window.location.pathname.indexOf("/", 2));
};


// 아이디 찾기 탭 클릭 시 비밀번호 찾기 input 초기화
$(".find-id-tab").click((e) => {
	
	// 폼 리셋
	$(memberFindPasswordFrm)[0].reset();
	
});
// 비밀번호 찾기 탭 클릭 시 아이디 찾기 input 초기화
$(".find-pw-tab").click((e) => {
	
	// 폼 리셋
	$(memberFindIdFrm)[0].reset();
	
});
// 아이디 찾기
$(memberFindIdFrm).submit((e) => {
	e.preventDefault(); // 폼제출방지
	
	//console.log($(e.target));
	
	// 이름
	const name = $(e.target).find("input[name=name]").val();
	// 이메일
	const email = $(e.target).find("input[name=email]").val();
	// 팝업요청
	const url = `${getContextPath()}/member/${name}/${email}/findId.do`;
	
	// 띄울 팝업창 높이
	const popHeight = 300;		                                      
	// 띄울 팝업창 너비
	const popWidth = 400;                                       
	// 현재창의 높이
	const winHeight = document.body.clientHeight;	  
	// 현재창의 너비
	const winWidth = document.body.clientWidth;	  
	// 현재창의 x좌표
	const winX = window.screenLeft;	                          
	// 현재창의 y좌표
	const winY = window.screenTop;	                          
	const popX = winX + (winWidth - popWidth)/2;
	const popY = winY + (winHeight - popHeight)/2;
	open(url, name, `top=${popY}, left=${popX}, width=${popWidth}, height=${popHeight}`);
	
	
});

//비밀번호 찾기
function findPassword() {
	
	const frm = document.memberFindPasswordFrm;
	
	// 이름
	const id = $('form[name=memberFindPasswordFrm]').find("input[name=id]").val();
	// 이메일
	const email = $('form[name=memberFindPasswordFrm]').find("input[name=email]").val();

	const title = "findPasswordPopup";
	
	// 띄울 팝업창 높이
	const popHeight = 300;		                                      
	// 띄울 팝업창 너비
	const popWidth = 400;                                       
	// 현재창의 높이
	const winHeight = document.body.clientHeight;
	// 현재창의 너비
	const winWidth = document.body.clientWidth;	  
	// 현재창의 x좌표
	const winX = window.screenLeft;	                          
	// 현재창의 y좌표
	const winY = window.screenTop;	                          
	const popX = winX + (winWidth - popWidth)/2;
	const popY = winY + (winHeight - popHeight)/2;
	open("", title, `top=${popY}, left=${popX}, width=${popWidth}, height=${popHeight}`);

	frm.action = `${getContextPath()}/member/${id}/${email}/findPassword.do`;
	frm.target = title;
	frm.method = "POST";
	frm.submit();

}