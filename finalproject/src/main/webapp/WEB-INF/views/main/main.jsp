<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../all/chatbot.jsp" %>
    <!DOCTYPE html>
    <html>

    <head>
        <script>let headerHeight = 0;</script>
        <script src="${pageContext.request.contextPath}/assets/js/plugin.js"></script>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        <meta charset="UTF-8">
        <title>캠프로버</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/setting.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/plugin.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/template.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/nav.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/footer.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
        <!-- <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css"> -->
        <script>
            $(document).ready(function () {
                // main 초기화
                $.ajax({
                    url: "nav.do",
                    success: function (res_data) {
                        $("#nav").html(res_data);
                        $.ajax({
                            url: "header.do",
                            success: function (res_data) {
                                $("#header").html(res_data);
                                
                                $.ajax({
                                    url: "container1.do",
                                    success: function (res_data) {
                                        $("#container1").html(res_data);
                                        $.ajax({
                                            url: "container2.do",
                                            success: function (res_data) {
                                                $("#container2").html(res_data);
                                                $.ajax({
                                                    url: "footer.do",
                                                    success: function (res_data) {
                                                        $("#footer").html(res_data);
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
                            }
                        });
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        console.table(jqXHR)
                    },
                    complete: function () {

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
        <button class="chat_open_btn" onclick="openChatBotModal();">챗봇</button>
        <div id="nav"></div>
        <div id="header"></div>
        <div id="container1"></div>
        <div id="container2"></div>
        <div id="footer"></div>
        
    </body>

    </html>