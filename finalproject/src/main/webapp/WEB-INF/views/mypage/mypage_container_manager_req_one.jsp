<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
 function req_send(f){
    $.ajax({
      type: "GET",
      url: "mypage_container_manager_req_send.do",
      data: "data",
      success: function (res_data) {
        $("#container_content").html(res_data);
      },
      error: function (jqXHR, textStatus, errorThrown) {
        console.table(jqXHR)
      }
    });
 }
 function req_list(f){
    $.ajax({
      type: "GET",
      url: "mypage_container_manager_req_content.do",
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
  <form>
    <main class="th-layout-main">
        <div id="manager_table_one">
            <div class="my_info_title">캠핑장 신청 내역</div>
            <div class="table_one_detail">
                <table class="table table_list">
                    <tr>
                      <th class="table_list_th">사업자등록번호</th>
                      <td class="table_list_td">000-00-00000</td>
                    </tr>
                    <tr>
                      <th class="table_list_th">업종</th>
                      <td class="table_list_td">업종</td>
                    </tr>
                    <tr>
                      <th class="table_list_th">가게명</th>
                      <td class="table_list_td">가게명</td>
                    </tr>
                    <tr>
                      <th class="table_list_th">연락처</th>
                      <td class="table_list_td">연락처</td>
                    </tr>
                    <tr>
                      <th class="table_list_th">주소</th>
                      <td class="table_list_td">주소주소</td>
                    </tr>
                    <tr>
                      <th class="table_list_th">가게소개</th>
                      <td class="table_list_td">가게소개가게소개</td>
                    </tr>
                    <tr>
                      <th class="table_list_th">홈페이지</th>
                      <td class="table_list_td">홈페이지</td>
                    </tr>
                    <tr>
                      <th class="table_list_th">입지구분</th>
                      <td class="table_list_td">입지구분</td>
                    </tr>
                    <tr>
                      <td colspan="2">
                        <input type="button" class="btnset btnset-round" value="저장" onclick="req_send(this.form);">
                        <input type="button" class="btnset btnset-round btnset-line" value="뒤로가기" onclick="req_list(this.form);">
                      </td>
                    </tr>
                   
                </table>
            </div>
        </div>
    </main>
  </form>

</body>
</html>