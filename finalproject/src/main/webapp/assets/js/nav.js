window.addEventListener('resize', () => {
    headerHeight = resizeHeaderHeight();
    console.log(headerHeight);
  });
  
  function resizeHeaderHeight() {  
    let localHeaderHeight = 0;
    if(document.querySelector('s.wiper-wrapper')!= null){
      localHeaderHeight = document.querySelector('.swiper-wrapper').offsetHeight;
    }else if(document.querySelector('.contents-container') != null){
      localHeaderHeight = document.querySelector('.contents-container').offsetHeight;
    }
    //console.log(headerHeight);
    return localHeaderHeight; 
  }
  
  window.addEventListener('scroll', function() {
    
    var scrollPosition = document.documentElement.scrollTop;
    if(scrollPosition>=headerHeight){
      // console.log("하이");
      $(".header-container").addClass("all-nav");
    }else{
      $(".header-container").removeClass("all-nav");
    }
    
  });