<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/notice.css">
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
	           ['fontsize',['fontsize']],
	           ['fontname', ['fontname']],
	           ['color', ['color']],
	           ['para', ['ul', 'ol', 'paragraph']],
	           ['table', ['table']],
	           ['view', [ 'codeview', 'help']]
	         ],
	         fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','30','36','50','72']
        });
});
</script>
<script>
    function notify_modify(f){
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

      alert("첨부파일은 10개까지만 가능합니다");
			return;
		}

    var formData = new FormData(f);

    formData.append('search', search);
    formData.append('search_text', search_text);
    formData.append('page', page);

    $.ajax({
            type: "post",
            url: "notice_modify.do",
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
  function back_notice_one(not_idx) {
        $.ajax({
            type: "post",
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
</script>
<script>
  function del_file(index){

    if(confirm("정말 삭제하시겠습니까?\n수정하기를 눌러주셔야 수정됩니다.")==false) return;

    var file_idx = "file_"+index;
    var file_name = "file_name_"+index;
    var file_name_a = "file_name_a_"+index;

    $("#"+file_idx).removeAttr('name');
    $("#"+file_name).hide();
    $("#"+file_name_a).hide();

  }

</script>

<script>
  $(document).ready(function(){
    var selectValue = "${notice_vo.not_emergency_yn}"; // 서버 사이드에서 제공된 값
    $('#not_emergency_yn').val(selectValue);


  })
</script>
<script>
  function notice_list(){
    $.ajax({
      type: "GET",
      url: "mypage_container_manager_notice.do",
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
        <input type="hidden" name="not_idx" value="${notice_vo.not_idx}">
        <input type="hidden" name="not_file_yn" value="${notice_vo.not_file_yn}">
        <!-- [S]manager_report_one -->
        <main class="th-layout-main">
            <div id="manager_report_one">
                <div class="my_info_title">공지사항수정</div>
                <div class="table_one_detail">
                    <table class="table table_list">
                        <tr>
                          <th class="table_list_th">긴급공지여부</th>
                          <td class="table_list_td">
                            <select class="select" id="not_emergency_yn" name="not_emergency_yn">
                                <option value="y">긴급공지</option>
                                <option value="n">일반공지</option>
                            </select>
                          </td>
                        </tr>
                        <tr>
                          <th class="table_list_th">공지제목</th>
                          <td class="table_list_td">
                            <input class="form-control" type="text" name="not_title" value="${notice_vo.not_title}">
                          </td>
                        </tr>
                        <tr>
                          <th class="table_list_th">공지내용</th>
                          <td class="table_list_td"> 
                            <textarea id="summernote" name="not_content">${notice_vo.not_content}</textarea>
                            </td>
                        </tr>
                        <tr>
                          <th class="table_list_th">첨부파일</th>
                          <td class="table_list_td">
                            <c:if test="${empty notice_vo.file_list}">등록된 첨부파일이 없습니다.</c:if>
                            <c:if test="${not empty notice_vo.file_list}">
                              <ul>
                                <c:forEach var="vo" items="${notice_vo.file_list}" varStatus="i">
                                  <li>
                                    <input type="hidden" name="file_idx" value="${vo.file_idx}" id="file_${i.count}">
                                    <p class="file_name" id="file_name_${i.count}">${vo.file_name}&nbsp;</p><a class="file_name_btn" id="file_name_a_${i.count}" onclick="del_file('${i.count}');">X</a>
                                  </li>
                                </c:forEach>
                              </ul>
                            </c:if>
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
                            <input type="button" class="btnset btnset-round" value="공지수정" onclick="notify_modify(this.form);">
                            <input type="button" class="btnset btnset-round btnset-line" value="뒤로가기" onclick="back_notice_one('${notice_vo.not_idx}');">
                          </td>
                        </tr>
                       
                    </table>
                </div>
            </div>
        </main>
      </form>
</body>
</html>