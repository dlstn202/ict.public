<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>스토리</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/plugin.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/template.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/setting.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/nav.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/story.css">
    <script>let headerHeight = 0;</script>
    <script>
        $(document).ready(function () {
            // main 초기화
            $.ajax({
                url: "nav.do",
                success: function (res_data) {
                    $("#story_nav").html(res_data);
                    $.ajax({
                        url: "story_header.do",
                        success: function (res_data) {
                            $("#story_header").html(res_data);
                            $.ajax({
                                url: "story_container.do",
                                success: function (res_data) {
                                    $("#story_container").html(res_data);
                                    $.getScript("${pageContext.request.contextPath}/assets/js/domain.js");
                                    $.ajax({
                                        url: "footer.do",
                                        success: function (res_data) {
                                            $("#story_footer").html(res_data);
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
                    loadAdditionalScripts();
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
    <div id="story_nav"></div>
    <div id="story_header"></div>
    <div id="story_container"></div>
    <div id="story_footer"></div>
</body>
</html>