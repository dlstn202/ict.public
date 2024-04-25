<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>Insert title here</title>
        <script>
            $(document).ready(function(){
                var fee_weekend_yn = "${fee_weekend_yn}";
                var fee_peak_yn = "${fee_peak_yn}";

                $("#form_modify [name=fee_weekend_yn][value='" + fee_weekend_yn + "']").prop('checked', true);
                $("#form_modify [name=fee_peak_yn][value='" + fee_peak_yn + "']").prop('checked', true);

            })
        </script>
        <script>
            function back(f){
                var room_idx = f.room_idx.value;

                if(confirm("내용이 저장되지않습니다.\r뒤로가시겠습니까?") == false) return;

                $.ajax({
                    url: "fee/list.do",
                    data: {"room_idx": room_idx},
                    success: function (res_data) {
                        $("#container_content").html(res_data);
                        
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        console.table(jqXHR)
                    }
                });
            }
        </script>
        <script>
            function del(f){
                var fee_idx = f.fee_idx.value;
                var room_idx = f.room_idx.value;

                if(confirm("삭제하시겠습니까?") == false) return;

                $.ajax({
                    url: "fee/delete.do",
                    data: {"fee_idx": fee_idx,"room_idx": room_idx},
                    success: function (res_data) {
                        $("#container_content").html(res_data);
                        
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        console.table(jqXHR)
                    }
                });
            }
        </script>
        <script>
            function modify(f){

                var fee_idx = f.fee_idx.value;
                var room_idx = f.room_idx.value;
                var fee_weekend_yn = f.fee_weekend_yn.value;
                var fee_peak_yn = f.fee_peak_yn.value;
                var fee_adult = f.fee_adult.value;
                var fee_child = f.fee_child.value;
                var fee_infant = f.fee_infant.value;

                if(confirm("수정하시겠습니까?") == false) return;

                $.ajax({
                    url: "fee/modify.do",
                    data: {"fee_idx":fee_idx,"room_idx": room_idx,"fee_weekend_yn":fee_weekend_yn,
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
                <div class="my_info_title">요금정보수정</div>   
                <!-- [S]mypage_container_ceo_business_room_insertform  -->
                <div id="info_content">
                    <form id="form_modify">
                        <input type="hidden" name="room_idx" value="${vo.room_idx}">
                        <input type="hidden" name="fee_idx" value="${vo.fee_idx}">
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
                                                        <input id="radio1" name="fee_weekend_yn" class="radioset-input input-line" type="radio" value="n" >
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
                                                        <input id="radioset-c-3" name="fee_peak_yn" class="radioset-input input-line" type="radio" value="y" >
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
                                                    <input type="text" class="feeinput inputset-input form-control" name="fee_adult" value="${vo.fee_adult}">
                                                </div>
                                                <div class="won">원</div>
                                            </div>
                                        </div>
                                        <div class="fee roomform form-wrap">
                                            <div class="unique_room">
                                                <h6 class="form-tit">이용요금(소인) <span>*</span>
                                                </h6>
                                                <div class="feeset1 inputset inputset-round">
                                                    <input type="text" class="feeinput inputset-input form-control" name="fee_child" value="${vo.fee_child}">
                                                </div>
                                                <div class="won">원</div>
                                            </div>
                                        </div>
                                        <div class="fee roomform form-wrap">
                                            <div class="unique_room">
                                                <h6 class="form-tit">이용요금(유아) <span>*</span>
                                                </h6>
                                                <div class="feeset1 inputset inputset-round">
                                                    <input type="text" class=" feeinput inputset-input form-control" name="fee_infant" value="${vo.fee_infant}">
                                                </div>
                                                <div class="won">원</div>
                                            </div>
                                       
                                    </div>
                                    <div class="contents-btn-group">
                                        <input type="button" class="btnset btnset-round" value="수정" onclick="modify(this.form)">
                                        <input type="button" class="btnset btnset-round del" value="삭제" onclick="del(this.form)">
                                        <input type="button" class="btnset btnset-line btnset-round " value="뒤로가기" onclick="back(this.form)">
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