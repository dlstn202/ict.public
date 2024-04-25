<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Document</title>
            <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script> -->
            <script>
                $(document).ready(function () {
                    $('.sido_select_box').click(function () {
                        // 모든 .sido_select_box 요소에서 'active' 클래스 제거 후 현재 요소에만 추가

                        $('.sido_select_box').removeClass('active');
                        $(this).addClass('active');

                        // 클릭된 요소의 텍스트 가져오기(숫자는 제거후)
                        var selectedSido = $(this).clone().children().remove().end().text().trim();

                        // 구/군 목록을 담을 변수 초기화
                        var guListHtml = '<div class="gu_select_box">전체<span></span></div>';
                        <c:forEach var="vo" items="${listsi}" varStatus="i">
                            if ("${vo.doNm}" === selectedSido) {
                                guListHtml += '<div class="gu_select_box">${vo.sigunguNm}<span>(${vo.si_count})</span></div>'
                            }
                        </c:forEach>

                        // 구/군 선택 시 (동적으로 추가되므로 이벤트 위임 사용)
                        $(document).on('click', '.gu_select_box', function () {
                            $('.gu_select_box').removeClass('active');
                            $(this).addClass('active');
                        });


                        // 확인 버튼 클릭 이벤트
                        $('#local_ok').click(function () {
                            // 현재 활성화된 시/도와 구/군의 정보 가져오기
                            var doNm = $('.sido_select_box.active').clone().children().remove().end().text().trim();
 
                            var sigunguNm = $('.gu_select_box.active').text().trim();

                            // // 숫자와 괄호를 제거 (옵션)
                            sigunguNm = sigunguNm.replace(/\(\d+\)/, '').trim();

                            var form = document.createElement("form");

                            // 폼 속성 설정
                            form.setAttribute("method", "get");
                            form.setAttribute("action", "info_main.do");

                            // 입력 필드 생성 및 설정
                            var inputField = document.createElement("input");
                            inputField.setAttribute("type", "hidden");
                            inputField.setAttribute("name", "doNm");
                            inputField.setAttribute("value", doNm);

                            var inputField2 = document.createElement("input");
                            inputField2.setAttribute("type", "hidden");
                            inputField2.setAttribute("name", "sigunguNm");
                            inputField2.setAttribute("value", sigunguNm);

                           // 입력 필드를 폼에 추가
                            form.appendChild(inputField);
                            form.appendChild(inputField2);

                           
                            document.body.appendChild(form);

                            // 폼 제출
                            form.submit();
 


                        });

                        // .gu_select_list의 내용을 새로운 목록으로 업데이트
                        $('.gu_select_list').html(guListHtml);

                        $('.gu_select_box:first').addClass('active');

                        // 새로운 구/군 박스에 대해서도 클릭 이벤트 핸들러 설정
                        $('.gu_select_box').click(function () {
                            $('.gu_select_box').removeClass('active');
                            $(this).toggleClass('active');
                        });
                    });


                    //그전 페이지로 돌아가는 함수
                    $(document).ready(function () {
                        $('#local_cancel').click(function () {
                            window.location.href = "info_main.do" + "?doNm=" + encodeURIComponent('${doNm}') + "&sigunguNm=" + encodeURIComponent('${sigunguNm}');
                        });

                    });
                });


            </script>
            <script>
                $(document).ready(function(){
                    $("#local_filter_form[name=doNm]").val(doNm);
                    $("#local_filter_form[name=sigunguNm]").val(sigunguNm);
                    console.log("doNm : "+doNm);
                    console.log("sigunguNm : "+sigunguNm);
                })
            </script>
        </head>

        <body>
            <form id="local_filter_form">
                <div class="sido_select">
                    <form>
                        <input type="hidden" name="doNm" value="${doNm}">
                        <input type="hidden" name="sigunguNm" value="${sigunguNm}">
                        <div id="local_cancel"><i class="fa-solid fa-xmark" style="color: #00391c;"></i></div>
                    </form>
                    <div id="local_button">지역선택</div>
                    <div id="local_ok"><i id="local_ok_con" class="fa-solid fa-check"></i> 확인</div>
                    
                </div>
                <div class="local_select">
                    <div class="sido_wrap">
                        <div class="sido_title">시/도</div>
                        <div class="sido_select_list">
                            <c:forEach var="vo" items="${listdo}" varStatus="i">
                                <div class="sido_select_box">
                                    ${vo.doNm}<span>(${vo.count})</span>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                    <div class="gu_wrap">
                        <div class="gu_title">구/군</div>
                        <div class="gu_select_list">
                        </div>
                    </div>
                </div>
            </form>
        </body>

        </html>