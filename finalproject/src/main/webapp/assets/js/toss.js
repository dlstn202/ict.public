// 결제 위젯 로드 확인
const clientKey = "test_ck_Z61JOxRQVEmMWM6RzoRgVW0X9bAq";
const paymentWidget = PaymentWidget(clientKey, PaymentWidget.ANONYMOUS);




const paymentMethodWidget = paymentWidget.renderPaymentMethods("#payment-method", { value: valuea }, { variantKey: "DEFAULT", method: ["card"] });
paymentWidget.renderAgreement("#agreement", { variantKey: "AGREEMENT" });

const button = document.getElementById("payment-button");
paymentMethodWidget.on("ready", function () {
    button.disabled = false; // 결제 버튼 활성화
});




$("#payment-button").on("click", function () {
    var mem_email_first = $('input[name="mem_email_first"]').val();
    var mem_email_domain = $('input[name="mem_email_domain"]').val();
    var mem_email = mem_email_first+"@"+mem_email_domain;
    console.log("mem_email : "+mem_email);

    var checkbox2 = document.getElementById("chk-1-2").checked;
    var checkbox3 = document.getElementById("chk-1-3").checked;

    if (!checkbox2) {alert("개인정보 수집항목 및 이용 동의가 안됐습니다."); return;}
    if (!checkbox3) {alert("취소 규정 동의가 안됐습니다."); return;}

    var bizrno = $('input[name="bizrno"]').val();
    var contentId = $('input[name="contentId"]').val();
    var res_idx = orderId;
    var facltNm = $('input[name="facltNm"]').val();
    var res_checkindate = $('input[name="res_checkindate"]').val();
    var res_checkoutdate = $('input[name="res_checkoutdate"]').val();
    var res_stayday = $('input[name="res_stayday"]').val();
    var res_peopleadult = $('input[name="res_peopleadult"]').val();
    var res_peoplechild = $('input[name="res_peoplechild"]').val();
    var res_peopletoddler = $('input[name="res_peopletoddler"]').val();
    var animalCmgCl = $('input[name="animalCmgCl"]').val();
    var room_name = $('input[name="room_name"]').val();
    var room_idx = $('input[name="room_idx"]').val();
    var mem_name = $('input[name="mem_name"]').val();
    var mem_tel = $('input[name="mem_tel"]').val();
    
    
    var res_request = $('textarea[name="res_request"]').val();
    var res_use_agree_yn = $('input[name="res_use_agree_yn"]').val();
    var res_can_cagree_yn = $('input[name="res_can_cagree_yn"]').val();

    var res_payment = $('input[name="res_payment"]').val();


    var formData = new FormData();
    formData.append('bizrno', bizrno);
    formData.append('contentId', contentId);
    formData.append('res_idx', res_idx);
    formData.append('facltNm', facltNm);
    formData.append('res_checkindate', res_checkindate);
    formData.append('res_checkoutdate', res_checkoutdate);
    formData.append('res_stayday', res_stayday);
    formData.append('res_peopleadult', res_peopleadult);
    formData.append('res_peoplechild', res_peoplechild);
    formData.append('res_peopletoddler', res_peopletoddler);
    formData.append('animalCmgCl', animalCmgCl);
    formData.append('room_name', room_name);
    formData.append('room_idx', room_idx);
    formData.append('mem_name', mem_name);
    formData.append('mem_tel', mem_tel);
    formData.append('mem_email', mem_email);
    formData.append('res_request', res_request);
    formData.append('res_use_agree_yn', res_use_agree_yn);
    formData.append('res_can_cagree_yn', res_can_cagree_yn);
    formData.append('res_payment', res_payment);



    $.ajax({
        type: "post",
        url: "insert.do",
        data: formData,
        processData: false,
        contentType: false,
        dataType: "json",
        success: function (res_data) {
            if(res_data.result){
                var res_idx = res_data.orderId;
                var customerEmail = res_data.mem_email;
                var customerName = res_data.mem_name;
                var customerMobilePhone = res_data.mem_tel;
                paymentWidget.requestPayment({
                    orderId: res_idx,
                    orderName: orderName,
                    successUrl: successUrl,
                    failUrl: failUrl,
                    customerEmail: customerEmail,
                    customerName: customerName,
                    customerMobilePhone: customerMobilePhone
                });
            }
            if(res_data.user){
                alert("로그인이 만료됐습니다.\r로그인해주세요.");
                location.href = '../login_main.do';
            }
            if(res_data.reservation){
                alert("이미 해당기간에 예약이되어있습니다.\r다른날짜로 예약해주세요.");
                location.href = location.href;
            }
            
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.table(jqXHR)
        }
    });

   

    
});