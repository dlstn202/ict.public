<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script>let headerHeight = 0;</script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<meta charset="UTF-8">
<title>캠프로버</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/setting.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/plugin.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/template.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/common.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/faq.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/nav.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/footer.css">
<script>

$(document).ready(function() {
    // main 초기화
    $.ajax({
        url: "nav.do",
        success: function(res_data) {
            $("#nav").html(res_data);
            
            $.ajax({
                url: "faq_header.do",
                success: function(res_data) {
                    $("#faq_header").html(res_data);
                    
                    $.ajax({
                        url: "faq_container.do",
                        success: function(res_data) {
                            $("#faq_container").html(res_data);
                            
                            $.ajax({
                                url: "footer.do",
                                success: function(res_data) {
                                    $("#footer").html(res_data);
                                    
                                    loadAdditionalScripts();
                                },
                                error: function(jqXHR, textStatus, errorThrown) {
                                    console.table(jqXHR);
                                }
                            });
                        },
                        error: function(jqXHR, textStatus, errorThrown) {
                            console.table(jqXHR);
                        }
                    });
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    console.table(jqXHR);
                }
            });
        },
        error: function(jqXHR, textStatus, errorThrown) {
            console.table(jqXHR);
        },
            complete: function () {
                        
                      //  loadAdditionalScripts();
            }
    });
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
    <div id="nav"></div>
    <div id="faq_header"></div>
    <div id="faq_container"></div>
    <div id="footer"></div>
</body>
</html>