<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="join_select_modal.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 구글 로그인 스크립트 -->
<script src="https://accounts.google.com/gsi/client" async></script>
<script>
  
$(function(){
  $('.login_wrap > div').hide();
  $('.login_tab_ul a').click(function () {
    $('.login_wrap > div').hide().filter(this.hash).css('display', 'block');
    $('.login_tab_ul a').removeClass('active');
    $(this).addClass('active');
    return false;
  }).filter(':eq(0)').click();
  });
</script>
<script>
function gradeSelect() {

    $("#joinModal").modal('show');
  
}

</script>
<script>
  //--------------------------------------------------------로그인 CEO
function login_manager(f) {
	
	let mem_id = f.mem_id.value.trim();
	let mem_pwd = f.mem_pwd.value.trim();
	
	if(mem_id ==''){
		alert("아이디를 입력하세요!");
		f.mem_id.value = '';
		f.mem_id.focus();
		return;
	}
	
	if(mem_pwd ==''){
		alert("비밀번호를 입력하세요!");
		f.mem_pwd.value = '';
		f.mem_pwd.focus();
		return;
	}

  if(f.idsave.checked){
      setCookie("form", f.id, 7);
      setCookie("mem_id", mem_id, 7);
  }else{ 
			deleteCookie("form");
			deleteCookie("mem_id");
	}


	$.ajax({
	      
	      type: "POST",
	      url: "login_manager.do",
	      data: { mem_id: mem_id, mem_pwd: mem_pwd },
		    dataType : "json",
	      success: function(res_data) {	 
	    	  
	    	  if (res_data.reason === "fail_id") {
	              alert("아이디가 틀렸습니다");
	              f.mem_id.value = '';
	              f.mem_pwd.value = '';
	              f.mem_id.focus();
	              return;
	          }

	          if (res_data.reason === "fail_pwd") {
	              alert("비밀번호가 틀렸습니다");
	              f.mem_id.value = res_data.mem_id;
	              f.mem_pwd.value = '';
	              f.mem_pwd.focus();
	              return;
	          }	          
      
           

            if("${empty url}" == "true"){
            location.href = "main.do";
           }else{
             location.href = "${url}";
           }
           
           
	      },
	      error    : function(err) {
	           console.log(err.responseText);
	           }
	      
	   });
	
}
</script>
<script>
  //--------------------------------------------------------로그인 CEO
function login_ceo(f) {
	
	let mem_id = f.mem_id.value.trim();
	let mem_pwd = f.mem_pwd.value.trim();
	
	if(mem_id ==''){
		alert("아이디를 입력하세요!");
		f.mem_id.value = '';
		f.mem_id.focus();
		return;
	}
	
	if(mem_pwd ==''){
		alert("비밀번호를 입력하세요!");
		f.mem_pwd.value = '';
		f.mem_pwd.focus();
		return;
	}

  if(f.idsave.checked){
      setCookie("form", f.id, 7);
      setCookie("mem_id", mem_id, 7);
  }else{ 
			deleteCookie("form");
			deleteCookie("mem_id");
	}


	$.ajax({
	      
	      type: "POST",
	      url: "login_ceo.do",
	      data: { mem_id: mem_id, mem_pwd: mem_pwd },
		    dataType : "json",
	      success: function(res_data) {	 
	    	  
	    	  if (res_data.reason === "fail_id") {
	              alert("아이디가 틀렸습니다");
	              f.mem_id.value = '';
	              f.mem_pwd.value = '';
	              f.mem_id.focus();
	              return;
	          }

	          if (res_data.reason === "fail_pwd") {
	              alert("비밀번호가 틀렸습니다");
	              f.mem_id.value = res_data.mem_id;
	              f.mem_pwd.value = '';
	              f.mem_pwd.focus();
	              return;
	          }	          
      
           

            if("${empty url}" == "true"){
            location.href = "main.do";
           }else{
             location.href = "${url}";
             console.log("악성코드");
           }
           
           
	      },
	      error    : function(err) {
	           console.log(err.responseText);
	           }
	      
	   });
	
}
</script>
<script>
  $(document).ready(function () {

    var form_name = getCookie("form");
    var mem_id_cookie = getCookie("mem_id");
    
    if(getCookie("form") != false){
      var form = "#"+form_name+' [name="mem_id"]';
      $(form).val(mem_id_cookie);
    }
  })
</script>
<script>
  //--------------------------------------------------------로그인 general

