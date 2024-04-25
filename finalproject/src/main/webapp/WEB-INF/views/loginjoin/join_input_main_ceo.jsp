<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>캠프로버</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/plugin.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/template.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/setting.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/join.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/footer.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/nav.css">
<script>

    $(document).ready(function () {

       // main 초기화
       $.ajax({
           url: "nav.do",
           success: function (res_data) {
                $("#join_input_ceo_nav").html(res_data);
                $.ajax({
                    url: "join_header.do",
                    success: function (res_data) {
                        $("#join_input_ceo_header").html(res_data);
                        $.ajax({
                            url: "join_input_container_ceo.do",
                            success: function (res_data) {
                                $("#join_input_ceo_container").html(res_data);
                                $.getScript("${pageContext.request.contextPath}/assets/js/domain.js");
                                $.ajax({
                                    url: "footer.do",
                                    success: function (res_data) {
                                        $("#join_input_ceo_footer").html(res_data);
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
    <div id="join_input_ceo_nav"></div>
    <div id="join_input_ceo_header"></div>
    <div id="join_input_ceo_container"></div>
    <div id="join_input_ceo_footer"></div>
    <input type="hidden" id="mem_grade" name="mem_grade" value="${vo.mem_grade}">
    <input type="hidden" id="agree1_yn" name="agree1_yn" value="${vo.agree1_yn}">
    <input type="hidden" id="agree2_yn" name="agree2_yn" value="${vo.agree2_yn}">
    <input type="hidden" id="agree3_yn" name="agree3_yn" value="${vo.agree3_yn}">
</form>
</body>
</html>