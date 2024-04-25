<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>Insert title here</title>
        <script>
            $(document).ready(function () {
                // 예약가능여부 선택 이벤트 핸들러 등록
                $('#ynSelect1 .selectset-n').on('click', function () {
                    // 선택된 값(y 또는 n)의 data-value 값을 가져옵니다.
                    var selectedValue = $(this).data('value');

                    // 선택된 값을 input type="hidden"에 설정합니다.
                    $("#y").val(selectedValue);

                    // 선택된 옵션을 버튼의 텍스트로 표시(옵션)
                    $(".selectset-toggle span").text($(this).text());
                });

                // 체험프로그램여부 선택 이벤트 핸들러 등록
                $('#proSelect1 .selectset-y').on('click', function () {
                    // 선택된 값(y 또는 n)의 data-value 값을 가져옵니다.
                    var selectedValue = $(this).data('value');

                    // 선택된 값을 input type="hidden"에 설정합니다.
                    $("#n").val(selectedValue);

                    // 선택된 옵션을 버튼의 텍스트로 표시(옵션)
                    $(".selectset-toggle span").text($(this).text());
                });
            });
        </script>
        <style>
            .contents-inner2 {padding: 2.4rem;}
.business .radioset-input:checked+.radioset-label::before {color: rgba(var(--main-ton-down-rgb), 1);background: white;}
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
.general_reivew_photo{ display: flex;
  justify-content: flex-end;  }
.general_reivew_photo_btn{ width: 182px;margin-right: 60px; }
.photo {display: flex;flex-direction: column;align-items: stretch; margin-top: 41px;}

/* .stop.inputset.inputset-round{
  width: 150px;

} */




        </style>
<script>
    