function login_general(f) {
	
	let mem_id = f.mem_id.value.trim();
	let mem_pwd = f.mem_pwd.value.trim();
	
	if(mem_id ==''){
		alert("아이디를 입력하세요!");
		f.mem_id.value = '';
		f.mem_id.focus();
		return;
	}
	
	if(mem_pwd ==''){
		alert("비밀번호를 입력하세요!");
		f.mem_pwd.value = '';
		f.mem_pwd.focus();
		return;
	}
  
  if(f.idsave.checked){
      setCookie("form", f.id, 7);
      setCookie("mem_id", mem_id, 7);
  }else{ 
			deleteCookie("form");
			deleteCookie("mem_id");
	}

	$.ajax({
	      
	      type: "POST",
	      url: "login_general.do",
	      data: { mem_id: mem_id, mem_pwd: mem_pwd },
		    dataType : "json",
	      success: function(res_data) {	 
	    	  
	    	  if (res_data.reason === "fail_id") {
	              alert("아이디가 틀렸습니다");
	              f.mem_id.value = '';
	              f.mem_pwd.value = '';
	              f.mem_id.focus();
	              return;
	          }

	          if (res_data.reason === "fail_pwd") {
	              alert("비밀번호가 틀렸습니다");
	              f.mem_id.value = res_data.mem_id;
	              f.mem_pwd.value = '';
	              f.mem_pwd.focus();
	              return;
	          }	          
      
           
           
	          if("${empty url}" == "true"){
            location.href = "main.do";
           }else{
             location.href = "${url}";
           }
	          
	      },
	      error    : function(err) {
	           console.log(err.responseText);
	           }
	      
	   });
	
}
</script>
<script>
// 아이디 저장 선택시 쿠키

// 등록
function setCookie(cookieName, value, exdays){
    var exdate = new Date();
    exdate.setDate(exdate.getDate() + exdays);
    var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toGMTString());
    document.cookie = cookieName + "=" + cookieValue;
}
 
// 삭제
function deleteCookie(cookieName){
	var expireDate = new Date();
	expireDate.setDate(expireDate.getDate() - 1);
	document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
}

// 불러오기
function getCookie(cookieName) {
	cookieName = cookieName + '=';
	var cookieData = document.cookie;
	var start = cookieData.indexOf(cookieName);
	var cookieValue = '';
	if(start != -1){
		start += cookieName.length;
		var end = cookieData.indexOf(';', start);
		if(end == -1)end = cookieData.length;
		cookieValue = cookieData.substring(start, end);
	}
	return unescape(cookieValue);
}

