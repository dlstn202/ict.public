<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<meta charset="UTF-8">
<title>캠프안내</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/setting.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/plugin.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/template.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/footer.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/info.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/nav.css">
<script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=897d9c3b7e07054fabb6126c0c458f98&libraries=services"></script>

<script>
    let doNm = "${doNm}";
    let sigunguNm = "${sigunguNm}";
    let induty = "${induty}";
    let lctCl = "${lctCl}";
    let SiteCo = "${SiteCo}";
    let sbrsCl = "${sbrsCl}";
    // 윈도우의 사이즈가 변경될 때마다 부모 요소의 높이를 조정하는 함수를 정의합니다.
    function adjustParentHeight() {


    var parent = document.getElementsByClassName('map-container')[0];
    var windowHeight = window.innerHeight-80;
    parent.style.height = windowHeight + 'px';


    var parent = document.getElementById('map');
    var windowHeight = window.innerHeight-80;
    parent.style.height = windowHeight + 'px';


    var parent = document.getElementById('info_container_list');
    var windowHeight = window.innerHeight-80;
    parent.style.height = windowHeight + 'px';


    // var parent = document.getElementById('place_area');
    // var windowHeight = window.innerHeight-140;
    // parent.style.height = windowHeight + 'px';


    }  

$(document).ready(function() {
    // main 초기화
    $.ajax({
        url: "info_nav.do",
        success: function(res_data) {
            $("#all_nav").html(res_data);
            
            $.ajax({
                url: "info_container1.do",
                data:{"doNm": "${doNm}", "sigunguNm": "${sigunguNm}",
                      "induty":induty, "lctCl":lctCl,
                      "SiteCo":SiteCo ,"sbrsCl":sbrsCl  },
                success: function(res_data) {
                    $("#info_container1").html(res_data);
                    adjustParentHeight(); // 페이지 로드시에 높이를 조정합니다.
                           
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
                        
                        loadAdditionalScripts();
            }
    });
});


        // 페이지및 리사이즈시 윈도우 사이즈 변경 
    
        window.onresize = adjustParentHeight;

</script>

<script>

    function loadAdditionalScripts() {

    }



</script>
</head>
<body>
    
    <div id="all_nav"></div>
    <div id="info_container1"></div>
    
</body>
</html>