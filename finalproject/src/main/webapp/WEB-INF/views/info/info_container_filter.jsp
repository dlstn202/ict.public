<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Document</title>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

        <script>
            $(document).ready(function () {

                $('.filter_select_box').click(function () {
                    $(this).toggleClass('active');
                
                });
                
            });
        
        
        </script>

    <script>
        function info_filter_test(){
            var form = document.getElementById('filter_form');
            var formData = new FormData(form);
            console.log(formData);
            $.ajax({
                type: "POST",
                url: 'info_container_filter_test.do',
                data: formData,
                processData: false,
                contentType: false,
                success: function (data) {
                    $("#info_container_list").html(data);
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    console.table(jqXHR);
                }
            });

        }
    </script>
    <script>
        $(document).ready(function(){
            $("#filter_form[name=doNm]").val(doNm);
            $("#filter_form[name=sigunguNm]").val(sigunguNm);
        })
    </script>
    </head>
    <body>
    <form id="filter_form">
    <input type="hidden" name="doNm" value="${param.doNm}">
    <input type="hidden" name="sigunguNm" value="${param.sigunguNm}">
        <div class="sido_select">
            <div id="local_cancel" onclick=""><i class="fa-solid fa-xmark" style="color: #00391c;"></i></div>
            <div id="local_button">필터</div>
            <!-- <div id="local_ok"><i id="local_ok_con" class="fa-solid fa-check"></i> 확인</div> -->
            <div id="local_ok" onclick="info_filter_test();"><i id="local_ok_con" class="fa-solid fa-check"></i> 확인</div>
        </div>
        <div class="filter_select">
            <div class="filter_title">캠핑장타입</div>  
            <div class="filter_select_list" id="induty">
                <input type="checkbox" class="filter_select_box" name="induty" value="야영장" id="induty-1">
                <label for="induty-1"><div class="filter_select_box">야영장</div></label>
                <input type="checkbox" class="filter_select_box" name="induty" value="오토캠핑" id="induty-2">
                <label for="induty-2"><div class="filter_select_box">오토캠핑</div></label>
                <input type="checkbox" class="filter_select_box" name="induty" value="카라반" id="induty-3">
                <label for="induty-3"><div class="filter_select_box">카라반</div></label>
                <input type="checkbox" class="filter_select_box" name="induty" value="차박" id="induty-4">
                <label for="induty-4"><div class="filter_select_box">차박</div></label>
                <input type="checkbox" class="filter_select_box" name="induty" value="글램핑" id="induty-5">
                <label for="induty-5"><div class="filter_select_box">글램핑</div></label>
                <!-- <div class="filter_select_box">야영장</div>
                <div class="filter_select_box">오토캠핑</div>
                <div class="filter_select_box">카라반</div>
                <div class="filter_select_box">차박</div>
                <div class="filter_select_box">글램핑</div> -->
            </div>
            <div class="filter_title">위치/환경</div>
            <div class="filter_select_list" id="lctCl">
                <input type="checkbox" class="filter_select_box" name="lctCl" value="숲" id="lctCl-1">
                <label for="lctCl-1"><div class="filter_select_box">숲</div></label>
                <input type="checkbox" class="filter_select_box" name="lctCl" value="계곡" id="lctCl-2">
                <label for="lctCl-2"><div class="filter_select_box">계곡</div></label>
                <input type="checkbox" class="filter_select_box" name="lctCl" value="강" id="lctCl-3">
                <label for="lctCl-3"><div class="filter_select_box">강</div></label>
                <input type="checkbox" class="filter_select_box" name="lctCl" value="호수" id="lctCl-4">
                <label for="lctCl-4"><div class="filter_select_box">호수</div></label>
                <input type="checkbox" class="filter_select_box" name="lctCl" value="해변" id="lctCl-5">
                <label for="lctCl-5"><div class="filter_select_box">해변</div></label>
                <input type="checkbox" class="filter_select_box" name="lctCl" value="섬" id="lctCl-6">
                <label for="lctCl-6"><div class="filter_select_box">섬</div></label>
                <input type="checkbox" class="filter_select_box" name="lctCl" value="산" id="lctCl-7">
                <label for="lctCl-7"><div class="filter_select_box">산</div></label>
                <!-- <div class="filter_select_box">숲</div>
                <div class="filter_select_box">산</div>
                <div class="filter_select_box">계곡</div>
                <div class="filter_select_box">강</div>
                <div class="filter_select_box">호수</div>
                <div class="filter_select_box">해변</div>
                <div class="filter_select_box">섬</div>
                <div class="filter_select_box">폐교</div> -->
            </div>
            <div class="filter_title">사이트재질</div>
            <div class="filter_select_list" >
                <input type="checkbox" class="filter_select_box" name="SiteCo" value="siteBottomCl1" id="SiteCo-1">
                <label for="SiteCo-1"><div class="filter_select_box">잔디</div></label>
                <input type="checkbox" class="filter_select_box" name="SiteCo" value="siteBottomCl2" id="SiteCo-2">
                <label for="SiteCo-2"><div class="filter_select_box">파쇄석</div></label>
                <input type="checkbox" class="filter_select_box" name="SiteCo" value="siteBottomCl3" id="SiteCo-3">
                <label for="SiteCo-3"><div class="filter_select_box">테크</div></label>
                <input type="checkbox" class="filter_select_box" name="SiteCo" value="siteBottomCl4" id="SiteCo-4">
                <label for="SiteCo-4"><div class="filter_select_box">자갈</div></label>
                <input type="checkbox" class="filter_select_box" name="SiteCo" value="siteBottomCl5" id="SiteCo-5">
                <label for="SiteCo-5"><div class="filter_select_box">맨흙</div></label>
                <!-- <div class="filter_select_box">잔디</div>
                <div class="filter_select_box">데크</div>
                <div class="filter_select_box">자갈</div>
                <div class="filter_select_box">파쇄석</div>
                <div class="filter_select_box">맨흙</div> -->
            </div>
            <div class="filter_title">부대시설</div>
            <div class="filter_select_list"id="sbrsCl">
                <input type="checkbox" class="filter_select_box" name="sbrsCl" value="전기" id="sbrsCl-1">
                <label for="sbrsCl-1"><div class="filter_select_box">전기</div></label>
                <input type="checkbox" class="filter_select_box" name="sbrsCl" value="화장실" id="sbrsCl-2">
                <label for="sbrsCl-2"><div class="filter_select_box">화장실</div></label>
                <input type="checkbox" class="filter_select_box" name="sbrsCl" value="샤워" id="sbrsCl-3">
                <label for="sbrsCl-3"><div class="filter_select_box">샤워</div></label>
                <input type="checkbox" class="filter_select_box" name="sbrsCl" value="개수대" id="sbrsCl-4">
                <label for="sbrsCl-4"><div class="filter_select_box">개수대</div></label>
                <input type="checkbox" class="filter_select_box" name="sbrsCl" value="인터넷" id="sbrsCl-5">
                <label for="sbrsCl-5"><div class="filter_select_box">인터넷</div></label>
                <input type="checkbox" class="filter_select_box" name="sbrsCl" value="수영장" id="sbrsCl-6">
                <label for="sbrsCl-6"><div class="filter_select_box">수영장</div></label>
                <input type="checkbox" class="filter_select_box" name="sbrsCl" value="운동장" id="sbrsCl-7">
                <label for="sbrsCl-7"><div class="filter_select_box">운동장</div></label>
                <input type="checkbox" class="filter_select_box" name="sbrsCl" value="놀이시설" id="sbrsCl-8">
                <label for="sbrsCl-8"><div class="filter_select_box">놀이시설</div></label>

                <!-- <div class="filter_select_box">전기</div>
                <div class="filter_select_box">화장실</div>
                <div class="filter_select_box">샤워</div>
                <div class="filter_select_box">개수대</div>
                <div class="filter_select_box">인터넷</div>
                <div class="filter_select_box">수영장</div>
                <div class="filter_select_box">운동장</div>
                <div class="filter_select_box">놀이시설</div> -->
            </div>
            <!-- <div class="filter_title">기타</div>
            <div class="filter_select_list">
                <div class="filter_select_box">반려동물 입장가능</div>
                <div class="filter_select_box">어린이 놀이시설</div>
                <div class="filter_select_box">체험</div>
            </div> -->
        </div>
    </form>
    </body>

    </html>