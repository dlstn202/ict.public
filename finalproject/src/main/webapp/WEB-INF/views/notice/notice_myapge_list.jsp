<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/notice.css">
<script>
    function notice_one(not_idx) {
      var search = $("#search_form [name=search]").val();
      var search_text = $("#search_form [name=search_text]").val();
      var page = $('.pagiset-link.active-fill').text();
        $.ajax({
            type: "GET",
            url: "notice_mypage_one.do",
            data: {"not_idx":not_idx,search:search,search_text:search_text,page:page},
            success: function (res_data) {
                $("#container_content").html(res_data);
            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.table(jqXHR)
            }
        });
    }

    function notice_register() {
      var search = $("#search_form [name=search]").val();
      var search_text = $("#search_form [name=search_text]").val();
      var page = $('.pagiset-link.active-fill').text();
      
        $.ajax({
            url: "notice_insert_form.do",
            data: {search:search,search_text:search_text,page:page},
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
  function search_now(){

    var search = $("#search_form [name=search]").val();
    var search_text = $("#search_form [name=search_text]").val();
    var page = $('.pagiset-link.active-fill').text();

    //console.log(page);


    $.ajax({
      url: "notice_myapge_list.do",
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
      url: "notice_myapge_list.do",
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
        <div id="req_content">
            <div class="my_info_title">공지사항</div>
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
          <div>
            <table class="table">
                <tr >
                    <th class="table_list_th">번호</th>
                    <th class="table_list_th">제목</th>
                    <th class="table_list_th">작성자</th>
                    <th class="table_list_th">긴급여부</th>
                    <th class="table_list_th">등록일</th>
                </tr>
                <c:forEach var="vo" items="${notice_list}">
                  <c:if test="${vo.not_del_yn eq 'y'}">
                    <tr>
                        <td class="table_list_td_idx center">${vo.not_idx}</td>
                        <td class="table_content">삭제된 공지사항 입니다.</td>
                        <td class="table_list_td name center">${vo.mem_name}</td>
                        <td class="table_list_td_yn center">${vo.not_emergency_yn}</td>
                        <td class="center table_date">${fn:substring(vo.not_regdate,0,10)}</td>
                    </tr>
                  </c:if>
                  <c:if test="${vo.not_del_yn eq 'n'}">
                    <tr class="req_list_td_wrap" onclick="notice_one('${vo.not_idx}');">
                        <td class="table_list_td_idx center">${vo.not_idx}</td>
                        <td class="table_content">${vo.not_title}</td>
                        <td class="table_list_td name center">${vo.mem_name}</td>
                        <td class="table_list_td_yn center">${vo.not_emergency_yn}</td>
                        <td class="center table_date">${fn:substring(vo.not_regdate,0,10)}</td>
                    </tr>
                  </c:if>
                </c:forEach>
                <c:if test="${empty notice_list}">
                  <tr>
                    <td class="table_list_td center" colspan="6">등록된 공지사항이 없습니다.</td>
                  </tr>
                </c:if>
                <c:if test="${page eq rastPage or rastPage eq 1}">
                  <c:forEach begin="1" end="${binPage}" step="1">
                    <tr class="row-spacing">
                      <td class="row-spacing table_list_td"colspan="5">&nbsp;</td>
                    </tr>
                  </c:forEach>
                  </c:if>
                <tr>
                  <td colspan="6 "><input type="button" class="btnset btnset-round" value="등록" onclick="notice_register();"></td>
                </tr>

            </table>
          <div>
            <nav class="pagiset pagiset-circ">
              ${pageMenu}
            </nav>      
    </main>
</body>
</html>