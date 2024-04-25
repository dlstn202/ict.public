<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Document</title>
            <SCript>

                function moveMap(mapY, mapX,
                                 contentId,facltNm,
                                 addr1,addr2,tel) {
                    var moveLatLon = new kakao.maps.LatLng(mapY, mapX);
                    map.setCenter(moveLatLon); // 지도 중심을 첫 번째 캠핑장 위치로 이동

                    var content = '<div class="placeinfo"><div>' +
                        '   <a class="title" href="detail_main.do?contentId=' + contentId + '" title="' + facltNm + '">' + facltNm + '</a>' +
                        '   <div class="close" onclick="closeOverlay()" title="닫기"></div>' +
                        '</div>' +

                        '    <span title="' + addr1 + '">' + addr1 + '</span>' +
                        '  <span class="jibun" title="' + addr2 + '">(지번 : ' + addr2 + ')</span>';
                        content += ' <span class="tel">' + tel + '</span>' +
                        '</div>' +
                        '<div class="after"></div>';



                    // 컨텐츠를 오버레이에 설정합니다
                    contentNode.innerHTML = content;

                    // 오버레이를 표시할 위치를 설정합니다
                    placeOverlay.setPosition(new kakao.maps.LatLng(mapY,mapX));

                    // 오버레이를 지도에 표시합니다
                    placeOverlay.setMap(map);

                }
            </SCript>
        </head>

        <body>
            <div id="place_area">

                <c:forEach var="vo" items="${list_local}" varStatus="i">

                    <div class="place_list" onclick="moveMap('${vo.mapY}','${vo.mapX}',
                                                     '${vo.contentId}','${vo.facltNm}',
                                                     '${vo.addr1}','${vo.addr2}',
                                                     '${vo.tel}')">
                        <div class="place_list_img">
                            <img  src="${vo.firstImageUrl}" alt="카드이미지"
                                onerror="this.src='${pageContext.request.contextPath}/assets/img/sample/img_glamping_N5_2.png'">
                            
                            <!-- <c:if test="${empty vo.firstImageUrl}">
                                <img src="${pageContext.request.contextPath}/assets/img/sample/img_glamping_N5_2.png" alt="카드이미지">
                            </c:if> -->
                            
                        </div>
                        <div class="place_list_content">
                            <div class="content_hash_tag">${vo.induty},${vo.lctCl}</div>
                            <div class="content_facltNm">${vo.facltNm}</div>
                            <div class="content_addr1">${vo.addr1}</div>
                            <div class="content_lineIntro">${vo.lineIntro}</div>
                            <div></div>
                        </div>
                    </div>
                </c:forEach>
            </div>


        </body>

        </html>