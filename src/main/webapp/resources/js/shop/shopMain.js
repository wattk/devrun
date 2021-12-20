   /*반응형 사이드바 시작*/
   var slideMq = window.matchMedia("(min-width: 479px)");
  
  /* Sliding side navigation */
   function openSideNav() {
  if (slideMq.matches) {
    /* the viewport is at least 479 pixels wide */
    document.getElementById("slidingSideNav").style.width = "30%";
    
  } else {
    /* the viewport is less than 479 pixels wide */
    document.getElementById("slidingSideNav").style.width = "100%";
  }
  
  
  }
  slideMq.addListener(function(changed) {
     
         document.getElementById("slidingSideNav").style.width = "0";
     
  });
  
  
  
  function closeSideNav() {
      document.getElementById("slidingSideNav").style.width = "0%";
  }
  
  /*Copyright (c) 2017 by Ryan Bobrowski (https://codepen.io/rbobrowski/pen/likvA)*/
  
  var headers = ["H1","H2","H3","H4","H5","H6"];
  
  $(".accordion").click(function(e) {
    var target = e.target,
        name = target.nodeName.toUpperCase();
    
    if($.inArray(name,headers) > -1) {
      var subItem = $(target).next();
      
      //slideUp all elements (except target) at current depth or greater
      var depth = $(subItem).parents().length;
      var allAtDepth = $(".accordion p, .accordion div").filter(function() {
        if($(this).parents().length >= depth && this !== subItem.get(0)) {
          return true; 
        }
      });
      $(allAtDepth).slideUp("fast");
      
      //slideToggle target content and adjust bottom border if necessary
      subItem.slideToggle("fast",function() {
          $(".accordion :visible:last");
      });
     
    }
  });  
   /*반응형 사이드바 끝*/
   
   /*실시간 순위 시작*/
   $(function() {
       var count = $('#rank-list li').length;
       var height = $('#rank-list li').height();
   
       function step(index) {
           $('#rank-list ol').delay(2000).animate({
               top: -height * index,
           }, 500, function() {
               step((index + 1) % count);
           });
       }
       step(1);
   });
   
   /*실시간 순위 끝*/
   
   /*오늘 본 상품 div 시작*/
   var currentPosition = parseInt($("#sidebox").css("top")); 
   $(window).scroll(function() { 
       var position = $(window).scrollTop(); 
       $("#sidebox").stop()
                    .animate({"top":position+currentPosition+"px"},1000); 
   });
   /*오늘 본 상품 div 끝*/
    
    
   /*상품 카테고리 슬라이드 시작 */
   var slideIndex = 1;
   showSlides(slideIndex);
   
   function plusSlides(n) {
     showSlides(slideIndex += n);
   }
   
   function currentSlide(n) {
     showSlides(slideIndex = n);
   }
   
   function showSlides(n) {
     var i;
     var slides = document.getElementsByClassName("mySlides");
     var dots = document.getElementsByClassName("dot");
     if (n > slides.length) {slideIndex = 1}    
     if (n < 1) {slideIndex = slides.length}
     for (i = 0; i < slides.length; i++) {
         slides[i].style.display = "none";  
     }
     for (i = 0; i < dots.length; i++) {
         dots[i].className = dots[i].className.replace(" active2", "");
     }
     slides[slideIndex-1].style.display = "block";  
     dots[slideIndex-1].className += " active2";
   }
   /*상품 카테고리 슬라이드 끝 */