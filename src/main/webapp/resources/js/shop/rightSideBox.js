 window.onload = function(){ 
	
 /*오늘 본 상품 div 시작*/
   var currentPosition = parseInt($("#sidebox").css("top")); 
   $(window).scroll(function() { 
       var position = $(window).scrollTop(); 
       $("#sidebox").stop()
                    .animate({"top":position+currentPosition+"px"},1000); 
   });
   /*오늘 본 상품 div 끝*/
	
	}
 