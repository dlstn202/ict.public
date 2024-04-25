<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
      <!DOCTYPE html>
      <html>
    

      <head>
        <meta charset="UTF-8">
        <title>캠프로버</title>
      <style>
.photo_card{
  height: 380px;
}
.cardset-text-limited {
  display: -webkit-box !important;
    -webkit-line-clamp: 3 !important;
    word-break: normal !important;
    height: 7rem;
}
      </style>
      </head>

      <body>
        <main class="th-layout-main ">
          <!-- [S]glamping-N9 -->
          <div class="glamping-N9" data-bid="FllTwPhQTo">
            <div class="contents-inner">
              <div class="contents-container container-md">
                <div class="textset">
                  <h2 class="textset-tit">캠프로버를 이용한 생생 리뷰</h2>
                  <p class="textset-desc">캠프로버의 생생 리뷰를 만나보세요.</p>
                </div>
                <div class="contents-control">
                  <div class="swiper-button-prev"></div>
                  <div class="swiper-button-next"></div>
                </div>
              </div>
              <div class="contents-container">
                <div class="contents-swiper">
                  <div class="swiper-wrapper">
                      <c:forEach var="vo" items="${ review_list }">
                        <c:if test="${vo.photo_yn eq 'y'}">

                        <div class="swiper-slide">
                          <div class="contents-slide-group">
                            <div class="photo_card cardset cardset-user">
                                <figure class="cardset-figure">
                                  <c:if test="${not empty vo.photo_list}">
                                  <img class="cardset-img" src="${pageContext.request.contextPath}/review_file_upload/${vo.photo_list[0].pho_name}">
                                  </c:if>

                                </figure>
                              <div class="cardset-profile">
                                <p class="cardset-text cardset-text-limited">${vo.rev_content}</p>
                                <p class="cardset-info">${vo.facltNm}</p>
                                <p class="cardset-info">${vo.mem_id}</p>
                              </div>

                            </div>
                          </div>
                        </div>



                      </c:if>
                    </c:forEach>
                    </div>
                  </div>
                </div>
                  
            </div>
          </div>
          <!-- [E]glamping-N9 -->
        </main>
      </body>

      </html>