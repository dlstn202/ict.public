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
<script>

    $(document).ready(function () {

       // main 초기화
       $.ajax({
           url: "nav.do",
           success: function (res_data) {
                $("#join_input_nav").html(res_data);
                $.ajax({
                    url: "join_header.do",
                    success: function (res_data) {
                        $("#join_input_header").html(res_data);
                        $.ajax({
                            url: "join_input_container.do",
                            data: { 
                                "mem_name":"${vo.mem_name}","mem_email_first":"${mem_email_first}","mem_email_domain":"${mem_email_domain}",
                                "mem_tel":"${vo.mem_tel}"
                            },
                            success: function (res_data) {
                                $("#join_input_container").html(res_data);
                                $.getScript("${pageContext.request.contextPath}/assets/js/domain.js");
                                $.ajax({
                                    url: "footer.do",
                                    success: function (res_data) {
                                        $("#join_input_footer").html(res_data);
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
           //    loadAdditionalScripts();
           }
       });
   })
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
<form>
    <div id="join_input_nav"></div>
    <div id="join_input_header"></div>
    <div id="join_input_container"></div>
    <div id="join_input_footer"></div>
    <input type="hidden" id="mem_grade" name="mem_grade" value="${vo.mem_grade}">
    <input type="hidden" id="mem_kakao" name="mem_kakao" value="${vo.mem_kakao}">
    <input type="hidden" id="mem_naver" name="mem_naver" value="${vo.mem_naver}">
    <input type="hidden" id="mem_google" name="mem_google" value="${vo.mem_google}">
    <input type="hidden" id="url" name="url" value="${url}">
    <input type="hidden" id="agree1_yn" name="agree1_yn" value="${vo.agree1_yn}">
    <input type="hidden" id="agree2_yn" name="agree2_yn" value="${vo.agree2_yn}">
    <input type="hidden" id="agree3_yn" name="agree3_yn" value="${vo.agree3_yn}">
</form>
 
</body>