<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" />
        <meta charset="UTF-8">
        <title>캠프로버</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/setting.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/plugin.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/template.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/common.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/reservation.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/nav.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/footer.css">
        <script>
            $(document).ready(function () {
                // main 초기화
                $.ajax({
                    url: "../nav.do",
                    success: function (res_data) {
                        $("#reservation_nav").html(res_data);
                        $.ajax({
                            url: "header.do",
                            success: function (res_data) {
                                $("#reservation_header").html(res_data);
                                $.ajax({
                                    url: "reservation_container_input.do",
                                    success: function (res_data) {
                                        $("#reservation_container_input").html(res_data);
                                        $.ajax({
                                            url: "../footer.do",
                                            success: function (res_data) {
                                                $("#reservation_footer").html(res_data);
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

        <div id="reservation_nav"></div>
        <div id="reservation_header"></div>
        <div id="reservation_container_input"></div>
        <div id="reservation_footer"></div>
    </body>

    </html>