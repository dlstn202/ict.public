// glamping-N1 [KdltWpHPRk]

//[S]nav 변경 js
headerHeight = resizeHeaderHeight(); 
window.addEventListener('resize', () => {
  headerHeight = resizeHeaderHeight();
  //console.log("resize function"+headerHeight);
});

function resizeHeaderHeight() {  
  let localHeaderHeight = 0;
  if(document.querySelector('s.wiper-wrapper')!= null){
    localHeaderHeight = document.querySelector('.swiper-wrapper').offsetHeight;
  }else if(document.querySelector('.contents-container') != null){
    localHeaderHeight = document.querySelector('.contents-container').offsetHeight;
  }
  //console.log("resizeHeaderHeight function"+localHeaderHeight);
  //console.log(headerHeight);
  return localHeaderHeight; 
}

window.addEventListener('scroll', function() {
  
  var scrollPosition = document.documentElement.scrollTop;
  //console.log("scrollPosition function"+scrollPosition);
  //console.log("scrollPosition function,headerHeight"+headerHeight);
  //console.log(headerHeight);
  if(scrollPosition>=headerHeight-80){
    // console.log("하이");
    $(".header-container").addClass("all-nav");
  }else{
    $(".header-container").removeClass("all-nav");
  }
  
});
//[E]nav 변경 js

(function() {
  $(function() {
    $(".glamping-N1").each(function() {
      const $block = $(this);
      resizeHeaderHeight();
      $(window).on("load scroll", function() {
        const $thisTop = $(this).scrollTop();
        if ($thisTop > 0) {
          $block.addClass("header-top-active");
        } else {
          $block.removeClass("header-top-active");
        }
      });
      // Gnb
      // $block.find(".header-center").on("mouseover", function() {
      //   if (window.innerWidth > 992) {
      //     $block.addClass("block-active");
      //   }
      // });
      // $block.find(".header-center").on("mouseout", function() {
      //   if (window.innerWidth > 992) {
      //     $block.removeClass("block-active");
      //   }
      // });
      // Gnb DecoLine
      // $block.find(".header-gnbitem").each(function() {
      //   const $this = $(this);
      //   $this.on("mouseover", function() {
      //     if (window.innerWidth > 992) {
      //       $this.find(".header-gnblink").addClass("on");
      //     }
      //   });
      //   $this.on("mouseout", function() {
      //     if (window.innerWidth > 992) {
      //       $this.find(".header-gnblink").removeClass("on");
      //     }
      //   });
      // });
      // Mobile Top
      $block.find(".btn-momenu").on("click", function() {
        $block.addClass("mo-active");
      });
      $block.find(".btn-moclose").on("click", function() {
        $block.removeClass("mo-active");
      });
      // Mobile Gnb
      // $block.find(".header-gnbitem").each(function() {
      //   const $this = $(this);
      //   const $thislink = $this.find(".header-gnblink");
      //   $thislink.on("click", function() {
      //     if (!$(this).parent().hasClass("item-active")) {
      //       $(".header-gnbitem").removeClass("item-active");
      //     }
      //     $(this).parents(".header-gnbitem").toggleClass("item-active");
      //   });
      // });
      // Full Gnb
      $block.find(".btn-allmenu").on("click", function() {
        $block.find(".header-fullmenu").addClass("fullmenu-active");
      });
      $block.find(".fullmenu-close").on("click", function() {
        $block.find(".header-fullmenu").removeClass("fullmenu-active");
      });
      // Full Gnb DecoLine
      // $block.find(".fullmenu-gnbitem").each(function() {
      //   const $this = $(this);
      //   $this.on("mouseover", function() {
      //     if (window.innerWidth > 992) {
      //       $this.find(".fullmenu-gnblink").addClass("on");
      //     }
      //   });
      //   $this.on("mouseout", function() {
      //     if (window.innerWidth > 992) {
      //       $this.find(".fullmenu-gnblink").removeClass("on");
      //     }
      //   });
      // });
      // Header Mobile 1Depth Click
      if (window.innerWidth <= 992) {
        $block.find(".header-gnbitem").each(function() {
          const $gnblink = $(this).find(".header-gnblink");
          const $sublist = $(this).find(".header-sublist");
          if ($sublist.length) {
            $gnblink.attr("href", "javascript:void(0);");
          }
        });
      }
    });
  });
})();
// glamping-N2 [FwLtWPIO7s]
(function() {
  $(function() {
    $(".glamping-N2").each(function() {
      const $block = $(this);
      // Header Scroll
      $(window).on("load scroll", function() {
        const $thisTop = $(this).scrollTop();
        if ($thisTop > 250) {
          $block.addClass("header-top-active");
        } else {
          $block.removeClass("header-top-active");
        }
      });
      // Gnb
      $block.find(".header-center").on("mouseover", function() {
        if (window.innerWidth > 992) {
          $block.addClass("block-active");
        }
      });
      $block.find(".header-center").on("mouseout", function() {
        if (window.innerWidth > 992) {
          $block.removeClass("block-active");
        }
      });
      // Gnb DecoLine
      $block.find(".header-gnbitem").each(function() {
        const $this = $(this);
        $this.on("mouseover", function() {
          if (window.innerWidth > 992) {
            $this.find(".header-gnblink").addClass("on");
          }
        });
        $this.on("mouseout", function() {
          if (window.innerWidth > 992) {
            $this.find(".header-gnblink").removeClass("on");
          }
        });
      });
      // Mobile Top
      $block.find(".btn-momenu").on("click", function() {
        $block.addClass("mo-active");
      });
      $block.find(".btn-moclose").on("click", function() {
        $block.removeClass("mo-active");
      });
      // Mobile Gnb
      $block.find(".header-gnbitem").each(function() {
        const $this = $(this);
        const $thislink = $this.find(".header-gnblink");
        $thislink.on("click", function() {
          if (!$(this).parent().hasClass("item-active")) {
            $(".header-gnbitem").removeClass("item-active");
          }
          $(this).parents(".header-gnbitem").toggleClass("item-active");
        });
      });
      // Full Gnb
      $block.find(".btn-allmenu").on("click", function() {
        $block.find(".header-fullmenu").addClass("fullmenu-active");
      });
      $block.find(".fullmenu-close").on("click", function() {
        $block.find(".header-fullmenu").removeClass("fullmenu-active");
      });
      // Full Gnb DecoLine
      $block.find(".fullmenu-gnbitem").each(function() {
        const $this = $(this);
        $this.on("mouseover", function() {
          if (window.innerWidth > 992) {
            $this.find(".fullmenu-gnblink").addClass("on");
          }
        });
        $this.on("mouseout", function() {
          if (window.innerWidth > 992) {
            $this.find(".fullmenu-gnblink").removeClass("on");
          }
        });
      });
      // Header Mobile 1Depth Click
      if (window.innerWidth <= 992) {
        $block.find(".header-gnbitem").each(function() {
          const $gnblink = $(this).find(".header-gnblink");
          const $sublist = $(this).find(".header-sublist");
          if ($sublist.length) {
            $gnblink.attr("href", "javascript:void(0);");
          }
        });
      }
    });
  });
})();