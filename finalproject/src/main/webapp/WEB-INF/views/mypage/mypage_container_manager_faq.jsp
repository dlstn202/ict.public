<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- <style>
  .box{
    margin: auto;
  }
  .table{
    height: 50px;
  }
  .search_wrap{
    display: flex;
    margin-bottom: 20px;
    float: right;
    
  }
  .search_inquiry{
    margin-right: 20px;
    border: 1px solid rgba(var(--main-ton-down-rgb), 0.11);
    border-radius: 8px;
  }
  .search_text{
    margin-right: 10px;
  }

  /* -------------------------------- */
  .table.faq_list_table tbody:last-child {
    border-bottom: 1px solid #ddd;
    
  }
  .faq_list_th_wrap{
    background-color: rgba(var(--main-ton-down-rgb), 0.1);
    height: 50px;
  }
  .faq_list_td_wrap{
    height: 50px;
  }
  .faq_list_td,.faq_list_th{
    text-align: center;
    vertical-align: middle !important;
  }
  

  .faq_list_td_idx, .faq_list_td_yn{
      width: 75px;
      text-align: center;
      align-content: center;

  }
  .faq_list_td_btn{
      width: 110px;
  }
  .memberlist_btn{
      width: 90px;
      height: 35px;
      color: #fff;
      background-color: var(--main);
      border-radius: 3rem;
      text-align: center;
      border:none;

  }
  .faq_insert_wrap{
    display: flex;
    flex-direction: row-reverse;
  }
  .faq_insert{
    cursor: pointer;
    align-content: center;
    padding-bottom: 2px;
    width: 90px; height: 35px; color: #fff; background-color: var(--main); border-radius: 3rem; text-align: center; border:none; margin:5px; margin-top: none;
  }
  .faq_insert:hover{
    background-color: rgba(var(--main-ton-up-rgb));
  }
  .faq_list_td_wrap{
    /* transition: 0.3s; */
    cursor: pointer;
  }
  .faq_list_title{
    align-content: center;
  }
  .inquiry_content{
    
    padding: 10px;
  }
  
  .inquiry_reply{
    padding: 10px;
    margin-top: 10px;
    background-color: rgba(var(--main-ton-down-rgb), 0.1);
  }
  .inquiry_reply_title,.inquiry_content_title{
    margin-bottom: 10px;
  }
  .reply_btn{
    float: right;
    padding-bottom: 2px;
    width: 90px; height: 35px; color: #fff; background-color: var(--main); border-radius: 3rem; text-align: center; border:none; margin:5px; margin-top: none;
  }
  .reply_btn:hover{
    background-color: rgba(var(--main-ton-up-rgb));
  }
  .inquiry_content{
    padding: 10px;
    margin-top: 10px;
    background-color: rgba(var(--main-ton-down-rgb), 0.1);
  }
</style> -->
<script>
  // faq 내역
  // function inquiry_insert(){
  //       $.ajax({
  //           url: "mypage_container_faq_insert.do",
  //           success: function (res_data) {rgdgdf
  //               $("#container_content").html(res_data);
  //               changeLiColor();
  //               $("#inquiry").css("color", "#00AF52");
  //               $.getScript("${pageContext.request.contextPath}/assets/js/domain.js");
  //           },
  //           error: function (jqXHR, textStatus, errorThrown) {
  //               console.table(jqXHR)
  //           }
  //       });
  //   }
  function fileupload(){

  }

</script>
</head>
<body>
  <main class="th-layout-main">
    <div id="manager_faq">
        <div class="my_info_title">FAQ</div>
    </div>
    <form action="/upload_faq_file" method="post" enctype="multipart/form-data">
      <label for="faqFile">FAQ 파일 선택:</label>
      <input type="file" id="faqFile" name="faqFile" required>
      <br><br>
      <input type="button" onclick="fileupload()" value="파일 제출">
  </form>
  
  </main> 
    
</body>
</html>