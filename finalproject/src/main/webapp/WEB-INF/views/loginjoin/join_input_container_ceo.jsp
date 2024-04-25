<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>캠프로버</title>

<script>
  var code;
  
</script>
<script>
$(document).ready(function() {

  // 초기 상태에서 '다음 단계' 버튼을 비활성화
  $("#btn_register").prop("disabled", true);

  $("#mail_code").css("display","none");
  
  // 확인 절차 완료 플래그
  var isBizrnoChecked = false;
  var isIdChecked = false;
  var isEmailChecked = false;
  var isPwdChecked = false;

  // 사업자번호나 아이디 입력 필드가 변경될 때의 이벤트 핸들러
  $('#bizrno').on('input', function() {
    // 입력 필드가 변경되면 관련 플래그를 초기화하고, '다음 단계' 버튼을 비활성화
    isBizrnoChecked = false;
    $("#btn_register").prop("disabled", true);
  });
  $('#mem_id').on('input', function() {
    // 입력 필드가 변경되면 관련 플래그를 초기화하고, '다음 단계' 버튼을 비활성화
    isIdChecked = false;
    $("#btn_register").prop("disabled", true);
  });
  $('#mem_email_first').on('input', function() {
    // 입력 필드가 변경되면 관련 플래그를 초기화하고, '다음 단계' 버튼을 비활성화
    isEmailChecked = false;
    $("#btn_register").prop("disabled", true);
  });
  $('#mem_email_domain').on('input', function() {
    // 입력 필드가 변경되면 관련 플래그를 초기화하고, '다음 단계' 버튼을 비활성화
    isEmailChecked = false;
    $("#btn_register").prop("disabled", true);
  });


  // 비밀번호 확인 필드에서 keyup 이벤트 발생 시 실행되는 함수
  $("#mem_pwd_correct").keyup(function() {

    // 입력된 비밀번호와 비밀번호 확인 값 가져오기
    let mem_pwd = $("#mem_pwd").val();
    let mem_pwd_correct = $("#mem_pwd_correct").val();

    // 비밀번호와 비밀번호 확인이 일치하는지 확인
    if (mem_pwd == mem_pwd_correct) {
        $("#pwd_match_msg").text("비밀번호가 일치합니다.").css("color", "blue");
        isPwdChecked = true;
        enableNextStep();
    } else {
        $("#pwd_match_msg").text("비밀번호가 일치하지 않습니다.").css("color", "red");
        // 회원가입 버튼 비활성화
        isPwdChecked = false;
        $("#btn_register").prop("disabled", true);
    }

  });

  // 사업자번호 확인 함수
  window.check_bizrno = function() {
    let b_no      = $("#bizrno").val();

    if(b_no == ""){
      alert("사업자등록번호를 입력해주세요");
      $("#bizrno").val(null);
      $("#bizrno").focus();
      return;
    }

    var data = {
      "b_no":[b_no]
    };

    // AJAX 호출 및 성공 처리 로직...
    $.ajax({
      url: "https://api.odcloud.kr/api/nts-businessman/v1/status?serviceKey=",  // serviceKey 값을 xxxxxx에 입력
      type: "POST",
      data: JSON.stringify(data), // json 을 string으로 변환하여 전송
      dataType: "JSON",
      contentType: "application/json",
      accept: "application/json",
      success: function(result) {
        var b_stt = result.data[0].b_stt;
        var tax_type = result.data[0].tax_type;
        if( b_stt != "" ){ 
          $.ajax({
            url: "check_db_bizrno.do",
            data: {"b_no" : b_no},
            success: function (res_data) {
              if(res_data.bizrno == res_data.bizrno1 && res_data.bizrno == res_data.bizrno2){
                alert("이미 가입된 캠핑장입니다");
                $("#bizrno").val(null);
                $("#bizrno").focus();
                return;
              }else if(res_data.bizrno == res_data.bizrno1 && res_data.bizrno != res_data.bizrno2){
                alert("캠핑장 사업자입니다");
                // 성공적으로 확인된 경우:
                isBizrnoChecked = true;
                enableNextStep();
              }else if(res_data.bizrno != res_data.bizrno1){
                alert("회원가입 후 캠핑장 신청을 완료해주세요");
                isBizrnoChecked = true;
                enableNextStep();
                return;
              }else{
                alert("캠핑장 사업자가 아닙니다");
                $("#bizrno").val(null);
                $("#bizrno").focus();
                return;
              }
              
              
            },  
            error: function (jqXHR, textStatus, errorThrown) {
              console.table(jqXHR)
            }
          });
        }
        else{ 
          alert(tax_type); 
          return;
        }

      },
      error: function(result) {
        alert(err.responseText);
      }
    });


  };

  // 아이디 중복 확인 함수
  window.check_id = function() {

    let mem_id = $("#mem_id").val();

    if(mem_id == ''){
      alert('아이디를 입력하세요');
      $("#mem_id").val(null);
      $("#mem_id").focus();
      return;
    }

    // 아이디 정규식 (영문과 숫자)
    let regular_id = /^[a-zA-Z0-9]{3,}$/;

    if(regular_id.test(mem_id)==false){
        alert('아이디는 3자 이상의 영문자, 숫자 조합으로 입력해주세요.');
        $("#mem_id").val(null);
        $("#mem_id").focus();
        return;
    }


    // AJAX 호출 및 성공 처리 로직...
    //	중복 아이디 체크
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
          // 성공적으로 확인된 경우:
          isIdChecked = true;
          enableNextStep();

        }else{
          //	이미 사용중인 아이디
          alert("이미 존재하는 아이디입니다.");
          $("#mem_id").val(null);
          $("#mem_id").focus();
          return;
        }
        
      },
      error	:	function(err){
        alert(err.responseText);
        
      }
      
    });
    
  };

  // 이메일 중복 확인 함수
  window.check_email = function() {
    $("#btn_email_check").attr("disabled",true);
    let mem_email_first = $("#mem_email_first").val();
    let mem_email_domain = $("#mem_email_domain").val();


    if(mem_email_first == ''){
      alert('이메일을 입력하세요.');
      $("#mem_email_first").val(null);
      $("#mem_email_first").focus();
      return;
    }

    if(mem_email_domain == ''){
      alert('이메일을 입력하세요.');
      $("#mem_email_domain").val(null);
      return;
    }

    // AJAX 호출 및 성공 처리 로직...
    //	중복 아이디 체크
    $.ajax({
      type: "POST",
      url		:	"check_email.do",			 
      data	:	{"mem_email_first" : mem_email_first, "mem_email_domain" : mem_email_domain},	// parameter -> check_id.do?mem_id=one
      dataType:	"json",					    // 결과값의 Data Type
      success	:	function(res_data){
      //	res_data = { "result" : true } or { "result" : false }
        if(res_data.result){
          //	사용 가능한 아이디
          alert("사용 가능한 이메일입니다.\r메일에 발송된 인증코드를 입력해주세요.");
          //  성공적으로 확인된 경우:
          isEmailChecked = true;
          $("#mail_code").css("display","");
          $("#btn_email_check").attr("disabled",false);
          enableNextStep();

        }else{
          //	이미 사용중인 아이디
          alert("이미 존재하는 이메일입니다.");
          $("#mem_email_first").val(null);
          $("#mem_email_domain").val(null);
          $("#mem_email_first").focus();
          return;
        }

        if(res_data.code != null){
          code = res_data.code;
        }
        
      },
      error	:	function(err){
        alert(err.responseText);

        $(".idcheckbtn").attr("disabled",false);
        
      }
      
    });

  }


  // '다음 단계' 버튼 활성화를 결정하는 함수
  function enableNextStep() {
    if(isBizrnoChecked && isIdChecked && isEmailChecked) {
      $("#btn_register").prop("disabled", false);
    }
  }
});
</script>
<script>
// 비밀번호 정규식(최소 8자에서 16자까지, 영문자, 숫자 및 특수 문자를 포함)
let regular_pwd =/^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*?_]).{8,16}$/;
// 연락처 정규식(숫자만)
let regular_tel = /^[0-9]*$/;

