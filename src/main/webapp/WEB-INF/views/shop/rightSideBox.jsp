<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/shop/rightSideBox.js"></script>

           <div id="sidebox"> 
               <div id="sideboxHeader">
                   <p class="text-center">오늘 본 상품 </p><p></p>
               </div>
               <div id="sideboxBody">
				<div id="carouselExampleControls" class="carousel slide" data-bs-ride="carousel" data-bs-interval="false">
				  <div class="carousel-inner thisHeight">
				      <div class="carousel-item active firstS">
				      	<p style="font-family: 'Nanum Pen Script'; font-size:20px" id="todayNothing">오늘 본 상품이 없어요 ㅠㅠ</p>
					    </div>
					    <div class="carousel-item secondS">
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
.thisHeight{
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
	console.log("todayViewBox 함수 시작");
	const todayViewitems = JSON.parse(localStorage.getItem('todayViewitems')) || [];
	
	//뒤집기 가장 먼저 본 상품이 가장 처음으로 오게 - 확인 완료
	const rTodayViewitems = todayViewitems.reverse();
	
	const $box = $('.carousel-inner');
	
	if(rTodayViewitems != null){
		const length = rTodayViewitems.length; 
		console.log(`오늘본상품갯수: \${length}`);
		
		if(length == 0){
			$('.thisHeight').css("height", "60px");
		}
		if(length >0){
			$(todayNothing).remove();
		}
		
		if(length<=3){
			$('.secondS').remove();
		}
		
		//div분기 처리 끝
		
		if(length>3){
			const $firstSlide = $('.firstS');
			const $secondSlide = $('.secondS');
			
			for (var i = 0; i < rTodayViewitems.length; i++){
				if(i<3){
					const productCode = rTodayViewitems[i]["productCode"];
					const a = `<a href="${pageContext.request.contextPath}/shop/itemDetail/\${productCode}"> <img class=\"todayView\" src=\"${pageContext.request.contextPath}/resources/upload/product/\${productCode}.png \" style = \"width: 100px; height: 100px;\"></a>`;
					$firstSlide.append(a);

				}
				if(i>=3 && i<6){
					const productCode = rTodayViewitems[i]["productCode"];
					const a = `<a href="${pageContext.request.contextPath}/shop/itemDetail/\${productCode}"> <img class=\"todayView\" src=\"${pageContext.request.contextPath}/resources/upload/product/\${productCode}.png \" style = \"width: 100px; height: 100px;\"></a>`;
					$secondSlide.append(a);
					
				}
				if(i>=6){
					return;
				}
			}
		}
		if(length>0 && length <=3){
			const $firstSlide = $('.firstS');
			for (var i = 0; i < rTodayViewitems.length; i++){
				const productCode = rTodayViewitems[i]["productCode"];
				const a = `<a href="${pageContext.request.contextPath}/shop/itemDetail/\${productCode}"> <img class=\"todayView\" src=\"${pageContext.request.contextPath}/resources/upload/product/\${productCode}.png \" style = \"width: 100px; height: 100px;\"></a>`;
				$firstSlide.append(a);
			}
			
		}
		
		

		
	}	
	
}	
	
</script>           