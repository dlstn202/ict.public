<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>Insert title here</title>
        <script>
            $(document).ready(function(){
                $('.inputset-input').keyup(function(event) {
                    // 사용자 입력값을 숫자만 포함하도록 필터링
                    var value = $(this).val().replace(/,/g, '').replace(/\D/g, '');
                    // 숫자에 콤마를 추가
                    var formattedValue = value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                    // 콤마가 추가된 문자열로 입력값을 업데이트
                    $(this).val(formattedValue);
                });
            });
        </script>
        <script>
            function insert(f){

                var room_idx = f.room_idx.value;
                var fee_weekend_yn = f.fee_weekend_yn.value;
                var fee_peak_yn = f.fee_peak_yn.value;
                var fee_adult = f.fee_adult.value.replace(",","");
                var fee_child = f.fee_child.value.replace(",","");
                var fee_infant = f.fee_infant.value.replace(",","");


                $.ajax({
                    url: "fee/insert.do",
                    data: {"room_idx": room_idx,"fee_weekend_yn":fee_weekend_yn,
                            "fee_peak_yn":fee_peak_yn,"fee_adult":fee_adult,"fee_child":fee_child,
                            "fee_infant":fee_infant
                            },
                    success: function (res_data) {
                        $("#container_content").html(res_data);
                        
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        console.table(jqXHR)
                    }
                });

                // f.action="fee/insert.do";
                // f.submit();


            }
        </script>
    </head>

    <body>
        <main class="th-layout-main">
            <div id="my_room">
                <div class="my_info_title">요금등록</div>   
                <!-- [S]mypage_container_ceo_business_room_insertform  -->
                <div id="info_content">
                    <form id="form_insert">
                        <input type="hidden" name="room_idx" value="${room_idx}">
                        <div class="glamping-N47" data-bid="KAltwpIVGl">
                            <div class="contents-inner2">
                                <div class="contents-container container-md">
                                    <div class="contents-top">
                                        <span>* 표시는 반드시 입력하셔야 하는 항목입니다</span>
                                    </div>
                                    <div class="contents-group">
                                        <div class="roomform form-wrap">
                                            <div class="unique_room">
                                                <h6 class="form-tit">주말여부<span>*</span></h6>
                                                <ul class="room radioset-wrap">
                                                    <li class="radioset">
                                                        <input id="radio1" name="fee_weekend_yn" class="radioset-input input-line" type="radio" value="n" checked>
                                                        <label class="radioset-label" for="radio1"></label>
                                                        <span class="seoson radioset-text">평일</span>
                                                        
                                                    </li>
                                                    <li class="radioset">
                                                        <input id="radio2" name="fee_weekend_yn" class="radioset-input input-line" type="radio" value="y">
                                                        <label class="radioset-label" for="radio2"></label>
                                                        <span class="seoson radioset-text">주말</span>
                                                        
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                        <div class="roomform form-wrap">
                                            <div class="unique_room">
                                                <h6 class="form-tit">성수기여부<span>*</span></h6>
                                                <ul class="room radioset-wrap">
                                                    <li class="radioset">
                                                        <input id="radioset-c-3" name="fee_peak_yn" class="radioset-input input-line" type="radio" value="y" checked>
                                                        <label class="radioset-label" for="radioset-c-3"></label>
                                                        <span class="seoson radioset-text">성수기</span>
                                                        
                                                    </li>
                                                    <li class="radioset">
                                                        <input id="radioset-c-4" name="fee_peak_yn" class="radioset-input input-line" type="radio" value="n" >
                                                        <label class="radioset-label" for="radioset-c-4"></label>
                                                        <span class="seoson radioset-text">비성수기</span>
                                                        
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                     
                                        <div class="fee roomform form-wrap">
                                            <div class="unique_room">
                                                <h6 class="form-tit">이용요금(성인) <span>*</span>
                                                </h6>
                                                <div class="feeset1 inputset inputset-round">
                                                    <input type="text" class="feeinput inputset-input form-control" name="fee_adult">
                                                </div>
                                                <div class="won">원</div>
                                            </div>
                                        </div>
                                        <div class="fee roomform form-wrap">
                                            <div class="unique_room">
                                                <h6 class="form-tit">이용요금(소인) <span>*</span>
                                                </h6>
                                                <div class="feeset1 inputset inputset-round">
                                                    <input type="text" class="feeinput inputset-input form-control" name="fee_child">
                                                </div>
                                                <div class="won">원</div>
                                            </div>
                                        </div>
                                        <div class="fee roomform form-wrap">
                                            <div class="unique_room">
                                                <h6 class="form-tit">이용요금(유아) <span>*</span>
                                                </h6>
                                                <div class="feeset1 inputset inputset-round">
                                                    <input type="text" class=" feeinput inputset-input form-control" name="fee_infant">
                                                </div>
                                                <div class="won">원</div>
                                            </div>
                                       
                                    </div>
                                    <div class="contents-btn-group">
                                        <input type="button" class="btnset btnset-round" value="등록" onclick="insert(this.form)">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
                <!-- [E]mypage_container_ceo_business_room_insertform  -->
            </div>
        </main>
    </body>

    </html>