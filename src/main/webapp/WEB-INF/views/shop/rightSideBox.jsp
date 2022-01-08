<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/shop/rightSideBox.js"></script>

           <div id="sidebox"> 
               <div id="sideboxHeader">
                   <p class="text-center">최근 본 상품 </p><p></p>
               </div>
               <div id="sideboxBody">
               </div>
               <div id="sideboxFooter">
                   <div id="todayViewErrow">
                       <img class="errow-img"src="https://i.ibb.co/TwyPKry/errow2.png" alt="">
                       <img class="errow-img"src="https://i.ibb.co/ZTyXx9q/errow.png" alt="" style="margin-left: 30px">
                   </div>
               </div>
               <hr>
               <div id="chatbox">
                 <a href=""><i class="fas fa-comment-dots" style="font-size: 70px;"></i></a>
                 <button type="button" class="btn btn-warning">1:1문의하기</button>
               </div>
           </div>

<script>
window.onload = todayViewBox;

function todayViewBox () {
	const todayViewitems = JSON.parse(localStorage.getItem('todayViewitems')) || [];
	console.log("오늘본상품박스");
	console.log(todayViewitems);
	
	const $box = $(sideboxBody);
	
	if(todayViewitems != null){
		todayViewitems.forEach((el, i) => {
			const productCode = el.productCode;
			console.log(`productCode 로컬에서 잘 받? : \${productCode}`);
			const a = `                   <div class=\"todayView1\">
                <img class=\"todayView\" src=\"${pageContext.request.contextPath}/resources/upload/product/\${productCode}.png\">
                </div>`;
			$box.append(a);
		})
	}

	
}

</script>           