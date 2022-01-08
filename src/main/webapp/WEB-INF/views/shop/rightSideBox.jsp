<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/shop/rightSideBox.js"></script>

           <div id="sidebox"> 
               <div id="sideboxHeader">
                   <p class="text-center">최근 본 상품 </p><p></p>
               </div>
               <div id="sideboxBody">
				<div id="carouselExampleControls" class="carousel slide" data-bs-ride="carousel" data-bs-interval="false">
				  <div class="carousel-inner">
				    <div class="carousel-item active firstS">
				    </div>
				    <div class="carousel-item">
				    </div>
				    <div class="carousel-item">
				    </div>
				  </div>
				</div>
               </div>
               <div id="sideBoxFooter" class="ml-2 mr-2">
				  <button class="slide-btn" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="prev">
				    <img src="https://i.ibb.co/TwyPKry/errow2.png" alt="" />
				  </button>
				  <button class="slide-btn"  type="button" data-bs-target="#carouselExampleControls" data-bs-slide="next">
				    <img src="https://i.ibb.co/ZTyXx9q/errow.png" alt="" />
				  </button>
               </div>
           </div>
<style>
.carousel-inner{
	height: 330px;
}
.slide-btn > img {
	width: 20px;
	height: 20px;
}
#sideBoxFooter{
	display: flex;
    justify-content: space-between;
}
#sideBoxFooter >button {
	border: 0px;
}
</style>
<script>
 window.onload = todayViewBox;

function todayViewBox () {
	const todayViewitems = JSON.parse(localStorage.getItem('todayViewitems')) || [];
	console.log("오늘본상품박스");
	console.log(todayViewitems);
	
	const $box = $('.firstS');
	
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