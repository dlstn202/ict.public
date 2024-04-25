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
  var search = "${search}";
  var search_text = "${search_text}";
  var page = "${page}";
</script>
<script>
  function search_now(){

    var search = $("#search_form [name=search]").val();
    var search_text = $("#search_form [name=search_text]").val();
    var page = $('.pagiset-link.active-fill').text();

    //console.log(page);


    $.ajax({
      url: "answer/mypage_list.do",
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
      url: "answer/mypage_list.do",
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
<script>
  $(document).ready(function(){

    $.ajax({
      url: "answer/mypage_list_json.do",
      data: {search:search,search_text:search_text,page:page},
      dataType: "json",
      success: function (res_data) {
        res_data.forEach(function(vo) {
          var qna_idx = vo.qna_idx;

          if(vo.qna_condition == '답변대기'){
            $("#old_ans_content_"+qna_idx).css("display", "none");
            $("#btn_cancle_answer_"+qna_idx).css("display", "none");
            $("#btn_modify_form_"+qna_idx).css("display", "none");
            $("#btn_modify_"+qna_idx).css("display", "none");
          }else{
            $("#ans_content_"+qna_idx).css("display", "none");
            $("#btn_cancle_answer_"+qna_idx).css("display", "none");
            $("#btn_modify_"+qna_idx).css("display", "none");
            $("#btn_insert_"+qna_idx).css("display", "none");
          }
        });
      },
      error: function (jqXHR, textStatus, errorThrown) {
        console.table(jqXHR)
      }
    });

  })

</script>
<script>
  function insert_answer(f){
    var ans_content = f.ans_content.value.trim();
    var qna_idx = f.qna_idx.value;
    $("#btn_insert_"+qna_idx).attr("disabled",true);
    
    if(ans_content == ''){
      alert("답변 내용을 입력해주세요.");
      f.ans_content.value = '';
      f.ans_content.focus();
      $("#btn_insert_"+qna_idx).attr("disabled",false);
      return;
    }
    var formData = new FormData(f);
   
    $.ajax({
        type: "post",
        url: "answer/insert.do",
        data: formData,
        contentType: false,
        processData: false,
        success: function (res_data) {
            $("#container_content").html(res_data);
            $("#search_form [name=search]").val(search);
            $("#search_form [name=search_text]").val(search_text);
            $("#btn_insert_"+qna_idx).attr("disabled",false);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.table(jqXHR)
            $("#btn_insert_"+qna_idx).attr("disabled",false);
        }
    });
  }

  
</script>
<script>

  function modify_answer(f){
    var ans_content = f.ans_content.value.trim();
    var qna_idx = f.qna_idx.value;
    $("#btn_modify_"+qna_idx).attr("disabled",true);
    
    
    if(ans_content === ''){
      alert("답변 내용을 입력해주세요.");
      f.ans_content.value = '';
      f.ans_content.focus();
      $("#btn_modify_"+qna_idx).attr("disabled",false);
      return;
    }
    console.log(ans_content);
    var formData = new FormData(f);

    $.ajax({
        type: "post",
        url: "answer/modify.do",
        data: formData,
        contentType: false,
        processData: false,
        success: function (res_data) {
            $("#container_content").html(res_data);
            $("#search_form [name=search]").val(search);
            $("#search_form [name=search_text]").val(search_text);
            // alert("문의 답글이 정상적으로 처리됐습니다.");
            $("#btn_modify_"+qna_idx).attr("disabled",false);
          },
          error: function (jqXHR, textStatus, errorThrown) {
            // alert("문의 답글이 처리되지않았습니다.\r시스템관리자에게 문의하세요");
            $("#btn_modify_"+qna_idx).attr("disabled",false);
            console.table(jqXHR)
        }
    });
  }
</script>
<script>
  function modify_form_answer(qna_idx){
    $("#btn_modify_"+qna_idx).css("display", "");
    $("#btn_cancle_answer_"+qna_idx).css("display", "");
    $("#btn_cancle_answer_"+qna_idx).css("display", "");
    $("#ans_content_"+qna_idx).css("display", "");
    $("#btn_modify_form_"+qna_idx).css("display", "none");
    $("#old_ans_content_"+qna_idx).css("display", "none");

  }
</script>
<script>
  function cancel_modify(qna_idx){
    $("#btn_modify_"+qna_idx).css("display", "none");
    $("#btn_cancle_answer_"+qna_idx).css("display", "none");
    $("#btn_cancle_answer_"+qna_idx).css("display", "none");
    $("#ans_content_"+qna_idx).css("display", "none");
    $("#btn_modify_form_"+qna_idx).css("display", "");
    $("#old_ans_content_"+qna_idx).css("display", "");
    $("#ans_content_" + qna_idx).val($("#old_ans_content_" + qna_idx).text());

  }
</script>
<script>
  $(document).ready(function(){
    if ("${not empty bReult}" == "true") {
      if ("${bReult }" == "true"){
        alert("문의 답글이 정상적으로 처리됐습니다.");
      }else{
        alert("문의 답글이 처리되지않았습니다.\r시스템관리자에게 문의하세요");
      }
    }
    
  })
</script>
</head>
<body>
  <main class="th-layout-main">
    <div id="admin_qna">
        <div class="my_info_title">문의 답변</div>
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
    <div id="qna_list">
      <table class="table qna_list_table">
          <tr class="qna_list_th_wrap">
              <th class="qna_list_th">번호</th>
              <th class="qna_list_th">제목</th>
              <th class="qna_list_th">작성자</th>
              <th class="qna_list_th">작성일자</th>
              <th class="qna_list_th">답변상태</th>
          </tr>
          <c:forEach var="vo" items="${qna_list}">
            <tr class="qna_list_td_wrap"  data-toggle="collapse" data-target="#demo_${vo.qna_idx}">
                <td class="qna_list_td_idx">${vo.qna_idx}</td>
                <td class="qna_list_title">${vo.qna_title}</td>
                <td class="qna_list_td">${vo.qna_name}</td>
                <td class="qna_list_td">${fn:substring(vo.qna_date, 0, 10)}</td>
                <td class="qna_list_td">${vo.qna_condition}</td>
            </tr>
            <tr id="demo_${vo.qna_idx}" class="collapse">
              <td></td>
              <td colspan="4">
                <div class="qna_content">
                  <div class="qna_content_title">[상담 구분]
                    <p class="reply_inline">
                      <c:if test="${vo.qna_section eq 'reservation'}">예약문의</c:if>
                      <c:if test="${vo.qna_section eq 'cancel'}">취소문의</c:if>
                      <c:if test="${vo.qna_section eq 'dissatisfaction'}">고객불만</c:if>
                      <c:if test="${vo.qna_section eq 'etc'}">기타</c:if>
                    </p>
                  </div>
                  <div class="qna_content_title">[이&nbsp;&nbsp;메&nbsp;&nbsp;일] <p class="reply_inline">${vo.qna_email}</p></div>
                  <div class="qna_content_title">[문의 제목]</div>
                  <div class="qna_content_content">${vo.qna_title}</div>
                  <div class="qna_content_title">[문의 내용]</div>
                  <div class="qna_content_content">${vo.qna_content}</div>
                </div>
                <div class="qna_reply">
                  <div class="qna_reply_title">[답변 내용]</div>
                  <form>
                    <input type="hidden" name="page" value="${page}">
                    <input type="hidden" name="search" value="${search}">
                    <input type="hidden" name="search_text" value="${search_text}">
                    <input type="hidden" name="qna_idx" value="${vo.qna_idx}">
                    <input type="hidden" name="qna_title" value="${vo.qna_title}">
                    <input type="hidden" name="qna_date" value="${vo.qna_date}">
                    <input type="hidden" name="qna_email" value="${vo.qna_email}">
                    <input type="hidden" name="qna_name" value="${vo.qna_name}">
                    <c:if test="${not empty vo.answer.ans_idx}">
                      <input type="hidden" name="ans_idx" value="${vo.answer.ans_idx}">
                    </c:if>
                    <div class="qna_reply_content" id="old_ans_content_${vo.qna_idx}">${vo.answer.ans_content}</div>
                    <textarea id="ans_content_${vo.qna_idx}" class="qna_reply_content" rows="5" placeholder="답변 내용을 작성하세요." name="ans_content">${vo.answer.ans_content}</textarea>
                    <c:if test="${vo.qna_condition eq '답변완료'}">
                      <div class="qna_reply_title">[답변 일자]<p class="reply_inline">${vo.answer.ans_date}</p>
                        <c:if test="${vo.answer.ans_modify_yn eq 'y'}">
                          <p class="reply_inline">( 수정일자 : ${vo.answer.ans_modifydate} )</p>
                        </c:if>
                      </div>
                      <div class="qna_reply_title">[답&nbsp;&nbsp;변&nbsp;&nbsp;자]<p class="reply_inline">${vo.answer.mem_name}</p></div>
                      
                    </c:if> 
                    <input id="btn_cancle_answer_${vo.qna_idx}" class="reply_cancel_btn" type="button" value=" 취소 " onclick = "cancel_modify('${vo.qna_idx}');">
                    <input id="btn_modify_form_${vo.qna_idx}" class="reply_btn" type="button" value=" 답변수정 " onclick="modify_form_answer('${vo.qna_idx}');" >
                    <input id="btn_modify_${vo.qna_idx}" class="reply_btn" type="button" value=" 답변수정 " onclick="modify_answer(this.form)" >
                    <input id="btn_insert_${vo.qna_idx}" class="reply_btn" type="button" value=" 답변작성 " onclick="insert_answer(this.form);" >
                  </form>
                </div>
                
              </td>
              
            </tr>
          </c:forEach>
          
          
      </table>
      
    <div>
      <nav class="pagiset pagiset-circ">
        ${pageMenu}
        
      </nav>  
  </main> 
    
</body>
</html>