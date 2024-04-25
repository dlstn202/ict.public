<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="mypage_container_manager_authorize_create_modal.jsp" %>
<%@ include file="mypage_container_manager_authorize_modify_modal.jsp" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>Insert title here</title>

        <script>
            function openAuthorizeModal(mem_idx){

                let mem_id          = $("#mem_id_" + mem_idx).text();
                let mem_email       = $("#mem_email_" + mem_idx).val();
                let mem_tel         = $("#mem_tel_" + mem_idx).text();
                let mem_joindate    = $("#mem_joindate_" + mem_idx).val();
                let not_man_yn      = $("#not_man_yn_" + mem_idx).text();
                let mem_man_yn      = $("#mem_man_yn_" + mem_idx).text();
                let rep_man_yn      = $("#rep_man_yn_" + mem_idx).text();
                let qna_man_yn      = $("#qna_man_yn_" + mem_idx).text();
                let mem_quit_yn     = $("#mem_quit_yn_" + mem_idx).text();
                let mem_quitdate    = $("#mem_quitdate_" + mem_idx).val();
            
                $("#mem_idx").text(mem_idx);
                $("#mem_id_input").text(mem_id);
                $("#mem_email_input").text(mem_email);
                $("#mem_tel_input").text(mem_tel);
                $("#mem_joindate_input").text(mem_joindate);

                $("#not_man_yn_input").val(not_man_yn);
                $("#mem_man_yn_input").val(mem_man_yn);
                $("#rep_man_yn_input").val(rep_man_yn);
                $("#qna_man_yn_input").val(qna_man_yn);
                $("#mem_quit_yn_input").val(mem_quit_yn);
                $("#mem_quitdate_input").text(mem_quitdate);


                $("#btn_modify").prop("disabled", false);
                $("#btn_reset").prop("disabled", false);

                let mem_quit_y = $(".mem_quit_y").val();

                if(mem_idx == "1" || mem_quit_y == "y"){ 
                    $("#btn_modify").prop("disabled", true); 
                    $("#btn_reset").prop("disabled", true); 
                }
                
                $("#ManagerAuthorizeModal").modal('show');
                $("#ManagerAuthorizeModal").modal({backdrop : "static"});

            }
        </script>
        <script>
            function openNewManagerModal(){
                $("#NewManagerModal").modal('show');
                $("#NewManagerModal").modal({backdrop : "static"});
            }
        </script>
        
    </head>

    <body>
        <main class="th-layout-main ">
            <!-- [S] my_authorize -->
            <div id="my_authorize">
                <div class="my_info_title">관리자 계정/권한 관리</div>
                
                <div id="manager_list">
                    <div id="manager_list_title">
                        <div>관리자 계정</div>
                        <input class="btnset btnset-round" type="button" onclick="openNewManagerModal();" value="계정부여">
                    </div>
                    <div id="manager_list_table">
                        <table class="table table_list">
                            <tr>
                                <th rowspan="2" class="table_list_th">번호</th>
                                <th rowspan="2" class="table_list_th">아이디</th>
                                <th rowspan="2" class="table_list_th">이름</th>
                                <th rowspan="2" class="table_list_th">전화번호</th>
                                <th colspan="4" class="table_list_th">관리자권한</th>
                                <th rowspan="2" class="table_list_th">탈퇴<br>여부</th>
                            </tr>
                            <tr>
                                
                                <th class="table_list_th">공지사항<br>FAQ</th>
                                <th class="table_list_th">회원관리</th>
                                <th class="table_list_th">신고</th>
                                <th class="table_list_th">온라인<br>문의</th>
                            </tr>

                            <c:forEach var="vo" items="${admin_list}">
                                <tr class="table_one" onclick="openAuthorizeModal('${vo.mem_idx}');">
                                    <td class="table_list_td_idx center num" id="${vo.mem_idx}">${vo.mem_idx}
                                        <input type="hidden" id="mem_email_${vo.mem_idx}" value="${vo.mem_email}">
                                        <input type="hidden" id="mem_joindate_${vo.mem_idx}" value="${vo.mem_joindate}">
                                        <input type="hidden" id="mem_quitdate_${vo.mem_idx}" value="${vo.mem_quitdate}">
                                    </td>
                                    <td class="table_list_td center" id="mem_id_${vo.mem_idx}">${vo.mem_id}</td>
                                    <td class="table_list_td center name" id="mem_name_${vo.mem_idx}">${vo.mem_name}</td>
                                    <td class="table_list_td center tel" id="mem_tel_${vo.mem_idx}">${vo.mem_tel}</td>
                                    <td class="table_list_td center yn" id="not_man_yn_${vo.mem_idx}">${vo.not_man_yn}</td>
                                    <td class="table_list_td center yn" id="mem_man_yn_${vo.mem_idx}">${vo.mem_man_yn}</td>
                                    <td class="table_list_td center yn" id="rep_man_yn_${vo.mem_idx}">${vo.rep_man_yn}</td>
                                    <td class="table_list_td center yn" id="qna_man_yn_${vo.mem_idx}">${vo.qna_man_yn}</td>
                                    <td class="table_list_td center yn" id="mem_quit_yn_${vo.mem_idx}">${vo.mem_quit_yn}</td>
                                </tr>
                            </c:forEach>
                        </table>
                    </div>
                </div>
                 
            </div>
            <!-- [E] my_authorize -->
        </main>

        



        



    </body>
    </html>