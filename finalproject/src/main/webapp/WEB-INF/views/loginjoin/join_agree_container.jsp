<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>캠프로버</title>
<script>

function join_agree(f){

  let agree1_yn = $('input[name="agree1_yn"]:checked').val();
  let agree2_yn = $('input[name="agree2_yn"]:checked').val();
  let agree3_yn = $('input[name="agree3_yn"]:checked').val();
  let mem_grade = f.mem_grade.value;
  let url = f.url.value;

  console.log(mem_grade);

  if(agree1_yn!='y'){
    alert('필수 약관에 동의해야 회원가입이 가능합니다.');
    return;
	}

  if(agree2_yn!='y'){
    alert('필수 약관에 동의해야 회원가입이 가능합니다.');
    return;
	}

  if(mem_grade=='general'){

    f.method='post';
    f.action='join_input.do?url=' + url;
    f.submit();
  }

  if(mem_grade=='ceo'){

    f.method='post';
    f.action='join_input_ceo.do';
    f.submit();
  }

}
</script>
<script>
  $(document).ready(function(){
    
  })
</script>
</head>
<body>
<!-- [E]glamping-N2 -->

<main class="th-layout-main ">
    <!-- [S]glamping-N45 -->
    <div class="glamping-N45" data-bid="SGltwPIrt8">
      <div class="contents-inner">
        <div class="contents-container container-md">
          <div class="textset">
            <h2 class="textset-tit">약관동의</h2>
            <p class="textset-desc">가입에 필요한 약관에 동의해주세요</p>
          </div>
          <ul class="contents-list">
            <li class="contents-item item-active">
              <span>1</span>
            </li>
            <li class="contents-item">
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
    <!-- [S]glamping-N46 -->
    
      <div class="glamping-N46" data-bid="ObLtWPiRwP">
        <div class="contents-inner">
          <div class="contents-container container-md">
            <div class="contents-group">
              <div class="contents-top">
                <h2 class="contents-tit">이용약관 (필수)</h2>
                <div class="radioset-wrap">
                  <div class="radioset">
                    <input id="radio-a-1" name="agree1_yn" class="radioset-input input-line" type="radio" value="y">
                    <label class="radioset-label" for="radio-a-1"></label>
                    <span class="radioset-text">동의</span>
                  </div>
                  <div class="radioset">
                    <input id="radio-a-2" name="agree1_yn" class="radioset-input input-line" type="radio" value="n" checked="">
                    <label class="radioset-label" for="radio-a-2"></label>
                    <span class="radioset-text">미동의</span>
                  </div>
                </div>
              </div>
              <div class="contents-terms">
                <strong>총칙</strong>
                <span>제1조</span>
                <p> 본 약관은 주식회사 캠프로버(이하 ‘캠프로버')와 고객(당 캠프로버에 숙박예약을 희망하는 자 및 실제 숙박하는 자를 의미하며, 이하 동일합니다)간의 권리와 의무에 대하여 규정함을 그 목적으로 합니다. 이하 이용약관에 대한 내용이 노출됩니다 이용약관에 대한 내용이 노출됩니다 이용약관에 대한 내용이 노출됩니다 이용약관에 대한 내용이 노출됩니다이용약관에 대한 내용이 노출됩니다이하 이용 약관에 대한 내용이 노출됩니다 이용약관에 대한 내용이 노출됩니다 이용약관에 대한 내용이 노출됩니다 이용약관에 대한 내용이 노출됩니다이용약관에 대한 내용이 노출됩니다 </p>
              </div>
            </div>
            <div class="contents-group">
              <div class="contents-top">
                <h2 class="contents-tit">개인정보 수집 및 이용동의 (필수)</h2>
                <div class="radioset-wrap">
                  <div class="radioset">
                    <input id="radio-b-1" name="agree2_yn" class="radioset-input input-line" type="radio" value="y">
                    <label class="radioset-label" for="radio-b-1"></label>
                    <span class="radioset-text">동의</span>
                  </div>
                  <div class="radioset">
                    <input id="radio-b-2" name="agree2_yn" class="radioset-input input-line" type="radio" value="n" checked="">
                    <label class="radioset-label" for="radio-b-2"></label>
                    <span class="radioset-text">미동의</span>
                  </div>
                </div>
              </div>
              <div class="contents-terms">
                <strong>총칙</strong>
                <span>제1조</span>
                <p> 본 약관은 주식회사 캠프로버(이하 캠프로버')와 고객(당 캠프로버에 숙박예약을 희망하는 자 및 실제 숙박하는 자를 의미하며, 이하 동일합니다)간의 권리와 의무에 대하여 규정함을 그 목적으로 합니다. 이하 이용약관에 대한 내용이 노출됩니다 이용약관에 대한 내용이 노출됩니다 이용약관에 대한 내용이 노출됩니다 이용약관에 대한 내용이 노출됩니다이용약관에 대한 내용이 노출됩니다이하 이용 약관에 대한 내용이 노출됩니다 이용약관에 대한 내용이 노출됩니다 이용약관에 대한 내용이 노출됩니다 이용약관에 대한 내용이 노출됩니다이용약관에 대한 내용이 노출됩니다 </p>
              </div>
            </div>
            <div class="contents-group">
              <div class="contents-top">
                <h2 class="contents-tit">마케팅 개인정보 수집 및 이용동의</h2>
                <div class="radioset-wrap">
                  <div class="radioset">
                    <input id="radio-c-1" name="agree3_yn" class="radioset-input input-line" type="radio" value="y">
                    <label class="radioset-label" for="radio-c-1"></label>
                    <span class="radioset-text">동의</span>
                  </div>
                  <div class="radioset">
                    <input id="radio-c-2" name="agree3_yn" class="radioset-input input-line" type="radio" value="n" checked="">
                    <label class="radioset-label" for="radio-c-2"></label>
                    <span class="radioset-text">미동의</span>
                  </div>
                </div>
              </div>
              <div class="contents-terms">
                <strong>총칙</strong>
                <span>제1조</span>
                <p> 본 약관은 주식회사 캠프로버(이하 캠프로버')와 고객(당 캠프로버에 숙박예약을 희망하는 자 및 실제 숙박하는 자를 의미하며, 이하 동일합니다)간의 권리와 의무에 대하여 규정함을 그 목적으로 합니다. 이하 이용약관에 대한 내용이 노출됩니다 이용약관에 대한 내용이 노출됩니다 이용약관에 대한 내용이 노출됩니다 이용약관에 대한 내용이 노출됩니다이용약관에 대한 내용이 노출됩니다이하 이용 약관에 대한 내용이 노출됩니다 이용약관에 대한 내용이 노출됩니다 이용약관에 대한 내용이 노출됩니다 이용약관에 대한 내용이 노출됩니다이용약관에 대한 내용이 노출됩니다 </p>
              </div>
            </div>
   
            <div class="contents-btnset">
              <input class="btnset btnset-round" type="button" onclick="join_agree(this.form);" value="다음단계">
            </div>
          </div>
        </div>
      </div>

    <!-- [E]glamping-N46 -->
    </main>

</body>
</html>