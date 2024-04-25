<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <!DOCTYPE html>
  <html>

  <head>
    <meta charset="UTF-8">
    <title>캠프로버</title>
    <script>
      $(document).ready(function () {
        $.getScript("${pageContext.request.contextPath}/assets/js/footer.js");
        $.getScript("${pageContext.request.contextPath}/assets/js/setting.js");
        $.getScript("${pageContext.request.contextPath}/assets/js/template.js");
        $.getScript("${pageContext.request.contextPath}/assets/js/common.js");
        $.getScript("${pageContext.request.contextPath}/assets/js/script.js");
      })
    </script>
  </head>

  <body>
    <!-- [S]glamping-N3 -->
    <footer class="glamping-N3" data-bid="NgltwpHQWu">
      <div class="footer-container">
        <div class="footer-body container-md">
          <h2 class="footer-logo">
            <a href="javascript:void(0)">
              <img src="${pageContext.request.contextPath}/assets/img/sample/img_logo_white.png" alt="로고">
            </a>
          </h2>
          <ul class="footer-menugroup">
            <li class="footer-menulink">
              <a href="javascript:void(0)">
                <span>이용약관</span>
              </a>
            </li>
            <li class="footer-menulink">
              <a href="javascript:void(0)">
                <span>개인정보처리방침</span>
              </a>
            </li>
            <li class="footer-menulink">
              <a href="javascript:void(0)">
                <span>제휴제안</span>
              </a>
            </li>
            <li class="footer-menulink">
              <a href="javascript:void(0)">
                <span>고객센터</span>
              </a>
            </li>
          </ul>
          <div class="footer-txtgroup">
            <div class="footer-txt">
              <p> 서울 서초구 서초대로77길 41 </p>
              <p>
                <span>E. camprover@naver.com</span>
              </p>
            </div>
            <div class="footer-txt">
              <p>2023 BY CAMPROVER. ALL RIGHTS RESEVED</p>
            </div>
          </div>
        </div>
      </div>
    </footer>
  </body>

  </html>