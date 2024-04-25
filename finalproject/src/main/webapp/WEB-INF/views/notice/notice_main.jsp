<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">

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
    <title>커뮤니티_공지사항</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/setting.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/plugin.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/template.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/notice.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/nav.css">
    <script>
        $(document).ready(function () {
            // main 초기화
            $.ajax({
                url: "nav.do",
                success: function (res_data) {
                    $("#notice_nav").html(res_data);
                    $.ajax({
                        url: "notice_header.do",
                        success: function (res_data) {
                            $("#notice_header").html(res_data);
                            $.ajax({
                                url: "notice_container.do",
                                success: function (res_data) {
                                    $("#notice_container").html(res_data);
                                    $.ajax({
                                        url: "footer.do",
                                        success: function (res_data) {
                                            $("#notice_footer").html(res_data);
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
    <div id="notice_nav"></div>
    <div id="notice_header"></div>
    <div id="notice_container"></div>
    <div id="notice_footer"></div>

</body>

</html>