</script>
<script>
  function kp_login_g(event, form) {
    // 엔터 키의 keyCode는 13입니다.
    if (event.keyCode === 13) {
    	login_general(form);
    }
  }
  function kp_login_c(event, form) {
    // 엔터 키의 keyCode는 13입니다.
    if (event.keyCode === 13) {
    	login_ceo(form);
    }
  }
  function kp_login_m(event, form) {
    // 엔터 키의 keyCode는 13입니다.
    if (event.keyCode === 13) {
    	login_manager(form);
    }
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
            <h2 class="textset-tit">로그인</h2>
            <p class="textset-desc">캠프로버에 오신것을 진심으로 환영합니다</p>
          </div>

            <div class="login_tab">
              <ul class="login_tab_ul">
                <li class="login_tab_li l_t_1">
                  <a href="#noraml_login">일반회원</a>
                </li>
                <li class="login_tab_li l_t_2">
                  <a href="#ceo_login">기업회원</a>
                </li>       
                <li class="login_tab_li l_t_3">
                  <a href="#manager_login">관리자회원</a>
                </li>       
              </ul>
            </div>
            <div class="login_wrap">
              <div id="noraml_login">
                <form  id="normal_login_form">
                  <div class="contents-form">
                    <div class="inputset inputset-round">
                      <input type="text" name="mem_id" class="inputset-input form-control" aria-label="내용" placeholder="아이디를 입력해주세요" required="" value="">
                    </div>
                    <div class="inputset inputset-round">
                      <input type="password" name="mem_pwd" class="inputset-input form-control" aria-label="내용" placeholder="비밀번호를 입력해주세요" required="" onkeypress="kp_login_g(event, this.form);">
                    </div>
                    <div class="contents-util">
                      <div class="checkset">
                        <input id="checkset-a-1-1" name="idsave" class="checkset-input input-round" type="checkbox" value="" checked="">
                        <label class="checkset-label" for="checkset-a-1-1"></label>
                        <span class="checkset-text">아이디저장</span>
                      </div>
                      <div class="contents-find">
                        <a href="find_id.do">아이디 찾기</a>
                        <a href="find_pwd.do">비밀번호 찾기</a>
                      </div>
                    </div>
                    <div class="contents-btnset">
                      <input class="btnset btnset-round" type="button" onclick="login_general(this.form);" value="로그인">
                      <input class="btnset btnset-round btnset-line" type="button" onclick="gradeSelect();" value="회원가입">
                    </div>
                  </div>
                </form>
                <!-- end:contents-form -->

                <div class="contents-start">
                  <span class="contents-or">
                    <span class="contents-ortext">SNS 계정으로 간편 로그인</span>
                  </span>
                  <ul class="contents-list">
                    <li>
                      <a href="javascript:void(0);"onclick="location.href='kakao_url.do'">
                        <figure class="contents-figure ico-kakao">
                          <img class="contents-icon-kakao-emblem" src="${pageContext.request.contextPath}/assets/icons/ico_kakao.svg" alt="카카오톡 아이콘">
                          <span class="content-sns fontkakao">
                            <div >카카오 로그인</div>
                          </span>
                        </figure>
                      </a>
                    </li>
                    <li class="contents-item" onclick="location.href='naver_url.do'">
                      <a  id="naver_login_button" href="javascript:void(0);" onclick="document.getElementById('naver_id_login').firstChild.click();">
                        <figure class="contents-figure ico-naver">
                          <img class="contents-icon-naver-emblem" src="${pageContext.request.contextPath}/assets/icons/ico_naver_round.png" alt="네이버 아이콘">
                          <span class="content-sns fontnaver">네이버 로그인</span>
                        </figure>
                      </a>
                    </li>
                    <li class="contents-item " id="gSignInWrapper" >
                      <a href="javascript:void(0);"  onclick="location.href='google_url.do'">
                        <figure class="contents-figure ico-google">
                          <img class="contents-icon-google-emblem" src="${pageContext.request.contextPath}/assets/icons/ico_google_round.svg" alt="구글 아이콘">
                          <span class="content-sns fontgoogle">&nbsp;구글&nbsp;&nbsp;로그인</span>
                        </figure>
                      </a>
                    </li>
                  </ul>
                </div>

                <!-- end:contents-start -->
              </div>
              <div id="ceo_login">
                <form id="ceo_login_form">
                  <div class="contents-form">
                    <div class="inputset inputset-round">
                      <input type="text" name="mem_id" class="inputset-input form-control" aria-label="내용" placeholder="아이디를 입력해주세요" required="">
                    </div>
                    <div class="inputset inputset-round">
                      <input type="password" name="mem_pwd" class="inputset-input form-control" aria-label="내용" placeholder="비밀번호를 입력해주세요" required="" onkeypress="kp_login_c(event, this.form);">
                    </div>
                    <div class="contents-util">
                      <div class="checkset">
                        <input  id="checkset-b-1-1" name="idsave" class="checkset-input input-round" type="checkbox" value="" checked="">
                        <label class="checkset-label" for="checkset-b-1-1"></label>
                        <span class="checkset-text">아이디저장</span>
                      </div>
                      <div class="contents-find">
                        <a href="find_id.do">아이디 찾기</a>
                        <a href="javascript:void(0);">비밀번호 찾기</a>
                      </div>
                    </div>
                    <div class="contents-btnset">
                      <input class="btnset btnset-round" type="button" onclick="login_ceo(this.form);" value="로그인">
                      <input class="btnset btnset-round btnset-line" type="button" onclick="gradeSelect();" value="회원가입">
                    </div>
                  </div>
                </form>
                <!-- end:contents-form -->
              </div>
              <div id="manager_login">
                <form id="manager_login_form">
                  <div class="contents-form">
                    <div class="inputset inputset-round">
                      <input type="text" name="mem_id" class="inputset-input form-control" aria-label="내용" placeholder="아이디를 입력해주세요" required="">
                    </div>
                    <div class="inputset inputset-round">
                      <input type="password" name="mem_pwd" class="inputset-input form-control" aria-label="내용" placeholder="비밀번호를 입력해주세요" required="" onkeypress="kp_login_m(event, this.form);">
                    </div>
                    <div class="contents-util">
                      <div class="checkset">
                        <input  id="checkset-c-1-1" name="idsave" class="checkset-input input-round" type="checkbox" value="" checked="">
                        <label class="checkset-label" for="checkset-c-1-1"></label>
                        <span class="checkset-text">아이디저장</span>
                      </div>
                      <div class="contents-find">
                        <a href="find_id.do">아이디 찾기</a>
                        <a href="javascript:void(0);">비밀번호 찾기</a>
                      </div>
                    </div>
                    <div class="contents-btnset">
                      <input class="btnset btnset-round" type="button" onclick="login_manager(this.form);" value="로그인">
                      <input class="btnset btnset-round btnset-line" type="button" onclick="gradeSelect();" value="회원가입">
                    </div>
                  </div>
                </form>
                <!-- end:contents-form -->
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