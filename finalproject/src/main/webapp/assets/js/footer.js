// glamping-N9 [FllTwPhQTo]
(function() {
    $(function() {
      $(".glamping-N9").each(function() {
        const $block = $(this);
        // Swiper
        const swiper = new Swiper(".glamping-N9 .contents-swiper", {
          slidesPerView: 'auto',
          spaceBetween: 0,
          allowTouchMove: false,
          loop: true,
          autoplay: {
            delay: 3000,
          },
          navigation: {
            nextEl: ".glamping-N9 .swiper-button-next",
            prevEl: ".glamping-N9 .swiper-button-prev",
          },
        });
      });
    });
  })();