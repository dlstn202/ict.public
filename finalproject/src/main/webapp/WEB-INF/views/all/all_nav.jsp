<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <!DOCTYPE html>
    <html>

    <head>
      <meta charset="UTF-8">
      <title>캠프로버</title>
      <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
      <script>

        function logout() {
          $.ajax({
            url: "${pageContext.request.contextPath}/logout.do",
            success: function (data) {
              if (data.result) {
                Swal.fire({
                  title: "로그아웃되었습니다.",
                  allowOutsideClick: false
                }).then((result) => {
                  if (result.value) {
                    if (location.href.includes('mypage')) {
                      location.href = '${pageContext.request.contextPath}/main.do';
                    } else {
                      location.href = location.href;
                    }
                  }
                });
              }
            },
            error: function (jqXHR, textStatus, errorThrown) {
              console.table(jqXHR)
            }
          });
        }
      </script>
      <script>
        function login_main() {

          var form = document.getElementById('url_form');


          form.action = '${pageContext.request.contextPath}/login_main.do';
          form.submit();

        }
      </script>
      <script>

        $(document).ready(function () {

          var currentUrl = location.href;

          // URL에서 'url' 파라미터의 값을 추출하는 함수
          function getQueryParam(param) {
            var urlParams = new URLSearchParams(window.location.search);
            return urlParams.get(param);
          }

          // 'url' 파라미터의 값을 가져옵니다.
          var urlParam = getQueryParam('url');

          // URL에 'url' 파라미터가 있는지 확인하고, 값이 있으면 입력 필드에 설정합니다.
          if (urlParam) {
            //console.log(urlParam);
            $("#url").val(decodeURIComponent(urlParam));
          } else {
            // 'url' 파라미터가 없는 경우 현재 페이지 URL을 사용합니다.
            $("#url").val(currentUrl);
          }

        });

      </script>
    </head>

    <body>
      <!-- [S]glamping-N1 -->
      <header class="glamping-N1" data-bid="KdltWpHPRk">
        <div class="header-container">
          <div class="header-left" onclick="location.href='main.do'">
            <h1 class="header-title">
              <a href="javascript:void(0)">
                <img src="${pageContext.request.contextPath}/assets/img/sample/img_logo_white.png" alt="로고">
              </a>
            </h1>
          </div>
          <div class="header-center">
            <ul class="header-member">
              <li >
                <c:if test="${empty user}">
                  <a onclick="location.href='login_main.do'" href="javascript:void(0)">로그인</a>
                </c:if>
                <c:if test="${not empty user}">
                  <a href="javascript:void(0);" onclick="location.href='${pageContext.request.contextPath}/mypage_main.do'" class="a_user">  ${user.mem_name}님 </a>
                  <a onclick="logout()" href="javascript:void(0)">로그아웃</a>
                </c:if>
              </li>
            </ul>
            <ul class="header-gnblist">
              <li class="header-gnbitem" onclick="location.href='${pageContext.request.contextPath}/info_main.do'">
                <a class="header-gnblink" href="javascript:void(0)">
                  <span>캠핑안내</span>
                </a>
              </li>
              <!-- <li class="header-gnbitem" onclick="location.href='${pageContext.request.contextPath}/story_main.do'">
                <a class="header-gnblink" href="javascript:void(0)">
                  <span>스토리</span>
                </a>
              </li> -->
              <li class="header-gnbitem" onclick="location.href='${pageContext.request.contextPath}/notice_main.do'">
                <a class="header-gnblink" href="javascript:void(0)">
                  <span>공지사항</span>
                </a>
              </li>
              <li class="header-gnbitem" onclick="location.href='${pageContext.request.contextPath}/faq_main.do'">
                <a class="header-gnblink" href="javascript:void(0)">
                  <span>FAQ</span>
                </a>
              </li>
              <c:if test="${user.mem_grade eq 'general' or user.mem_grade eq 'ceo'}">
                <li class="header-gnbitem" onclick="location.href='${pageContext.request.contextPath}/qna_main.do'">
                  <a class="header-gnblink" href="javascript:void(0)">
                    <span>온라인문의</span>
                  </a>
                </li>
              </c:if>
            </ul>
          </div>
          <div class="header-right">
            <div class="header-utils">

              <c:if test="${empty user}">
                <form id="url_form">
                  <input type="hidden" name="url" id="url">
                </form>
                <a href="javascript:void(0);" class="nav_loginout user_login_logout" onclick="login_main();">
                  로그인
                </a>
              </c:if>
              <c:if test="${not empty user}">
                <a href="javascript:void(0);" class="nav_loginout user_nav btn-user header-utils-btn "
                  onclick="location.href='${pageContext.request.contextPath}/mypage_main.do'">
                  ${user.mem_name}님
                </a>
                <a href="javascript:void(0);" class="nav_loginout user_login_logout" onclick="logout()">
                  로그아웃
                </a>
              </c:if>

              <button class="btn-momenu header-utils-btn">
                <img src="${pageContext.request.contextPath}/assets/icons/ico_menu_white.svg" alt="모바일메뉴">
              </button>
              <button class="btn-moclose header-utils-btn">
                <img src="${pageContext.request.contextPath}/assets/icons/ico_close_white.svg" alt="닫기">
              </button>
            </div>
          </div>
        </div>
        <div class="header-fullmenu fullmenu-right">
          <div class="fullmenu-wrapper">
            <div class="fullmenu-head">
              <h4 class="fullmenu-title">
                <a href="javascript:void(0)">
                  <img src="${pageContext.request.contextPath}/assets/img/sample/img_logo_white.png" alt="로고">
                </a>
              </h4>
              <ul class="fullmenu-member">
                <c:if test="${empty user}">
                  <li onclick="location.href='${pageContext.request.contextPath}/login_main.do'">
                    <a href="javascript:void(0)">로그인</a>
                  </li>
                </c:if>
                <c:if test="${not empty user}">
                  <li>
                    <a href="javascript:void(0);" class="nav_loginout user_nav btn-user header-utils-btn "
                      onclick="location.href='${pageContext.request.contextPath}/mypage_main.do'">
                      ${user.mem_name}님
                    </a>
                    <a href="javascript:void(0);" class="nav_loginout user_login_logout" onclick="logout()">
                      로그아웃
                    </a>
                  </li>
                </c:if>
              </ul>
            </div>
            <ul class="fullmenu-gnblist">
              <li class="fullmenu-gnbitem" onclick="location.href='${pageContext.request.contextPath}/info_main.do'">
                <a class="fullmenu-gnblink" href="javascript:void(0)">
                  <span>캠핑안내</span>
                </a>
              </li>
              <!-- <li class="fullmenu-gnbitem" onclick="location.href='${pageContext.request.contextPath}/story_main.do'">
                <a class="fullmenu-gnblink" href="javascript:void(0)">
                  <span>스토리</span>
                </a>
              </li> -->
              <li class="fullmenu-gnbitem" onclick="location.href='${pageContext.request.contextPath}/notice_main.do'">
                <a class="fullmenu-gnblink" href="javascript:void(0)">
                  <span>공지사항</span>
                </a>
              </li>
              <li class="fullmenu-gnbitem" onclick="location.href='${pageContext.request.contextPath}/faq_main.do'">
                <a class="fullmenu-gnblink" href="javascript:void(0)">
                  <span>QNA</span>
                </a>
              </li>
              <c:if test="${user.mem_grade eq 'general' or user.mem_grade eq 'ceo'}">
                <li class="header-gnbitem" onclick="location.href='${pageContext.request.contextPath}/qna_main.do'">
                  <a class="header-gnblink" href="javascript:void(0)">
                    <span>온라인문의</span>
                  </a>
                </li>
              </c:if>
            </ul>
          </div>
          <button class="fullmenu-close">
            <img src="${pageContext.request.contextPath}/assets/icons/ico_close_white.svg" alt="닫기">
          </button>
        </div>
      </header>
    </body>

    </html>