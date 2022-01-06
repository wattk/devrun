/**
 * 
 */
$(document).ready(()=>{

$(".order-btn").click((e)=>{
	const merchantUid = $(e.target).data("target");
	location.href = `${pageContext.request.contextPath}/mypage/changeOrder?merchantUid=\${merchantUid}`;
})	
})