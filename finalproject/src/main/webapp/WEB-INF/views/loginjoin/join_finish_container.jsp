<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>캠프로버</title>
</head>
<body>
<!-- [E]glamping-N2 -->
<main class="th-layout-main ">
    <!-- [S]glamping-N45 -->
    <div class="glamping-N45" data-bid="ToLTwpiYKe">
      <div class="contents-inner">
        <div class="contents-container container-md">
          <div class="textset">
            <h2 class="textset-tit">가입완료</h2>
            <p class="textset-desc">캠프로버에 오신것을 진심으로 환영합니다</p>
          </div>
          <ul class="contents-list">
            <li class="contents-item item-check">
              <span>1</span>
            </li>
            <li class="contents-item item-check">
              <span>2</span>
            </li>
            <li class="contents-item item-active">
              <span>3</span>
            </li>
          </ul>
        </div>
      </div>
    </div>
    <!-- [E]glamping-N45 -->
    <!-- [S]glamping-N48 -->
    <div class="glamping-N48" data-bid="xZlTWpIYnD">
      <div class="contents-inner">
        <div class="contents-container container-md">
          <div class="contents-icon">
            <img src="${pageContext.request.contextPath}/assets/icons/ico_check_xl_white.svg" alt="체크 아이콘 이미지">
          </div>
          <div class="textset">
            <h2 class="textset-tit">캠프로버 회원가입이 완료되었습니다</h2>
            <p class="textset-desc"> 로그인 후 안전하고 편리하게 <br> 캠프로버 서비스를 이용하실 수 있습니다. </p>
          </div>
          <div class="contents-btnset">
            <input type="hidden" id="url" name="url" value="${url}">
            <input class="btnset btnset-round" type="button" onclick="location.href='login_main.do?url=${url}'" value="로그인">
          </div>
        </div>
      </div>
    </div>
    <!-- [E]glamping-N48 -->
  </main>
</body>
</html>