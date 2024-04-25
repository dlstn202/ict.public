  <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>캠프로버</title>
</head>
<body>
      <!-- [E]glamping-N1 -->
  <main class="th-layout-main ">
    <!-- [E]glamping-N4 -->
    <!-- [S]glamping-N5 -->
    <div class="glamping-N5" data-bid="dbltWPhpZn">
      <div class="contents-inner">
        <div class="contents-container container-md">
          <div class="cardset-wrap">
            <div class="cardset cardset-xl cardset-deco cardset-hor row-rever">
              <figure class="cardset-figure">
                <!-- <img class="cardset-img" src="${pageContext.request.contextPath}/assets/img/sample/img_glamping_N5_1.png" alt="카드이미지"> -->
                <c:if test="${!empty camp_vo1.firstImageUrl}">
                  <img class="cardset-img" src="${ camp_vo1.firstImageUrl }" alt="카드이미지">
                </c:if>
                <c:if test="${empty camp_vo1.firstImageUrl}">
                    <img class="cardset-img" src="${pageContext.request.contextPath}/assets/img/sample/img_glamping_N5_1.png" alt="카드이미지">
                </c:if>
              </figure>
              <div class="cardset-body">
                <h2 class="cardset-tit"> ${ camp_vo1.facltNm }</h2>
                <p class="cardset-desc"> ${ camp_vo1.intro }
                  <c:if test="${empty camp_vo1.intro}">${ camp_vo1.lineIntro }
                    <c:if test="${empty camp_vo1.lineIntro}">${ camp_vo1.featureNm }</c:if>
                  </c:if> </p>
                <a href="javascript:void(0);" class="btnset btnset-round btnset-line btnset-black" onclick="location.href='detail_main.do?contentId=${ camp_vo1.contentId }'">자세히보기</a>
              </div>
            </div>
            <div class="cardset cardset-xl cardset-deco cardset-hor">
              <figure class="cardset-figure">
                <!-- <img class="cardset-img" src="${pageContext.request.contextPath}/assets/img/sample/img_glamping_N5_2.png" alt="카드이미지"> -->
                  <img class="cardset-img" src="${ camp_vo2.firstImageUrl }" alt="카드이미지" onerror="this.src='${pageContext.request.contextPath}/assets/img/sample/img_glamping_N5_2.png'">
              </figure>
              <div class="cardset-body">
                <h2 class="cardset-tit"> ${ camp_vo2.facltNm } </h2>
                <p class="cardset-desc"> ${ camp_vo2.intro }
                  <c:if test="${empty camp_vo2.intro}">${ camp_vo2.lineIntro }
                    <c:if test="${empty camp_vo2.lineIntro}">${ camp_vo2.featureNm }</c:if>
                  </c:if> </p>
                <a href="javascript:void(0);" class="btnset btnset-round btnset-line btnset-black" onclick="location.href='detail_main.do?contentId=${ camp_vo2.contentId }'">자세히보기</a>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    

</main>
</body>
</html> 