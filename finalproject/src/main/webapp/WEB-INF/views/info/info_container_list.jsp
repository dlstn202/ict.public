<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

        <!DOCTYPE html>
        <html>

        <head>
            
            <meta charset="UTF-8">
            <title>캠프안내</title>

            <script>
                doNm = "${doNm}";
                sigunguNm = "${sigunguNm}";
                induty = "${induty}";
                lctCl = "${lctCl}";
                SiteCo = "${SiteCo}";
                sbrsCl = "${sbrsCl}";
                console.log("induty :"+induty);
                console.log("lctCl :"+lctCl);
                console.log("SiteCo :"+SiteCo);
                console.log("sbrsCl :"+sbrsCl);
                $(document).ready(function () {
                    $('.place_select_kind').click(function () {
                        $('.place_select_kind').removeClass('active');
                        $(this).toggleClass('active');
                    });
                    // 필터의 표시 순서를 정의합니다.
                    var filterOrder = ['induty', 'lctCl', 'sbrsCl'];

                    // URL에서 쿼리 매개변수 값을 가져옵니다.
                    var urlParams = new URLSearchParams(window.location.search);

                    // 정의된 순서에 따라 필터 값을 저장할 객체를 초기화합니다.
                    var filters = {
                        'induty': urlParams.get('induty'),
                        'lctCl': urlParams.get('lctCl'),
                        'sbrsCl': urlParams.get('sbrsCl')
                    };

                    // 필터 아이콘을 제외한 나머지 필터를 담을 임시 컨테이너를 생성합니다.
                    var tempContainer = $('<div></div>');

                    // 정의된 순서대로 필터를 임시 컨테이너에 표시합니다.
                    filterOrder.forEach(function (key) {
                        if (filters[key]) {
                            displayFilters(filters[key], tempContainer);
                        }
                    });

                    // 임시 컨테이너의 내용을 실제 필터 컨테이너 앞에 추가합니다.
                    $('.hashtag_icon').before(tempContainer.html());

                    // 주어진 파라미터 값을 바탕으로 필터를 표시하는 함수입니다.
                    function displayFilters(paramValue, container) {
                        var filterList = paramValue.split(',');
                        filterList.forEach(function (filter) {
                            var filterDiv = $('<div></div>')
                                .addClass('hashtag_list')
                                .text(decodeURIComponent(filter));
                            container.append(filterDiv);
                        });
                    }
                });

                function moveMap(mapY, mapX,
                    contentId, facltNm,
                    addr1, addr2, tel) {
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
                    placeOverlay.setPosition(new kakao.maps.LatLng(mapY, mapX));

                    // 오버레이를 지도에 표시합니다
                    placeOverlay.setMap(map);

                }
            </script>
        <script>
            console.log("${list_local}")
        </script>
        </head>

        <body>

            <div id="list">
                <div class="fixed_top">
                    <div class="sido_select">
                        <div id="sido" onclick="filter('local')"><span>
                                <c:if test="${empty doNm}">
                                    전국
                                </c:if>
                                <c:if test="${not empty doNm}">
                                    ${doNm}
                                </c:if>
                            </span> <i class="fa-solid fa-angle-down" style="color: #003a1b;"></i></div>
                    </div>
                    <div class="place_select">
                        <div class="place_select_kind" onclick="changeContent('camping')">캠핑장</div>
                        <div class="place_select_kind" onclick="changeContent('HP8')" id="HP8" data-order="0">병원</div>
                        <div class="place_select_kind" onclick="changeContent('PM9')" id="PM9" data-order="1">약국</div>
                        <div class="place_select_kind" onclick="changeContent('CS2')" id="CS2" data-order="2">편의점</div>
                        <div class="place_select_kind" onclick="changeContent('MT1')" id="MT1" data-order="3">마트</div>
                    </div>
                    <div class="hashtag">

                        <div class="hashtag_icon" onclick="filter('filter')">

                            <i class="fa-solid fa-sliders" style="color: #00391c;"></i> 필터
                        </div>
                    </div>
                </div>
                <form>
                    <div id="place_area">

                        <c:forEach var="vo" items="${list_filter}" varStatus="i">

                            <div class="place_list" onclick="moveMap('${vo.mapY}','${vo.mapX}',
                                                             '${vo.contentId}','${vo.facltNm}',
                                                             '${vo.addr1}','${vo.addr2}',
                                                             '${vo.tel}')">
                                <div class="place_list_img">
                                    <img  src="${vo.firstImageUrl}" alt="카드이미지"
                                       onerror="this.src='${pageContext.request.contextPath}/assets/img/sample/img_glamping_N5_2.png'">                                                                                                     
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
                </form>


            </div>

        </body>

        </html>