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
    function res_del(res_idx,dday){

        if(dday<=14){
            if(confirm("입실 14일 이내입니다.\r결제금액의 30%만 환불됩니다.\r정말 취소하시겠습니까?")==false) return;
        }

        if(confirm("정말 취소하시겠습니까?")==false) return;

        $.ajax({
            type: "post",
            url: "reservation/cancle.do",
            data: {"res_idx":res_idx,"dday":dday},
            dataType: "json",
            success: function (res_data) {
                if(res_data.result){
                    alert("취소가 완료되었습니다.");
                }else{
                    alert("취소가 되지않았습니다.\r관리자에게 문의바랍니다.");
                }
                location.href = location.href;
            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.table(jqXHR)
            }
        });
    }
</script>
</head>
<body>
    <main class="th-layout-main">
        <!-- [S]my_reserve  -->
        <div id="my_reserve">
            <div class="my_info_title">예약 내역</div>
            <div class="my_reserve_list">
                <c:if test="${empty res_list}">예약 내역이 없습니다.</c:if>
                <c:forEach var="vo" items="${res_list}">
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
                                <div class="reserve_title" ><p onclick="location.href='detail_main.do?contentId=${vo.contentId}'">${vo.facltNm}</p></div>
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
                                    <c:if test="${vo.dday > 7  and vo.res_can_yn eq 'n' and vo.res_check eq 'n'}">
                                        <div ><input class="res_del" type="button" value="예약취소" onclick="res_del('${vo.res_idx}','${vo.dday}')"></div>
                                    </c:if>
                                    <c:if test="${7 >= vo.dday}">
                                        <div class="res_del_text">입실 7일전 부터는 예약취소가 불가합니다.</div>
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
        </div>
        <!-- [E]my_reserve  -->
    </main>
</body>
</html>