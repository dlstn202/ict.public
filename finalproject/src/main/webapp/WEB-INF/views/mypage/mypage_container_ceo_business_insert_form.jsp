<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>Insert title here</title>
        <style>
            .contents-inner2 {padding: 2.4rem;}
            .business .radioset-input:checked+.radioset-label::before {color: rgba(var(--main-ton-down-rgb), 1);background: white;}
            .unique {display: flex; align-items: center; margin-top:15px;}
            .unique {display: flex; align-items: center; margin-top:15px;}
            .unique > ul .radioset+.radioset {margin-left: 0;}
            .business {display: flex;flex-direction: column;align-items: stretch;}
            .radioset {display: flex;align-items: center;width: auto; max-width: 200px;}
            .radioset-input { margin-right: 5px; }
            .uniquetext {flex-grow: 1;text-align: left;width: 100px;}
            .radioset-input:checked+.radioset-label {background-color: #e0e0e0;}
            .unique > ul { display: flex;flex-wrap: wrap; gap: 10px; margin-bottom: -5px;} 

            .general_review_img_x_wrap{ margin-left: 150px;}
            .general_review_img_wrap{ display: inline-block; position: relative; width: 110px; padding:0px; margin-left: 7px; margin-bottom: 10px; }
            .general_review_img_wrap>img{ width:104px; border-radius: 4px; }
            .general_review_img_wrap>button{ position: absolute; top: 3px; right: 10px; border:none; background-color: transparent; color:#fff }
            .general_reivew_photo{ display: flex;}
            .general_reivew_photo_btn{ width: 182px;margin-right: 60px; }
            .photo {display: flex;flex-direction: column;align-items: stretch; margin-top: 41px;}


        </style>
        <script>
           

        </script>
       <script>
            
            //화로대 선택값 가져오기
            $(".selectset-item-brazierCl .btn").on("click", function() {
                let selectedValue = $(this).find("span").text().trim(); // 클릭한 버튼의 텍스트 값을 가져옴
                let form = $(this).closest("form"); // 클릭한 버튼이 속한 폼을 찾음
                let targetInput = form.find("#brazierCl"); // 해당 폼 내의 특정 입력 필드를 찾음

                targetInput.val(selectedValue); // 입력 필드의 값 업데이트
               
             });
            //화로대 선택값 가져오기
            $(".selectset-item-animalCmgCl .btn").on("click", function() {
                let selectedValue = $(this).find("span").text().trim(); // 클릭한 버튼의 텍스트 값을 가져옴
                let form = $(this).closest("form"); // 클릭한 버튼이 속한 폼을 찾음
                let targetInput = form.find("#animalCmgCl"); // 해당 폼 내의 특정 입력 필드를 찾음

                targetInput.val(selectedValue); // 입력 필드의 값 업데이트
               
             });
            //체험프로그램여부 선택값 가져오기
            $(".selectset-item-exprnProgrmAt .btn").on("click", function() {
                let selectedValue = $(this).find("span").text().trim(); // 클릭한 버튼의 텍스트 값을 가져옴
                let form = $(this).closest("form"); // 클릭한 버튼이 속한 폼을 찾음
                let targetInput = form.find("#exprnProgrmAt"); // 해당 폼 내의 특정 입력 필드를 찾음

                targetInput.val(selectedValue); // 입력 필드의 값 업데이트
               
             });
     
            function insertCamp(form) {
               
                var formData = new FormData(form);
                
                $.ajax({
                    type:"POST",
                    url: "ceo_business_insert.do",
                    data: formData,
                    contentType: false,
                    processData: false,
                    success: function (res_data) {
                        alert("등록되었습니다");
                        location.href=location.href;
                    //  $("#container_content").html(res_data);
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        console.table(jqXHR)
                    }
                    });
            }    
            function checkFileType(input) {
                const file = input.files[0];
                if (file) {
                    const fileType = file.type;
                    if (!fileType.startsWith('image/')) {
                        alert('이미지 파일을 선택해주세요.');
                        input.value = ''; // 파일 선택을 취소합니다.
                    }
                }
            }
       </script>
       <script>
            $(document).ready(function(){

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
                        }else if(res_data.bizrno != res_data.bizrno1){
                            alert("필수입력칸을 모두 입력한 후 캠핑장 신청을 완료해주세요");
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

            })
       </script>
    </head>

    <body>
        <main class="th-layout-main">
            <div id="my_keep">
                <div class="my_info_title">내 캠핑장</div>
                
                <!-- [S]mypage_container_info  -->
                <div id="info_content">
                    
                    <form id="campInsert" method="post" enctype="multipart/form-data">
                        <div class="glamping-N47" data-bid="KAltwpIVGl">
                            <div class="contents-inner2">
                                <div class="contents-container container-md">
                                    <div class="contents-top">
                                        <span>* 표시는 반드시 입력하셔야 하는 항목입니다</span>
                                    </div>

                                    <div class="contents-group">
                                        <div class="business form-wrap">
                                            <h6 class="form-tit">캠핑장 등록번호<span>*</span>
                                            </h6>
                                            <div class="contents-form-group">
                                                <div class="inputset inputset-round">   
                                                    <input type="text" class="inputset-input form-control" name="contentId"
                                                        placeholder="9000~100000사이의 숫자를 입력하세요" aria-label="내용"
                                                        value="9000"
                                                        required="아이디">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="business form-wrap">
                                            <h6 class="form-tit">사업자번호<span>*</span>
                                            </h6>
                                            <div class="contents-form-group">
                                                <div class="inputset inputset-round">
                                                    <input type="text" class="inputset-input form-control" name="bizrno" id="bizrno" aria-label="사업자등록번호" required="" placeholder="-없이 입력하세요">
                                                  </div>
                                                  <input class="btnset btnset-round bizrnocheckbtn" type="button" onclick="check_bizrno();" value="사업자번호확인">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="business form-wrap">
                                            <h6 class="form-tit">관광사업자번호
                                            </h6>
                                            <div class="contents-form-group">
                                                <div class="inputset inputset-round">
                                                    <input type="text" class="inputset-input form-control"
                                                        placeholder="제 0000-0000 호" aria-label="내용"
                                                        value="" name="trsagntNo"
                                                        required="아이디">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="business form-wrap">
                                            <h6 class="form-tit">휴장시작일
                                            </h6>
                                            <div class="contents-form-group">
                                                <div class="inputset inputset-round">
                                                    <input type="text" class="inputset-input form-control"
                                                        placeholder="YYYY-MM-DD" aria-label="내용"
                                                        value=""name="hvofBgnde"
                                                        required="아이디">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="business form-wrap">
                                            <h6 class="form-tit">휴장종료일
                                            </h6>
                                            <div class="contents-form-group">
                                                <div class="inputset inputset-round">
                                                    <input type="text" class="inputset-input form-control"
                                                        placeholder="YYYY-MM-DD" aria-label="내용"
                                                        value="" name="hvofEnddle"
                                                        required="아이디">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="business form-wrap">
                                            <h6 class="form-tit">업종 <span>*</span>
                                            </h6>
                                            <div class="inputset inputset-round">
                                                <input type="text" class="inputset-input form-control" aria-label="내용"
                                                value="" name="induty"
                                                    required="">
                                            </div>
                                        </div>
                                        <div class="business form-wrap">
                                            <h6 class="form-tit">캠핑장명 <span>*</span>
                                            </h6>
                                            <div class="inputset inputset-round">
                                                <input type="text" class="inputset-input form-control" aria-label="내용"
                                                value="금쪽캠핑"name="facltNm"
                                                    required="">
                                            </div>
                                        </div>
                                        <div class="business form-wrap">
                                            <h6 class="form-tit">연락처 <span>*</span>
                                            </h6>
                                            <div class="inputset inputset-round">
                                                <input type="text" class="inputset-input form-control" aria-label="내용"
                                                value=""name="tel"
                                                    placeholder="-없이 번호를 입력해주세요" required="">
                                            </div>
                                        </div>
                                        <div class="business form-wrap">
                                            <h6 class="form-tit">주소 <span>*</span>
                                            </h6>
                                            <div class="contents-address">
                                                <div class="contents-form-group">
                                                    <div class="inputset inputset-round">
                                                        <input type="text" class="inputset-input form-control"
                                                        value="${campCeo.camps.addr1}"name="addr1"
                                                            aria-label="내용">
                                                    </div>
                                                    <input class="btnset btnset-round btnset-line" type="button"
                                                        value="우편번호 검색">
                                                </div>
                                                <div class="inputset inputset-round">
                                                    <input type="text" class="inputset-input form-control"
                                                    value=""name="addr2"
                                                        aria-label="내용" required="">
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <div class="business form-wrap">
                                            <h6 class="form-tit">한줄소개 <span>*</span>
                                            </h6>
                                            <div class="inputset inputset-round">
                                                <input type="text" class="inputset-input form-control" aria-label="내용"
                                                value=""name="lineIntro"
                                                    required="">
                                            </div>
                                        </div>
                                        <div class="business form-wrap">
                                            <h6 class="form-tit">특징 <span></span>
                                            </h6>
                                            <div class="inputset inputset-round">
                                                <input type="text" class="inputset-input form-control" aria-label="내용"
                                                value=""name="featureNm"
                                                    required="">
                                            </div>
                                        </div>
                                        <div class="business form-wrap">
                                            <h6 class="form-tit">홈페이지
                                            </h6>
                                            <div class="inputset inputset-round">
                                                <input type="text" class="inputset-input form-control" aria-label="내용"
                                                value=""name="homepage"
                                                    required="">
                                            </div>
                                        </div>
                                        <div class="business form-wrap">
                                            <h6 class="form-tit">예약구분<span style="font-size: 15px;">(, 구분 필수)</span>
                                            </h6>
                                            <div class="inputset inputset-round">
                                                <input type="text" placeholder="예시:전화,온라인예약대기,온라인실시간예약,현장" class="inputset-input form-control" aria-label="내용"
                                                value=""name="resveCl"
                                                    required="">
                                            </div>
                                        </div>
                                        <div class="business form-wrap">
                                            <h6 class="form-tit">예약페이지 <span></span>
                                            </h6>
                                            <div class="inputset inputset-round">
                                                <input type="text" class="inputset-input form-control" aria-label="내용"
                                                value=""name="resveUrl"
                                                    required="">
                                            </div>
                                        </div>

                                        <div class="business form-wrap">
                                            <h6 class="form-tit">입지구분<span style="font-size: 15px;">(, 구분 필수)</span>
                                            </h6>
                                            <div class="inputset inputset-round">
                                                <input type="text" placeholder="예시:해변,산,숲,계곡,강,호수"
                                                value=""name="lctCl"
                                                class="inputset-input form-control" aria-label="내용"
                                                    required="">
                                            </div>
                                        </div>


                                        <div class="business form-wrap">
                                            <h6 class="form-tit">주요시설(일반야영장) <span></span>
                                            </h6>
                                            <div class="inputset inputset-round">
                                                <input type="text" placeholder="숫자를 입력하세요" 
                                                value="0"name="gnrlSiteCo"
                                                class="inputset-input form-control" aria-label="내용"
                                                    required="">
                                            </div>
                                        </div>
                                        <div class="business form-wrap">
                                            <h6 class="form-tit">주요시설(자동차야영장)<span></span>
                                            </h6>
                                            <div class="inputset inputset-round">
                                                <input type="text" placeholder="숫자를 입력하세요" 
                                                value="0"name="autoSiteCo"
                                                class="inputset-input form-control" aria-label="내용"
                                                    required="">
                                            </div>
                                        </div>
                                        <div class="business form-wrap">
                                            <h6 class="form-tit">주요시설(글램핑)<span></span>
                                            </h6>
                                            <div class="inputset inputset-round">
                                                <input type="text" placeholder="숫자를 입력하세요" 
                                                value="0"name="glampSiteCo"
                                                class="inputset-input form-control" aria-label="내용"
                                                    required="">
                                            </div>
                                        </div>
                                        <div class="business form-wrap">
                                            <h6 class="form-tit">주요시설(카라반)<span></span>
                                            </h6>
                                            <div class="inputset inputset-round">
                                                <input type="text" placeholder="숫자를 입력하세요"
                                                value="0"name="caravSiteCo"
                                                 class="inputset-input form-control" aria-label="내용"
                                                    required="">
                                            </div>
                                        </div>
                                        <div class="business form-wrap">
                                            <h6 class="form-tit">내부시설(글램핑)<span style="font-size: 15px;">(, 구분 필수)</span>
                                            </h6>
                                            <div class="inputset inputset-round">
                                                <input type="text" placeholder="예시:침대,TV,에어컨,냉장고,유무선인터넷,난방기구,취사도구,내부화장실,내부샤워실" 
                                                value=""name="glampInnerFclty"
                                                class="inputset-input form-control" aria-label="내용"
                                                    required="">
                                            </div>
                                        </div>
                                        <div class="business form-wrap">
                                            <h6 class="form-tit">내부시설(카라반)<span style="font-size: 15px;">(, 구분 필수)</span>
                                            </h6>
                                            <div class="inputset inputset-round">
                                                <input type="text" placeholder="예시:침대,TV,에어컨,냉장고,유무선인터넷,난방기구,취사도구,내부화장실,내부샤워실" 
                                                value=""name="caravInnerFclty"
                                                class="inputset-input form-control" aria-label="내용"
                                                    required="">
                                            </div>
                                        </div>
                                        <div class="business form-wrap">
                                            <h6 class="form-tit">캠핑장비대여<span style="font-size: 15px;">(, 구분 필수)</span>
                                            </h6>
                                            <div class="inputset inputset-round">
                                                <input type="text" placeholder="예시:텐트,릴선,화로대,난방기구,식기,침낭" 
                                                value=""name="eqpmnLendCl"
                                                class="inputset-input form-control" aria-label="내용"
                                                    required="">
                                            </div>
                                        </div>


                                        <div class="business form-wrap">
                                            <h6 class="form-tit">화장실개수
                                            </h6>
                                            <div class="inputset inputset-round">
                                                <input type="text" class="inputset-input form-control" 
                                                value="0"name="toiletCo"
                                                aria-label="내용"
                                                    required="">
                                            </div>
                                        </div>
                                        <div class="business form-wrap">
                                            <h6 class="form-tit">샤워실개수
                                            </h6>
                                            <div class="inputset inputset-round">
                                                <input type="text" class="inputset-input form-control" 
                                                value="0"name="swrmCo"
                                                aria-label="내용"
                                                    required="">
                                            </div>
                                        </div>
                                        <div class="business form-wrap">
                                            <h6 class="form-tit">개수대개수
                                            </h6>
                                            <div class="inputset inputset-round">
                                                <input type="text" class="inputset-input form-control" 
                                                value="0"name="wtrplCo"
                                                aria-label="내용"
                                                    required="">
                                            </div>
                                        </div>
                                        <div class="business form-wrap">
                                            <h6 class="form-tit">부대시설 <span>*</span> <span style="font-size: 15px;">(, 구분 필수)</span>
                                            </h6>
                                            <div class="inputset inputset-round">
                                                <input type="text" placeholder="예시:전기,무선인터넷,장작판매,온수,트렘폴린,기타 " 
                                                value=""name="sbrsCl"
                                                class="inputset-input form-control" aria-label="내용"
                                                    required="">
                                            </div>
                                        </div>
                                        <div class="business form-wrap">
                                            <h6 class="form-tit">부대시설기타<span style="font-size: 15px;">(, 구분 필수)</span></h6>
                                            <div class="inputset inputset-round">
                                                <input type="text" placeholder="예시:음식점,영농체험장,고카트트랙 등" 
                                                value=""name="sbrsEtc"
                                                class="inputset-input form-control" aria-label="내용"
                                                    required="">
                                            </div>
                                        </div>

                                        <div class="business form-wrap">
                                            <input type="hidden" id="exprnProgrmAt" name="exprnProgrmAt" value="">
                                            <h6 class="form-tit">체험프로그램여부</h6>
                                            <div class="form-wrap"name="hvofBgnde">
                                                <div class="selectset selectset-round selectset-md">
                                                  <button class="selectset-toggle btn" type="button">
                                                    <span></span>
                                                  </button>
                                                  <ul class="selectset-list">
                                                    <li class="selectset-item-exprnProgrmAt">
                                                      <button class="selectset-y btn" type="button" >
                                                        <span>y</span>
                                                      </button>
                                                    </li>
                                                    <li class="selectset-item-exprnProgrmAt">
                                                      <button class="selectset-y btn" type="button" >
                                                        <span>n</span>
                                                      </button>
                                                    </li>
                                                  </ul>
                                                </div>
                                              </div>

                                        </div>

                                        <div class="business form-wrap">
                                            <h6 class="form-tit">체험프로그램명<span style="font-size: 15px;">(, 구분 필수)</span>
                                            </h6>
                                            <div class="inputset inputset-round">
                                                <input type="text" placeholder="예시:래프팅,영농 체험,고카트 체험 등" 
                                                value=""name="exprnProgrm"
                                                class="inputset-input form-control" aria-label="내용"
                                                    required="">
                                            </div>
                                        </div>
                                        <div class="business form-wrap">
                                            <h6 class="form-tit">테마환경<span style="font-size: 15px;">(, 구분 필수)</span>
                                            </h6>
                                            <div class="inputset inputset-round">
                                                <input type="text" placeholder="예시:일출명소,일몰명소,수상레저" 
                                                value=""name="themaEnvrnCl"
                                                class="inputset-input form-control" aria-label="내용"
                                                    required="">
                                            </div>
                                        </div>
                                        



                                        <!-- -------------------------------------------------------------------------------------------------------------------->


                                        <div class="business form-wrap">
                                            <input type="hidden"  id="brazierCl" name="brazierCl" value="">
                                            <div class="unique">
                                                <h6 class="form-tit">화로대<span>*</span></h6>
                                                <div class="form-wrap">
                                                    <div class="selectset selectset-round selectset-md">
                                                      <button class="selectset-toggle btn" type="button" id="${status.index}">
                                                        <span></span>
                                                      </button>
                                                      <ul class="selectset-list">
                                                        <li class="selectset-item-brazierCl">
                                                          <button class="selectset-y btn" type="button" >
                                                            <span>개별</span>
                                                          </button>
                                                        </li>
                                                        <li class="selectset-item-brazierCl">
                                                          <button class="selectset-y btn" type="button" >
                                                            <span>공동취사장</span>
                                                          </button>
                                                        </li>
                                                        <li class="selectset-item-brazierCl">
                                                          <button class="selectset-y btn" type="button" >
                                                            <span>불가</span>
                                                          </button>
                                                        </li>
                                                        <li class="selectset-item-brazierCl">
                                                          <button class="selectset-y btn" type="button" >
                                                            <span>기타</span>
                                                          </button>
                                                        </li>
                                                      </ul>
                                                    </div>
                                                  </div>
                                            </div>
                                        </div>

                                        <div class="business form-wrap">
                                            <input type="hidden" id="animalCmgCl" name="animalCmgCl" value="">
                                            <div class="unique">
                                                <h6 class="form-tit">애견동물출입<span>*</span></h6>
                                                <div class="form-wrap">
                                                    <div class="selectset selectset-round selectset-md">
                                                      <button class="selectset-toggle btn" type="button">
                                                        <span></span>
                                                      </button>
                                                      <ul class="selectset-list">
                                                        <li class="selectset-item-animalCmgCl">
                                                          <button class="selectset-y btn" type="button" >
                                                            <span>개별문의</span>
                                                          </button>
                                                        </li>
                                                        <li class="selectset-item-animalCmgCl">
                                                          <button class="selectset-y btn" type="button" >
                                                            <span>가능</span>
                                                          </button>
                                                        </li>
                                                        <li class="selectset-item-animalCmgCl">
                                                          <button class="selectset-y btn" type="button" >
                                                            <span>가능(소형견)</span>
                                                          </button>
                                                        </li>
                                                        <li class="selectset-item-animalCmgCl">
                                                          <button class="selectset-y btn" type="button" >
                                                            <span>불가능</span>
                                                          </button>
                                                        </li>
                                                      </ul>
                                                    </div>
                                                  </div>
                                            </div>
                                        </div>
                                        
                                        <div class="business form-wrap">
                                            
                                            <h6 class="form-tit">사이트바닥재<span style="font-size: 15px;">(숫자만 입력하세요)</span></h6>
                                            <div class="unique">
                                                <div class="form-wrap">
                                                <div class="inputset inputset-round">
                                                    <div class="site_wrap" style="display: flex; align-items: center;" >
                                                        <div class="site" style="font-size: var(--fs-p1); width: 60px; margin-right: 10px;">잔디</div>
                                                        <input type="text" placeholder="" 
                                                        value="11"name="siteBottomCl1"
                                                        class="inputset-input form-control" aria-label="내용"
                                                            required="">
                                                    </div>
                                                </div>
                                                <div class="inputset inputset-round">
                                                    <div class="site_wrap" style="display: flex; align-items: center;" >
                                                        <div class="site" style="font-size: var(--fs-p1); width: 107px; margin-left: 10px; margin-right: 10px;">파쇄석</div>
                                                        <input type="text" placeholder="" 
                                                        value="0"name="siteBottomCl2"
                                                        class="inputset-input form-control" aria-label="내용"
                                                            required="">
                                                    </div>
                                                </div>
                                                <div class="inputset inputset-round">
                                                    <div class="site_wrap" style="display: flex; align-items: center;" >
                                                        <div class="site" style="font-size: var(--fs-p1); width: 60px; margin-left: 10px; margin-right: 10px;">테크</div>
                                                        <input type="text" placeholder="" 
                                                        value="0"name="siteBottomCl3"
                                                        class="inputset-input form-control" aria-label="내용"
                                                            required="">
                                                    </div>
                                                </div>
                                                <div class="inputset inputset-round">
                                                    <div class="site_wrap" style="display: flex; align-items: center;" >
                                                        <div class="site" style="font-size: var(--fs-p1); width: 60px; margin-left: 10px; margin-right: 10px;">자갈</div>
                                                        <input type="text" placeholder="" 
                                                        value="0"name="siteBottomCl4"
                                                        class="inputset-input form-control" aria-label="내용"
                                                            required="">
                                                    </div>
                                                </div>
                                                <div class="inputset inputset-round">
                                                    <div class="site_wrap" style="display: flex; align-items: center;" >
                                                        <div class="site" style="font-size: var(--fs-p1); width: 60px; margin-left: 10px; margin-right: 10px;">맨흙</div>
                                                        <input type="text" placeholder="" 
                                                        value="0"name="siteBottomCl5"
                                                        class="inputset-input form-control" aria-label="내용"
                                                            required="">
                                                    </div>
                                                </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="photo">
                                            <h6 class="form-tit">대표이미지<span style="font-size: 15px;">(최대 20장)</span></h6>                                        
                                        </div>

                                        <div class="general_reivew_photo">
                                            <input type="file" class="general_reivew_photo_btn" name="photo"accept="image/*"  onchange="checkFileType(this)" multiple="multiple">
                                        </div>
                                        


                                    </div>
                                    <div class="contents-btn-group">
                                        <input type="button" class="btnset btnset-round"  id="btn_register"  value="등록"onclick="insertCamp(this.form)">
                                        
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
   
                </div>
                <!-- [E]mypage_container_info  -->
            </div>
        </main>
    </body>

    </html>