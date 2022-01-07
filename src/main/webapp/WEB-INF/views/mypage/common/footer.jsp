<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
		</section>		   
        	   
    </article>
</main>

<script>
/* location.hash로 url 활용 */
$(function(){
	var hash = window.location.hash;
	console.log(hash);
	hash && $('#tabBtns ul.nav-tabs a[href="' + hash + '"]').tab('show');

	$('#tabBtns ul.nav-tabs a').click(function (e) {
		$(this).tab('show');
	    var scrollmem = $('html').scrollTop(); //1) 사용자의 현재 스크롤 위치를 가져와서
	    window.location.hash = this.hash;
	    $('html').scrollTop(scrollmem); //2) 이동 페이지에 뿌려준다.
	});
});

/* $(document).click(function(){
	const $ative = $(".nav-item a.active");
	$ative
		.parents(".nav-item")
		.css("background-color", "#FFFFFF");
}); */

/* $(){
	$("#tabContainer").load("myshopping.jsp");
}); */

/* $(function() {
	// tab operation
	$('.nav-item').click(function() {
		var activeTab = $(this).attr('data-tab');
		$.ajax({
			type : 'GET',                 //get방식으로 통신
			url : activeTab + ".jsp",    //탭의 data-tab속성의 값으로 된 html파일로 통신
			dataType : "html",            //html형식으로 값 읽기
			error : function() {          //통신 실패시
				alert('통신실패!');
			},
			success : function(data) {    //통신 성공시 탭 내용담는 div를 읽어들인 값으로 채운다.
				$('#tabContainer').html(data);
			}
		});
	});
	$('#mypageTab').click();          
}); */

/* 마이페이지 - 채팅 클릭 시 함수 호출 */
const chatList = () => {
	
	// 팝업요청 // url 부분 로그인 회원 받게 수정할 것
	const url = `${pageContext.request.contextPath}/chat/chatList.do`;
	const name = 'chatList'; // 팝업창 Window객체의 name.
	const spec = "width=400px, height=600px";
	open(url, name, spec);
	
};

</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>