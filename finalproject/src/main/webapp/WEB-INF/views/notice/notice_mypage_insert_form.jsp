<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
$(document).ready(function() {
    $('#summernote').summernote({
        toolbar: [
            ['style', ['style']],
            ['font', ['bold', 'underline', 'clear']],
            ['fontsize', ['fontsize']],
            ['fontname', ['fontname']],
            ['color', ['color']],
            ['para', ['ul', 'ol', 'paragraph']],
            ['table', ['table']],
            ['view', ['codeview', 'help']]
        ],
        fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','30','36','50','72'],
        callbacks: {
            onImageUpload: function(files) {

                alert('이미지는 첨부 파일로 넣어주세요');

            }
        }
    });
    
});

</script>
<script>
    function notify_insert(f){
        let not_title   = f.not_title.value.trim();
        let not_content = f.not_content.value.trim();

		let file_count = f.not_file.files.length;


		
		if (not_title == '') {
			alert("제목을 입력하세요");
			f.not_title.value = '';
			f.not_title.focus();
			return;
		}
		if (not_content == '') {
			alert("공지내용을 입력하세요");
			f.not_content.value = '';
			f.not_content.focus();
			return;
		}
		if (file_count>10) {

			return;
		}

    var formData = new FormData(f);

		$.ajax({
      type: "post",
      url: "notice_insert.do",
      data: formData,
      contentType: false,
      processData: false,
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
</head>
<body>
    <form method="post" enctype="multipart/form-data">
        <input type="hidden" name="not_public" value="0">
        <!-- [S]manager_report_one -->
        <main class="th-layout-main">
            <div id="manager_report_one">
                <div class="my_info_title">공지사항등록</div>
                <div class="table_one_detail">
                    <table class="table table_list">
                        <tr>
                          <th class="table_list_th">긴급공지여부</th>
                          <td class="table_list_td">
                            <select class="select" id="not_emergency_yn" name="not_emergency_yn">
                                <option value="y" selected>긴급공지</option>
                                <option value="n">일반공지</option>
                              </select>
                          </td>
                        </tr>
                        <tr>
                          <th class="table_list_th">공지제목</th>
                          <td class="table_list_td">
                            <input class="form-control" type="text" name="not_title" value="">
                          </td>
                        </tr>
                        <tr>
                          <th class="table_list_th">공지내용</th>
                          <td class="table_list_td"> 
                            <textarea id="summernote" name="not_content"></textarea>
                            </td>
                        </tr>
                        <tr>
                          <th class="table_list_th">파일첨부</th>
                          <td class="table_list_td">
                            <input type="file" name="not_file" multiple="multiple">
                          </td>
                        </tr>

                        <tr>
                          <td colspan="2">
                            <input type="button" class="btnset btnset-round" value="공지등록" onclick="notify_insert(this.form);">
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