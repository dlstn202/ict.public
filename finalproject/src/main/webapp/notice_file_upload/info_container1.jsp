<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Document</title>

            <script>
                $(document).ready(function () {
                    var urlParams = new URLSearchParams(window.location.search);
                    var doNm = urlParams.get('doNm');
                    var sigunguNm = urlParams.get('sigunguNm');

                    if (doNm && sigunguNm) {
                        updateMapAndMarkers(doNm, sigunguNm);
                    }
                    
                });
                var mapContainer = document.getElementById('map'),
                    placeOverlay = new kakao.maps.CustomOverlay({ zIndex: 1 }),
                    contentNode = document.createElement('div'), // 커스텀 오버레이의 컨텐츠 엘리먼트 입니다 
                    // 지도를 표시할 div 
                    markers = [], // 마커를 담을 배열입니다
                    currCategory = '', // 현재 선택된 카테고리를 가지고 있을 변수입니다
                    mapOption = {
                        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
                        level: 5 // 지도의 확대 레벨
                    };


                var overlays = []; // 전역 오버레이 배열
                // 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
                var map = new kakao.maps.Map(mapContainer, mapOption);

                //-----------------------------------------test-------------------
                // 장소 검색 객체를 생성합니다
                var ps = new kakao.maps.services.Places(map);
                // 지도에 idle 이벤트를 등록합니다
                kakao.maps.event.addListener(map, 'idle', searchPlaces);
                // 커스텀 오버레이의 컨텐츠 노드에 css class를 추가합니다 
                contentNode.className = 'placeinfo_wrap';

                // 커스텀 오버레이의 컨텐츠 노드에 mousedown, touchstart 이벤트가 발생했을때
                // 지도 객체에 이벤트가 전달되지 않도록 이벤트 핸들러로 kakao.maps.event.preventMap 메소드를 등록합니다 
                addEventHandle(contentNode, 'mousedown', kakao.maps.event.preventMap);
                addEventHandle(contentNode, 'touchstart', kakao.maps.event.preventMap);

                // 커스텀 오버레이 컨텐츠를 설정합니다
                placeOverlay.setContent(contentNode);

                // 엘리먼트에 이벤트 핸들러를 등록하는 함수입니다
                function addEventHandle(target, type, callback) {
                    if (target.addEventListener) {
                        target.addEventListener(type, callback);
                    } else {
                        target.attachEvent('on' + type, callback);
                    }
                }

                //카테고리 검색을 요청하는 함수입니다
                function searchPlaces() {
                    if (!currCategory) {
                        return;
                    }
                    // 커스텀 오버레이를 숨깁니다 
                    placeOverlay.setMap(null);

                    // 지도에 표시되고 있는 마커를 제거합니다
                    removeMarker();

                    ps.categorySearch(currCategory, placesSearchCB, { useMapBounds: true });

                }
                // 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
                function placesSearchCB(data, status, pagination) {
                    if (status === kakao.maps.services.Status.OK) {

                        // 정상적으로 검색이 완료됐으면 지도에 마커를 표출합니다
                        displayPlaces(data);
                    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
                        // 검색결과가 없는경우 해야할 처리가 있다면 이곳에 작성해 주세요

                    } else if (status === kakao.maps.services.Status.ERROR) {
                        // 에러로 인해 검색결과가 나오지 않은 경우 해야할 처리가 있다면 이곳에 작성해 주세요

                    }
                }

                // 지도에 마커를 표출하는 함수입니다
                function displayPlaces(places) {
                    console.log("displayPlaces 호출됨", places);
                    // 몇번째 카테고리가 선택되어 있는지 얻어옵니다
                    // 이 순서는 스프라이트 이미지에서의 위치를 계산하는데 사용됩니다


                    for (var i = 0; i < places.length; i++) {

                        // 마커를 생성하고 지도에 표시합니다
                        var marker = addMarker(new kakao.maps.LatLng(places[i].y, places[i].x));

                        // 마커와 검색결과 항목을 클릭 했을 때
                        // 장소정보를 표출하도록 클릭 이벤트를 등록합니다
                        (function (marker, place) {
                            kakao.maps.event.addListener(marker, 'click', function () {
                                displayPlaceInfo(place);
                            });
                        })(marker, places[i]);
                    }

                    var listEl = document.getElementById('place_area'),
                        fragment = document.createDocumentFragment();

                    // 장소 목록을 비웁니다
                    removeAllChildNods(listEl);

                    // 검색 결과 목록이 검색된 장소를 순회하면서
                    for (var i = 0; i < places.length; i++) {
                        // HTML 요소 생성 및 설정
                        var itemEl = document.createElement('div'), // 장소 항목을 담을 div
                            imgEl = document.createElement('div'), // 이미지를 담을 div
                            contentEl = document.createElement('div'), // 내용을 담을 div
                            img = document.createElement('img'), // 실제 이미지 요소
                            placeName = places[i].place_name, // 장소명
                            address = places[i].address_name; // 주소
                        phone = places[i].phone;//전화번호


                        itemEl.className = 'place_list';
                        imgEl.className = 'place_list_img';
                        contentEl.className = 'place_list_content';

                        (function (place) {
                            itemEl.addEventListener('click', function () {
                                // 지도의 중심을 장소의 좌표로 이동
                                var moveLatLon = new kakao.maps.LatLng(place.y, place.x);
                                map.setCenter(moveLatLon);

                                var content = '<div class="placeinfo">' + '<div>' +
                                    '   <a class="title" href="' + place.place_url + '" target="_blank" title="' + place.place_name + '">' + place.place_name + '</a>' +
                                    '   <div class="close" onclick="closeOverlay()" title="닫기"></div>' +
                                    '</div>';

                                if (place.road_address_name) {
                                    content += '    <span title="' + place.road_address_name + '">' + place.road_address_name + '</span>' +
                                        '  <span class="jibun" title="' + place.address_name + '">(지번 : ' + place.address_name + ')</span>';
                                } else {
                                    content += '    <span title="' + place.address_name + '">' + place.address_name + '</span>';
                                }

                                content += '    <span class="tel">' + place.phone + '</span>' +
                                    '</div>' +
                                    '<div class="after"></div>';

                                contentNode.innerHTML = content;
                                placeOverlay.setPosition(new kakao.maps.LatLng(place.y, place.x));
                                placeOverlay.setMap(map);
                            });
                        })(places[i]);

                        // 이미지 설정
                        if (currCategory == "HP8") {
                            img.src = '../assets/icons/ico_marker_hospital.png'; // 장소 이미지, 예제에서는 고정 이미지 사용
                        } else if (currCategory == "PM9") {
                            img.src = '../assets/icons/ico_marker_drug.png';
                        } else if (currCategory == "CS2") {
                            img.src = '../assets/icons/ico_marker_store.png';
                        } else if (currCategory == "MT1") {
                            img.src = '../assets/icons/ico_marker_mart.png';
                        }

                        img.alt = '이미지1';
                        img.className = 'img';
                        imgEl.appendChild(img);

                        // 내용 설정
                        contentEl.innerHTML = '<div>' + placeName + '</div>' +
                            '<div>' + address + '</div>' +
                            '<div>' + phone + '</div>'
                            ;

                        // div에 이미지와 내용 추가
                        itemEl.appendChild(imgEl);
                        itemEl.appendChild(contentEl);

                        // DocumentFragment에 항목 추가
                        fragment.appendChild(itemEl);
                    }

                    // #place_area에 항목들 추가
                    listEl.appendChild(fragment);
                }

                // 노드의 모든 자식을 제거하는 함수
                function removeAllChildNods(el) {
                    while (el.hasChildNodes()) {
                        el.removeChild(el.lastChild);
                    }


                }
                // 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
                function addMarker(position, order) {
                    if (currCategory == "HP8") {
                        var imageSrc = '../assets/icons/ico_marker_hospital.png';
                    } else if (currCategory == "PM9") {
                        var imageSrc = '../assets/icons/ico_marker_drug.png';
                    } else if (currCategory == "CS2") {
                        var imageSrc = '../assets/icons/ico_marker_store.png';
                    } else {
                        var imageSrc = '../assets/icons/ico_marker_mart.png';
                    }
                    imageSize = new kakao.maps.Size(27, 28),  // 마커 이미지의 크기
                        imgOptions = {
                            // spriteSize: new kakao.maps.Size(72, 208), // 스프라이트 이미지의 크기
                            // spriteOrigin: new kakao.maps.Point(46, (order * 36)), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
                            offset: new kakao.maps.Point(11, 28) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
                        },
                        markerImage = new kakao.maps.MarkerImage(imageSrc, new kakao.maps.Size(24, 35));
                    marker = new kakao.maps.Marker({
                        position: position, // 마커의 위치
                        image: markerImage
                    });

                    marker.setMap(map); // 지도 위에 마커를 표출합니다
                    markers.push(marker);  // 배열에 생성된 마커를 추가합니다

                    return marker;
                }

                // 지도 위에 표시되고 있는 마커를 모두 제거합니다
                function removeMarker() {
                    for (var i = 0; i < markers.length; i++) {
                        markers[i].setMap(null);
                    }
                    markers = [];
                }

                // 클릭한 마커에 대한 장소 상세정보를 커스텀 오버레이로 표시하는 함수입니다
                function displayPlaceInfo(place) {
                    var content = '<div class="placeinfo">' + '<div>' +
                        '   <a class="title" href="' + place.place_url + '" target="_blank" title="' + place.place_name + '">' + place.place_name + '</a>' +
                        '   <div class="close" onclick="closeOverlay()" title="닫기"></div>' +
                        '</div>';

                    if (place.road_address_name) {
                        content += '    <span title="' + place.road_address_name + '">' + place.road_address_name + '</span>' +
                            '  <span class="jibun" title="' + place.address_name + '">(지번 : ' + place.address_name + ')</span>';
                    } else {
                        content += '    <span title="' + place.address_name + '">' + place.address_name + '</span>';
                    }

                    content += '    <span class="tel">' + place.phone + '</span>' +
                        '</div>' +
                        '<div class="after"></div>';

                    contentNode.innerHTML = content;
                    placeOverlay.setPosition(new kakao.maps.LatLng(place.y, place.x));
                    placeOverlay.setMap(map);
                }

                // 커스텀 오버레이를 닫기 위해 호출되는 함수입니다 
                function closeOverlay() {
                    placeOverlay.setMap(null);
                }


                function CategoryClickEvent() {
                    searchPlaces();
                    hideOverlays(); // 모든 오버레이 숨김


                }
                // 카테고리를 클릭했을 때 호출되는 함수입니다
                function onClickCategory() {
                    var id = this.id,
                        className = this.className;

                    placeOverlay.setMap(null);

                    if (className === 'on') {
                        currCategory = '';
                        changeCategoryClass();
                        removeMarker();
                    } else {
                        currCategory = id;
                        changeCategoryClass(this);
                        searchPlaces();
                    }
                }

                // 클릭된 카테고리에만 클릭된 스타일을 적용하는 함수입니다
                function changeCategoryClass(el) {
                    var category = document.getElementById('category'),
                        children = category.children,
                        i;

                    for (i = 0; i < children.length; i++) {
                        children[i].className = '';
                    }

                    if (el) {
                        el.className = 'on';
                    }
                }

            </script>


            <script>
                $(document).ready(function () {

                    $.ajax({
                        url: 'info_container_list.do',
                        data: { "doNm": "${doNm}", "sigunguNm": "${sigunguNm}" },
                        success: function (data) {
                            $("#info_container_list").html(data);
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            console.table(jqXHR);
                        }
                    });

                });


                function filter(type) {

                    $.ajax({
                        url: 'info_container_filter.do',
                        data: { "type": type, "doNm": "${doNm}", "sigunguNm": "${sigunguNm}" },
                        success: function (data) {
                            $("#info_container_list").html(data);
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            console.table(jqXHR);
                        }
                    });

                }


                function changeContent(type) {
                    currCategory = "";
                    // searchPlaces();
                    removeMarker();

                    placeOverlay.setMap(null);
                    $.ajax({
                        url: 'info_container_place.do',
                        data: { "type": type, "doNm": "${doNm}", "sigunguNm": "${sigunguNm}" },
                        success: function (data) {
                            $("#place_area").html(data);
                            if (type == "camping") {
                                $.ajax({
                                    url: 'info_container_place_json.do',
                                    data: { "doNm": "${doNm}", "sigunguNm": "${sigunguNm}" },
                                    dataType: "json",
                                    success: function (data) {
                                        // 첫 번째 캠핑장의 위치를 지도의 중심으로 설정합니다.
                                        if (data.length > 0) {
                                            var firstCamp = data[0]; // 첫 번째 캠핑장 정보
                                            var moveLatLon = new kakao.maps.LatLng(firstCamp.mapY, firstCamp.mapX);
                                            map.setCenter(moveLatLon);

                                        }
                                        // 캠핑장 데이터를 가지고 캠핑장 마커를 추가하는 함수를 호출합니다
                                        addCampMarkers(data);

                                    },
                                    error: function (jqXHR, textStatus, errorThrown) {
                                        console.table(jqXHR);
                                    }
                                });
                            } else {
                                currCategory = type;
                                CategoryClickEvent(); // 기타 카테고리에 대한 처리
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            console.table(jqXHR);
                        }
                    });
                }
                // 지역필터 적용후 확인버튼 클릭시 실행되는 함수
                function updateMapAndMarkers(doNm, sigunguNm) {
                    // 기존 마커 제거 및 오버레이 숨김
                    removeMarker();
                    placeOverlay.setMap(null);

                    // 캠핑장 데이터를 서버로부터 요청
                    $.ajax({
                        url: 'info_container_place_json.do',
                        data: { "doNm": doNm, "sigunguNm": sigunguNm },
                        dataType: "json",
                        success: function (data) {
                            // 서버 응답으로부터 캠핑장 데이터 처리
                            if (data.length > 0) {
                                // 첫 번째 캠핑장의 위치를 지도의 중심으로 설정
                                var firstCamp = data[0];
                                var moveLatLon = new kakao.maps.LatLng(firstCamp.mapY, firstCamp.mapX);
                                map.setCenter(moveLatLon);


                                // 캠핑장 마커 추가
                                addCampMarkers(data);
                                console.log(data);
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            console.error('캠핑장 데이터 요청 실패: ', textStatus);
                        }
                    });
                }
                // 클릭한 마커에 대한 오버레이를 표시하는 함수입니다
                function displayOverlayForCampMarker(camp) {
                    // 오버레이에 표시할 HTML 내용을 생성합니다
                    var content = '<div class="placeinfo"><div>' +
                        '   <a class="title" href="detail_main.do?contentId=' + camp.contentId + '" title="' + camp.facltNm + '">' + camp.facltNm + '</a>' +
                        '   <div class="close" onclick="closeOverlay()" title="닫기"></div>' +
                        '</div>' +

                        '    <span title="' + camp.addr1 + '">' + camp.addr1 + '</span>' +
                        '  <span class="jibun" title="' + camp.addr2 + '">(지번 : ' + camp.addr2 + ')</span>';
                    content += ' <span class="tel">' + camp.tel + '</span>' +
                        '</div>' +
                        '<div class="after"></div>';



                    // 컨텐츠를 오버레이에 설정합니다
                    contentNode.innerHTML = content;

                    // 오버레이를 표시할 위치를 설정합니다
                    placeOverlay.setPosition(new kakao.maps.LatLng(camp.mapY, camp.mapX));

                    // 오버레이를 지도에 표시합니다
                    placeOverlay.setMap(map);
                }

                // 캠핑장 마커를 클릭했을 때의 이벤트 처리 함수입니다
                function handleCampMarkerClick(camp) {
                    // displayPlaceInfo 함수를 호출하여 오버레이를 표시합니다
                    displayOverlayForCampMarker(camp);
                }

                // 캠핑장 마커에 대한 이벤트 리스너를 등록합니다
                function addCampMarkerClickListener(marker, camp) {
                    kakao.maps.event.addListener(marker, 'click', function () {
                        // 캠핑장 마커를 클릭했을 때의 처리 함수를 호출합니다
                        handleCampMarkerClick(camp);
                    });
                }

                // 캠핑장 마커를 생성하고 지도에 추가하는 함수입니다
                function addCampMarkers(camps) {
                    var imageSrc = '../assets/icons/ico_marker_camp.png';

                    // 캠핑장 데이터를 순회하면서 마커를 생성하고 지도에 추가합니다
                    camps.forEach(function (camp) {
                        var markerPosition = new kakao.maps.LatLng(camp.mapY, camp.mapX);
                        var markerImage = new kakao.maps.MarkerImage(imageSrc, new kakao.maps.Size(24, 35));

                        // 마커를 생성합니다
                        var marker = new kakao.maps.Marker({
                            position: markerPosition,
                            map: map,
                            image: markerImage
                        });

                        // 마커를 클릭했을 때의 이벤트 리스너를 등록합니다
                        addCampMarkerClickListener(marker, camp);
                    });
                }
                function hideOverlays() {
                    for (var i = 0; i < overlays.length; i++) {
                        overlays[i].setMap(null); // 오버레이 숨김
                    }
                }



            </script>

        </head>

        <body>

            <!-- 지도를 표시할 div 입니다 -->
            <div class="map-container">
                <div id="map"></div>
                <div id="info_container_list"></div>
            </div>

        </body>

        </html>