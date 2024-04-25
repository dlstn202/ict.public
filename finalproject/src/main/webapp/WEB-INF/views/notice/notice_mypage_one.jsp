<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>

  var search = "${search}";
  var search_text = "${search_text}";
  var page = "${page}";


 function not_modify_form(not_idx){
    $.ajax({
      type: "post",
      url: "notice_modify_form.do",
      data: {"not_idx":not_idx,search:search,search_text:search_text,page:page},
      success: function (res_data) {
        $("#container_content").html(res_data);
      },
      error: function (jqXHR, textStatus, errorThrown) {
        console.table(jqXHR)
      }
    });
 }
 function not_del(not_idx){
    if(confirm("정말 삭제하시겠습니까?")==false) return;

    $.ajax({
      url: "notice_delete.do",
      data: {"not_idx":not_idx,search:search,search_text:search_text,page:page},
      success: function (res_data) {
        $("#container_content").html(res_data);
      },
      error: function (jqXHR, textStatus, errorThrown) {
        console.table(jqXHR)
      }
    });
 }
 function notice_list(){
    $.ajax({
      type: "GET",
      url: "notice_myapge_list.do",
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
  function download(file_name) {
		//alert(g_p_filename+"파일 다운로드...");
		
		//alert('안녕/'+encodeURIComponent('안녕'));
		//안녕/%EC%95%88%EB%85%95 이렇게 0xEc 0x95 이렇게 16진수로 넘어감
		
		location.href="FileDownload.do?dir=/notice_file_upload/&filename="+encodeURIComponent(file_name,"utf-8");
	}
</script>
</head>
<body>
  <form>
    <main class="th-layout-main">
        <div id="manager_table_one">
            <div class="my_info_title">공지사항 상세</div>
            <div class="table_one_detail">
                <table class="table table_list">
                    <tr>
                      <th class="table_list_th">번호</th>
                      <td class="table_list_td">${notice_vo.not_idx}</td>
                    </tr>
                    <tr>
                      <th class="table_list_th">긴급공지여부</th>
                      <td class="table_list_td">${notice_vo.not_emergency_yn}</td>
                    </tr>
                    <tr>
                      <th class="table_list_th">제목</th>
                      <td class="table_list_td">${notice_vo.not_title}</td>
                    </tr>
                    <tr>
                      <th class="table_list_th">내용</th>
                      <td class="table_list_td">${notice_vo.not_content}</td>
                    </tr>
                    <tr>
                      <th class="table_list_th">첨부파일</th>
                      <td class="table_list_td">
                        <c:if test="${empty notice_vo.file_list}">등록된 첨부파일이 없습니다.</c:if>
                        <c:if test="${not empty notice_vo.file_list}">
                            <c:forEach var="vo" items="${notice_vo.file_list}">
                              <input class="btn_none" type="button" onclick="download('${vo.file_name}')" value="${vo.file_name}"><br>
                            </c:forEach>
                        </c:if>
                      </td>
                    </tr>
                    <tr>
                      <th class="table_list_th">작성자</th>
                      <td class="table_list_td">${notice_vo.mem_name}</td>
                    </tr>
                    <tr>
                      <th class="table_list_th">작성일자</th>
                      <td class="table_list_td">${notice_vo.not_regdate}</td>
                    </tr>
                    <tr>
                      <th class="table_list_th">수정여부</th>
                      <td class="table_list_td">${notice_vo.not_modify_yn}</td>
                    </tr>
                    <c:if test="${not empty notice_vo.not_modifydate}">
                      <tr>
                        <th class="table_list_th">수정일자</th>
                        <td class="table_list_td">${notice_vo.not_modifydate}</td>
                      </tr>
                    </c:if>

                    <tr>
                      <td colspan="2">
                        <input type="button" class="btnset btnset-round" value="수정" onclick="not_modify_form('${notice_vo.not_idx}');">
                        <input type="button" class="btnset btnset-round" value="삭제" onclick="not_del('${notice_vo.not_idx}');">
                        <input type="button" class="btnset btnset-round btnset-line" value="뒤로가기" onclick="notice_list();">
                      </td>
                    </tr>
                   
                </table>
            </div>
        </div>
    </main>
  </form>

</body>
</html>