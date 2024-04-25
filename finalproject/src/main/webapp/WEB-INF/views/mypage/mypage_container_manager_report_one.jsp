<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
 function report_send(f){
    $.ajax({
      type: "GET",
      url: "mypage_container_manager_report_send.do",
      data: "data",
      success: function (res_data) {
        $("#container_content").html(res_data);
      },
      error: function (jqXHR, textStatus, errorThrown) {
        console.table(jqXHR)
      }
    });
 }
 function report_list(f){
    $.ajax({
      type: "GET",
      url: "mypage_container_manager_report.do",
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
    <!-- [S]manager_report_one -->
    <main class="th-layout-main">
        <div id="manager_report_one">
            <div class="my_info_title">신고 상세 내역</div>
            <div class="table_one_detail">
                <table class="table table_list">
                    <tr>
                      <th class="table_list_th">신고 번호</th>
                      <td class="table_list_td">1</td>
                    </tr>
                    <tr>
                      <th class="table_list_th">리뷰(캠핑장)번호</th>
                      <td class="table_list_td">2</td>
                    </tr>
                    <tr>
                      <th class="table_list_th">리뷰내용</th>
                      <td class="table_list_td">adf</td>
                    </tr>
                    <tr>
                      <th class="table_list_th">신고유형</th>
                      <td class="table_list_td">adf</td>
                    </tr>
                    <tr>
                      <th class="table_list_th">신고내용</th>
                      <td class="table_list_td">이러한 내용때문에 신고했습니다.</td>
                    </tr>
                    <tr>
                      <th class="table_list_th">신고일자</th>
                      <td class="table_list_td">2024-03-25</td>
                    </tr>
                    <tr>
                      <th class="table_list_th">신고자</th>
                      <td class="table_list_td">금쪽이</td>
                    </tr>
                    <tr>
                      <th class="table_list_th">처리내역</th>
                      <td class="table_list_td">
                        <select class="select" id="notify_result" name="notify_result">
                          <option value="wait" selected>처리대기</option>
                          <option value="companion">신고반려</option>
                          <option value="processed_hide_review">신고수리:댓글숨김</option>
                          <option value="processed_ceo">신고수리:캠핑장경고</option>
                        </select>
                      </td>
                    </tr>
                    <tr>
                      <th class="table_list_th">처리사유</th>
                      <td class="table_list_td">
                        <textarea name="" id="" cols="30" rows="10" placeholder="처리사유를 입력하세요."></textarea>
                      </td>
                    </tr>
                    <tr>
                      <td colspan="2">
                        <input type="button" class="btnset btnset-round" value="저장" onclick="report_send(this.form);">
                        <input type="button" class="btnset btnset-round btnset-line" value="뒤로가기" onclick="report_list(this.form);">
                      </td>
                    </tr>
                   
                </table>
            </div>
        </div>
    </main>
  </form>

    
    <!-- [E]manager_report_one -->
</body>
</html>