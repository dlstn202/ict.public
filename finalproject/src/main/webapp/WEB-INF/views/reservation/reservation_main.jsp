<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <script src="${pageContext.request.contextPath}/assets/js/plugin.js"></script>
        <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script> -->
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
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/tossStyle.css">
        <script src="https://js.tosspayments.com/v1/payment-widget"></script>
        <script>
            $(document).ready(function () {
                // main 초기화
                $.ajax({
                    url: "../nav.do",
                    async: false,
                    success: function (res_data) {
                        $("#reservation_nav").html(res_data);
                        $.ajax({
                            url: "header.do",
                            async: false,
                            success: function (res_data) {
                                $("#reservation_header").html(res_data);
                                var jaxurl = "select_room.do";
                                var formData = new FormData();
                                formData.append('bizrno', "${bizrno}");
                                if("${not empty tossSuccess}" == "true"){
                                    jaxurl = "reservation_finish.do";
                                    formData.append('res_idx', "${res_vo.res_idx}");
                                }

                                

                                $.ajax({
                                    type: "post",
                                    url: jaxurl,
                                    data: formData,
                                    processData: false,
                                    contentType: false,
                                    success: function (res_data) {
                                        $("#select_room").html(res_data);
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
        <div id="container">
            <div id="select_room"></div>
            <div id="reservation_container_date"></div>
        </div>
        <div id="reservation_footer"></div>
    </body>

    </html>