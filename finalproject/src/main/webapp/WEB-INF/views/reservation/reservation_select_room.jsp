<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <!-- core JSTL -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %><!-- fmt JSTL -->
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> <!-- functions JSTL -->
  
<!DOCTYPE html>
  <html>

  <head>
    <meta charset="UTF-8">
    <title>캠프로버</title>
  </head>
  <script>
    $(document).ready(function () {
            var id = document.querySelectorAll('[class="photo"]')[0].id;
            updateInfo(id); // 여기서 '0'은 첫 번째 캠핑장 정보에 해당하는 옵션의 value 값의 숫자 부분입니다.
        });
        function updateInfo(selectedValue) {
          // 모든 폼을 숨깁니다.
          var room_list = document.querySelectorAll('[class="photo"]');
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
              // console.log("#"+selectedFormId);
              
          }

          $.ajax({
            url: "date.do",
            data:{"room_idx":selectedValue,"bizrno":"${bizrno}"},
            success: function (res_data) {
                $("#reservation_container_date").html(res_data);
                $.getScript("${pageContext.request.contextPath}/assets/js/domain.js");
                // $.getScript("${pageContext.request.contextPath}/assets/js/script.js");

            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.table(jqXHR)
            }
          });
          
        }
  </script>
  <body>

  <main class="th-layout-main ">
    <!-- [S]glamping-N45 -->
    <div class="glamping-N45">
      <div class="contents-inner">
        <div class="contents-container container-md">
          <div class="textset">
            <h2 class="textset-tit">예약날짜</h2>
          </div>
          <ul class="contents-list">
            <li class="contents-item item-active">
              <span>1</span>
            </li>
            <li class="contents-item ">
              <span>2</span>
            </li>
            <li class="contents-item" >
              <span>3</span>
            </li>
          </ul>
        </div>
      </div>

    </div>
    <!-- [E]glamping-N45 -->
  </main>
  <div>
    <div class="contents-inner padding_t_b_no">
      <div class="contents-container container-md">
        <div class="select_room">
          <div>객실 선택</div>
          <select class="search_inquiry" name="search" id="search" onchange="updateInfo(this.value)">
            <c:forEach items="${list}" var="vo" varStatus="status">
                <option value="${vo.room_idx}">${vo.room_name}</option>
            </c:forEach>                     
          </select>
        </div>
        <c:forEach items="${list}" var="vo" varStatus="status">
          <div class="photo" id="${vo.room_idx}">
            <c:if test="${empty vo.photo_list}">
              등록된 객실 사진이 없습니다.
            </c:if>
            <c:forEach var="photo_vo" items="${vo.photo_list}">
              <img src="${pageContext.request.contextPath}/room_photo_upload/${photo_vo.pho_name}">
            </c:forEach>
          </div>
        </c:forEach>   
        
      </div>
    </div>
  </div>

  </body>

  </html>