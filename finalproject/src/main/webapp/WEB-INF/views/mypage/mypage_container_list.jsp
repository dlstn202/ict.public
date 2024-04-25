<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>

    //내정보
    function container_info(){
        sessionStorage.setItem('mypage_menu', 1);

        $.ajax({
            url: "mypage_container_info.do",
            success: function (res_data) {
                $("#container_content").html(res_data);
                $.getScript("${pageContext.request.contextPath}/assets/js/domain.js");
                changeLiColor();
                $("#info").css("color", "#00AF52");

            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.table(jqXHR)
            }
        });
    }
    

    // 내장소
    function keep_list(){
        sessionStorage.setItem('mypage_menu', 2);

        $.ajax({
            url: "mypage_container_general_keep_list.do",
            success: function (res_data) {
                $("#container_content").html(res_data);
                changeLiColor();
                $("#keep").css("color", "#00AF52");
            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.table(jqXHR)
            }
        });
    }

    // 예약 내역
    function mygeneral_reserve(){
        sessionStorage.setItem('mypage_menu', 3);

        $.ajax({
            url: "reservation/mypage_general.do",
            success: function (res_data) {
                $("#container_content").html(res_data);
                changeLiColor();
                $("#reserve").css("color", "#00AF52");
            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.table(jqXHR)
            }
        });
    }

    // 문의 내역
    function inquiry(){
        sessionStorage.setItem('mypage_menu', 4);

        $.ajax({
            url: "qna_mypage_list_general_ceo.do",
            success: function (res_data) {
                $("#container_content").html(res_data);
                changeLiColor();
                $("#inquiry").css("color", "#00AF52");
            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.table(jqXHR)
            }
        });
    }

    // 리뷰 내역
    function review(){
        sessionStorage.setItem('mypage_menu', 5);

        $.ajax({
            url: "mypage_container_general_review.do",
            success: function (res_data) {
                $("#container_content").html(res_data);
                changeLiColor();
                $("#review").css("color", "#00AF52");
            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.table(jqXHR)
            }
        });
    }

    // 내캠핑장
    function business(){
        sessionStorage.setItem('mypage_menu', 6);

        $.ajax({
            url: "mypage_container_ceo_business.do",
            success: function (res_data) {
                $("#container_content").html(res_data);
                changeLiColor();
                $("#business").css("color", "#00AF52");
                $.getScript("${pageContext.request.contextPath}/assets/js/domain.js");
            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.table(jqXHR)
            }
        });
    }
    function ceo_room(){

        sessionStorage.setItem('mypage_menu', 7);

        $.ajax({
            url: "room/list.do",
            success: function (res_data) {
                $("#container_content").html(res_data);
                changeLiColor();
                $("#ceo_room").css("color", "#00AF52");
            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.table(jqXHR)
            }
        });
    }

    // 회원정보
    function member(){

        sessionStorage.setItem('mypage_menu', 8);

        $.ajax({
            url: "mypage_container_manager_member.do",
            success: function (res_data) {
                $("#container_content").html(res_data);
                changeLiColor();
                $("#member").css("color", "#00AF52");
                $.getScript("${pageContext.request.contextPath}/assets/js/domain.js");
            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.table(jqXHR)
            }
        });
    }

    // 문의답변
    function qna(){

        sessionStorage.setItem('mypage_menu', 9);

        $.ajax({
            url: "answer/mypage_list.do",
            success: function (res_data) {
                $("#container_content").html(res_data);
                changeLiColor();
                $("#qna").css("color", "#00AF52");
            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.table(jqXHR)
            }
        });
    }

    // FAQ
    function faq(){

        sessionStorage.setItem('mypage_menu', 10);
 
        $.ajax({
            url: "mypage_container_manager_faq.do",
            success: function (res_data) {
                $("#container_content").html(res_data);
                changeLiColor();
                $("#faq").css("color", "#00AF52");
                
            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.table(jqXHR)
            }
        });
    }

    // 공지사항
    function notice(){

        sessionStorage.setItem('mypage_menu', 11);

        $.ajax({
            url: "notice_myapge_list.do",
            success: function (res_data) {
                $("#container_content").html(res_data);
                changeLiColor();
                $("#notice").css("color", "#00AF52");
                
            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.table(jqXHR)
            }
        });
    }

    // 캠핑장 신청내역
    function req_content(){

        sessionStorage.setItem('mypage_menu', 12);

        $.ajax({
            url: "mypage_container_manager_req_content.do",
            success: function (res_data) {
                $("#container_content").html(res_data);
                changeLiColor();
                $("#req_content").css("color", "#00AF52");
            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.table(jqXHR)
            }
        });
    }

    // 신고내역
    function report(){

        sessionStorage.setItem('mypage_menu', 13);

        $.ajax({
            url: "mypage_container_manager_report.do",
            success: function (res_data) {
                $("#container_content").html(res_data);
                changeLiColor();
                $("#report").css("color", "#00AF52");
            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.table(jqXHR)
            }
        });
    }

    // 권한/계정 부여
    function authorize(){

        sessionStorage.setItem('mypage_menu', 14);

        $.ajax({
            url: "mypage_container_manager_authorize.do",
            success: function (res_data) {
                $("#container_content").html(res_data);
                changeLiColor();
                $("#authorize").css("color", "#00AF52");
            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.table(jqXHR)
            }
        });
    }

    // 관리자 캠핑장 수정
    function manager_modify_camp(){

        sessionStorage.setItem('mypage_menu', 15);

        $.ajax({
            url: "mypage_container_manager_modify_camp.do",
            success: function (res_data) {
                $("#container_content").html(res_data);
                changeLiColor();
                $("#manager_modify_camp").css("color", "#00AF52");
                $.getScript("${pageContext.request.contextPath}/assets/js/domain.js");
            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.table(jqXHR)
            }
        });
    }

    //사장 캠핌장 예약 내역
    function room_rev(){

        sessionStorage.setItem('mypage_menu', 16);

        $.ajax({
            url: "reservation/mypage_ceo.do",
            success: function (res_data) {
                $("#container_content").html(res_data);
                changeLiColor();
                $("#room_rev").css("color", "#00AF52");
            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.table(jqXHR)
            }
        });
    }

    //사장 캠핌장 예약 내역
    function room_rev_old(){

        sessionStorage.setItem('mypage_menu', 17);

        $.ajax({
            url: "reservation/mypage_ceo_old.do",
            success: function (res_data) {
                $("#container_content").html(res_data);
                changeLiColor();
                $("#room_rev_old").css("color", "#00AF52");
            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.table(jqXHR)
            }
        });
    }


