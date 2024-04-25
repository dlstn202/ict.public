<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta http-equiv="imagetoolbar" content="no">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="format-detection" content="telephone=no">
  <meta name="title" content="웹사이트">
  <meta name="description" content="웹사이트입니다.">
  <meta name="keywords" content="키워드,키워드,키워드">
  <meta property="og:title" content="웹사이트">
  <meta property="og:description" content="웹사이트입니다">
  <meta property="og:image" content="https://웹사이트/images/opengraph.png">
  <meta property="og:url" content="https://웹사이트"> 
  <title>로그인 | ㅎ</title>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <!-- <script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script> -->
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/plugin.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/template.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/setting.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/login.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/footer.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/nav.css">
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
  <script>let headerHeight = 0;</script>
  <script>
    sessionStorage.removeItem('mypage_menu');
  </script>
  <script>
    
  $(document).ready(function () {   
    $.ajax({
      url: "nav.do",
        success: function (res_data) {
          $("#login_nav").html(res_data);
          $.ajax({
            url: "login_header.do",
            success: function (res_data) {
              $("#login_header").html(res_data);
              $.ajax({
                url: "login_container.do",
                data: {"url":"${url}"},
                success: function (res_data) {
                  $("#login_container").html(res_data);
                  $.ajax({
                    url: "footer.do",
                    success: function (res_data) {
                        $("#login_footer").html(res_data);
                        
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        console.table(jqXHR)
                    }
                  });
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    console.table(jqXHR)
                }
              });
            },
            error: function (jqXHR, textStatus, errorThrown) {
                    console.table(jqXHR)
            }
          });
        },
      error: function (jqXHR, textStatus, errorThrown) {
          console.table(jqXHR)
      },
      complete: function () {
        // AJAX 호출이 모두 완료되면 추가적인 스크립트 파일들을 로드합니다.
  //      loadAdditionalScripts();
      }
    });
  })
</script>
<script>
  $(document).ready(function(){
    if("${param.timeout}" == "true"){
      Swal.fire({
            title: "로그인이 만료됐습니다.<br>다시 로그인해주세요.",
            allowOutsideClick: false
          });
    }
  });
</script>
<script>
function loadAdditionalScripts() {
    // 추가적인 스크립트 파일들을 로드합니다.
    // $.getScript("${pageContext.request.contextPath}/assets/js/setting.js");
    // $.getScript("${pageContext.request.contextPath}/assets/js/plugin.js");
    // $.getScript("${pageContext.request.contextPath}/assets/js/template.js");
    // $.getScript("${pageContext.request.contextPath}/assets/js/common.js");
    // $.getScript("${pageContext.request.contextPath}/assets/js/script.js");
}

</script>
</head>
<body>
 

  <div id="login_nav"></div>
  <div id="login_header"></div>
  <div id="login_container"></div>
  <div id="login_footer"></div>
          

</body>
</body>
</html>