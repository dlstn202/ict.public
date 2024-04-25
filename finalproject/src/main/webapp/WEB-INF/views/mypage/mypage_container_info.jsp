<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <!DOCTYPE html>
    <html>

    <head>

        <meta charset="UTF-8">
        <title>Insert title here</title>
        <style>
            .glamping-N47 .contents-prefer .selectset.selectset-round .selectset-toggle { width:25rem; }
            .deletePhoto_label{ position: absolute; right: 36rem; }
            .deletePhoto{ display:none;  position: absolute; right: 36rem; }

        </style>
        <script>
          function sns(sns){

            if(sns == 'naver' && '${not empty user.mem_naver}' =='true'){
              if(confirm("naver 연동을 해제하시겠습니까?") == false) return;
            }
            if(sns == 'kakao' && '${not empty user.mem_kakao}' =='true'){
              if(confirm("kakao 연동을 해제하시겠습니까?") == false) return;
            }
            if(sns == 'google' && '${not empty user.mem_google}' =='true'){
              if(confirm("google 연동을 해제하시겠습니까?") == false) return;
            }

            $.ajax({
              type: "post",
              url: "sns.do",
              data: {"sns":sns},
              dataType: "json",
              success: function (res_data) {
                if(res_data.sns_del){
                  alert("연동해제가 완료되었습니다.");
                  location.href = location.href;
                }
                if(res_data.sns_del !=null &&!res_data.sns_del){
                  alert("연동해제가 실패됐습니다.\r관리자에게 문의하세요 사유 : "+res_data.error);
                  location.href = location.href;
                }
                if(res_data.url != null){
                  location.href =res_data.url;
                }
                
              },
              error: function (jqXHR, textStatus, errorThrown) {
                console.table(jqXHR)
              }
            });
          }
        </script>
        <script>
          var code;
          $(document).ready(function () {
            
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

          $(document).ready(function () {

            $("#mail_code").css("display","none");

            // 마케팅 동의여부
            let span_agree3_yn = $("#agree3_yn").val();
            $('.span_agree3_yn').html(span_agree3_yn);
            $("#agree3_yn").val(span_agree3_yn);

            $(".selectset-story").on("click", function() {
              let agree3Value = $(this).find("span").text(); // 클릭한 버튼의 텍스트 값을 가져옴
              $("#agree3_yn").val(agree3Value); // input 요소의 값 업데이트
              $('.span_agree3_yn').html(agree3Value); // span 요소의 내용도 업데이트
            });

            // 이메일 나눠서 넣기
            let mem_email = $("#mem_email").val();
            let emailParts = mem_email.split("@");

            let mem_email_first = "";
            let mem_email_domain = "";

            if(emailParts.length == 2) {
              mem_email_first = emailParts[0];
              mem_email_domain = emailParts[1];

              $("#mem_email_first").val(mem_email_first);
              $("#mem_email_domain").val(mem_email_domain);
            }

            // 선호지역 나눠서 넣기
            // 선호지역 1
            if($("#pre_si_0").val() != null && $("#pre_gun_0").val() != null){ 
              let pre_si1   = $("#pre_si_0").val();
              let pre_gun1  = $("#pre_gun_0").val();
              let pre_idx1  = $("#pre_idx_0").val();

              $('.span_pre_si1').html(pre_si1);
              $('.span_pre_gun1').html(pre_gun1);

              $("#pre_si1").val(pre_si1);
              $("#pre_gun1").val(pre_gun1);
              $("#pre_idx1").val(pre_idx1);
            }

            // 선호지역 2
            if($("#pre_si_1").val() != null && $("#pre_gun_1").val() != null){ 
              let pre_si2   = $("#pre_si_1").val();
              let pre_gun2  = $("#pre_gun_1").val();
              let pre_idx2  = $("#pre_idx_1").val();

              $('.span_pre_si2').html(pre_si2);
              $('.span_pre_gun2').html(pre_gun2);

              $("#pre_si2").val(pre_si2);
              $("#pre_gun2").val(pre_gun2);
              $("#pre_idx2").val(pre_idx2);
            }

            // 선호지역 3
            if($("#pre_si_2").val() != null && $("#pre_gun_2").val() != null){ 
              let pre_si3   = $("#pre_si_2").val();
              let pre_gun3  = $("#pre_gun_2").val();
              let pre_idx3  = $("#pre_idx_2").val();

              $('.span_pre_si3').html(pre_si3);
              $('.span_pre_gun3').html(pre_gun3);

              $("#pre_si3").val(pre_si3);
              $("#pre_gun3").val(pre_gun3);
              $("#pre_idx3").val(pre_idx3);
            }

          });


          // 초기 상태에서 '다음 단계' 버튼을 비활성화
          $("#btn_modify").prop("disabled", true);
          $("#btn_delete").prop("disabled", true);
          $("#btn_email").prop("disabled", true);

            var isPwdChecked = false;
            var isEmailChecked = true;

            $('#mem_email_first').on('input', function() {
            // 입력 필드가 변경되면 관련 플래그를 초기화하고, '다음 단계' 버튼을 비활성화
              isEmailChecked = false;
              $("#btn_email").prop("disabled", false);
              $("#btn_modify").prop("disabled", true);
            });
            $('#mem_email_domain').on('input', function() {
              // 입력 필드가 변경되면 관련 플래그를 초기화하고, '다음 단계' 버튼을 비활성화
              isEmailChecked = false;
              $("#btn_email").prop("disabled", false);
              $("#btn_modify").prop("disabled", true);
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
                  $("#btn_modify").prop("disabled", true);
                  $("#btn_delete").prop("disabled", true);
              }

          });

      // 이메일 중복 확인 함수
      window.check_email = function() {
        $("#btn_email").attr("disabled",true);

        let mem_email_first = $("#mem_email_first").val();
        let mem_email_domain = $("#mem_email_domain").val();
        let mem_email = $("#mem_email").val()


        if(mem_email_first == ''){
          alert('이메일을 입력하세요.');
          $("#mem_email_first").val(null);
          $("#mem_email_first").focus(); 
          $("#btn_email").attr("disabled",false);
          return;
        }

        if(mem_email_domain == ''){
          alert('이메일을 입력하세요.');
          $("#mem_email_domain").val(null);
          $("#btn_email").attr("disabled",false);
          return;
        }

        if(mem_email_first + "@" + mem_email_domain == mem_email){
          isEmailChecked = true;
          enableNextStep();

        }else{
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
                $("#btn_email").prop("disabled", true);
                enableNextStep();

              }else{
                //	이미 사용중인 아이디
                alert("이미 존재하는 이메일입니다.");
                $("#mem_email_first").val(null);
                $("#mem_email_domain").val(null);
                $("#mem_email_first").focus();
                $("#btn_email").attr("disabled",false);

                return;
              }

              if(res_data.code != null){
              code = res_data.code;
        }
              
            },
            error	:	function(err){
              alert(err.responseText);
              
            }
            
          });


        }

        

      }

      // '다음 단계' 버튼 활성화를 결정하는 함수
      function enableNextStep() {
        if(isEmailChecked && isPwdChecked) {
          $("#btn_modify").prop("disabled", false);
        }
        if(isPwdChecked) {
          $("#btn_delete").prop("disabled", false);
        }
      }

