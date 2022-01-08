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
					    <div class="carousel-item secondS">
					    </div>
					    <div class="carousel-item thirdS">
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
	
	//뒤집기 가장 먼저 본 상품이 가장 처음으로 오게 - 확인 완료
	const rTodayViewitems = todayViewitems.reverse();
	
	const $box = $('.carousel-inner');
	
	if(rTodayViewitems != null){
		const length = rTodayViewitems.length; 
		console.log(`오늘본상품갯수: \${length}`);
		
		if(length<=3){
			$('.secondS').remove();
			$('.thirdS').remove();
		}
		if(length<=6){
			$('.thirdS').remove();
		}
		
	}	
	
	
	
	
	
	
	
	
	
	
	

		/* 	if(length <4) {
					const $firstSlide = $('.firstS');
				console.log("여기 찍힘?");
				for (var i = 0; i < rTodayViewitems.length; i++){
					
					const productCode = rTodayViewitems[i]["productCode"];
					console.log(`productCode : \${productCode}`);
					const a = `<a href="${pageContext.request.contextPath}/shop/itemDetail/\${productCode}"> <img class=\"todayView\" src=\"${pageContext.request.contextPath}/resources/upload/product/\${productCode}.png \" style = \"width: 100px; height: 100px;\"></a>`;
					$firstSlide.append(a);
					
					
				}
			if(length > 3 && length <7){
		        const second = `				    <div class="carousel-item secondS">
				    </div>`;
				$box.prepend(second);
				const $secondSlide = $('.secondS');
				
				for (var i = 3; i < rTodayViewitems.length; i++) {
					const productCode = rTodayViewitems[i]["productCode"];
					console.log(`productCode : \${productCode}`);
					const a = `<a href="${pageContext.request.contextPath}/shop/itemDetail/\${productCode}"> <img class=\"todayView\" src=\"${pageContext.request.contextPath}/resources/upload/product/\${productCode}.png \" style = \"width: 100px; height: 100px;\"></a>`;
					$secondSlide.append(a);
				}
				
				
			}
			if(length > 6 && length <10){
				
			} */
			


} 

</script>           