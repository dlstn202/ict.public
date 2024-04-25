<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
  
<meta charset="UTF-8">
<title>Insert title here</title>

<script>
  // 문의 내역
  function inquiry_insertform(){
        $.ajax({
            url: "qna_container.do",
            data:{"mypage":"mypage"},
            success: function (res_data) {
                $("#container_content").html(res_data);
                changeLiColor();
                $("#inquiry").css("color", "#00AF52");
                $.getScript("${pageContext.request.contextPath}/assets/js/domain.js");
                $(".glamping-N42 .contents-inner").css("padding","0");
            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.table(jqXHR)
            }
        });
    }

</script>
<script>
  function search_now(){

    var search = $("#search_form [name=search]").val();
    var search_text = $("#search_form [name=search_text]").val();
    var page = $('.pagiset-link.active-fill').text();

    //console.log(page);


    $.ajax({
      url: "qna_mypage_list_general_ceo.do",
      data: {search:search,search_text:search_text,page:page},
      success: function (res_data) {
        $("#container_content").html(res_data);
        $("#search_form [name=search]").val(search);
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

  function page_move(page){
    var search = $("#search_form [name=search]").val();
    var search_text = $("#search_form [name=search_text]").val();

    $.ajax({
      url: "qna_mypage_list_general_ceo.do",
      data: {search:search,search_text:search_text,page:page},
      success: function (res_data) {
        $("#container_content").html(res_data);
        $("#search_form [name=search]").val(search);
        $("#search_form [name=search_text]").val(search_text);
      },
      error: function (jqXHR, textStatus, errorThrown) {
        console.table(jqXHR)
      }
    });


  }


</script>
<script>
  //전체보기면 검색어 지우기
  if("${search eq 'all' or empty search}" == "true"){
			$("#search_text").val("");
			$("#search_text").attr("readonly", "readonly");

		}
		
		
		$("#search").change(function() {
			
			if ($("#search").val() == "all") {
			
				$("#search_text").val("");
				$("#search_text").attr("readonly", "readonly");
			
			}else {
                // 다른 옵션이 선택되면 input 타입을 text로 변경
                $("#search_text").removeAttr("readonly");
                $("#search_text").attr("type", "text");
                $("#search_text").val("${search_text eq 'null' ? '' :search_text }");
      }
		});
</script>
</head>
<body>
  <main class="th-layout-main">
    <div id="my_inquiry">
        <div class="my_info_title">문의내역</div>
    </div>
    <form id="search_form" onsubmit="return false;">
      <div class="search_wrap">
        <select  class="search_inquiry" name="search" id="search">
          <option value="all">전체보기</option>
          <option value="name">이름</option>
          <option value="subject">제목</option>
          <option value="content">내용</option>
          <option value="subject_content">제목+내용</option>
        </select>
        <div class="inputset inputset-border-bottom">
          <button class="inputset-icon icon-right icon-search btn" type="button" onclick="search_now();" ></button>
          <input type="text" id="search_text" name="search_text" class="inputset-input form-control" placeholder="내용을 입력하세요" onkeypress="handleKeyPress(event);">
        </div>
            <!-- <input class="search_text" placeholder="검색어를 입력하세요">
        <div ><i class="fa-solid fa-magnifying-glass" style="color: #003a1b;"></i></div> -->
      </div>
    </form> 
    <div id="inquiry_list">
      <table class="table inquiry_table">
          <tr class="inquiry_list_th_wrap">
              <th class="inquiry_list_th">번호</th>
              <th class="inquiry_list_th">제목</th>
              <th class="inquiry_list_th">작성일자</th>
              <th class="inquiry_list_th">답변상태</th>
          </tr>
          <c:if test="${empty qna_list}">
            <tr class="table_list_tr">
              <td class="table_list_td center" colspan="4">등록된 문의가 없습니다.</td>
          </tr>
          </c:if>
          <c:forEach var="vo" items="${qna_list}">
            <tr class="table_list_tr" data-toggle="collapse" data-target="#demo_${vo.qna_idx}" >
                <td class="inquiry_list_td_idx">${vo.qna_idx}</td>
                <td class="inquiry_list_title">${vo.qna_title}</td>
                <td class="inquiry_list_td">${fn:substring(vo.qna_date,0,10)}</td>
                <td class="inquiry_list_td">${vo.qna_condition}</td>
            </tr>
            <tr id="demo_${vo.qna_idx}" class="collapse">
              <td class="space"></td>
              <td colspan="3">
                <div class="inquiry_content">
                  <div class="inquiry_content_title">[상담구분]</div>
                  <div class="inquiry_content_content">${vo.qna_section}</div>
                  <div class="inquiry_content_title">[문의제목]</div>
                  <div class="inquiry_content_content">${vo.qna_title}</div>
                  <div class="inquiry_content_title">[문의내용]</div>
                  <div class="inquiry_content_content">${vo.qna_content}</div>
                </div>
                <c:if test="${vo.qna_condition eq '답변완료'}">
                  <div class="inquiry_reply">
                    <div class="inquiry_reply_title">[답변내용]</div>
                    <div class="inquiry_reply_content">${vo.answer.ans_content}</div>
                    <div class="inquiry_reply_title">[답변자]</div>
                    <div class="inquiry_reply_content">${vo.answer.mem_name}</div>
                    <div class="inquiry_reply_title">[답변일자]</div>
                    <div class="inquiry_reply_content">${fn:substring(vo.answer.ans_date,0,10)}</div>
                  </div>
                </c:if>
              </td>
            </tr>
          </c:forEach>

          
      </table>
      <div class="inquiry_insert_wrap" >
        <div class="inquiry_insert " onclick="inquiry_insertform();">
           문의작성  
        </div>
      </div>
    <div>
      <nav class="pagiset pagiset-circ">
          ${pageMenu}
      </nav>  
  </main> 
    
</body>
</html>