</script>
<script>
// 비밀번호 정규식(최소 8자에서 16자까지, 영문자, 숫자 및 특수 문자를 포함)
var regular_pwd =/^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*?_]).{8,16}$/;
// 연락처 정규식(숫자만)
var regular_tel = /^[0-9]*$/;

  function modify_member(f){
    let mem_idx   = f.mem_idx.value;
    let mem_grade   = f.mem_grade.value;

    let mem_pwd           = f.mem_pwd.value.trim();
    let mem_pwd_correct   = f.mem_pwd_correct.value.trim();
    let mem_name          = f.mem_name.value.trim();
    let mem_email_first   = f.mem_email_first.value.trim();
    let mem_email_domain  = f.mem_email_domain.value.trim();
    let mem_tel           = f.mem_tel.value.trim();

    let email_code = f.email_code.value;

    let photo     ="";
    let agree3_yn ="";

    let pre_si1  ="";
    let pre_si2  ="";
    let pre_si3  ="";
    let pre_gun1 ="";
    let pre_gun2 ="";
    let pre_gun3 ="";
    let pre_idx1 ="";
    let pre_idx2 ="";
    let pre_idx3 ="";

    if(mem_grade=="general"){
      pre_si1  = f.pre_si1.value.trim();
      pre_si2  = f.pre_si2.value.trim();
      pre_si3  = f.pre_si3.value.trim();
      pre_gun1 = f.pre_gun1.value.trim();
      pre_gun2 = f.pre_gun2.value.trim();
      pre_gun3 = f.pre_gun3.value.trim();
      pre_idx1 = f.pre_idx1.value.trim();
      pre_idx2 = f.pre_idx2.value.trim();
      pre_idx3 = f.pre_idx3.value.trim();
      agree3_yn = f.agree3_yn.value;
      let mem_photo = f.mem_photo.value;
    }
    
    if(mem_grade=="ceo"){
      agree3_yn   = f.agree3_yn.value;
    }


    if(mem_pwd != mem_pwd_correct){
      alert('비밀번호가 틀렸습니다.');
      f.mem_pwd_correct.value='';
      f.mem_pwd_correct.focus();
      return;
    }

    if(mem_pwd == ''){
    alert('비밀번호를 입력하세요.');
    f.mem_pwd.value='';
    f.mem_pwd.focus();
    return;
	}

  if(mem_grade != 'manager' && regular_pwd.test(mem_pwd)==false){
    alert('비밀번호는 최소 8자에서 16자까지, 영문자, 숫자 및 특수 문자를 포함해야 합니다.');
    f.mem_pwd.value='';
    f.mem_pwd_correct.value='';
    f.mem_pwd.focus();
    return;
	} 

  if(mem_name == ''){
    alert('이름을 입력하세요.');
    f.mem_name.value='';
    f.mem_name.focus();
    return;
	}

  if( code != null && code != email_code){
    alert("인증코드가 맞지않습니다");
    f.email_code.value = '';
    f.email_code.focus();
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

		   	   
    var form = $("member_form")[0];
    var formData = new FormData(form);

    formData.append("mem_grade", mem_grade);
    formData.append("mem_idx", mem_idx);
    formData.append("mem_pwd", mem_pwd);
    formData.append("mem_name", mem_name);
    formData.append("mem_email_first", mem_email_first);
    formData.append("mem_email_domain", mem_email_domain);
    formData.append("mem_tel", mem_tel);
   

    if(mem_grade=="general"){

      if ($("#mem_photo_profile")[0].files.length > 0) {
       
        formData.append("photo", $("#mem_photo_profile")[0].files[0]);
        
      }
      formData.append("mem_photo", mem_photo);
      formData.append("pre_si1", pre_si1);
      formData.append("pre_si2", pre_si2);
      formData.append("pre_si3", pre_si3);
      formData.append("pre_gun1", pre_gun1);
      formData.append("pre_gun2", pre_gun2);
      formData.append("pre_gun3", pre_gun3);
      formData.append("pre_idx1", pre_idx1);
      formData.append("pre_idx2", pre_idx2);
      formData.append("pre_idx2", pre_idx2);
      formData.append("pre_idx3", pre_idx3);
      formData.append("agree3_yn", agree3_yn);
    }

    if(mem_grade=="ceo"){
      formData.append("agree3_yn", agree3_yn);
    }

    if(confirm("수정하시겠습니까?")==false) return;


    $.ajax({
      type:"POST",
      url: "member_modify.do",
      data: formData,
      contentType: false,
      processData: false,
      success: function (res_data) {
        alert("수정되었습니다");
        location.href=location.href;
      //  $("#container_content").html(res_data);
      },
      error: function (jqXHR, textStatus, errorThrown) {
        console.table(jqXHR)
      }
    });

 

  }

  function delete_member(f){

    if(confirm("정말 탈퇴하시겠습니까?")==false) return;

    $.ajax({
      url: "member_delete.do",
      success: function (res_data) {
        alert("탈퇴가 완료되었습니다");
        location.href="main.do";
      },
      error: function (jqXHR, textStatus, errorThrown) {
        console.table(jqXHR)
      }
    });


  }
</script>
<script>

function setThumbnail(event) {
  var reader = new FileReader();
  reader.onload = function(event) {
    document.getElementById("mem_photo").src = event.target.result;
  };

  // 사용자가 파일을 선택했는지 확인하고, 선택된 파일을 읽어옴
  if (event.target.files && event.target.files[0]) {
        const file = event.target.files[0];
        const fileType = file.type;
        if (!fileType.startsWith('image/')) {
            alert('이미지 파일을 선택해주세요.');
            event.target.value = ''; // 파일 선택을 취소합니다.
            return;
        }
        reader.readAsDataURL(file);
    }
}

</script>
<script>

$(document).ready(function () {
    // 이미지 요소를 선택
    const photoImg = document.getElementById('mem_photo');
    // 기본 이미지 경로 설정
    const defaultImgSrc = '${pageContext.request.contextPath}/assets/img/sample/img_glamping_N5_1.png';
    if ('${user.mem_grade}' === 'general') {
      // 사용자 이미지가 없는 경우 기본 이미지를 사용
      if ('${user.mem_photo}' === '' || '${user.mem_photo}' === null) {
          photoImg.src = defaultImgSrc;
      } else {
          // 사용자 이미지가 있는 경우 해당 이미지 경로를 사용
          const userImgSrc = '${pageContext.request.contextPath}/member_photo_upload/${user.mem_photo}';
          photoImg.src = userImgSrc;
      }
  }
});

</script>
<script>
  function photo_del(){
    if(confirm("기본 이미지로 바꾸시겠습니까?")==false) return;
    const photoImg = document.getElementById('mem_photo');
    const defaultImgSrc = '${pageContext.request.contextPath}/assets/img/sample/img_glamping_N5_1.png';
    photoImg.src = defaultImgSrc;
    $("#mem_photo_profile").removeAttr("name");
  //  $("#hidden_photo").removeAttr("name");
  }

</script>
        
    </head>

    <body>
        <main class="th-layout-main ">
            <div id="my_info">
                <div class="my_info_title">내 정보 관리</div>
                <form method="POST" enctype="multipart/form-data" id="member_form">
                  <c:if test="${user.mem_grade eq 'general'}">
                    <input type="hidden" name="mem_photo" id="hidden_photo" value="${user.mem_photo}">
                    <div id="photo">
                      <c:if test="${empty user.mem_photo}">
                        <img src="${pageContext.request.contextPath}/assets/img/sample/img_glamping_N5_1.png" id="mem_photo" name="mem_photo">
                      </c:if>
                      <c:if test="${!empty user.mem_photo}">
                        <a class="deletePhoto_label" onclick="photo_del();">X</a>
                        <img src="${pageContext.request.contextPath}/member_photo_upload/${user.mem_photo}" id="mem_photo" name="mem_photo">
                      </c:if>
                      <!-- <img src="${pageContext.request.contextPath}/member_photo_upload/${user.mem_photo}" alt="프로필사진" id="mem_photo"> -->
                        <label class="btn_modify_photo" for="mem_photo_profile">수정</label>
                        <input class="btn_modify_photo" id="mem_photo_profile" name="photo" type="file" accept="image/*" onchange="setThumbnail(event);"  style="visibility: hidden;">
                    </div>
                  </c:if>
                <!-- [S]mypage_container_info  -->
                
                <div id="info_content">
                    
                        <div class="glamping-N47" data-bid="KAltwpIVGl">
                            <div class="contents-inner">
                                <div class="contents-container container-md">
                                    <div class="contents-top">
                                        <span>* 표시는 반드시 입력하셔야 하는 항목입니다</span>
                                        <input type="hidden" id="mem_grade" value="${user.mem_grade}">
                                        <input type="hidden" id="mem_idx" value="${user.mem_idx}">
                                    </div>
                                    <div class="contents-group">
                                        <div class="form-wrap">
                                            <h6 class="form-tit">아이디 <span>*</span>
                                            </h6>
                                            <div class="contents-form-group">
                                                <div class="inputset inputset-round">
                                                    <input type="text" class="inputset-input form-control"
                                                        aria-label="내용" required="아이디" id="mem_id" name="mem_id" value="${user.mem_id}" readonly="true">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-wrap">
                                            <h6 class="form-tit">비밀번호 <span>*</span>
                                            </h6>
                                            <div class="inputset inputset-round">
                                                <input type="password" id="mem_pwd" name="mem_pwd" class="inputset-input form-control" value="" aria-label="내용"
                                                    required="">
                                            </div>
                                        </div>
                                        <div class="form-wrap">
                                            <h6 class="form-tit">비밀번호 확인 <span>*</span>
                                            </h6>
                                            <div class="inputset inputset-round">
                                                <input type="password" id="mem_pwd_correct" name="mem_pwd_correct" class="inputset-input form-control" aria-label="내용"
                                                    required="">
                                                    <span id="pwd_match_msg"></span>
                                            </div>
                                        </div>
                                        <div class="form-wrap">
                                            <h6 class="form-tit">이름 <span>*</span>
                                            </h6>
                                            <div class="inputset inputset-round">
                                                <input type="text" class="inputset-input form-control" aria-label="내용"
                                                    required="" id="mem_name" name="mem_name" value="${user.mem_name}">
                                            </div>
                                        </div>
                                        <div class="form-wrap">
                                            <h6 class="form-tit">이메일 <span>*</span>
                                            </h6>
                                            <div class="contents-form-group">
                                              <div class="inputset inputset-round">
                                                <div class="contents-mail">
                                                  <input type="text"  id="mem_email_first" name="mem_email_first" value="${mem_email_first}"class="inputset-input form-control" aria-label="내용" required="">
                                                  <span class="joininput_email">@</span>
                                                  <input type="text" id="mem_email_domain" name="mem_email_domain" value="${mem_email_domain}"class="email_domain inputset-input form-control" value=" ">
                                                  <input type="hidden" id="mem_email" value="${user.mem_email}">
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
                                                  <button class="selectset-link btn" type="button" data-value="naver.com">
                                                    <span>naver.com</span>
                                                  </button>
                                                </li>
                                                <li class="selectset-item">
                                                  <button class="selectset-link btn" type="button" data-value="daum.net">
                                                    <span>daum.net</span>
                                                  </button>
                                                </li>
                                                <li class="selectset-item">
                                                  <button class="selectset-link btn" type="button" data-value="hanmail.net">
                                                    <span>hanmail.net</span>
                                                  </button>
                                                </li>
                                                <li class="selectset-item">
                                                  <button class="selectset-link btn" type="button" data-value="kakao.com">
                                                    <span>kakao.com</span>
                                                  </button>
                                                </li>
                                                <li class="selectset-item">
                                                  <button class="selectset-link btn" type="button" data-value="gmail.com">
                                                    <span>gmail.com</span>
                                                  </button>
                                                </li>
                                              </ul>
                                            </div>
                                            <input type="button" id="btn_email" onclick="check_email();" class="btnset btnset-round" value="중복체크">
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
                                                <input type="text" class="inputset-input form-control" id="mem_tel" name="mem_tel" value="${user.mem_tel}" aria-label="내용"
                                                    placeholder="-없이 번호를 입력해주세요" required="">
                                            </div>
                                        </div>
                                        


                                        <c:if test="${user.mem_grade eq 'general'}">
                                          
                                        
                                        <c:forEach var="pre_vo" items="${user.prefer_list}" varStatus="num">
                                          <input type="hidden" id="pre_si_${num.index}" name="pre_si_${num.index}" value="${pre_vo.pre_si}">
                                          <input type="hidden" id="pre_gun_${num.index}" name="pre_gun_${num.index}" value="${pre_vo.pre_gun}">
                                          <input type="hidden" id="pre_idx_${num.index}" name="pre_idx_${num.index}" value="${pre_vo.pre_idx}">
                                        </c:forEach>

                                        <div class="form-wrap">
                                          <h6 class="form-tit">선호지역&nbsp;1</h6>
                                          <div class="contents-prefer">
                                            <div class="contents-form-group">
                                              <div class="selectset selectset-round selectset-md">
                                                <button class="selectset-toggle btn" type="button">
                                                  <span class="span_pre_si1">시/도</span>
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
                                                  <span class="span_pre_gun1" id="diSelect1">군/구</span>
                                                </button>
                                                <ul class="selectset-list">
                                                  <ul class="ul_list" id="districtSelect1"></ul>
                                                </ul>
                                                <input type="hidden" id="pre_gun1" name="pre_gun1" value="">
                                                <input type="hidden" id="pre_idx1" name="pre_idx1" value="">
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
                                                  <span class="span_pre_si2">시/도</span>
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
                                                  <span class="span_pre_gun2" id="diSelect2">군/구</span>
                                                </button>
                                                <ul class="selectset-list">
                                                  <ul class="ul_list" id="districtSelect2"></ul>
                                                </ul>
                                                <input type="hidden" id="pre_gun2" name="pre_gun2" value="">
                                                <input type="hidden" id="pre_idx2" name="pre_idx2" value="">
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
                                                    <span  class="span_pre_si3">시/도</span>
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
                                                    <span class="span_pre_gun3" id="diSelect3">군/구</span>
                                                  </button>
                                                  <ul class="selectset-list">
                                                    <ul class="ul_list" id="districtSelect3"></ul>
                                                  </ul>
                                                  <input type="hidden" id="pre_gun3" name="pre_gun3" value="">
                                                  <input type="hidden" id="pre_idx3" name="pre_idx3" value="">
                                                </div>
                                              </div>
                                            </div>
                                          </div>
                                        </c:if>
                                        

                                        <c:if test="${user.mem_grade ne 'manager'}">
                                          <div class="form-wrap">
                                          <h6 class="form-tit">마케팅 동의 </h6>
                                            <div class="contents-story">
                                              <div class="contents-form-group">
                                                <div class="selectset selectset-round selectset-md">
                                                  <button class="selectset-toggle btn" type="button">
                                                    <span class="span_agree3_yn"></span>
                                                  </button>
                                                  <ul class="selectset-list">
                                                    <li class="selectset-item">
                                                      <button class="selectset-story btn" type="button" data-value="y">
                                                        <span>y</span>
                                                      </button>
                                                    </li>
                                                    <li class="selectset-item">
                                                      <button class="selectset-story btn" type="button" data-value="n">
                                                        <span>n</span>
                                                      </button>
                                                    </li>
                                                  </ul>
                                                  <input type="hidden" id="agree3_yn" name="agree3_yn" value="${user.agree3_yn}" required="">
                                                </div>
                                              </div>
                                            </div>
                                            </div>
                                          </div>
                                          



                                        </c:if>


                                        <c:if test="${user.mem_grade eq 'manager'}">
                                          <div class="form-wrap">
                                            <h6 class="form-tit">공지사항/FAQ</h6>
                                            <div class="contents-form-group">
                                                <div class="inputset inputset-round">
                                                    <input type="text" class="inputset-input form-control"
                                                        aria-label="공지faq" required="" id="not_man_yn" name="not_man_yn" value="${user.not_man_yn}" readonly="true">
                                                </div>
                                            </div>
                                          </div>
                                          
                                          <div class="form-wrap">
                                            <h6 class="form-tit">회원관리</h6>
                                            <div class="contents-form-group">
                                                <div class="inputset inputset-round">
                                                    <input type="text" class="inputset-input form-control"
                                                        aria-label="회원관리" required="" id="mem_man_yn" name="mem_man_yn" value="${user.mem_man_yn}" readonly="true">
                                                </div>
                                            </div>
                                          </div>
                                          <div class="form-wrap">
                                            <h6 class="form-tit">신고</h6>
                                            <div class="contents-form-group">
                                                <div class="inputset inputset-round">
                                                    <input type="text" class="inputset-input form-control"
                                                        aria-label="신고" required="" id="rep_man_yn" name="rep_man_yn" value="${user.rep_man_yn}" readonly="true">
                                                </div>
                                            </div>
                                          </div>
                                          <div class="form-wrap">
                                            <h6 class="form-tit">온라인문의</h6>
                                            <div class="contents-form-group">
                                                <div class="inputset inputset-round">
                                                    <input type="text" class="inputset-input form-control"
                                                        aria-label="온라인문의" required="" id="qna_man_yn" name="qna_man_yn" value="${user.qna_man_yn}" readonly="true">
                                                </div>
                                            </div>
                                          </div>
                                        </c:if>


                                    <div class="contents-btn-group">
                                        <input type="button" id="btn_modify" class="btnset btnset-round" onclick="modify_member(this.form);" value="수정">

                                        <c:if test="${user.mem_grade ne 'manager'}">
                                          <input type="button" id="btn_delete" class="btnset btnset-line btnset-round" onclick="delete_member(this.form);" value="탈퇴">
                                        </c:if>

                                    </div>


                                    


                                </div>
                            </div>
                        </div>
                    </form>
                </div>
                <!-- [E]mypage_container_info  -->
                <!-- [S]sns  -->
                <c:if test="${user.mem_grade eq 'general'}">
                  <div id="sns_box">
                      <div id="sns">
                          <div id="sns_title">SNS 계정 연동하기</div>
                          <div id="sns_content">SNS 계정을 연동하면 해당 계정을 사용해 바로 로그인 할 수 있습니다.</div>
                          <div class="sns_brand">
                              <div class="sns_brand_one">
                                  <img src="${pageContext.request.contextPath}/assets/icons/ico_naver_round.png" alt="">
                                  <div class="company">Naver</div>
                                  <c:if test="${empty user.mem_naver}">
                                    <input id="naverOn" type="button" value="연동하기" onclick="sns('naver')">
                                    <input id="naverOff" type="button" value="연동해제" style="display: none;" onclick="sns('naver')">
                                  </c:if>
                                  <c:if test="${not empty user.mem_naver}">
                                    <input id="naverOn" type="button" value="연동하기" style="display: none;" onclick="sns('naver')">
                                    <input id="naverOff" type="button" value="연동해제" onclick="sns('naver')">
                                  </c:if>
                              </div>
                              <div class="sns_brand_one kakao">
                                  <div class="kakao_logo">
                                      <img src="${pageContext.request.contextPath}/assets/icons/ico_kakao.svg" alt="">
                                  </div>
                                  <div class="company ">Kakao</div>
                                  <c:if test="${empty user.mem_kakao}">
                                    <input id="kakaoOn" type="button" value="연동하기" onclick="sns('kakao')">
                                    <input id="kakaoOff" type="button" value="연동해제" style="display: none;" onclick="sns('kakao')">
                                  </c:if>
                                  <c:if test="${not empty user.mem_kakao}">
                                    <input id="kakaoOn" type="button" value="연동하기" style="display: none;" onclick="sns('kakao')">
                                    <input id="kakaoOff" type="button" value="연동해제" onclick="sns('kakao')">
                                  </c:if>
                              </div>
                              <div class="sns_brand_one">
                                  <img src="${pageContext.request.contextPath}/assets/icons/ico_google.svg" alt="">
                                  <div class="company">Google</div>
                                  <c:if test="${empty user.mem_google}">
                                    <input id="googleOn" type="button" value="연동하기" onclick="sns('google')">
                                    <input id="googleOff" type="button" value="연동해제" style="display: none;"  onclick="sns('google')">
                                  </c:if>
                                  <c:if test="${not empty user.mem_google}">
                                    <input id="googleOn" type="button" value="연동하기" style="display: none;" onclick="sns('google')">
                                    <input id="googleOff" type="button" value="연동해제" onclick="sns('google')">
                                  </c:if>
                              </div>

                </div>
              </div>
            </div>
          </c:if>
          <!-- [E]sns  -->



        </div>
      </main>
    </body>


    </html>