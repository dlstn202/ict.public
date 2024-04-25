<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>캠프로버</title>
<style>

.contents-form-group { display: flex; }
.idcheckbtn{ margin-left: 57px; }
.joininput_email_height{ height: 48px; line-height: 48px;}
.contents-mail{ display: flex; }

</style>
<script>
    $(document).ready(function() {
      // 초기 상태에서 '다음 단계' 버튼을 비활성화
        $("#btn_register").prop("disabled", true);
          // 아이디 중복 확인 함수
        window.check_id = function() {
          
            let mem_id = document.getElementById('mem_id').value;
                
            if(mem_id == ''){
                alert('아이디를 입력하세요.');
                document.getElementById('mem_id').value = '';
                document.getElementById('mem_id').focus();
                return;
            }
        
            // 중복 아이디 체크
                $.ajax({
                type: "POST",
                    url		:	"check_id.do",			 
                    data	:	{"mem_id" : mem_id},	// parameter -> check_id.do?mem_id=one
                    dataType:	"json",					    // 결과값의 Data Type
                    success	:	function(res_data){
                    //	res_data = { "result" : true } or { "result" : false }
                        if(res_data.result){
                            //	사용 가능한 아이디
                            alert("사용 가능한 아이디입니다.");
        
                        }else{
                            //	이미 사용중인 아이디
                            alert("이미 존재하는 아이디입니다.");
                            document.getElementById('mem_id').value = '';
                            document.getElementById('mem_id').focus();
                            return;
                        }  
                    },
                    error	:	function(err){
                        alert(err.responseText);
                        
                    }
                    
                });
            // 성공적으로 확인된 경우:
            isIdChecked = true;
            enableNextStep();
        };
        
        // '다음 단계' 버튼 활성화를 결정하는 함수
        function enableNextStep() {
            if(isIdChecked) {
                $("#btn_register").prop("disabled", false);
            }
        }
        
    });
    
</script>
<script>

    function manager_insert(f){

        let mem_id              = f.mem_id.value.trim();
        let mem_pwd             = f.mem_pwd.value.trim();
        let mem_pwd_correct     = f.mem_pwd_correct.value.trim();
        let mem_name            = f.mem_name.value.trim();
        let mem_email_first     = f.mem_email_first.value.trim();
        let mem_email_domain    = f.mem_email_domain.value.trim();
        let mem_tel             = f.mem_tel.value.trim();
        let not_man_yn          = f.not_man_yn.value;
        let mem_man_yn          = f.mem_man_yn.value;
        let rep_man_yn          = f.rep_man_yn.value;
        let qna_man_yn          = f.qna_man_yn.value;
        let mem_grade           = f.mem_grade.value;


        if(mem_pwd == ''){
            alert('비밀번호를 입력하세요.');
            f.mem_pwd.value='';
            f.mem_pwd.focus();
            return;
        }

        if(mem_pwd != mem_pwd_correct){
            alert('비밀번호가 틀렸습니다.');
            f.mem_pwd_correct.value='';
            f.mem_pwd_correct.focus();
            return;
        }

        if(mem_name == ''){
            alert('이름을 입력하세요.');
            f.mem_name.value='';
            f.mem_name.focus();
            return;
        }

        if(mem_tel == ''){
            alert('연락처를 입력하세요.');
            f.mem_tel.value='';
            f.mem_tel.focus();
            return;
        }

        // 연락처 정규식(숫자만)
        let regular_tel = /^[0-9]*$/;
        if(regular_tel.test(mem_tel)==false){
            alert('연락처는 숫자만 입력하세요.');
            return;
        } 

        if(mem_email_first == ''){
            alert('이메일을 입력하세요.');
            f.mem_email.value='';
            f.mem_email.focus();
            return;
        }

        if(mem_email_domain == ''){
            alert('이메일을 입력하세요.');
            f.mem_email.value='';
            f.mem_email.focus();
            return;
        }

        f.method="post"
        f.action='join_insert_manager.do';
        f.submit();
        
    }

