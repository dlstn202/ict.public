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
  <title>캠프로버</title>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/plugin.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/template.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/setting.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/join.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/footer.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/nav.css">
  <script>let headerHeight = 0;</script>
  <script src="https://accounts.google.com/gsi/client" async></script>
</head>

<script>

    
    $(document).ready(function () {

        let mem_grade = $('input[name="mem_grade"]').val();
        let url = $('input[name="url"]').val();

       // main 초기화
       $.ajax({
           url: "nav.do",
           success: function (res_data) {
                $("#join_agree_nav").html(res_data);
                $.ajax({
                    url: "join_header.do",
                    success: function (res_data) {
                        $("#join_agree_header").html(res_data);
                        $.ajax({
                            url: "join_agree_container.do",
                            data: { mem_grade:mem_grade, url:url },
                            success: function (res_data) {
                                $("#join_agree_container").html(res_data);
                                $.ajax({
                                    url: "footer.do",
                                    success: function (res_data) {
                                        $("#join_agree_footer").html(res_data);
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
             //   loadAdditionalScripts();
            }
        });
    })
</script>
<script>
    function loadAdditionalScripts() {
        // 추가적인 스크립트 파일들을 로드합니다.
        //    $.getScript("${pageContext.request.contextPath}/assets/js/setting.js");
        //    $.getScript("${pageContext.request.contextPath}/assets/js/plugin.js");
        //    $.getScript("${pageContext.request.contextPath}/assets/js/template.js");
        //    $.getScript("${pageContext.request.contextPath}/assets/js/common.js");
        //    $.getScript("${pageContext.request.contextPath}/assets/js/script.js");
    }
    
</script>
<body>
    <form>
        <div id="join_agree_nav"></div>
        <div id="join_agree_header"></div>
        <div id="join_agree_container"></div>
        <div id="join_agree_footer"></div>
        <input type="hidden" name="mem_grade" value="${mem_grade}">
        <input type="hidden" name="url" value="${url}">
        <input type="hidden" name="mem_kakao" value="${mem_kakao}">
        <input type="hidden" name="mem_naver" value="${mem_naver}">
        <input type="hidden" name="mem_google" value="${mem_google}">
        <input type="hidden" name="mem_name" value="${mem_name}">
        <input type="hidden" name="mem_tel" value="${mem_tel}">
        <input type="hidden" name="mem_email_first" value="${mem_email_first}">
        <input type="hidden" name="mem_email_domain" value="${mem_email_domain}">
    </form>

</body>

  </html>