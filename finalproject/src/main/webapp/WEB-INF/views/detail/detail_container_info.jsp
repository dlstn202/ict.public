<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
      <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
         <!DOCTYPE html>
         <html>

         <head>
            <meta charset="UTF-8">
            <title>상세정보</title>
         </head>
         <script>
            /* 페이지 로드될때 저장되어있는 페이지인지 확인 */
            $(document).ready(function() {
               $('#myCarousel').carousel({
                  interval: false
               });


                  if( "${not empty user}" == "true"){
                     
                     $.ajax({
                        type : "POST",
                        url : "place_keep_check.do",
                        data : {"contentId":"${vo.contentId}"},
                        dataType :"json",
                        success : function(res_data) {
                           if (res_data.result) {
                              $("#keepNo").css("display", "none");
                              $("#keepOn").css("display", "inline-block");
                           }
                        },
                        error : function(err) {
                           console.log(err.responseText);
                        }
                     })
                  }
               });//end 저장되어있는 페이지인지 확인
            
               $(document).ready(function() {
                  //저장버튼 클릭시
                  $("#keepNo").click(function() {
                     if ("${empty user}" == "true") {
                        location.href='login_main.do?url='+location.href;
                     }else{
                        $.ajax({
                           url : "place_keep_insert.do",
                           data : {"contentId":"${vo.contentId}",
                                 "mem_idx":"${user.mem_idx}",
                                 "mapY":"${vo.mapY}",
                                 "mapX":"${vo.mapX}",
                                 "facltNm":"${vo.facltNm}"
                           },
                           dataType :"json",
                           success : function(res_data) {
                              if (res_data.result) {
                                 $("#keepNo").css("display", "none");
                                 $("#keepOn").css("display", "inline-block");
                              }
                           },
                           error : function(err) {
                              console.log(err.responseText);
                           }
                        });
                     }
                  });
               });
               
               $(document).ready(function() {
                  //저장버튼취소 클릭시
                  $("#keepOn").click(function() {
                     if ("${empty user}" == "true") {
                        location.href='login_main.do?url='+location.href;
                     }else{
                        $.ajax({
                           url : "place_keep_delete.do",
                           data : {"contentId":"${vo.contentId}"},
                           dataType :"json",
                           success : function(res_data) {
                              if (res_data.result) {
                                 $("#keepNo").css("display", "inline-block");
                                 $("#keepOn").css("display", "none");
                              }
                           },
                           error : function(err) {
                              console.log(err.responseText);
                           }
                        });
                     }
                  });
                  
               });

               $(document).ready(function () {
                  var infoAddElements = document.querySelectorAll('.info_add');
                     
                     // 각 "info_add" 요소에 대해 작업을 수행
                     infoAddElements.forEach(function(infoAddElement) {
                        // "info_add" 요소의 모든 하위 요소를 선택
                        var childElements = infoAddElement.querySelectorAll('*');
                        
                        // 각 하위 요소의 내용 앞에 '#'을 추가하는 작업 수행
                        childElements.forEach(function(childElement) {
                           var content = childElement.textContent; // 요소의 내용 가져오기
                           childElement.textContent = '#' + content.trim(); // 내용 앞에 '#'을 추가하여 설정
                        });
                     });
             })
            
            
            
            </script>

         <body>
            <div id="info">
              <input type="hidden" id="detail_contentid" value="${vo.contentId}"> <!--${detail_vo.contentid}-->
               <!-- ---------------------상세정보--------------------- -->
               <div class="detail">
                  <div class="detail_top">
                  </div>
                  <div class="detail_center">
                     <div class="detail_center_sm">
                        <div id="location_title">${vo.facltNm}</div>
                        <div id="evaluate">${vo.induty}</div>
                        <div id="detail_icon">
                           <div id="detail_map"
                              onclick="">
                              <i class="fa-solid fa-location-dot fa-2x" style="color: #007235;"></i>
                              <p>지도</p>
                           </div>
                           <c:if test="${user.mem_grade eq 'general' or empty user}">
                              <div id="detail_keep">
                                 <i id="keepNo" class="fa-regular fa-bookmark fa-2x"></i>
                                 <i id="keepOn" class="fa-solid fa-bookmark fa-2x"></i>
                                 <p>저장</p>
                              </div>
                              <div id="detail_reservation">
                                 <c:if test="${empty Rreservation}">
                                    <i class="fa-solid fa-calendar-check fa-2x" style="color: #007235;" onclick="location.href='${vo.resveUrl}'"></i>
                                 </c:if>
                                 <c:if test="${not empty Rreservation}">
                                    <i class="fa-solid fa-calendar-check fa-2x" style="color: #007235;" onclick="location.href='reservation/main.do?bizrno=${vo.bizrno}'"></i>
                                 </c:if>
                              
                              <p>예약</p>
                           </div>
                           </c:if>
                           <div id="detail_report">
                              <i class="fa-solid fa-land-mine-on fa-2x" style="color: #007235;"></i>
                              <p>신고</p>
                           </div>
                        </div>
                     </div>
                  </div>
                  <div class="detail_bottom"></div> <!-- 여백 -->
               </div>

               <div class="detail_info">
                  <div class="detail_infotop">
                     <p>상세정보</p>
                     <div class="info_reg">업데이트 : ${vo.modifiedtime}
                     </div>
                  </div>

                  <div class="info_addr">
                     <i class="fa-solid fa-location-dot fa-lg" style="color:#007235;"></i>
                     <div>${vo.addr1}(${vo.addr2})</div>
                  </div>

                  <div class="info_operate">
                     <i class="fa-regular fa-clock fa-lg" style="color:#007235;"></i>
                     <div>
                        <c:if test="${ empty vo.hvofBgnde }">영업시간 : </c:if>
                        <c:if test="${ !empty vo.hvofBgnde }">휴무 : ${ vo.hvofBgnde } ~ ${ vo.hvofEnddle }</c:if>
                     </div>
                  </div>
                  <div class="info_home">
                     <i class="fa-solid fa-globe fa-lg" style="color:#007235;"></i>
                     <div>${vo.homepage}</div>
                  </div>
                  <div class="info_tel">
                     <i class="fa-solid fa-phone fa-lg" style="color:#007235;"></i>
                     <div>${vo.tel}</div>
                  </div>

                  <div class="info_image_container">
                     <div class="info_image">
                        <i class="fa-regular fa-image fa-lg" style="color:#007235;"></i>
                        <div style="font-size:15px;">이미지</div>
                     </div>

                     <div id="myCarousel" class="carousel slide" data-ride="carousel" data-interval="false">
                        <!-- Indicators -->
                        <ol class="carousel-indicators">
                           <li data-target="#myCarousel" data-slide-to="0"></li>
                           <li data-target="#myCarousel" data-slide-to="1"></li>
                           <li data-target="#myCarousel" data-slide-to="2"></li>
                           <li data-target="#myCarousel" data-slide-to="3"></li>
                        </ol>

                        <!-- Wrapper for slides -->
                        <div class="carousel-inner">
                           <div class="item active">
                              <img src="${vo.firstImageUrl}"
                                 alt="PC 메인 비주얼 이미지">
                           </div>

                           <div class="item">
                              <img src="${pageContext.request.contextPath}/assets/img/header/main_header.jpg"
                                 alt="PC 메인 비주얼 이미지">
                           </div>

                           <div class="item">
                              <img src="${pageContext.request.contextPath}/assets/img/sample/img_glamping_N5_2.png"
                                 alt="PC 메인 비주얼 이미지">
                           </div>

                           <div class="item">
                              <img src="${pageContext.request.contextPath}/assets/img/header/main_header.jpg"
                                 alt="PC 메인 비주얼 이미지">
                           </div>
                        </div>

                        <!-- Left and right controls -->
                        <a class="left carousel-control" href="#myCarousel" data-slide="prev">
                           <span class="glyphicon glyphicon-chevron-left"></span>
                        </a>
                        <a class="right carousel-control" href="#myCarousel" data-slide="next">
                           <span class="glyphicon glyphicon-chevron-right"></span>
                        </a>
                     </div>
                  </div>



                     <div class="info_info">
                        <div class="info_detail">
                           <i class="fa-solid fa-circle-info fa-lg" style="color:#007235;"></i>
                           <div style="font-size:15px;">상세정보</div>
                        </div>
                        <div class="new-line">${vo.intro}</div>
                     </div>
                     <!-- 추가정보 #태그로 남기기 -->
                     <div class="info_add">
                        <c:if test="${!empty vo.animalCmgCl}"><div class="animalCmgCl">애완동물동반유무 : ${vo.animalCmgCl}</div></c:if>
                        <c:if test="${!empty vo.lctCl}"><div class="lctCl">입지 : ${vo.lctCl}</div></c:if>
                        <c:if test="${!empty vo.induty}"><div class="induty">캠핑장유형 : ${vo.induty}</div></c:if>
                        <c:if test="${!empty vo.tooltip}"><div class="tooltip">유의사항 : ${vo.tooltip}</div></c:if>
                        <c:if test="${!empty vo.sbrsCl}"><div class="sbrsCl">부대시설 : ${vo.sbrsCl}</div></c:if>
                        <c:if test="${!empty vo.exprnProgrm}"><div class="exprnProgrm">체험가능프로그램 : ${vo.exprnProgrm}</div></c:if>
                        <c:if test="${!empty vo.posblFcltyCl}"><div class="posblFcltyCl">주변이용가능시설 : ${vo.posblFcltyCl}</div></c:if>
                        <c:if test="${!empty vo.themaEnvrnCl}"><div class="themaEnvrnCl">테마환경 : ${vo.themaEnvrnCl}</div></c:if>
                        <c:if test="${!empty vo.eqpmnLendCl}"><div class="eqpmnLendCl">대여가능장비 : ${vo.eqpmnLendCl}</div></c:if>

                     </div>


                  </div>
               </div>
         </body>
         </body>

         </html>