</script>
<script>
    // email domain input에 넣기
    document.getElementById("mem_email_select").addEventListener("change", function() {
        var emailDomain = this.value; // 선택된 도메인 가져오기
        var emailInput = document.getElementById("mem_email_domain");
    
        if (emailDomain === "") {
            // '직접입력' 옵션 선택 시, input을 비워 사용자가 직접 입력할 수 있도록 함
            emailInput.value = "";
            emailInput.focus(); // 사용자가 바로 입력할 수 있도록 input에 포커스
        } else {
            // 선택된 도메인을 input 필드에 설정
            emailInput.value = emailDomain;
        }
    });
</script>
</head>
<body>
<!-- 계정 생성 모달 -->
<div id="NewManagerModal" class="modal fade" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content ">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <p class="modal-title"><a onclick="">관리자 계정 부여</a></p>
            </div>
            <div class="modal-body ">
                <form>
                    <table class="table table_list">
                        <tr>
                            <th class="table_list_th">아이디</th>
                            <td class="table_list_td">
                                <div class="form-wrap">
                                    <div class="contents-form-group">
                                        <div class="inputset inputset-round">
                                            <input type="text" class="inputset-input form-control" id="mem_id" name="mem_id" value="">
                                        </div>
                                        <input type="button" class="btnset btnset-round idcheckbtn" onclick="check_id();" type="buton" value="중복확인">
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th class="table_list_th">비밀번호</th>
                            <td class="table_list_td">
                                <div class="inputset inputset-round">
                                    <input class="inputset-input form-control" type="password" id="mem_pwd" name="mem_pwd" value="">
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th class="table_list_th">비밀번호확인</th>
                            <td class="table_list_td">
                                <div class="inputset inputset-round">
                                    <input type="password" class="inputset-input form-control" id="mem_pwd_correct" name="mem_pwd_correct" value="">
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th class="table_list_th">이름</th>
                            <td class="table_list_td">
                                <div class="inputset inputset-round">
                                    <input type="text" class="inputset-input form-control" id="mem_name" name="mem_name" value="">
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th class="table_list_th">이메일</th>
                            <td class="table_list_td">
                                <div class="inputset inputset-round">
                                    <div class="contents-mail">
                                        <input type="text" class="inputset-input form-control" id="mem_email_first" name="mem_email_first" value="">
                                        <span class="joininput_email joininput_email_height">@</span>
                                        <input type="text" class="inputset-input form-control" id="mem_email_domain" name="mem_email_domain" value="">
                                    </div>
                                </div>

                                <select class="select" class="selectset selectset-round selectset-md" id="mem_email_select" name="mem_email_select">
                                    <option value="y" selected>직접입력</option>
                                    <option value="naver.com">naver.com</option>
                                    <option value="daum.net">daum.net</option>
                                    <option value="hanmail.net">hanmail.net</option>
                                    <option value="kakao.com">kakao.com</option>
                                    <option value="gmail.com">gmail.com</option>
                                </select>

                            </td>
                        </tr>
                        <tr>
                            <th class="table_list_th">전화번호</th>
                            <td class="table_list_td">
                                <div class="inputset inputset-round">
                                    <input type="text" class="inputset-input form-control" id="mem_tel" name="mem_tel" value="">
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th class="table_list_th">공지사항/FAQ권한</th>
                            <td class="table_list_td">
                                <select class="select" id="not_man_yn" name="not_man_yn">
                                    <option value="y" selected>y</option>
                                    <option value="n">n</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <th class="table_list_th">회원관리권한</th>
                            <td class="table_list_td">
                                <select class="select" id="mem_man_yn" name="mem_man_yn">
                                    <option value="y" selected>y</option>
                                    <option value="n">n</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <th class="table_list_th">신고권한</th>
                            <td class="table_list_td">
                                <select class="select" id="rep_man_yn" name="rep_man_yn">
                                    <option value="y" selected>y</option>
                                    <option value="n">n</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <th class="table_list_th">온라인문의권한</th>
                            <td class="table_list_td">
                                <select class="select" id="qna_man_yn" name="qna_man_yn">
                                    <option value="y" selected>y</option>
                                    <option value="n">n</option>
                                </select>
                            </td>
                        </tr>

                        <tr>
                            <input type="hidden" id="mem_grade" name="mem_grade" value="manager">
                            <td colspan="2" class="btn_modify_td"><input class="btnset btnset-round" type="button" id="btn_register" onclick="manager_insert(this.form);" value="생성"></td>
                        </tr>
                    </table>
                </form>


            </div>
        </div>
    </div>
</div>



</body>
</html>