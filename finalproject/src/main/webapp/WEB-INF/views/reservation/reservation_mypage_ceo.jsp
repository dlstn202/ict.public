<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <!-- core JSTL -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %><!-- fmt JSTL -->
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> <!-- functions JSTL -->

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
    $(document).ready(function(){
        $(".detail").css("display","none");
        $(".hide_detail_reserve").css("display","none");
    })
</script>
<script>
    function show_detail_reserve(res_idx){
        $("#"+res_idx).css("height","33rem");
        $("#"+res_idx+" .detail").css("display","");
        $("#"+res_idx+" .hide_detail_reserve").css("display","");
        $("#"+res_idx+" .show_detail_reserve").css("display","none");

    }

    function hide_detail_reserve(res_idx){
        $("#"+res_idx).css("height","23rem");
        $("#"+res_idx+" .detail").css("display","none");
        $("#"+res_idx+" .hide_detail_reserve").css("display","none");
        $("#"+res_idx+" .show_detail_reserve").css("display","");
    }
</script>
<script>
    $(document).ready(function () {
        var id = document.querySelectorAll('[class="my_reserve_list"]')[0].id;
        updateInfo(id); // 여기서 '0'은 첫 번째 캠핑장 정보에 해당하는 옵션의 value 값의 숫자 부분입니다.
    });
    function updateInfo(selectedValue) {
        // 모든 폼을 숨깁니다.
        var room_list = document.querySelectorAll('[class="my_reserve_list"]');
        room_list.forEach(function(form) {
            form.style.display = 'none';
        });
        
        // 선택된 캠핑장에 해당하는 폼만 보이도록 합니다.
        // 여기서 selectedValue는 option의 value 속성을 기반으로 하는데,
        // 실제 value와 form ID 사이에 일관된 매핑이 필요합니다.
        var selectedFormId = selectedValue;
        var selectedForm = document.getElementById(selectedFormId);
        if (selectedForm) {
            selectedForm.style.display = 'flex';            
        }
    }
</script>
</head>
<body>
    <main class="th-layout-main">
        <!-- [S]my_reserve  -->
        <div id="my_reserve">
            <div class="my_info_title">예약 내역</div>
            <div class="room_search">
                <select class="search_inquiry" name="search" id="search" onchange="updateInfo(this.value)">
                    <c:forEach items="${user.camp_ceo_list}" var="campCeoList" varStatus="status">
                        <option value="${campCeoList.bizrno}">${campCeoList.bizrno}</option>
                    </c:forEach>                     
                </select>
            </div>
            <c:forEach var="camp_vo" items="${camp_list}">
                <div class="my_reserve_list" id="${camp_vo.bizrno}">
                    <c:forEach var="vo" items="${camp_vo.res_list}">
                        <div class="reserve_box" id="${vo.res_idx}">
                            <table class="reserve_info_idx">
                                <tr>
                                    <th>예약번호 :</th>
                                    <td>${vo.res_idx}</td>
                                    <th>예약일자 :</th>
                                    <td>${vo.res_date}</td>
                                </tr>
                            </table>

                            <div class="reserve_box_content">
                                <div class="reserve_info">
                                    <div class="reserve_title"><p  onclick="location.href='detail_main.do?contentId=${vo.contentId}'">${vo.facltNm}</p></div>
                                    <div class="reserve_detailed">
                                        <div class="reserve_date">
                                            <div class="reserve_date_to">${vo.res_checkindate} ~ ${vo.res_checkoutdate}</div>
                                            <div class="reserve_date_str">${vo.res_stayday}박</div>
                                        </div>
                                        <div class="reserve_room">${vo.room_name}</div>
                                        <div class="reserve_guest">
                                            <c:if test="${not empty vo.res_peopleadult}">성인 ${vo.res_peopleadult}명</c:if>
                                            <c:if test="${not empty vo.res_peoplechild}">소인 ${vo.res_peoplechild}명</c:if>
                                            <c:if test="${not empty vo.res_peopletoddler}">유아 ${vo.res_peopletoddler}명</c:if>
                                        </div>
                                        
                                    </div>
                                    <div class="detail">
                                        <div class="reserve_name">예약자명 : ${vo.mem_name}</div>
                                        <div class="reserve_tel">전화번호 : ${vo.mem_tel}</div>
                                        <div class="reserve_pay">결제방법 : ${vo.res_payment_type}</div>
                                        <div class="reserve_amount">결제금액 : <fmt:formatNumber value="${vo.res_payment}" type="number" maxFractionDigits="3"  />원(공급가액 : <fmt:formatNumber value="${vo.res_supply_price}" type="number" maxFractionDigits="3"  />원, 부 가 세 : <fmt:formatNumber value="${vo.res_vat}" type="number" maxFractionDigits="3"  />원)</div>
                                        <c:if test="${vo.res_can_yn eq 'y'}">
                                            <div class="reserve_amount res_del_text">취소금액 : <fmt:formatNumber value="${vo.res_can_payment}" type="number" maxFractionDigits="3"  />원(공급가액 : <fmt:formatNumber value="${vo.res_can_supply_price}" type="number" maxFractionDigits="3"  />원, 부 가 세 : <fmt:formatNumber value="${vo.res_can_vat}" type="number" maxFractionDigits="3"  />원)</div>
                                        </c:if>
                                        
                                    </div>
                                    <div class="reserve_detailed_pay">
                                        <div onclick="show_detail_reserve('${vo.res_idx}');" class="show_detail_reserve">자세히보기</div>
                                        <div onclick="hide_detail_reserve('${vo.res_idx}');" class="hide_detail_reserve">닫기</div>
                                        <div>${vo.res_payment_result}
                                            <c:if test="${vo.res_can_yn eq 'n' and vo.res_check eq 'n'}">(입실전)</c:if>
                                            <c:if test="${vo.res_can_yn eq 'n' and vo.res_check eq 'y'}">(투숙완료)</c:if>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                    </div>
                </div>  
            </c:forEach>
        </div>
        <!-- [E]my_reserve  -->
    </main>
</body>
</html>