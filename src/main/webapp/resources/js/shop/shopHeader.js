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