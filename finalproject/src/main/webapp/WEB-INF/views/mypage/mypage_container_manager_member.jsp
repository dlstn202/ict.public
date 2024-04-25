<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <!-- core JSTL -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %><!-- fmt JSTL -->
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> <!-- functions JSTL -->

<%@ include file="mypage_container_manager_member_modal.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>

    $(function(){
        $('.memberlist_wrap > div').hide();
        $('.memberlist_tab_ul a').click(function () {
            $('.memberlist_wrap > div').hide().filter(this.hash).css('display', 'block');
            $('.memberlist_tab_ul a').removeClass('active');
            $(this).addClass('active');
            return false;
        }).filter(':eq(0)').click();
    });

</script>

<script>

    function GeneralModifyForManager(mem_idx) {
        var form = $("#member_"+mem_idx);
        
        var mem_idx = form.find("input[name='mem_idx']").val();
        var mem_joindate = form.find("input[name='mem_joindate']").val();
        var mem_name = form.find("input[name='mem_name']").val();
        var mem_email = form.find("input[name='mem_email']").val();
        var mem_tel = form.find("input[name='mem_tel']").val();
        var mem_id = form.find("input[name='mem_id']").val();
        var agree3_yn = form.find("input[name='agree3_yn']").val();
        var mem_reserv_yn = form.find("input[name='mem_reserv_yn']").val();
        var mem_reservdate = form.find("input[name='mem_reservdate']").val();
        var mem_review_yn = form.find("input[name='mem_review_yn']").val();
        var mem_reviewdate = form.find("input[name='mem_reviewdate']").val();
        var mem_quit_yn = form.find("input[name='mem_quit_yn']").val();
        var mem_quitdate = form.find("input[name='mem_quitdate']").val();
        var mem_photo = form.find("input[name='mem_photo']").val();
        var mem_grade = form.find("input[name='mem_grade']").val();





        var general_form = $("#general_form");
        general_form.find("input[name='mem_idx']").val(mem_idx);
        general_form.find("input[name='mem_joindate']").val(mem_joindate);
        general_form.find("input[name='mem_name']").val(mem_name);
        general_form.find("input[name='mem_email']").val(mem_email);
        general_form.find("input[name='mem_tel']").val(mem_tel);
        general_form.find("input[name='mem_id']").val(mem_id);
        general_form.find("input[name='agree3_yn']").val(agree3_yn);
        general_form.find("input[name='mem_reserv_yn']").val(mem_reserv_yn);
        general_form.find("input[name='mem_reservdate']").val(mem_reservdate);
        general_form.find("input[name='mem_review_yn']").val(mem_review_yn);
        general_form.find("input[name='mem_reviewdate']").val(mem_reviewdate);
        general_form.find("input[name='mem_quit_yn']").val(mem_quit_yn);
        general_form.find("input[name='mem_quitdate']").val(mem_quitdate);
        general_form.find("input[name='mem_photo']").val(mem_photo);
        general_form.find("input[name='mem_grade']").val(mem_grade);
        general_form.find("select[name='mem_reserv_yn']").val(mem_reserv_yn);
        general_form.find("select[name='mem_review_yn']").val(mem_review_yn);
        
        console.log(mem_reserv_yn);
        console.log(mem_review_yn);
        
        // $("#mem_reserv_yn").html(mem_reserv_yn);
        // $("#mem_review_yn").html(mem_review_yn);

        $("#GeneralModifyModal").modal('show');
        $("#GeneralModifyModal").modal({backdrop : "static"});

    }

    function CEOModifyForManager(mem_idx) {

      var form = $("#member_"+mem_idx);
        
        var mem_idx = form.find("input[name='mem_idx']").val();
        var mem_joindate = form.find("input[name='mem_joindate']").val();
        var mem_name = form.find("input[name='mem_name']").val();
        var mem_email = form.find("input[name='mem_email']").val();
        var mem_tel = form.find("input[name='mem_tel']").val();
        var mem_id = form.find("input[name='mem_id']").val();

        var mem_quit_yn = form.find("input[name='mem_quit_yn']").val();
        var mem_quitdate = form.find("input[name='mem_quitdate']").val();
        var mem_grade = form.find("input[name='mem_grade']").val();



        var general_form = $("#ceo_form");
        general_form.find("input[name='mem_idx']").val(mem_idx);
        general_form.find("input[name='mem_joindate']").val(mem_joindate);
        general_form.find("input[name='mem_name']").val(mem_name);
        general_form.find("input[name='mem_email']").val(mem_email);
        general_form.find("input[name='mem_tel']").val(mem_tel);
        general_form.find("input[name='mem_id']").val(mem_id);

        general_form.find("input[name='mem_quit_yn']").val(mem_quit_yn);
        general_form.find("input[name='mem_quitdate']").val(mem_quitdate);
        general_form.find("input[name='mem_grade']").val(mem_grade);

      

        $("#CEOModifyModal").modal('show');
        $("#CEOModifyModal").modal({backdrop : "static"});

    }


