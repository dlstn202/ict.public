/* ========== */
/* Temha */
(function () {
    // Selectset
    const selectsetToggle = document.querySelectorAll(".selectset-toggle");
    const selectsetLink = document.querySelectorAll(".selectset-link, .selectset-prefer, .selectset-story,.selectset-y,.selectset-n");
    selectsetToggle.forEach((buttonElement) => {
      const clickEventHandler = (event) => {
        event.stopPropagation();
        const button = event.target.closest(".selectset-toggle");
        const buttonParent = button.closest(".selectset");
        buttonParent.classList.toggle("active");
      };
      buttonElement.removeEventListener("click", clickEventHandler);
      buttonElement.addEventListener("click", clickEventHandler);
    });
    selectsetLink.forEach((buttonElement) => {
      const clickEventHandler = (event) => {

        event.stopPropagation();
        const button = event.target.closest(".selectset-link, .selectset-prefer, .selectset-story,.selectset-y,.selectset-n");
        //console.log(button.querySelector("span").innerHTML);
        const buttonText = button.querySelector("span").innerHTML;
        const buttonGrandParent = button.closest(".selectset-list");
        const buttonParent = button.closest(".selectset-item");
        const buttonParentSiblings = getSiblings(buttonGrandParent, buttonParent);
        const buttonSelectsetToggle = button
          .closest(".selectset")
          .querySelector(".selectset-toggle");
        buttonParentSiblings.forEach((siblingElement) => {
          siblingElement.querySelector(".selectset-link, .selectset-prefer, .selectset-story,.selectset-y,.selectset-n").classList.remove("on");
        });
        //console.log(buttonText);
        // button.classList.toggle("on");
        buttonSelectsetToggle.querySelector("span").innerHTML = buttonText;
        if(buttonText == "직접입력"){
         document.querySelector(".email_domain").value = "";}
        else if(buttonText == "naver.com"){
         document.querySelector(".email_domain").value = buttonText;}
        else if(buttonText == "daum.net"){
          document.querySelector(".email_domain").value = buttonText;}
        else if(buttonText == "hanmail.net"){
          document.querySelector(".email_domain").value = buttonText;}
        else if(buttonText == "kakao.com"){
          document.querySelector(".email_domain").value = buttonText;}
        else if(buttonText == "gmail.com"){
          document.querySelector(".email_domain").value = buttonText;}
        
      };
      buttonElement.removeEventListener("click", clickEventHandler);
      buttonElement.addEventListener("click", clickEventHandler);
    });
    
    function getSiblings(parent, element) {
        return [...parent.children].filter((item) => item !== element);
      }
      function getIndex(element) {
        return [...element.parentNode.children].indexOf(element);
      }

      selectsetLink.forEach((buttonElement) => {
        const clickEventHandler = (event) => {
          event.stopPropagation();
          const button = event.target.closest(".selectset-link, .selectset-prefer, .selectset-story, .selectset-y, .selectset-n");
          const buttonText = button.querySelector("span").innerHTML;
          const buttonSelectset = button.closest(".selectset");
      
          // 버튼의 텍스트에 따라 email_domain 값을 설정합니다.
          if (buttonText === "직접입력") {
            document.querySelector(".email_domain").value = "";
            buttonSelectset.classList.remove("active");
          } else if (buttonText === "naver.com" || buttonText === "daum.net" || buttonText === "hanmail.net" || buttonText === "kakao.com" || buttonText === "gmail.com") {
            document.querySelector(".email_domain").value = buttonText;
            buttonSelectset.classList.remove("active");
          }
      
          // '미동행' 버튼이 클릭된 경우 상위 selectset 요소에서 'active' 클래스 제거
          if (button.dataset.value === "미동행") {
            buttonSelectset.classList.remove("active");
          }
          if (button.dataset.value === "동행") {
            buttonSelectset.classList.remove("active");
          }
        };
      
        buttonElement.removeEventListener("click", clickEventHandler);
        buttonElement.addEventListener("click", clickEventHandler);
      });
  
  })();
  