function member_insert_ceo(f){

  let bizrno = f.bizrno.value.trim();
  let mem_id = f.mem_id.value.trim();
  let mem_pwd = f.mem_pwd.value.trim();
  let mem_pwd_correct = f.mem_pwd_correct.value.trim();
  let mem_name = f.mem_name.value.trim();
  let mem_tel = f.mem_tel.value.trim();
  let mem_email_first = f.mem_email_first.value.trim();
  let mem_email_domain = f.mem_email_domain.value.trim();

  let agree1_yn = f.agree1_yn.value;
  let agree2_yn = f.agree2_yn.value;
  let agree3_yn = f.agree3_yn.value;
  let mem_grade = f.mem_grade.value;

  let email_code = f.email_code.value;

  if(bizrno == ''){
    alert('사업자등록번호를 입력하세요');
    f.bizrno.value='';
    f.bizrno.focus();
    return;
  }

  if(regular_pwd.test(mem_pwd)==false){
    alert('비밀번호는 최소 8자에서 16자까지, 영문자, 숫자 및 특수 문자를 포함해야 합니다.');
    return;
	} 

  if(mem_pwd == ''){
    alert('비밀번호를 입력하세요');
    f.mem_pwd.value='';
    f.mem_pwd.focus();
    return;
  }

  if(mem_name == ''){
    alert('이름을 입력하세요.');
    f.mem_name.value='';
    f.mem_name.focus();
    return;
  }

  if(regular_tel.test(mem_tel)==false){
		  alert('연락처는 숫자만 입력하세요.');
		  return;
	} 

  if(mem_tel == ''){
    alert('연락처를 입력하세요.');
    f.mem_tel.value='';
    f.mem_tel.focus();
    return;
  }


  f.method="post"
  f.action='join_insert_ceo.do';
  f.submit();
}
</script>
</head>
<body>
<!-- [E]glamping-N2 -->
<main class="th-layout-main ">
    <!-- [S]glamping-N45 -->
    <div class="glamping-N45" data-bid="iFltwPivdp">
      <div class="contents-inner">
        <div class="contents-container container-md">
          <div class="textset">
            <h2 class="textset-tit">개인정보</h2>
            <p class="textset-desc">가입에 필요한 정보들을 입력해주세요</p>
          </div>
          <ul class="contents-list">
            <li class="contents-item item-check">
              <span>1</span>
            </li>
            <li class="contents-item item-active">
              <span>2</span>
            </li>
            <li class="contents-item">
              <span>3</span>
            </li>
          </ul>
        </div>
      </div>
    </div>
    <!-- [E]glamping-N45 -->
    <!-- [S]glamping-N47 -->
      <div class="glamping-N47" data-bid="KAltwpIVGl">
        <div class="contents-inner">
          <div class="contents-container container-md">
            <div class="contents-top">
              <h2 class="contents-tit">정보입력</h2>
              <span>* 표시는 반드시 입력하셔야 하는 항목입니다</span>
            </div>
            <div class="contents-group">
              <div class="form-wrap">
                <h6 class="form-tit">사업자번호 <span>*</span>
                </h6>
                <div class="contents-form-group">
                  <div class="inputset inputset-round">
                    <input type="text" class="inputset-input form-control" name="bizrno" id="bizrno" aria-label="사업자등록번호" required="" placeholder="-없이 입력하세요">
                  </div>
                  <input class="btnset btnset-round bizrnocheckbtn" type="button" onclick="check_bizrno();" value="사업자번호확인">
                </div>
              </div>
              <div class="form-wrap">
                <h6 class="form-tit">아이디 <span>*</span>
                </h6>
                <div class="contents-form-group">
                  <div class="inputset inputset-round">
                    <input type="text" name="mem_id" id="mem_id" class="inputset-input form-control" aria-label="아이디" required="" placeholder="3자 이상의 영문자, 숫자 조합으로 입력해주세요">
                  </div>
                  <input class="btnset btnset-round idcheckbtn" onclick="check_id();" type="button" value="중복확인">
                </div>
              </div>
              <div class="form-wrap">
                <h6 class="form-tit">비밀번호 <span>*</span>
                </h6>
                <div class="inputset inputset-round">
                  <input type="password" name="mem_pwd" id="mem_pwd" class="inputset-input form-control" aria-label="비밀번호" required="" placeholder="8~16자,영문자,숫자 및 특수문자를 포함하여 입력해주세요">
                </div>
              </div>
              <div class="form-wrap">
                <h6 class="form-tit">비밀번호 확인 <span>*</span>
                </h6>
                <div class="inputset inputset-round">
                  <input type="password" name="mem_pwd_correct" id="mem_pwd_correct" class="inputset-input form-control" aria-label="비밀번호확인" required="">
                  <span id="pwd_match_msg"></span>
                </div>
              </div>
              <div class="form-wrap">
                <h6 class="form-tit">이름 <span>*</span>
                </h6>
                <div class="inputset inputset-round">
                  <input type="text" name="mem_name" id="mem_name" class="inputset-input form-control" aria-label="이름" required="">
                </div>
              </div>
              <div class="form-wrap">
                <h6 class="form-tit">이메일 <span>*</span>
                </h6>
                <div class="contents-form-group">
                  <div class="inputset inputset-round">
                    <div class="contents-mail">
                      <input type="text" name="mem_email_first" id="mem_email_first" class="inputset-input form-control" aria-label="이메일앞" required="">
                      <span class="joininput_email">@</span>
                      <input type="text" name="mem_email_domain" id="mem_email_domain" class="email_domain inputset-input form-control" aria-label="이메일뒤" required="">
                    </div>
                  </div>
                </div>
                <div class="selectset selectset-round selectset-md">
                  <button class="selectset-toggle btn" type="button">
                    <span>선택해주세요</span>
                  </button>
                  <ul class="selectset-list">
                    <li class="selectset-item">
                      <button class="selectset-link btn" type="button" data-value="직접입력" selected="">
                        <span>직접입력</span>
                      </button>
                    </li>
                    <li class="selectset-item">
                      <button class="selectset-link btn" type="button" value="naver.com">
                        <span>naver.com</span>
                      </button>
                    </li>
                    <li class="selectset-item">
                      <button class="selectset-link btn" type="button" value="daum.net">
                        <span>daum.net</span>
                      </button>
                    </li>
                    <li class="selectset-item">
                      <button class="selectset-link btn" type="button" value="hanmail.net">
                        <span>hanmail.net</span>
                      </button>
                    </li>
                    <li class="selectset-item">
                      <button class="selectset-link btn" type="button" value="kakao.com">
                        <span>kakao.com</span>
                      </button>
                    </li>
                    <li class="selectset-item">
                      <button class="selectset-link btn" type="button" value="gmail.com">
                        <span>gmail.com</span>
                      </button>
                    </li>
                  </ul>
                </div>
                <div>
                  <input class="btnset btnset-round idcheckbtn" onclick="check_email();" type="button" value="중복확인">
                </div>
              </div>
              <div class="form-wrap" id="mail_code">
                <h6 class="form-tit">이메일 인증코드<span>*</span></h6>
                <div class="inputset inputset-round">
                  <input type="text" name="email_code" class="inputset-input form-control" required="">
                </div>

              </div>
              <div class="form-wrap">
                <h6 class="form-tit">연락처 <span>*</span>
                </h6>
                <div class="inputset inputset-round">
                  <input type="text" name="mem_tel" id="mem_tel" class="inputset-input form-control" aria-label="전번" placeholder="-없이 번호를 입력해주세요" required="">
                </div>
              </div>

            <div class="contents-btn-group">
              <input class="btnset btnset-line btnset-round" type="button" onclick="location.href='join_agree.do?mem_grade=ceo&url=${param.url}'" value="이전단계">
              <input class="btnset btnset-round" id="btn_register" type="button" onclick="member_insert_ceo(this.form)" value="다음단계">
          </div>
        </div>
      </div>
    <!-- [E]glamping-N47 -->
  </main>
</body>
</html>