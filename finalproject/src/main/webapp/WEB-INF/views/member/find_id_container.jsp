<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script>
  $(document).ready(function () {
    $("#mail_code").css("display","none");
    $(".id_show").css("display","none");
  });
</script>
<script>
  var code = "";
  var mem_id ="";
  var email = "";
  window.check_email = function() {
    $("#btn_email_check").attr("disabled",true);
    let mem_email = $("#mem_email").val();


    if(mem_email == ''){
      alert('이메일을 입력하세요.');
      $("#mem_email").val(null);
      $("#btn_email_check").attr("disabled",false);
      return;
    }

    let emailParts = mem_email.split("@");

    var mem_email_first = "";
    var mem_email_domain = "";
    if(emailParts.length == 2) {
      mem_email_first = emailParts[0];
      mem_email_domain = emailParts[1];

    }

    // AJAX 호출 및 성공 처리 로직...
    //	중복 아이디 체크
    $.ajax({
      type: "POST",
      url		:	"check_email.do",			 
      data	:	{"mem_email_first" : mem_email_first, "mem_email_domain" : mem_email_domain},	
      dataType:	"json",					    // 결과값의 Data Type
      success	:	function(res_data){
      //	res_data = { "result" : true } or { "result" : false }
        if(!res_data.result){
          //	사용 가능한 아이디
          alert("메일에 발송된 인증코드를 입력해주세요.");
          //  성공적으로 확인된 경우:
          $("#mail_code").css("display","");
          $("#btn_email_check").attr("disabled",false);
          
        }

        if(res_data.email ==false){
          alert("이메일 발송에 실패했습니다.\r이메일주소를 확인해주세요");
        }

        if(res_data.code != null){
          code = res_data.code;
        }
        
      },
      error	:	function(err){
        alert(err.responseText);

        $("#btn_email_check").attr("disabled",false);
        
      }
      
    });

  }
</script>
<script>
  function search_id(f){
    var mem_name = f.mem_name.value.trim();
    mem_email = f.mem_email.value.trim();
    var email_code = f.email_code.value.trim();

    if(mem_name == ''){
      alert('이름을 입력하세요.');
      f.mem_name.value='';
      f.mem_name.focus();
      return;
	  }

    if(code != email_code){
    alert("인증코드가 맞지않습니다");
    $("#mem_email").attr("readonly",false);
    f.email_code.value = '';
    f.email_code.focus();
    return;
  }
  
  $.ajax({
    type: "post",
    url: "search_id.do",
    data: {mem_name:mem_name,mem_email:mem_email},
    dataType: "json",
    success: function (res_data) {
      if(res_data.result){
        
        $("#user_id").html(res_data.id);
        $("#regdate").html(res_data.regdate.substring(0,10));
        $(".id_show").css("display","");
        $(".contents-form").css("display","none");
        
        
      }else{
        alert("가입된 정보가 없습니다");
      }
    },
    error: function (jqXHR, textStatus, errorThrown) {
      console.table(jqXHR)
    }

    
  });
}
</script>
<script>
  function change_pwd(){
    $("#btn_pwd").attr("disabled",true);
    mem_id = $("#user_id").html();
    console.log(mem_id);
    console.log(mem_email);
    
    $.ajax({
      url: "change_pwd.do",
      data: {"mem_id":mem_id, "mem_email":mem_email},
      dataType: "json",
      success: function (res_data) {
        if(res_data.result){
          alert("임시 비밀번호를 발송했습니다.\r로그인해주세요\r반드시 비밀번호를 변경해주세요.");

        }else{
          alert("비밀번호 초기화가 되지않았습니다.\r관리자에게 문의바랍니다.[ error : "+res_data.error+"]");
        }
      },
      error: function (jqXHR, textStatus, errorThrown) {
        console.table(jqXHR)
      }
    });

  }
</script>
</head>
<body>
    <!-- [E]glamping-N2 -->
    <main class="th-layout-main ">
    <!-- [S]glamping-N44 -->
    <div class="glamping-N44" data-bid="gtlTWpIoop">
      <div class="contents-inner">
        <div class="contents-container">
          <div class="textset">
            <h2 class="textset-tit">아이디찾기</h2>

            <div class="login_wrap">
              <div id="id">
                <form >
                  <div class="contents-form">
                    <div class="inputset inputset-round  input_name">
                      <div>이름</div>
                      <input type="text" name="mem_name" class="inputset-input form-control" aria-label="내용" placeholder="동록된 이름을 입력해주세요." required="" value="">
                    </div>
                    <div class="inputset inputset-round input_email">
                      <div>이메일</div>
                      <input type="text" name="mem_email" id="mem_email" class="inputset-input form-control" aria-label="내용" placeholder="등록된 이메일을 입력해주세요." required="">
                      <input class="btnset btnset-round btn_email btnset-line" id="btn_email_check" type="button" onclick="check_email();" value="이메일인증" >
                    </div>
                    <div class="inputset inputset-round  input_name" id="mail_code">
                      <div>코드</div>
                      <input type="text" name="email_code" class="inputset-input form-control" aria-label="내용" placeholder="발송된 코드를 입력해주세요." required="" value="">
                    </div>
                    <div class="contents-btnset">
                      <input class="btnset btnset-round " type="button" onclick="search_id(this.form);" value="아이디 찾기">
                    </div>
                  </div>
                </form>
                
                <div class="id_show">
                  <div>등록된 아이디</div>
                  <div id="user"><div id="user_id"></div>&nbsp;( 가입일자 : &nbsp;<div id="regdate"></div>&nbsp;)</div>
                  <div>입니다.</div>
                  <input id="btn_pwd" class="btnset btnset-round " type="button" onclick="change_pwd();" value="비밀번호 초기화">
                </div>

              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <!-- [E]glamping-N44 -->
  </main>
</body>

</html>