</script>
</head>
<body>
    <main class="th-layout-main">
        <div id="my_manager_member">
            <div class="my_info_title">회원정보</div>
        </div>

        <div class="memberlist_tab">
            <ul class="memberlist_tab_ul">
                <li class="memberlist_tab_li ml_t_1">
                    <a href="#normal_memberlist">일반회원</a>
                </li>
                <li class="memberlist_tab_li ml_t_2">
                    <a href="#ceo_memberlist">기업회원</a>
                </li>     
            </ul>
          </div>

        <div class="memberlist_wrap">
            <div class="memberlist" id="normal_memberlist">
                <table class="table memberlist_table">
                  <thead>
                    <tr>
                        <th class="memberlist_th" rowspan="2">회원번호</th>
                        <th class="memberlist_th" rowspan="2">회원명</th>
                        <th class="memberlist_th" rowspan="2">아이디</th>
                        <th class="memberlist_th" colspan="3">SNS 연동</th>
                        <th class="memberlist_th" rowspan="2">탈퇴<br>여부</th>
                        <th class="memberlist_th" rowspan="2"></th>
                    </tr>
                    <tr class="memberlist_tr">

                        <th class="memberlist_th">카카오</th>
                        <th class="memberlist_th">네이버</th>
                        <th class="memberlist_th">구글</th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:forEach var="general_vo" items="${general_list}">
                      <tr>
                          <td class="memberlist_td_idx">${general_vo.mem_idx}</td>
                          <td class="memberlist_td">${general_vo.mem_name}</td>
                          <td class="memberlist_td">${general_vo.mem_id}</td>
                          <td class="memberlist_td">
                            <c:if test="${empty general_vo.mem_kakao}">-</c:if>
                            <c:if test="${not empty general_vo.mem_kakao}">O</c:if>
                          </td>
                          <td class="memberlist_td">
                            <c:if test="${empty general_vo.mem_naver}">-</c:if>
                            <c:if test="${not empty general_vo.mem_naver}">O</c:if>
                          </td>
                          <td class="memberlist_td">
                            <c:if test="${empty general_vo.mem_google}">-</c:if>
                            <c:if test="${not empty general_vo.mem_google}">O</c:if>
                          </td>
                          <td class="memberlist_td_yn">${general_vo.mem_quit_yn}</td>
                          <td class="memberlist_td_btn"><input class="memberlist_btn" type="button" onclick="GeneralModifyForManager('${general_vo.mem_idx}');" value="수정하기"></td>
                      </tr>
                    </c:forEach>
                  </tbody>
                </table>
            </div>


            <div class="memberlist" id="ceo_memberlist">
                <table class="table memberlist_table">
                  <thead>
                    <tr>
                        <th class="memberlist_th">회원번호</th>
                        <th class="memberlist_th">회원명</th>
                        <th class="memberlist_th">아이디</th>
                        <th class="memberlist_th">탈퇴여부</th>
                        <th class="memberlist_th"></th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:forEach var="ceo_vo" items="${ceo_list}">
                      <tr>
                          <td class="memberlist_td_idx">${ceo_vo.mem_idx}</td>
                          <td class="memberlist_td">${ceo_vo.mem_name}</td>
                          <td class="memberlist_td">${ceo_vo.mem_id}</td>
                          <td class="memberlist_td">${ceo_vo.mem_quit_yn}</td>
                          <td class="memberlist_td_btn"><input class="memberlist_btn" type="button" onclick="CEOModifyForManager('${ceo_vo.mem_idx}');" value="수정하기"></td>
                      </tr>
                    </c:forEach>
                  </tbody>
                </table>

                
            </div>


        </div>



    </main>
<c:forEach var="vo" items="${general_list}">
<form id="member_${vo.mem_idx}">
  <input type="hidden" name="mem_idx"         value="${vo.mem_idx}">
  <input type="hidden" name="mem_joindate"    value="${vo.mem_joindate}">
  <input type="hidden" name="mem_name"        value="${vo.mem_name}">
  <input type="hidden" name="mem_email"       value="${vo.mem_email}">
  <input type="hidden" name="mem_tel"         value="${vo.mem_tel}">
  <input type="hidden" name="mem_id"          value="${vo.mem_id}">
  <input type="hidden" name="agree3_yn"       value="${vo.agree3_yn}">
  <input type="hidden" name="mem_reserv_yn"   value="${vo.mem_reserv_yn}">
  <input type="hidden" name="mem_reservdate"  value="${vo.mem_reservdate}">
  <input type="hidden" name="mem_review_yn"   value="${vo.mem_review_yn}">
  <input type="hidden" name="mem_reviewdate"  value="${vo.mem_reviewdate}">
  <input type="hidden" name="mem_quit_yn"     value="${vo.mem_quit_yn}">
  <input type="hidden" name="mem_quitdate"    value="${vo.mem_quitdate}">
  <input type="hidden" name="mem_photo"       value="${vo.mem_photo}">
  <input type="hidden" name="mem_grade"       value="${vo.mem_grade}">
</form>
</c:forEach>
<c:forEach var="vo" items="${ceo_list}">
<form id="member_${vo.mem_idx}">
  <input type="hidden" name="mem_idx"         value="${vo.mem_idx}">
  <input type="hidden" name="mem_joindate"    value="${vo.mem_joindate}">
  <input type="hidden" name="mem_name"        value="${vo.mem_name}">
  <input type="hidden" name="mem_email"       value="${vo.mem_email}">
  <input type="hidden" name="mem_tel"         value="${vo.mem_tel}">
  <input type="hidden" name="mem_id"          value="${vo.mem_id}">

  <input type="hidden" name="mem_quit_yn"     value="${vo.mem_quit_yn}">
  <input type="hidden" name="mem_quitdate"    value="${vo.mem_quitdate}">
  <input type="hidden" name="mem_grade"       value="${vo.mem_grade}">
</form>
</c:forEach>

    
</body>
</html>