<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <!-- core JSTL -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %><!-- fmt JSTL -->
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> <!-- functions JSTL -->

<!DOCTYPE html>
  <html>

  <head>
    
    <meta charset="UTF-8">
    <title>캠프로버</title>
    <script>
      function payment(f){

      }
    </script>
    <script>
      var valuea = "${amount}";
      var orderId = new Date().getTime();
      // if("${not empty res_idx}" == "true"){
      //   var idx = parseInt("${res_idx}");
      //   if(idx<10000){
      //     orderId = "20201"+"${res_idx}";
      //   }else{
      //     orderId = "${res_idx}";
      //   }
      // }

      var checkDays = "${checkDays}";
      var orderName = "${room_vo.room_name}_${res_vo.res_checkindate} - ${res_vo.res_checkoutdate}";
      var successUrl = "https://camprover.store/reservation/tossSuccess.do";
      var failUrl = "https://camprover.store/reservation/tossFail.do";
    </script>
    <script>
      $(document).ready(function () {
          var mem_email = "${user.mem_email}";
          var emailParts = mem_email.split('@');
  
          // 분리된 이메일 주소를 폼 입력 필드에 할당
          if (emailParts.length === 2) {
              $("input[name='mem_email_first']").val(emailParts[0]);
              $("input[name='mem_email_domain']").val(emailParts[1]);
          }

          $("input[name='mem_name']").val('${user.mem_name}');
          $("input[name='mem_tel']").val('${user.mem_tel}');
      });
    </script>
    <script>
      $(document).ready(function () {
       
        var form = $("#insert_form [neme=room_name]").value;
        console.log("form"+form);

          // var form = $("#insert_form")

          // console.log("form"+form);
          // var formData = new FormData(form);
          // console.log("formData"+formData);
          // formData.append("paymentType",paymentType);
          // formData.append("orderId",orderId);
          // formData.append("paymentKey",paymentKey);
          // formData.append("amount",amount);




      });
    </script>
    <script>
      document.getElementById("chk-1-1").addEventListener("click", agree_all);

      function agree_all(event) {

        var checkbox1 = document.getElementById("chk-1-1");
        var checkbox2 = document.getElementById("chk-1-2");
        var checkbox3 = document.getElementById("chk-1-3");

        if (checkbox1.checked) {
          checkbox2.checked = true;
          checkbox3.checked = true;
        } else {
          checkbox2.checked = false;
          checkbox3.checked = false;
        }
}
    </script>

  </head>

  <body>
  <form id="insert_form">  
    <!-- [S]glamping-N45 -->
    <div class="glamping-N45" data-bid="iFltwPivdp">
      <div class="contents-inner">
        <div class="contents-container container-md">
          <div class="textset">
            <h2 class="textset-tit">예약정보</h2>
            <p class="textset-desc">예약에 필요한 정보들을 입력해주세요</p>
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
    <!-- [S]glamping-N35 -->
    <div class="glamping-N35" data-bid="kDLtwPJ58p">
      <div class="contents-inner">
        <div class="contents-container container-md">
          <div class="contents-top">
            <div class="contents-list">
              <div class="contents-item">
                <div class="contents-icongroup">
                  <figure class="contents-icon">
                    <i class="fa-solid fa-calendar-days fa-xl" style="color: #007235;" alt="달력 아이콘"></i>
                  </figure>
                  <span>투숙기간</span>
                </div>
                <p class="content-text">${res_vo.res_checkindate} - ${res_vo.res_checkoutdate} </p>
              </div>
              <div class="contents-item">
                <div class="contents-icongroup">
                  <figure class="contents-icon">
                    <i class="fa-solid fa-campground fa-xl" style="color: #007235;" alt="캠핑 아이콘"></i>
                  </figure>
                  <span>객실명</span>
                </div>
                <p class="content-text">${room_vo.room_name}</p>
              </div>
              <div class="contents-item content-mobile-group">
                <div class="contents-icongroup">
                  <figure class="contents-icon">
                    <i class="fa-solid fa-person fa-2xl" style="color: #007235;" alt="성인 아이콘"></i>
                  </figure>
                  <span>성인</span>
                </div>
                <p class="content-text">${res_vo.res_peopleadult}명</p>
              </div>
              <div class="contents-item content-mobile-group">
                <div class="contents-icongroup">
                  <figure class="contents-icon">
                    <i class="fa-solid fa-child fa-2xl" style="color: #007235;" alt="소인 아이콘"></i>
                  </figure>
                  <span>소인</span>
                </div>
                <p class="content-text">${res_vo.res_peoplechild}명</p>
              </div>
              <div class="contents-item content-mobile-group">
                <div class="contents-icongroup">
                  <figure class="contents-icon">
                    <i class="fa-solid fa-baby fa-2xl" style="color: #007235;" alt="유아 아이콘"></i>
                  </figure>
                  <span>유아</span>
                </div>
                <p class="content-text">${res_vo.res_peopletoddler}명</p>
              </div>
              <div class="contents-item">
                <div class="contents-icongroup">
                  <figure class="contents-icon">
                    <i class="fa-solid fa-paw fa-2xl" style="color: #007235;" alt="펫 아이콘"></i>
                  </figure>
                  <span>반려견동행</span>
                </div>
                <p class="content-text">${res_vo.animalCmgCl}</p>
              </div>
            </div>
            <button class="btnset btnset-round btnset-line btnset-black" disabled=""><fmt:formatNumber value="${amount}" type="number" />원</button>
          </div>
          <div class="contents-bottom">
            <span>글램핑 정보</span>
            <strong>${camp_vo.facltNm}</strong>
          </div>
        </div>
      </div>
    </div>
    <!-- [E]glamping-N35 -->
    <!-- [S]glamping-N37 -->
    <div class="glamping-N37" data-bid="aFlTWPj5dO">
      <div class="contents-inner">
        <div class="contents-container container-md">
          <div class="contents-top">
            <h2 class="contents-tit">정보입력</h2>
            <div class="contents-group">
              <div class="form-wrap">
                <h6 class="form-tit">성명 <span>*</span>
                </h6>
                <div class="inputset inputset-round">
                  <input type="text" class="inputset-input form-control" name="mem_name">
                </div>
              </div>
              <div class="form-wrap">
                <h6 class="form-tit">연락처 <span>*</span>
                </h6>
                <div class="inputset inputset-round">
                  <input type="text" class="inputset-input form-control"name="mem_tel">
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
              </div>
              <div class="form-wrap">
                <h6 class="form-tit">요청사항</h6>
                <div class="inputset inputset-round">
                  <div class="textarea_parent">
                      <textarea class="inputset-textarea form-control" name="res_request"  required=""></textarea>
                  </div>
                  <div class="inputset-langth">
                      <span class="inputset-count">0</span>
                      <span class="inputset-total">/2000 Byte</span>
                  </div>
              </div>
              </div>
            </div>
          </div>
          <div class="contents-center">
            <!-- <h2 class="contents-tit">결제정보</h2>
            <div class="tabset tabset-round">
              <ul class="tabset-list tabset-fill">
                <li class="tabset-item">
                  <a class="tabset-link active" href="javascript:void(0)">
                    <span>무통장입금</span>
                  </a>
                </li>
                <li class="tabset-item">
                  <a class="tabset-link" href="javascript:void(0)">
                    <span>카드결제</span>
                  </a>
                </li>
              </ul>
            </div> -->
            <!-- <div class="contents-group">
              <div class="form-wrap">
                <h6 class="form-tit">카드번호 <span>*</span>
                </h6>
                <div class="contents-form-group">
                  <div class="inputset inputset-round">
                    <input type="text" class="inputset-input form-control" aria-label="내용" required="">
                  </div>
                  <div class="inputset inputset-round">
                    <input type="text" class="inputset-input form-control" aria-label="내용" required="">
                  </div>
                  <div class="inputset inputset-round">
                    <input type="text" class="inputset-input form-control" aria-label="내용" required="">
                  </div>
                  <div class="inputset inputset-round">
                    <input type="text" class="inputset-input form-control" aria-label="내용" required="">
                  </div>
                  <a href="javascript:void(0);" class="btnset btnset-round btnset-line">카드인증</a>
                </div>
              </div>
              <div class="form-wrap">
                <h6 class="form-tit">유효기간 <span>*</span>
                </h6>
                <div class="contents-card-num">
                  <div class="contents-form-group">
                    <div class="inputset inputset-round">
                      <input type="text" class="inputset-input form-control" aria-label="내용" placeholder="월"
                        required="">
                    </div>
                    <div class="inputset inputset-round">
                      <input type="text" class="inputset-input form-control" aria-label="내용" placeholder="년도"
                        required="">
                    </div>
                  </div>
                  <p class="contents-desc"> * 신용카드 정보는 위약금 결제를 위해 수집되며, 글램핑 요금은 체크인 시 결제됩니다. </p>
                </div>
              </div>
            </div> -->
          </div>
          <div class="contents-bottom">
            <h2 class="contents-tit">개인정보 수집 동의</h2>
            <div class="checkset checkset-sm">
              <input id="chk-1-1" class="checkset-input input-round" type="checkbox" value="">
              <label class="checkset-label" for="chk-1-1" ></label>
              <span class="checkset-text" id="all_check">전체동의</span>
            </div>
            <div class="checkset checkset-sm">
              <input id="chk-1-2" class="checkset-input input-round" type="checkbox" value="y" name="res_use_agree_yn">
              <label class="checkset-label" for="chk-1-2"></label>
              <span class="checkset-text">(필수) 개인정보 수집항목 및 이용 동의</span>
            </div>
              <div class="use_text">
                캠프로버(이하 ‘회사’라 한다)는 개인정보 보호법 제30조에 따라 정보주체의 개인정보를 보호하고 이와 관련한 고충을 신속하고 원활하게 처리할 수 있도록 하기 위하여 다음과 같이 개인정보 처리지침을 수립․공개합니다.

                제1조(개인정보의 처리목적) 회사는 다음의 목적을 위하여 개인정보를 처리합니다. 처리하고 있는 개인정보는 다음의 목적 이외의 용도로는 이용되지 않으며, 이용 목적이 변경되는 경우에는 개인정보 보호법 제18조에 따라 별도의 동의를 받는 등 필요한 조치를 이행할 예정입니다.

                · 서비스 제공
                회사 메인 웹 사이트 : 고객 제품문의 및 신청사항 답변 및 안내를 위한 고객의 정보 수집 ( 고객문의 페이지에서 입력하신 이름, 이메일, 연락처는 고객문의 내용을 회사와 문의하신 분에게 전송용으로 사용되고 해당 정보는 서버에 따로 저장되지 않습니다. )

                제2조(개인정보의 처리 및 보유기간) 회사는 법령에 따른 개인정보 보유․이용기간 또는 정보주체로부터 개인정보를 수집시에 동의받은 개인정보 보유․이용기간 내에서 개인정보를 처리․보유합니다.
                · 회사 메인 웹 사이트 : 제품문의 및 신청, 고객문의
                ➀ 수집방법 : 웹 사이트에 고객이 직접 입력 후 이메일 발송 (웹 사이트 저장 없음)
                ➁ 보유기간 : 없음

                제3조(개인정보의 제3자 제공) 회사는 이메일로 수신된 이용자의 개인정보를 원칙적으로 외부에 제공하지 않습니다. 다만, 아래의 경우에는 예외로 합니다.

                · 정보주체의 동의
                · 법률의 특별한 규정 등 개인정보 보호법 제17조 및 제18조에 해당하는 경우
                · 수사 목적으로 법령에 정해진 절차와 방법에 따라 수사기관의 요구가 있는 경우

                제4조(개인정보처리의 위탁) ① 개인정보처리 위탁 해당사항 없음

                ➁ 회사는 원활한 웹 사이트 운영을 위하여 다음과 같이 웹 사이트 H/W 및 S/W 유지보수를 위탁하고 있습니다.

                · 수탁업체명: 케이엘컴(ITSSUE) http://www.itssue.co.kr

                · 위탁업무: 회사 메인 웹 사이트 H/W 및 S/W 유지보수

                회사는 개인정보 처리의 위탁 시 개인정보 보호 관련 법규의 준수, 개인정보에 관한 3자 제공 금지 및 책임부담 등을 명확히 규정하여 공지사항 및 개인정보 처리방침을 통해 고지하겠습니다.

                제5조(정보주체의 권리․의무 및 행사방법)① 정보주체는 회사에 대해 언제든지 다음 각 호의 개인정보 보호 관련 권리를 행사할 수 있습니다.

                1. 개인정보 열람요구
                2. 오류 등이 있을 경우 정정 요구
                3. 삭제요구
                4. 처리정지 요구
                ② 제1항에 따른 권리 행사는 회사에 대해 서면, 전화, 전자우편, 모사전송(FAX) 등을 통하여 하실 수 있으며 회사는 이에 대해 지체없이 조치하겠습니다.
                ③ 정보주체가 개인정보의 오류 등에 대한 정정 또는 삭제를 요구한 경우에는 회사는 정정 또는 삭제를 완료할 때까지 당해 개인정보를 이용하거나 제공하지 않습니다.
                ④ 제1항에 따른 권리 행사는 정보주체의 법정대리인이나 위임을 받은 자 등 대리인을 통하여 하실 수 있습니다. 이 경우 개인정보 보호법 시행규칙 별지 제11호 서식에 따른 위임장을 제출하셔야 합니다.
                ⑤ 정보주체는 개인정보 보호법 등 관계법령을 위반하여 회사가 처리하고 있는 정보주체 본인이나 타인의 개인정보 및 사생활을 침해하여서는 아니됩니다.

                제6조(처리하는 개인정보 항목) 회사는 다음의 개인정보 항목을 처리하고 있습니다.

                · 필수항목 : 이름, 이메일, 연락처

                제7조(개인정보의 파기)
                해당사항 없음

                제8조(개인정보의 안전성 확보조치)
                해당사항 없음

                제9조(개인정보 자동 수집 장치의 설치∙운영 및 거부에 관한 사항)
                해당사항 없음

                제10조(개인정보 보호책임자) ① 회사는 개인정보 처리에 관한 업무를 총괄해서 책임지고, 개인정보 처리와 관련한 정보주체의 불만처리 및 피해구제 등을 위하여 아래와 같이 개인정보 보호책임자를 지정하고 있습니다.

                · 개인정보 보호책임자
                성명 : 관리자
                직책 : 재무관리팀장
                연락처 : 02-000-0000 camprover1@gmail.com
                ※ 개인정보 보호 담당부서로 연결됩니다.

                · 개인정보 보호 담당부서
                부서명 : 총무팀
                담당자 : 관리자
                연락처 : 02-000-0000 camprover1@gmail.com

                ② 정보주체께서는 회사의 서비스(또는 사업)을 이용하시면서 발생한 모든 개인정보 보호 관련 문의, 불만처리, 피해구제 등에 관한 사항을 개인정보 보호책임자 및 담당부서로 문의하실 수 있습니다. 회사는 정보주체의 문의에 대해 지체없이 답변 및 처리해드릴 것입니다.

                제11조(개인정보 열람청구)
                해당사항 없음

                제12조(권익침해 구제방법) 정보주체는 아래의 기관에 대해 개인정보 침해에 대한 피해구제, 상담 등을 문의하실 수 있습니다.

                <아래의 기관은 회사와는 별개의 기관으로서, 회사의 자체적인 개인정보 불만처리, 피해구제 결과에 만족하지 못하시거나 보다 자세한 도움이 필요하시면 문의하여 주시기 바랍니다>

                · 개인정보 침해신고센터 (한국인터넷진흥원 운영)
                - 소관업무 : 개인정보 침해사실 신고, 상담 신청
                - 홈페이지 : privacy.kisa.or.kr
                - 전화 : (국번없이) 118
                - 주소 : (58324) 전남 나주시 진흥길 9(빛가람동 301-2) 3층 개인정보침해신고센터

                · 개인정보 분쟁조정위원회
                - 소관업무 : 개인정보 분쟁조정신청, 집단분쟁조정 (민사적 해결)
                - 홈페이지 : www.kopico.go.kr
                - 전화 : (국번없이) 1833-6972
                - 주소 : (03171)서울특별시 종로구 세종대로 209 정부서울청사 4층

                · 대검찰청 사이버범죄수사단 : 02-3480-3573 (www.spo.go.kr)

                · 경찰청 사이버안전국 : 182 (http://cyberbureau.police.go.kr)

                제13조(개인정보 처리방침 변경)
                이 개인정보 처리방침은 2024. 03. 22부터 적용됩니다.
              </div>
            
            <div class="checkset checkset-sm">
              <input id="chk-1-3" class="checkset-input input-round" type="checkbox" value="y" name="res_can_cagree_yn">
              <label class="checkset-label" for="chk-1-3"></label>
              <span class="checkset-text">(필수) 취소 규정 동의</span>
              <div class="res_del_text">
                &nbsp;입실 14일 이내 취소시 30%만 취소되며, 입실 7일 이내는 취소되지않습니다.
              </div>
            </div>
          </div>
          <div class="contents-confirm">
              <c:if test="${res_vo.animalCmgCl eq '동행'}">
                <input type="hidden" name="animalCmgCl" value="y">
              </c:if>
              <c:if test="${res_vo.animalCmgCl eq '미동행'}">
                <input type="hidden" name="animalCmgCl" value="n">
              </c:if>
            
              <input type="hidden" name="room_name" value="${room_vo.room_name}">
              <input type="hidden" name="room_idx" value="${room_vo.room_idx}">
              <input type="hidden" name="res_checkindate" value="${res_vo.res_checkindate}">
              <input type="hidden" name="res_checkoutdate" value="${res_vo.res_checkoutdate}">
              <input type="hidden" name="res_stayday" value="${checkDays}">
              <input type="hidden" name="res_payment" value="${amount}" >
              <input type="hidden" name="facltNm" value="${camp_vo.facltNm}" >
              <input type="hidden" name="contentId" value="${camp_vo.contentId}" >
              <input type="hidden" name="bizrno" value="${camp_vo.bizrno}" >
              <input type="hidden" name="res_peopleadult" value="${res_vo.res_peopleadult}" >
              <input type="hidden" name="res_peoplechild" value="${res_vo.res_peoplechild}" >
              <input type="hidden" name="res_peopletoddler" value="${res_vo.res_peopletoddler}" >
             <!-- <input type="button" class="btnset btnset-round" onclick="payment(this.form);" value="결제하기"> -->
            
             <div class="wrapper">
              <div class="box_section" style="padding: 40px 30px 50px 30px; margin-top: 30px; margin-bottom: 50px">
                <!-- 결제 UI -->
                <div id="payment-method"></div>
                <!-- 이용약관 UI -->
                <div id="agreement"></div>
                <!-- 결제하기 버튼 -->
                <input type="button"  class="btnset btnset-round" id="payment-button" style="margin-top: 30px" disabled value="결제하기">
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <!-- [E]glamping-N37 -->
    </main>
  </form>
  </body>
  <script src="${pageContext.request.contextPath}/assets/js/toss.js"></script>

  </html>