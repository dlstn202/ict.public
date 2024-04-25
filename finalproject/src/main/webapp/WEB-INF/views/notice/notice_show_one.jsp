<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>캠프로버</title>
<script>
    var search_text = "${search_text}";
    var page        = "${page}";
  </script>
<script>

    function show_notice_list() {
        $.ajax({
            url: "notice_container.do",
            data: {search_text:search_text,page:page},
            success: function (res_data) {
                $("#notice_container").html(res_data);
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


    <!-- 공지사항 1개
    <br>
    ${ vo.not_idx } -->
    <div class="glamping-N39" data-bid="sbLtwpW9GA">
        <div class="contents-inner">
            <div class="contents-container container-md">
                <div class="contents-top">
                    <div><h3>${ notice_vo.not_title }</h3></div><div>${ notice_vo.mem_name }&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;${fn:substring(notice_vo.not_regdate, 0, 10)}</div>
                </div>
                <hr>
                <div class="notice_content_one">${ notice_vo.not_content }</div>
                <hr>
                <div class="notice_file">
                    <c:if test="${empty notice_vo.file_list}">등록된 첨부파일이 없습니다.</c:if>
                    <c:if test="${not empty notice_vo.file_list}">
                        <h4>첨부파일</h4>
                        <c:forEach var="vo" items="${notice_vo.file_list}">
                            <input class="btn_none" type="button" onclick="download('${vo.file_name}')" value="${vo.file_name}"><br>
                        </c:forEach>
                    </c:if>
                </div>
                <div class="notice_btn"><input type="button" class="btnset btnset-round" onclick="show_notice_list();" value="목록"></div>
            </div>            
        </div>
    </div>


</body>
</html>