<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>캠프로버</title>
<script>
var code;

$(document).ready(function () {

  $("#mail_code").css("display","none");
  // 시/도 선택 이벤트 핸들러 등록
  $('#citySelect1 .selectset-prefer').on('click', function () {
    // 선택된 시/도의 data-value 값을 가져옵니다.
    var selectedCity = $(this).data('value');
    updateDistricts1(selectedCity); // 군/구 목록 업데이트 함수 호출

    // 시/도 input type="hidden"에 넣기
    let pre_si1 = selectedCity;
    $("#pre_si1").val(pre_si1);
    this.closest(".selectset").classList.remove("active");
  });

  $('#citySelect2 .selectset-prefer').on('click', function () {
    // 선택된 시/도의 data-value 값을 가져옵니다.
    var selectedCity = $(this).data('value');
    updateDistricts2(selectedCity); // 군/구 목록 업데이트 함수 호출

    // 시/도 input type="hidden"에 넣기
    let pre_si2 = selectedCity;
    $("#pre_si2").val(pre_si2);
    this.closest(".selectset").classList.remove("active");
  });

  $('#citySelect3 .selectset-prefer').on('click', function () {
    // 선택된 시/도의 data-value 값을 가져옵니다.
    var selectedCity = $(this).data('value');
    updateDistricts3(selectedCity); // 군/구 목록 업데이트 함수 호출

    // 시/도 input type="hidden"에 넣기
    let pre_si3 = selectedCity;
    $("#pre_si3").val(pre_si3);
    this.closest(".selectset").classList.remove("active");
  });

  function updateDistricts1(city) {

    var districtOptionsHtml = '';
    $('#diSelect1').html('군/구');
    $("#pre_gun1").val(null);

    $.ajax({
      url: "listsi_json.do",
      data:{"doNm":city},
      dataType:"json",
      success: function (res_data) {
        
        res_data.forEach(function (item) {
          
          districtOptionsHtml += '<li class="selectset-item"><button class="selectset-prefer btn" type="button" data-value="' + item.sigunguNm + '"><span>' + item.sigunguNm + '</span></button></li>';
        });

        // 군/구 목록을 해당 selectset-list에 설정합니다.
        $('#districtSelect1').html(districtOptionsHtml);

        // 군/구 목록 선택 이벤트 핸들러 - 이벤트 위임 사용
        $(document).on("click", "#districtSelect1 .selectset-prefer", function () {

        // 선택된 군/구의 data-value 값을 가져옵니다.
        var selectedGu = $(this).data('value');
        $('#diSelect1').html(selectedGu);

        // 군/구 input type="hidden"에 넣기
        let pre_gun1 = selectedGu;
        $("#pre_gun1").val(pre_gun1);

        });
        
      },  
      error: function (jqXHR, textStatus, errorThrown) {
          console.table(jqXHR)
      }
    });
   
  }

});

  function updateDistricts2(city) {

    var districtOptionsHtml = '';
    $('#diSelect2').html('군/구');
    $("#pre_gun2").val(null);

    $.ajax({
      url: "listsi_json.do",
      data:{"doNm":city},
      dataType:"json",
      success: function (res_data) {
        
        res_data.forEach(function (item) {
          
          districtOptionsHtml += '<li class="selectset-item"><button class="selectset-prefer btn" type="button" data-value="' + item.sigunguNm + '"><span>' + item.sigunguNm + '</span></button></li>';
        });

        // 군/구 목록을 해당 selectset-list에 설정합니다.
        $('#districtSelect2').html(districtOptionsHtml);

        // 군/구 목록 선택 이벤트 핸들러 - 이벤트 위임 사용
        $(document).on("click", "#districtSelect2 .selectset-prefer", function () {

        // 선택된 군/구의 data-value 값을 가져옵니다.
        var selectedGu = $(this).data('value');
        $('#diSelect2').html(selectedGu);

        // 군/구 input type="hidden"에 넣기
        let pre_gun2 = selectedGu;
        $("#pre_gun2").val(pre_gun2);

        });
        
      },  
      error: function (jqXHR, textStatus, errorThrown) {
          console.table(jqXHR)
      }
    });
   
  }


  function updateDistricts3(city) {

    var districtOptionsHtml = '';
    $('#diSelect3').html('군/구');
    $("#pre_gun3").val(null);

    $.ajax({
      url: "listsi_json.do",
      data:{"doNm":city},
      dataType:"json",
      success: function (res_data) {
        
        res_data.forEach(function (item) {
          
          districtOptionsHtml += '<li class="selectset-item"><button class="selectset-prefer btn" type="button" data-value="' + item.sigunguNm + '"><span>' + item.sigunguNm + '</span></button></li>';
        });

        // 군/구 목록을 해당 selectset-list에 설정합니다.
        $('#districtSelect3').html(districtOptionsHtml);

        // 군/구 목록 선택 이벤트 핸들러 - 이벤트 위임 사용
        $(document).on("click", "#districtSelect3 .selectset-prefer", function () {

        // 선택된 군/구의 data-value 값을 가져옵니다.
        var selectedGu = $(this).data('value');
        $('#diSelect3').html(selectedGu);

        // 군/구 input type="hidden"에 넣기
        let pre_gun3 = selectedGu;
        $("#pre_gun3").val(pre_gun3);

        });
        
      },  
      error: function (jqXHR, textStatus, errorThrown) {
          console.table(jqXHR)
      }
    });
   
  }

