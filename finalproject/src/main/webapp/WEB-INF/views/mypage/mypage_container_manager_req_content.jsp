<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
    function req_one(req_idx) {
        $.ajax({
            type: "GET",
            url: "mypage_container_manager_req_one.do",
            data: "data",
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
    <main class="th-layout-main">
        <div id="req_content">
            <div class="my_info_title">캠핑장 신청 내역</div>
        </div>
        <form action="">
            <div class="search_wrap">
              <select  class="search_inquiry">
                <option value="all">전체보기</option>
                <option value="name">이름</option>
                <option value="subject">제목</option>
                <option value="content">내용</option>
                <option value="subject_content">제목+내용</option>
              </select>
              <div class="inputset inputset-border-bottom">
                <button class="inputset-icon icon-right icon-search btn" type="button" aria-label="아이콘"></button>
                <input type="text" class="inputset-input form-control" placeholder="내용을 입력하세요" aria-label="내용">
              </div>
                  <!-- <input class="search_text" placeholder="검색어를 입력하세요">
              <div ><i class="fa-solid fa-magnifying-glass" style="color: #003a1b;"></i></div> -->
            </div>
          </form> 
          <div>
            <table class="table req_list_table">
                <tr class="req_list_th_wrap">
                    <th class="center">번호</th>
                    <th class="req_list_th">신청자명</th>
                    <th class="req_list_th">캠핑장명</th>
                    <th class="center">신청일</th>
                    <th class="center">상태</th>
                </tr>
      
                <tr class="req_list_td_wrap" onclick="req_one(0);">
                    <td class="center">1</td>
                    <td class="req_list_td">금쪽삼</td>
                    <td class="req_list_td">금쪽캠핑</td>
                    <td class="center">2024.03.22</td>
                    <td class="center">신청대기</td>
                </tr>
                <tr class="req_list_td_wrap" onclick="req_one(1);">
                    <td class="center">2</td>
                    <td class="req_list_td">금쪽일</td>
                    <td class="req_list_td">금쪽캠핑</td>
                    <td class="center">2024.03.22</td>
                    <td class="center">신청대기</td>
                </tr>
                
            </table>
          <div>
            <nav class="pagiset pagiset-circ">
              <div class="pagiset-ctrl">
                <a class="pagiset-link pagiset-first" href="javascript:void(0)">
                  <span class="visually-hidden">처음</span>
                </a>
              </div>
              <div class="pagiset-ctrl">
                <a class="pagiset-link pagiset-prev" href="javascript:void(0)">
                  <span class="visually-hidden">이전</span>
                </a>
              </div>
              <div class="pagiset-list">
                <a class="pagiset-link active-fill" href="javascript:void(0)">1</a>
                <a class="pagiset-link" href="javascript:void(0)">2</a>
                <a class="pagiset-link" href="javascript:void(0)">3</a>
              </div>
              <div class="pagiset-ctrl">
                <a class="pagiset-link pagiset-next" href="javascript:void(0)">
                  <span class="visually-hidden">다음</span>
                </a>
              </div>
              <div class="pagiset-ctrl">
                <a class="pagiset-link pagiset-last" href="javascript:void(0)">
                  <span class="visually-hidden">마지막</span>
                </a>
              </div>

            </nav>      
    </main>
</body>
</html>