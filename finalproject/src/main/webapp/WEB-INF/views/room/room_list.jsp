<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <script>
        var bizrno;
    </script>
    <script>
        // 객실정보수정
        function modify_form(room_idx){

            $.ajax({
                url: "room/modify_form.do",
                data:{room_idx:room_idx},
                success: function (res_data) {
                    $("#container_content").html(res_data);
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    console.table(jqXHR)
                }
            });
        }              
        // 객실등록하기
        function room_insert(){
            bizrno = $("#search").val();
            $.ajax({
                url: "room/insert_form.do",
                success: function (res_data) {
                    $("#container_content").html(res_data);
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    console.table(jqXHR)
                }
            });
        }
        // 요금리스트
        function room_feelist(room_idx){
            $.ajax({
                url: "fee/list.do",
                data:{"room_idx": room_idx},
                success: function (res_data) {
                    $("#container_content").html(res_data);
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    console.table(jqXHR)
                }
            });
        }

    </script>
    <script>
        $(document).ready(function () {
            var id = document.querySelectorAll('[class="my_room_list"]')[0].id;
            updateInfo(id); // 여기서 '0'은 첫 번째 캠핑장 정보에 해당하는 옵션의 value 값의 숫자 부분입니다.
        });
        function updateInfo(selectedValue) {
            // 모든 폼을 숨깁니다.
            var room_list = document.querySelectorAll('[class="my_room_list"]');
            room_list.forEach(function(form) {
                form.style.display = 'none';
            });
            
            // 선택된 캠핑장에 해당하는 폼만 보이도록 합니다.
            // 여기서 selectedValue는 option의 value 속성을 기반으로 하는데,
            // 실제 value와 form ID 사이에 일관된 매핑이 필요합니다.
            var selectedFormId = selectedValue;
            var selectedForm = document.getElementById(selectedFormId);
            if (selectedForm) {
                selectedForm.style.display = 'block';
                console.log("#"+selectedFormId);
                
            }
        }
    </script>
    <script>
        function download(file_name) {
            //alert(g_p_filename+"파일 다운로드...");
            
            //alert('안녕/'+encodeURIComponent('안녕'));
            //안녕/%EC%95%88%EB%85%95 이렇게 0xEc 0x95 이렇게 16진수로 넘어감
            
            location.href="FileDownload.do?dir=/notice_file_upload/&filename="+encodeURIComponent(file_name,"utf-8");
        }
    </script>
</head>

<body>
    <main class="th-layout-main">

        <div class="th-layout-main">
            <!-- [S]my_room  -->
            <div id="my_room">
                <div class="my_info_title">객실정보</div>
                <div class="room_search">
                    <select class="search_inquiry" name="search" id="search" onchange="updateInfo(this.value)">
                        <c:forEach items="${user.camp_ceo_list}" var="campCeoList" varStatus="status">
                            <option value="${campCeoList.bizrno}">${campCeoList.bizrno}</option>
                        </c:forEach>                     
                    </select>
                    <div class="room_insert" onclick="room_insert();">객실등록</div>
                </div>
                <c:forEach var="vo" items="${camp_list}" varStatus="i" >
                    <div class="my_room_list" id="${vo.bizrno}" style="display: none;">
                        <c:forEach var="room_vo" items="${vo.room_list}">
                            <div class="room_box" >
                                <div class="room_box_content">
                                    <div class="room_box_img">
                                        <img src="${pageContext.request.contextPath}/assets/img/sample/img_glamping_N5_1.png"alt="">
                                    </div>
                                    <div class="room_info">
                                        <div class="room_title">${room_vo.room_name}</div>
                                        <div class="room_look"><p onclick="modify_form('${room_vo.room_idx}');" class="modify">객실수정 ></p></div>
                                        <div class="room_detailed">
                                            <div class="room_time">
                                                <div class="room_date_to">입실시간&nbsp;&nbsp;&nbsp;${room_vo.room_in}</div>
                                                <div class="room_date_str">퇴실시간&nbsp;&nbsp;&nbsp;${room_vo.room_out}</div>
                                            </div>    
                                            <div class="room_addinfo">
                                                <div class="room_date_to">객실정보 &nbsp;&nbsp;&nbsp;기준${room_vo.room_min}인 · 최대${room_vo.room_max}인</div>
                                                <div class="room_date_str">추가정보(기타) &nbsp;&nbsp;&nbsp;${room_vo.room_etc}</div>

                                            </div>
                                            
                                        </div>
                                    </div>
                                </div>
                                <c:if test="${not empty room_vo.photo_list}">
                                    <div class="room_detailed">
                                        <div class="room_photo" id="photo_${vo.bizrno}">
                                            <c:forEach var="photo_vo" items="${room_vo.photo_list}">
                                                <c:if test="${photo_vo.pho_del_yn eq 'n'}">
                                                    <img src="${pageContext.request.contextPath}/room_photo_upload/${photo_vo.pho_name}"onclick="download('${photo_vo.pho_name}')">
                                                </c:if>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </c:if>
                                <div class="room_detailed insert_container">
                                    <div class="fee_list" onclick="room_feelist('${room_vo.room_idx}')">요금등록</div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:forEach>
                </div>
            </div>
        </div>
        <!-- [E]my_room  -->
    </main>
</body>

</html>