</script>
<script>

$(document).ready(function() {

  // 초기 상태에서 '다음 단계' 버튼을 비활성화
  $("#btn_register").prop("disabled", true);
  
  var isIdChecked = false;
  var isPwdChecked = false;
  var isEmailChecked = false;

  // 사업자번호나 아이디 입력 필드가 변경될 때의 이벤트 핸들러
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


  // 아이디 중복 확인 함수
  window.check_id = function() {
      
    let mem_id = $("#mem_id").val();

    if(mem_id == ''){
      alert('아이디를 입력하세요');
      $("#mem_id").val(null);
      $("#mem_id").focus();
      return;
    }

    // 아이디 정규식 (3자 이상의 영문과 숫자)
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
      $("#btn_email_check").attr("disabled",false);
      return;
    }

    if(mem_email_domain == ''){
      alert('이메일을 입력하세요.');
      $("#mem_email_domain").val(null);
      $("#btn_email_check").attr("disabled",false);
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
          $("#btn_email_check").attr("disabled",false);
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
    if(isIdChecked && isEmailChecked && isPwdChecked) {
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

function member_insert(f){

  let mem_id = f.mem_id.value.trim();
  let mem_pwd = f.mem_pwd.value.trim();
  let mem_pwd_correct = f.mem_pwd_correct.value.trim();
  let mem_name = f.mem_name.value.trim();
  let mem_tel = f.mem_tel.value.trim();
  let mem_email_first = f.mem_email_first.value.trim();
  let mem_email_domain = f.mem_email_domain.value.trim();
  let pre_si1 = f.pre_si1.value.trim();
  let pre_si2 = f.pre_si2.value.trim();
  let pre_si3 = f.pre_si3.value.trim();
  let pre_gun1 = f.pre_gun1.value.trim();
  let pre_gun2 = f.pre_gun2.value.trim();
  let pre_gun3 = f.pre_gun3.value.trim();


  let mem_kakao   = f.mem_kakao.value;
  let mem_naver   = f.mem_naver.value;
  let mem_google  = f.mem_google.value;
  let agree1_yn   = f.agree1_yn.value;
  let agree2_yn   = f.agree2_yn.value;
  let agree3_yn   = f.agree3_yn.value;
  let mem_grade   = f.mem_grade.value;
  let url         = f.url.value;

  let email_code = f.email_code.value;


  if(mem_pwd == ''){
    alert('비밀번호를 입력하세요.');
    f.mem_pwd.value='';
    f.mem_pwd.focus();
    return;
	}


  if(regular_pwd.test(mem_pwd)==false){
    alert('비밀번호는 최소 8자에서 16자까지, 영문자, 숫자 및 특수 문자를 포함해야 합니다.');
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
    f.mem_email_domain.value='';
    f.mem_email_domain.focus();
    return;
	}

  if(code != email_code){
    alert("인증코드가 맞지않습니다");
    f.email_code.value = '';
    f.email_code.focus();
    return;
  }

  if(pre_si1 != "" && pre_gun1 == ""){
    alert("시/도와 군/구를 모두 입력해주세요");
    f.pre_si1.value='';
    return;
  }

  if(pre_si2 != "" && pre_gun2 == ""){
    alert("시/도와 군/구를 모두 입력해주세요");
    f.pre_si2.value='';
    return;
  }

  if(pre_si3 != "" && pre_gun3 == ""){
    alert("시/도와 군/구를 모두 입력해주세요");
    f.pre_si3.value='';
    return;
  }


  f.method="post"
  f.action='join_insert_general.do';
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
                <h6 class="form-tit">아이디 <span>*</span>
                </h6>
                <div class="contents-form-group">
                  <div class="inputset inputset-round">
                    <input type="text" id="mem_id" name="mem_id" class="inputset-input form-control" aria-label="아이디" required="" placeholder="3자 이상의 영문자, 숫자 조합으로 입력해주세요">
                  </div>
                  <input class="idcheckbtn btnset btnset-round" onclick="check_id();" type="button" value="중복확인" >
                </div>
              </div>
              <div class="form-wrap">
                <h6 class="form-tit">비밀번호 <span>*</span>
                </h6>
                <div class="inputset inputset-round">
                  <input type="password" id="mem_pwd" name="mem_pwd" class="inputset-input form-control" aria-label="비밀번호" required="" placeholder="8~16자,영문자,숫자 및 특수문자를 포함하여 입력해주세요">
                </div>
              </div>
              <div class="form-wrap">
                <h6 class="form-tit">비밀번호 확인 <span>*</span>
                </h6>
                <div class="inputset inputset-round">
                  <input type="password" id="mem_pwd_correct" name="mem_pwd_correct" class="inputset-input form-control" aria-label="비밀번호확인" required="">
                  <span id="pwd_match_msg"></span>
                </div>
              </div>
              <div class="form-wrap">
                <h6 class="form-tit">이름 <span>*</span>
                </h6>
                <div class="inputset inputset-round">
                  <input type="text" id="mem_name" name="mem_name"  value="${vo.mem_name}" class="inputset-input form-control" aria-label="이름" required="">
                </div>
              </div>
              <div class="form-wrap">
                <h6 class="form-tit">연락처 <span>*</span>
                </h6>
                <div class="inputset inputset-round">
                  <input type="text" id="mem_tel" name="mem_tel" class="inputset-input form-control" aria-label="전번" placeholder="-없이 번호를 입력해주세요" required="" value="${vo.mem_tel}">
                </div>
              </div>
              <div class="form-wrap">
                <h6 class="form-tit">이메일 <span>*</span>  
                </h6>
                <div class="contents-form-group">
                  <div class="inputset inputset-round">
                    <div class="contents-mail">
                      <input type="text" id="mem_email_first" name="mem_email_first" value="${mem_email_first}" class="inputset-input form-control" aria-label="이메일앞" required="">
                      <span class="joininput_email">@</span>
                      <input type="text" id="mem_email_domain" name="mem_email_domain" value="${mem_email_domain}" class="email_domain inputset-input form-control" aria-label="이메일뒤" required="">
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
                  <input class="btnset btnset-round idcheckbtn" id="btn_email_check" onclick="check_email();" type="button" value="중복확인">
                </div>
              </div>
              <div class="form-wrap" id="mail_code">
                <h6 class="form-tit">이메일 인증코드<span>*</span></h6>
                <div class="inputset inputset-round">
                  <input type="text" name="email_code" class="inputset-input form-control" required="">
                </div>

              </div>


                  <div class="form-wrap">
                    <h6 class="form-tit">선호지역&nbsp;1</h6>
                    <div class="contents-prefer">
                      <div class="contents-form-group">
                        <div class="selectset selectset-round selectset-md">
                          <button class="selectset-toggle btn" type="button">
                            <span>시/도</span>
                          </button>
                          <ul class="selectset-list" id="citySelect1">
                            <ul class="ul_list">
                              <c:forEach var="vo" items="${listdo}">
                                <li class="selectset-item">
                                  <button class="selectset-prefer btn" type="button" data-value="${vo.doNm}">
                                    <span>${vo.doNm}</span>
                                  </button>
                                </li>
                              </c:forEach>
                            </ul>
                          </ul>
                          <input type="hidden" id="pre_si1" name="pre_si1" value="">
                        </div>
                        <div class="selectset selectset-round selectset-md">
                          <button class="selectset-toggle btn" type="button">
                            <span id="diSelect1">군/구</span>
                          </button>
                          <ul class="selectset-list">
                            <ul class="ul_list" id="districtSelect1"></ul>
                          </ul>
                          <input type="hidden" id="pre_gun1" name="pre_gun1" value="">
                        </div>
                      </div>
                    </div>
                  </div>


                  <div class="form-wrap">
                    <h6 class="form-tit">선호지역&nbsp;2</h6>
                    <div class="contents-prefer">
                      <div class="contents-form-group">
                        <div class="selectset selectset-round selectset-md">
                          <button class="selectset-toggle btn" type="button">
                            <span>시/도</span>
                          </button>
                          <ul class="selectset-list" id="citySelect2">
                            <ul class="ul_list">
                              <c:forEach var="vo" items="${listdo}">
                                <li class="selectset-item">
                                  <button class="selectset-prefer btn" type="button" data-value="${vo.doNm}">
                                    <span>${vo.doNm}</span>
                                  </button>
                                </li>
                              </c:forEach>
                            </ul>
                          </ul>
                          <input type="hidden" id="pre_si2" name="pre_si2" value="">
                        </div>
                        <div class="selectset selectset-round selectset-md">
                          <button class="selectset-toggle btn" type="button">
                            <span id="diSelect2">군/구</span>
                          </button>
                          <ul class="selectset-list">
                            <ul class="ul_list" id="districtSelect2"></ul>
                          </ul>
                          <input type="hidden" id="pre_gun2" name="pre_gun2" value="">
                        </div>
                      </div>
                    </div>
                  </div>


                  <div class="form-wrap">
                    <h6 class="form-tit">선호지역&nbsp;3</h6>
                    <div class="contents-prefer">
                      <div class="contents-form-group">
                        <div class="selectset selectset-round selectset-md">
                          <button class="selectset-toggle btn" type="button">
                            <span>시/도</span>
                          </button>
                          <ul class="selectset-list" id="citySelect3">
                            <ul class="ul_list">
                              <c:forEach var="vo" items="${listdo}">
                                <li class="selectset-item">
                                  <button class="selectset-prefer btn" type="button" data-value="${vo.doNm}">
                                    <span>${vo.doNm}</span>
                                  </button>
                                </li>
                              </c:forEach>
                            </ul>
                          </ul>
                          <input type="hidden" id="pre_si3" name="pre_si3" value="">
                        </div>
                        <div class="selectset selectset-round selectset-md">
                          <button class="selectset-toggle btn" type="button">
                            <span id="diSelect3">군/구</span>
                          </button>
                          <ul class="selectset-list">
                            <ul class="ul_list" id="districtSelect3"></ul>
                          </ul>
                          <input type="hidden" id="pre_gun3" name="pre_gun3" value="">
                        </div>
                      </div>
                    </div>
                  </div>


                </div>


            <div class="contents-btn-group">
              <input class="btnset btnset-line btnset-round" type="button" onclick="location.href='join_agree.do?mem_grade=general&url=${param.url}'" value="이전단계">
              <input class="btnset btnset-round" id="btn_register" type="button" onclick="member_insert(this.form);" value="다음단계">
            </div>
          </div>
        </div>
      </div>
    <!-- [E]glamping-N47 -->
  </main>
</body>
</html>