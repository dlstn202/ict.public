<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %><!-- fmt JSTL -->

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
    $(document).ready(function(){
        if("${not empty fee_no}" == "true" && "${fee_no}" == "true"){
            alert("동일한 조건의 요금을 등록할 수 없습니다.");
        }
        if("${not empty modify_no}" == "true" && "${modify_no}" == "true"){
            alert("동일한 조건의 요금이있습니다.\r수정에 실패했습니다.");
        }
        if("${not empty fee_del}" == "true" && "${fee_del}" == "true"){
            alert("삭제됐습니다.");
        }
        if("${not empty fee_del}" == "true" && "${fee_del}" == "false"){
            alert("삭제에 실패했습니다.\r관리자에게 문의바랍니다.");
        }
        if("${not empty room_result}" == "true" && "${room_result}" == "true"){
            alert("요금이 등록됐습니다.");
        }
    })
</script>
<script>
            // 요금등록
            function fee_insert_form(){
                $.ajax({
                    url: "fee/insert_form.do",
                    data:{"room_idx":"${room_idx}"},
                    success: function (res_data) {
                        $("#container_content").html(res_data);
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        console.table(jqXHR)
                    }
                });
            }       
            // 요금수정
            function fee_modify_form(fee_idx){
                $.ajax({
                    url: "fee/modify_form.do",
                    data:{"fee_idx":fee_idx},
                    success: function (res_data) {
                        $("#container_content").html(res_data);
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
        <div id="fee_content">
            <div class="my_info_title">요금내역</div>
            <div class="my_info_title2">성수기/비성수기/주말/평일에 해당하는 요금을 모두 등록하셔야 예약이 가능합니다.</div>
        </div>
        <form action="">
          <div class="search_wrap">
            <c:if test="${fee_full ne 'true'}">
                <input class="memberlist_btn" type="button" onclick="fee_insert_form();" value="요금등록">
            </c:if>
          </div>
        </form> 
          <div>
            <table class="table fee_list_table">
              <tr class="fee_list_th_wrap">
                  <th class="center">요금번호</th>
                  <th class="center">성수기여부</th>
                  <th class="center">주말여부</th>
                  <th class="center">성인요금</th>
                  <th class="center">소인요금</th>
                  <th class="center">유아요금</th>
                  <th class="center"></th>
              </tr>
              
              <c:forEach var="vo" items="${fee_list}">
                <tr class="fee_list_td_wrap">
                    <td class="center">${vo.fee_idx}</td>
                    <td class="center">
                        <c:if test="${vo.fee_peak_yn eq 'y'}">성수기</c:if>
                        <c:if test="${vo.fee_peak_yn eq 'n'}">비성수기</c:if>
                    </td>  
                    <td class="center">
                        <c:if test="${vo.fee_weekend_yn eq 'y'}">주말</c:if>
                        <c:if test="${vo.fee_weekend_yn eq 'n'}">평일</c:if>
                    </td>
                    <td class="center"><fmt:formatNumber value="${vo.fee_adult}" type="number" maxFractionDigits="3"  />원</td>
                    <td class="center"><fmt:formatNumber value="${vo.fee_child}" type="number" maxFractionDigits="3" />원</td>
                    <td class="center"><fmt:formatNumber value="${vo.fee_infant}" type="number" maxFractionDigits="3" />원</td>
                    <td class="memberlist_td_btn"><input class="memberlist_btn" type="button" onclick="fee_modify_form('${vo.fee_idx}');" value="수정하기"></td>
                    
                </tr>
              </c:forEach>
              <c:if test="${empty fee_list}">
                <tr class="fee_list_td_wrap">
                  <td class="center" colspan="8">등록된 요금이 없습니다. 요금을 등록해주세요</td>
                </tr>
              </c:if>                
            </table>
        </div>
        
    </main>
</body>
</html>