</script>
    </head>

    <body>
        <main class="th-layout-main">
            <div id="ceo_camp">
                <div class="my_info_title">캠핑장수정</div>
                <!-- [S]mypage_container_info  -->
                <div id="info_content">
                    <form>
                        <div class="glamping-N47" data-bid="KAltwpIVGl">
                            <div class="contents-inner2">
                                <div class="contents-container container-md">
                                    <div class="contents-top">
                                        <span>* 표시는 반드시 입력하셔야 하는 항목입니다</span>
                                    </div>

                                    <div class="contents-group">
                                        <div class="business form-wrap">
                                            <h6 class="form-tit">사업자번호<span>*</span>
                                            </h6>
                                            <div class="contents-form-group">
                                                <div class="inputset inputset-round">
                                                    <input type="text" class="inputset-input form-control"
                                                        placeholder="000-00-00000 형식으로 입력하세요" aria-label="내용"
                                                        required="아이디">
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
                                                        required="아이디">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="business form-wrap">
                                            <h6 class="form-tit">업종 <span>*</span>
                                            </h6>
                                            <div class="inputset inputset-round">
                                                <input type="text" class="inputset-input form-control" aria-label="내용"
                                                    required="">
                                            </div>
                                        </div>
                                        <div class="business form-wrap">
                                            <h6 class="form-tit">캠핑장명 <span>*</span>
                                            </h6>
                                            <div class="inputset inputset-round">
                                                <input type="text" class="inputset-input form-control" aria-label="내용"
                                                    required="">
                                            </div>
                                        </div>
                                        <div class="business form-wrap">
                                            <h6 class="form-tit">연락처 <span>*</span>
                                            </h6>
                                            <div class="inputset inputset-round">
                                                <input type="text" class="inputset-input form-control" aria-label="내용"
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
                                                            aria-label="내용">
                                                    </div>
                                                    <input class="btnset btnset-round btnset-line" type="button"
                                                        value="우편번호 검색">
                                                </div>
                                                <div class="inputset inputset-round">
                                                    <input type="text" class="inputset-input form-control"
                                                        aria-label="내용" required="">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="business form-wrap">
                                            <h6 class="form-tit">캠핑장소개 <span>*</span>
                                            </h6>
                                            <div class="inputset inputset-round">
                                                <input type="text" class="inputset-input form-control" aria-label="내용"
                                                    required="">
                                            </div>
                                        </div>
                                        <div class="business form-wrap">
                                            <h6 class="form-tit">한줄소개 <span>*</span>
                                            </h6>
                                            <div class="inputset inputset-round">
                                                <input type="text" class="inputset-input form-control" aria-label="내용"
                                                    required="">
                                            </div>
                                        </div>
                                        <div class="business form-wrap">
                                            <h6 class="form-tit">특징 <span></span>
                                            </h6>
                                            <div class="inputset inputset-round">
                                                <input type="text" class="inputset-input form-control" aria-label="내용"
                                                    required="">
                                            </div>
                                        </div>
                                        <div class="business form-wrap">
                                            <h6 class="form-tit">홈페이지
                                            </h6>
                                            <div class="inputset inputset-round">
                                                <input type="text" class="inputset-input form-control" aria-label="내용"
                                                    required="">
                                            </div>
                                        </div>
                                        <div class="business form-wrap">
                                            <h6 class="form-tit">예약구분<span style="font-size: 15px;">(, 구분 필수)</span>
                                            </h6>
                                            <div class="inputset inputset-round">
                                                <input type="text" placeholder="예시:전화,온라인예약대기,온라인실시간예약,현장" class="inputset-input form-control" aria-label="내용"
                                                    required="">
                                            </div>
                                        </div>
                                        <div class="business form-wrap">
                                            <h6 class="form-tit">예약페이지 <span></span>
                                            </h6>
                                            <div class="inputset inputset-round">
                                                <input type="text" class="inputset-input form-control" aria-label="내용"
                                                    required="">
                                            </div>
                                        </div>

                                        <div class="business form-wrap">
                                            <h6 class="form-tit">입지구분<span style="font-size: 15px;">(, 구분 필수)</span>
                                            </h6>
                                            <div class="inputset inputset-round">
                                                <input type="text" placeholder="예시:해변,산,숲,계곡,강,호수" class="inputset-input form-control" aria-label="내용"
                                                    required="">
                                            </div>
                                        </div>


                                        <div class="business form-wrap">
                                            <h6 class="form-tit">주요시설(일반야영장) <span></span>
                                            </h6>
                                            <div class="inputset inputset-round">
                                                <input type="text" placeholder="숫자를 입력하세요" class="inputset-input form-control" aria-label="내용"
                                                    required="">
                                            </div>
                                        </div>
                                        <div class="business form-wrap">
                                            <h6 class="form-tit">주요시설(자동차야영장)<span></span>
                                            </h6>
                                            <div class="inputset inputset-round">
                                                <input type="text" placeholder="숫자를 입력하세요" class="inputset-input form-control" aria-label="내용"
                                                    required="">
                                            </div>
                                        </div>
                                        <div class="business form-wrap">
                                            <h6 class="form-tit">주요시설(글램핑)<span></span>
                                            </h6>
                                            <div class="inputset inputset-round">
                                                <input type="text" placeholder="숫자를 입력하세요" class="inputset-input form-control" aria-label="내용"
                                                    required="">
                                            </div>
                                        </div>
                                        <div class="business form-wrap">
                                            <h6 class="form-tit">주요시설(카라반)<span></span>
                                            </h6>
                                            <div class="inputset inputset-round">
                                                <input type="text" placeholder="숫자를 입력하세요" class="inputset-input form-control" aria-label="내용"
                                                    required="">
                                            </div>
                                        </div>
                                        <div class="business form-wrap">
                                            <h6 class="form-tit">내부시설(글램핑)<span style="font-size: 15px;">(, 구분 필수)</span>
                                            </h6>
                                            <div class="inputset inputset-round">
                                                <input type="text" placeholder="예시:침대,TV,에어컨,냉장고,유무선인터넷,난방기구,취사도구,내부화장실,내부샤워실" class="inputset-input form-control" aria-label="내용"
                                                    required="">
                                            </div>
                                        </div>
                                        <div class="business form-wrap">
                                            <h6 class="form-tit">내부시설(카라반)<span style="font-size: 15px;">(, 구분 필수)</span>
                                            </h6>
                                            <div class="inputset inputset-round">
                                                <input type="text" placeholder="예시:침대,TV,에어컨,냉장고,유무선인터넷,난방기구,취사도구,내부화장실,내부샤워실" class="inputset-input form-control" aria-label="내용"
                                                    required="">
                                            </div>
                                        </div>
                                        <div class="business form-wrap">
                                            <h6 class="form-tit">캠핑장비대여<span style="font-size: 15px;">(, 구분 필수)</span>
                                            </h6>
                                            <div class="inputset inputset-round">
                                                <input type="text" placeholder="예시:텐트,릴선,화로대,난방기구,식기,침낭" class="inputset-input form-control" aria-label="내용"
                                                    required="">
                                            </div>
                                        </div>


                                        <div class="business form-wrap">
                                            <h6 class="form-tit">화장실개수
                                            </h6>
                                            <div class="inputset inputset-round">
                                                <input type="text" class="inputset-input form-control" aria-label="내용"
                                                    required="">
                                            </div>
                                        </div>
                                        <div class="business form-wrap">
                                            <h6 class="form-tit">샤워실개수
                                            </h6>
                                            <div class="inputset inputset-round">
                                                <input type="text" class="inputset-input form-control" aria-label="내용"
                                                    required="">
                                            </div>
                                        </div>
                                        <div class="business form-wrap">
                                            <h6 class="form-tit">개수대개수
                                            </h6>
                                            <div class="inputset inputset-round">
                                                <input type="text" class="inputset-input form-control" aria-label="내용"
                                                    required="">
                                            </div>
                                        </div>
                                        <div class="business form-wrap">
                                            <h6 class="form-tit">부대시설 <span>*</span> <span style="font-size: 15px;">(, 구분 필수)</span>
                                            </h6>
                                            <div class="inputset inputset-round">
                                                <input type="text" placeholder="예시:전기,무선인터넷,장작판매,온수,트렘폴린,물놀이장,놀이터,산책로,운동장,운동시설,마트.편의점,덤프스테이션,기타 " class="inputset-input form-control" aria-label="내용"
                                                    required="">
                                            </div>
                                        </div>
                                        <div class="business form-wrap">
                                            <h6 class="form-tit">부대시설기타<span style="font-size: 15px;">(, 구분 필수)</span></h6>
                                            <div class="inputset inputset-round">
                                                <input type="text" placeholder="예시:음식점,영농체험장,카페,펜,작은도서관,포토존스튜디오,고카트트랙 등" class="inputset-input form-control" aria-label="내용"
                                                    required="">
                                            </div>
                                        </div>

                                        <div class="business form-wrap">
                                            <h6 class="form-tit">체험프로그램여부</h6>
                                            <div class="contents-prefer">
                                              <div class="contents-form-group">
                                                <div class="selectset selectset-round selectset-md">
                                                  <button class="selectset-toggle btn" type="button">
                                                    <span>선택하세요</span>
                                                  </button>
                                                  <ul class="selectset-list" id="proSelect1">
                                                      <li class="selectset-item">
                                                        <button class="selectset-y btn" type="button" data-value="y">
                                                            <span>y</span>
                                                        </button>
                                                      </li>
                                                      <li class="selectset-item">
                                                        <button class="selectset-y btn" type="button" data-value="n">
                                                            <span>n</span>
                                                        </button>
                                                      </li>
                                                  </ul>
                                                  <input type="hidden" id="n" name="n" value="">
                                                </div>
                                              </div>
                                            </div>
                                        </div>

                                        <div class="business form-wrap">
                                            <h6 class="form-tit">체험프로그램명<span style="font-size: 15px;">(, 구분 필수)</span>
                                            </h6>
                                            <div class="inputset inputset-round">
                                                <input type="text" placeholder="예시:래프팅,영농 체험,고카트 체험,갯벌 체험,커피체험 등" class="inputset-input form-control" aria-label="내용"
                                                    required="">
                                            </div>
                                        </div>
                                        <div class="business form-wrap">
                                            <h6 class="form-tit">테마환경<span style="font-size: 15px;">(, 구분 필수)</span>
                                            </h6>
                                            <div class="inputset inputset-round">
                                                <input type="text" placeholder="예시:일출명소,일몰명소,수상레저,낚시,액티비티,봄꽃여행,여름물놀이,가을단풍명소,겨울눈꽃명소,걷기길" class="inputset-input form-control" aria-label="내용"
                                                    required="">
                                            </div>
                                        </div>
                                        



                                        <!-- -------------------------------------------------------------------------------------------------------------------->


                                        <div class="business form-wrap">
                                            <div class="unique">
                                                <h6 class="form-tit">화로대<span>*</span></h6>
                                                <ul class="radioset-wrap">
                                                    <li class="radioset">
                                                        <input id="radioset-b-10" name="radioset-b"
                                                            class="radioset-input input-line" type="radio" value=""
                                                            >
                                                        <label class="radioset-label" for="radioset-b-10"></label>
                                                        <span class="uniquetext radioset-text">개별</span>
                                                    </li>
                                                    <li class="radioset">
                                                        <input id="radioset-b-11" name="radioset-b"
                                                            class="radioset-input input-line" type="radio" value=""
                                                            >
                                                        <label class="radioset-label" for="radioset-b-11"></label>
                                                        <span class="uniquetext radioset-text">공동취사장</span>
                                                    </li>
                                                    <li class="radioset">
                                                        <input id="radioset-b-12" name="radioset-b"
                                                            class="radioset-input input-line" type="radio" value=""
                                                            >
                                                        <label class="radioset-label" for="radioset-b-12"></label>
                                                        <span class="uniquetext radioset-text">기타</span>
                                                    </li>
                                                    <li class="radioset">
                                                        <input id="radioset-b-13" name="radioset-b"
                                                            class="radioset-input input-line" type="radio" value=""
                                                            >
                                                        <label class="radioset-label" for="radioset-b-13"></label>
                                                        <span class="uniquetext radioset-text">불가</span>
                                                    </li>

                                                </ul>
                                            </div>
                                        </div>

                                        <div class="business form-wrap">
                                            <div class="unique">
                                                <h6 class="form-tit">애견동물출입<span>*</span></h6>
                                                <ul class="radioset-wrap">
                                                    <li class="radioset">
                                                        <input id="radioset-c-10" name="radioset-c"
                                                            class="radioset-input input-line" type="radio" value=""
                                                           >
                                                        <label class="radioset-label" for="radioset-c-10"></label>
                                                        <span class="uniquetext radioset-text">개별문의</span>
                                                    </li>
                                                    <li class="radioset">
                                                        <input id="radioset-c-11" name="radioset-c"
                                                            class="radioset-input input-line" type="radio" value=""
                                                            >
                                                        <label class="radioset-label" for="radioset-c-11"></label>
                                                        <span class="uniquetext radioset-text">가능</span>
                                                    </li>
                                                    <li class="radioset">
                                                        <input id="radioset-c-12" name="radioset-c"
                                                            class="radioset-input input-line" type="radio" value=""
                                                            >
                                                        <label class="radioset-label" for="radioset-c-12"></label>
                                                        <span class="uniquetext radioset-text">가능(소형견)</span>
                                                    </li>
                                                    <li class="radioset">
                                                        <input id="radioset-c-13" name="radioset-c"
                                                            class="radioset-input input-line" type="radio" value=""
                                                            >
                                                        <label class="radioset-label" for="radioset-c-13"></label>
                                                        <span class="uniquetext radioset-text">불가능</span>
                                                    </li>

                                                </ul>
                                            </div>
                                        </div>
                                        <div class="business form-wrap">
                                            <div class="unique">
                                                <h6 class="form-tit">사이트바닥재</h6>
                                                <ul class="radioset-wrap">
                                                    <li class="radioset">
                                                        <input id="radioset-b-1" name="radioset-b"
                                                            class="radioset-input input-line" type="checkbox" value=""
                                                          >
                                                        <label class="radioset-label" for="radioset-b-1"></label>
                                                        <span class="uniquetext radioset-text">잔디</span>
                                                    </li>
                                                    <li class="radioset">
                                                        <input id="radioset-b-2" name="radioset-b"
                                                            class="radioset-input input-line" type="checkbox" value="">
                                                        <label class="radioset-label" for="radioset-b-2"></label>
                                                        <span class="uniquetext radioset-text">파쇄석</span>
                                                    </li>
                                                    <li class="radioset">
                                                        <input id="radioset-b-3" name="radioset-b"
                                                            class="radioset-input input-line" type="checkbox" value="">
                                                        <label class="radioset-label" for="radioset-b-3"></label>
                                                        <span class="uniquetext radioset-text">테크</span>
                                                    </li>
                                                    <li class="radioset">
                                                        <input id="radioset-b-4" name="radioset-b"
                                                            class="radioset-input input-line" type="checkbox" value="">
                                                        <label class="radioset-label" for="radioset-b-4"></label>
                                                        <span class="uniquetext radioset-text">자갈</span>
                                                    </li>
                                                    <li class="radioset">
                                                        <input id="radioset-b-5" name="radioset-b"
                                                            class="radioset-input input-line" type="checkbox" value="">
                                                        <label class="radioset-label" for="radioset-b-5"></label>
                                                        <span class="uniquetext radioset-text">맨흙</span>
                                                    </li>
                                                    <li class="radioset">
                                                        <input id="radioset-b-6" name="radioset-b"
                                                            class="radioset-input input-line" type="checkbox" value="">
                                                        <label class="radioset-label" for="radioset-b-6"></label>
                                                        <span class="uniquetext radioset-text">툴팁</span>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>

                                        <div class="photo">
                                            <h6 class="form-tit">대표이미지<span style="font-size: 15px;">(최대 20장)</span></h6>
                                            <div class="general_review_img_x_wrap">

                                                <div class="general_review_img_wrap">
                                                    <img src="${pageContext.request.contextPath}/assets/img/sample/img_glamping_N5_1.png">
                                                    <button>X</button>
                                                </div>
                                                <div class="general_review_img_wrap">
                                                    <img src="${pageContext.request.contextPath}/assets/img/sample/img_glamping_N5_1.png">
                                                    <button>X</button>
                                                </div>
                                                <div class="general_review_img_wrap">
                                                    <img src="${pageContext.request.contextPath}/assets/img/sample/img_glamping_N5_1.png">
                                                    <button>X</button>
                                                </div>
                                                <div class="general_review_img_wrap">
                                                    <img src="${pageContext.request.contextPath}/assets/img/sample/img_glamping_N5_1.png">
                                                    <button>X</button>
                                                </div>
                                                <div class="general_review_img_wrap">
                                                    <img src="${pageContext.request.contextPath}/assets/img/sample/img_glamping_N5_1.png">
                                                    <button>X</button>
                                                </div>
                                                <div class="general_review_img_wrap">
                                                    <img src="${pageContext.request.contextPath}/assets/img/sample/img_glamping_N5_1.png">
                                                    <button>X</button>
                                                </div>
                                                <div class="general_review_img_wrap">
                                                    <img src="${pageContext.request.contextPath}/assets/img/sample/img_glamping_N5_1.png">
                                                    <button>X</button>
                                                </div>
                                                <div class="general_review_img_wrap">
                                                    <img src="${pageContext.request.contextPath}/assets/img/sample/img_glamping_N5_1.png">
                                                    <button>X</button>
                                                </div>
                                                <div class="general_review_img_wrap ">
                                                    <img src="${pageContext.request.contextPath}/assets/img/sample/img_glamping_N5_1.png">
                                                    <button>X</button>
                                                </div>
                                                <div class="general_review_img_wrap ">
                                                    <img src="${pageContext.request.contextPath}/assets/img/sample/img_glamping_N5_1.png">
                                                    <button>X</button>
                                                </div>
                                                <div class="general_review_img_wrap ">
                                                    <img src="${pageContext.request.contextPath}/assets/img/sample/img_glamping_N5_1.png">
                                                    <button>X</button>
                                                </div>
                                                <div class="general_review_img_wrap ">
                                                    <img src="${pageContext.request.contextPath}/assets/img/sample/img_glamping_N5_1.png">
                                                    <button>X</button>
                                                </div>
                                                <div class="general_review_img_wrap ">
                                                    <img src="${pageContext.request.contextPath}/assets/img/sample/img_glamping_N5_1.png">
                                                    <button>X</button>
                                                </div>
                                                <div class="general_review_img_wrap ">
                                                    <img src="${pageContext.request.contextPath}/assets/img/sample/img_glamping_N5_1.png">
                                                    <button>X</button>
                                                </div>
                                                <div class="general_review_img_wrap ">
                                                    <img src="${pageContext.request.contextPath}/assets/img/sample/img_glamping_N5_1.png">
                                                    <button>X</button>
                                                </div>
 

                                            </div>
                                        </div>

                                        <div class="general_reivew_photo">
                                            <input type="file" class="general_reivew_photo_btn" name="photo">
                                        </div>

                                        <div class="business form-wrap">
                                            <h6 class="form-tit">예약가능여부</h6>
                                            <div class="contents-prefer">
                                              <div class="contents-form-group">
                                                <div class="selectset selectset-round selectset-md">
                                                  <button class="selectset-toggle btn" type="button">
                                                    <span>선택하세요</span>
                                                  </button>
                                                  <ul class="selectset-list" id="ynSelect1">
                                                      <li class="selectset-item">
                                                        <button class="selectset-n btn" type="button" data-value="y">
                                                            <span>y</span>
                                                        </button>
                                                      </li>
                                                      <li class="selectset-item">
                                                        <button class="selectset-n btn" type="button" data-value="n">
                                                            <span>n</span>
                                                        </button>
                                                      </li>
                                                  </ul>
                                                  <input type="hidden" id="y" name="y" value="">
                                                </div>
                                              </div>
                                            </div>
                                          </div>

                                      <div class="business form-wrap">
                                        <h6 class="form-tit">예약불가마지막일자
                                        </h6>
                                        <div class="stop inputset inputset-round">
                                            <input type="text" class="inputset-input form-control" aria-label="내용"
                                            placeholder="YYYY-MM-DD"  required="">
                                        </div>
                                    </div>

                                        


                                    </div>
                                    <div class="contents-btn-group">
                                        <input type="button" class="btnset btnset-round" value="수정">
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