<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
    function modify_admin(f){
        let mem_idx = document.getElementById('mem_idx').innerHTML;
        let not_man_yn = f.not_man_yn.value;
        let mem_man_yn = f.mem_man_yn.value;
        let rep_man_yn = f.rep_man_yn.value;
        let qna_man_yn = f.qna_man_yn.value;
        let mem_quit_yn = f.mem_quit_yn.value;

        if(confirm("수정하시겠습니까?")==false) return;

        $.ajax({
            type:"POST",
            url: "admin_modify.do",
            data: { "mem_idx":mem_idx, 
                    "not_man_yn":not_man_yn, 
                    "mem_man_yn":mem_man_yn, 
                    "rep_man_yn":rep_man_yn, 
                    "qna_man_yn":qna_man_yn, 
                    "mem_quit_yn":mem_quit_yn
                },
            success: function (res_data) {
                alert("수정되었습니다");
            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.table(jqXHR)
            }
        });

    }

</script>
<script>
    function reset_pwd(){
        
        let mem_idx = document.getElementById('mem_idx').innerHTML;

        if(confirm("비밀번호를 초기화하시겠습니까?")==false) return;

        alert(mem_idx);
        $.ajax({
            type:"POST",
            url: "reset_pwd_admin.do",
            data: { "mem_idx":mem_idx, 
                    "new_pwd":"1234"
                },
            success: function (res_data) {
                alert("비밀번호가 초기화되었습니다(초기 비밀번호 : 1234)");
            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.table(jqXHR)
            }
        });

        
    }



</script>
</head>


<body>

<!-- 계정 수정 모달 -->
<div id="ManagerAuthorizeModal" class="modal fade" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content ">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <p class="modal-title"><a onclick="">관리자 계정 수정</a></p>
            </div>

            <div class="modal-body">
                <form>
                    <table class="table table_list">
                        <tr>
                            <th class="table_list_th">관리자 번호</th>
                            <td class="table_list_td" id="mem_idx" class="mem_idx1"></td>
                        </tr>
                        <tr>
                            <th class="table_list_th">아이디</th>
                            <td class="table_list_td" id="mem_id_input"></td>
                        </tr>
                        <tr>
                            <th class="table_list_th">패스워드초기화</th>
                            <td class="table_list_td"><input class="btnset btnset-round btnset-line btn_pwd_initialization" id="btn_reset" type="button" onclick="reset_pwd();" value="비밀번호 초기화"></td>
                        </tr>
                        <tr>
                            <th class="table_list_th">이메일</th>
                            <td class="table_list_td" id="mem_email_input"></td>
                        </tr>
                        <tr>
                            <th class="table_list_th">전화번호</th>
                            <td class="table_list_td" id="mem_tel_input"></td>
                        </tr>
                        <tr>
                            <th class="table_list_th">계정부여일자</th>
                            <td class="table_list_td" id="mem_joindate_input"></td>
                        </tr>
                        <tr>
                            <th class="table_list_th">공지사항/FAQ권한</th>
                            <td class="table_list_td">
                                <select class="select" id="not_man_yn_input" name="not_man_yn">
                                    <option value="y" selected>y</option>
                                    <option value="n">n</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <th class="table_list_th">회원관리권한</th>
                            <td class="table_list_td">
                                <select class="select" id="mem_man_yn_input" name="mem_man_yn">
                                    <option value="y" selected>y</option>
                                    <option value="n">n</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <th class="table_list_th">신고권한</th>
                            <td class="table_list_td">
                                <select class="select" id="rep_man_yn_input" name="rep_man_yn">
                                    <option value="y" selected>y</option>
                                    <option value="n">n</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <th class="table_list_th">온라인문의권한</th>
                            <td class="table_list_td" id="qna_man_yn">
                                <select class="select" id="qna_man_yn_input" name="qna_man_yn">
                                    <option value="y" selected>y</option>
                                    <option value="n">n</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <th class="table_list_th">탈퇴여부</th>
                            <td class="table_list_td" id="mem_quit_yn">
                                <select class="select mem_quit_y" id="mem_quit_yn_input" name="mem_quit_yn">
                                    <option value="y" selected>y</option>
                                    <option value="n">n</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <th class="table_list_th">탈퇴일자</th>
                            <td class="table_list_td" id="mem_quitdate_input"></td>
                        </tr>
                        <tr>
                            <td colspan="2" class="btn_modify_td"><input class="btnset btnset-round" type="button" id="btn_modify" value="수정" onclick="modify_admin(this.form);"></td>
                        </tr>
                    </table>
                </form>

            </div>
        </div>
    </div>
</div>



</body>
</html>