</script>
<script>
    function changeLiColor() {

        var lis = document.querySelectorAll(".mypage_container_list li");

        
        lis.forEach(function(li) {
            li.style.color = "#003A1B"; 
        });
}
</script>
</head>
<body>
<nav class="mypage_container_list_nav">
<ul class="mypage_container_list">

    <li id="info"><div onclick="container_info();">내정보</div></li>
    <c:if test="${user.mem_grade eq 'general'}">
        <!-- 일반 -->
        <li id="keep"><div onclick="keep_list();">내장소</div></li>
        <!-- 일반 -->
        <li id="reserve"><div onclick="mygeneral_reserve();">예약내역</div></li>
    </c:if>
    <c:if test="${user.mem_grade eq 'general' or user.mem_grade eq 'ceo'}">
        <!-- 일반+사장 -->
        <li id="inquiry"><div onclick="inquiry();">문의내역</div></li>
    </c:if>
    <c:if test="${user.mem_grade eq 'general'}">
        <!-- 일반 -->
        <li id="review"><div onclick="review();">내리뷰</div></li>
    </c:if>
    <c:if test="${user.mem_grade eq 'ceo'}">
        <!-- 사장 -->
        <li id="business"><div onclick="business();">내캠핑장</div></li>
        <li id="ceo_room"><div onclick="ceo_room();">객실정보</div></li>
        <li id="room_rev"><div onclick="room_rev();">예약내역</div></li>
        <li id="room_rev_old"><div onclick="room_rev_old();">예약내역(과거)</div></li>
    </c:if>
    <c:if test="${user.mem_grade eq 'manager'}">
        <!-- 관리자 -->
        <c:if test="${user.mem_man_yn eq 'y'}">
            <li id="member"><div onclick="member();">회원정보</div></li>
        </c:if>
        <c:if test="${user.qna_man_yn eq 'y'}">
            <li id="qna"><div onclick="qna();">문의답변</div></li>
        </c:if>
        <c:if test="${user.not_man_yn eq 'y'}">
        <!-- <li id="faq"><div onclick="faq();">FAQ</div></li> -->
            <li id="notice"><div onclick="notice();">공지사항</div></li>
        </c:if>
        <c:if test="${user.qna_man_yn eq 'y'}"></c:if>
        <!-- <li id="req_content"><div onclick="req_content();">캠핑장신청내역</div></li> -->
        <!-- <li id="report"><div onclick="report();">신고내역</div></li> -->
        <!-- <li id="manager_modify_camp"><div onclick="manager_modify_camp();">캠핑장 수정</div></li> -->
    </c:if>
    <c:if test="${user.mem_id eq 'admin'}">
        <li id="authorize"><div onclick="authorize();">관리자 계정/권한</div></li>
    </c:if>
</ul>
</nav>
</body>
</html>