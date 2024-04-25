<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
  <script>
    var search_text = "${search_text}";
    var page        = $('.pagiset-link.active-fill').text();
  </script>
  <script>
    function page_move(page){

    var search_text = $("#search_form [name=search_text]").val();

    $.ajax({
      url: "notice_container.do",
      data: {search_text:search_text,page:page},
      success: function (res_data) {
        $("#notice_container").html(res_data);
        $("#search_form [name=search_text]").val(search_text);
      },
      error: function (jqXHR, textStatus, errorThrown) {
        console.table(jqXHR)
      }
    });


  }
  </script>
  <script>
      function search_now(){

      var search_text = $("#search_form [name=search_text]").val();
      var page = $('.pagiset-link.active-fill').text();

    // console.log(search_text);


      $.ajax({
        url: "notice_container.do",
        data: {search_text:search_text,page:page},
        success: function (res_data) {
          $("#notice_container").html(res_data);
          $("#search_form [name=search_text]").val(search_text);
        },
        error: function (jqXHR, textStatus, errorThrown) {
          console.table(jqXHR)
        }
      });

      }
      function handleKeyPress(event) {
	    // 엔터 키의 keyCode는 13입니다.
        if (event.keyCode === 13) {
          search_now(); // 검색 함수 호출
        }
	    }


  </script>
  <script>

function show_notice_one(not_idx) {
      
        $.ajax({
            url: "notice_show_one.do",
            data: {not_idx:not_idx,search_text:search_text,page:page},
            success: function (res_data) {
                $("#notice_container").html(res_data);
            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.table(jqXHR)
            }
        });
    }
  </script>
</head>
<body>
  <main class="th-layout-main ">


    <!-- [S]glamping-N39 -->
    <div class="glamping-N39" data-bid="sbLtwpW9GA">
      <div class="contents-inner">
        <div class="contents-container container-md">
          <div class="contents-top">
            <p class="contents-text">총 <strong>${rowTotal}</strong>개의 게시물이 있습니다.</p>
            <div class="inputset inputset-border-bottom">
              <form id="search_form" onsubmit="return false;">
                <button class="inputset-icon icon-right icon-search btn" type="button" aria-label="아이콘" onclick="search_now();"></button>
                <input type="text" class="inputset-input form-control" name="search_text" placeholder="내용을 입력하세요" aria-label="내용" onkeypress="handleKeyPress(event);">
              </form>
            </div>
          </div>
          <div class="cardset-wrap">
            <c:forEach var="vo" items="${notice_list}">
            <div class="cardset cardset-inner cardset-hover cardset-border" onclick="show_notice_one('${vo.not_idx}');">
              <div class="cardset-cont">
                
                <c:if test="${vo.not_emergency_yn eq 'n'}"><span class="badgeset badgeset-fill badgeset-round badgeset-black">공지</span></c:if>
                <c:if test="${vo.not_emergency_yn eq 'y'}"><span class="badgeset badgeset-fill badgeset-round badgeset-black emergency">긴급</span></c:if>
                
                <h5 class="cardset-tit">${vo.not_title}</h5>
                <p class="cardset-txt">${fn:substring(vo.not_regdate,0,10)}</p>
              </div>
            </div>
            </c:forEach>
            
          </div>
          <nav class="pagiset pagiset-circ">
            ${pageMenu}
          </nav>
        </div>
      </div>
    </div>
    <!-- [E]glamping-N39 -->
  </main>
    

    
</body>
</html>