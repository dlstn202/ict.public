<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>

// document.addEventListener("DOMContentLoaded", function() {
//     document.querySelectorAll('.story_content').forEach(function(content) {
//         // 설정된 line-height를 기반으로 최대 높이 계산
//         const lineHeight = parseFloat(window.getComputedStyle(content).lineHeight);
//         const maxHeight = lineHeight * 5; // 5줄에 해당하는 최대 높이

//         // content의 실제 높이가 계산된 최대 높이를 초과하는지 확인
//         if (content.scrollHeight > maxHeight) {
//             // "자세히보기" 버튼을 찾아서 보이게 함
//             const showAllButton = content.nextElementSibling; // .story_content 바로 다음에 위치한 .show_all 버튼을 가정
//             if (showAllButton && showAllButton.classList.contains('show_all')) {
//                 showAllButton.style.display = 'inline'; // 또는 'block'으로 설정
//             }
//         }
//     });
// });

function showAll(element) {
    var storyBox = element.closest('.storybox');
    var content = storyBox.querySelector('.story_content');
    content.classList.toggle('expanded');

    // "자세히보기"와 "숨기기" 텍스트 토글
    element.textContent = element.textContent === "자세히보기" ? "숨기기" : "자세히보기";
}

</script>
</head>
<body>
<div class="story_filterwrap">
    <div class="selectset selectset-round selectset-md story_filter">
        <button class="selectset-toggle btn" type="button">
            <span>필터</span>
        </button>
        <ul class="selectset-list">
            <ul class="ul_list">
                <li class="selectset-item">
                <button class="selectset-story btn" type="button" data-value="" selected="">
                    <span>최신순</span>
                </button>
                </li>
                <li class="selectset-item">
                <button class="selectset-story btn" type="button" data-value="">
                    <span>좋아요순</span>
                </button>
                </li>
                <li class="selectset-item">
                <button class="selectset-story btn" type="button" data-value="">
                    <span>리뷰갯수순</span>
                </button>
                </li>
            </ul>
        </ul>
    </div>
</div>


<div class="story_bigwrap"> 
<div class="story_wrap">
    <div class="storybox">
        <div class="story_photo"><img src="${pageContext.request.contextPath}/assets/img/sample/img_glamping_N7_1.png"></div>
        <div class="story_title">즐거운 캠핑장</div>
        <div class="story_content" >1 즐겁게 캠핑을 다녀왔다즐겁게 캠핑을 다녀왔다즐겁게 캠핑을 다녀왔다즐겁게 캠핑을 다녀왔다즐겁게 캠핑을 다녀왔다즐겁게 캠핑을 다녀왔다즐겁게 캠핑을 다녀왔다즐겁게 캠핑을 다녀왔다즐겁게 캠핑을 다녀왔다즐겁게 캠핑을 다녀왔다즐겁게 캠핑을 다녀왔다즐겁게 캠핑을 다녀왔다즐겁게 캠핑을 다녀왔다즐겁게 캠핑을 다녀왔다즐겁게 캠핑을 다녀왔다즐겁게 캠핑을 다녀왔다즐겁게 캠핑을 다녀왔다즐겁게 캠핑을 다녀왔다즐겁게 캠핑을 다녀왔다즐겁게 캠핑을 다녀왔다즐겁게 캠핑을 다녀왔다즐겁게 캠핑을 다녀왔다즐겁게 캠핑을 다녀왔다즐겁게 캠핑을 다녀왔다즐겁게 캠핑을 다녀왔다즐겁게 캠핑을 다녀왔다즐겁게 캠핑을 다녀왔다즐겁게 캠핑을 다녀왔다즐겁게 캠핑을 다녀왔다즐겁게 캠핑을 다녀왔다즐겁게 캠핑을 다녀왔다즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 </div>
        <div class="show_all" onclick="showAll(this)">자세히보기</div>
        <div class="stroy_writer_date">
          <div class="story_writer">금쪽일</div>
          <div class="story_date">2024-03-19</div>
        </div>
    </div>

    <div class="storybox">
        <div class="story_photo"><img src="${pageContext.request.contextPath}/assets/img/sample/img_mainvisual_mobile_03.png"></div>
        <div class="story_title">즐거운 캠핑장</div>
        <div class="story_content">2 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 </div>
        <div class="show_all" onclick="showAll(this)">자세히보기</div>
        <div class="stroy_writer_date">
            <div class="story_writer">금쪽일</div>
            <div class="story_date">2024-03-19</div>
          </div>
    </div>

    <div class="storybox">
        <div class="story_photo"><img src="${pageContext.request.contextPath}/assets/img/sample/img_glamping_N7_1.png"></div>
        <div class="story_title">즐거운 캠핑장</div>
        <div class="story_content">3 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다</div>
        <div class="show_all" onclick="showAll(this)">자세히보기</div>
        <div class="stroy_writer_date">
            <div class="story_writer">금쪽일</div>
            <div class="story_date">2024-03-19</div>
          </div>
    </div>
    

</div>
<div class="story_wrap">

    <div class="storybox">
        <div class="story_photo"><img src="${pageContext.request.contextPath}/assets/img/sample/img_glamping_N7_1.png"></div>
        <div class="story_title">즐거운 캠핑장</div>
        <div class="story_content">4 즐겁게 캠핑을 다녀왔다즐겁게 캠핑을 다녀왔다즐겁게 캠핑을 다녀왔다즐겁게 캠핑을 다녀왔다즐겁게 캠핑을 다녀왔다즐겁게 캠핑을 다녀왔다즐겁게 캠핑을 다녀왔다즐겁게 캠핑을 다녀왔다즐겁게 캠핑을 다녀왔다즐겁게 캠핑을 다녀왔다즐겁게 캠핑을 다녀왔다즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다</div>
        <div class="show_all" onclick="showAll(this)">자세히보기</div>
        <div class="stroy_writer_date">
            <div class="story_writer">금쪽일</div>
            <div class="story_date">2024-03-19</div>
          </div>
    </div>

    <div class="storybox">
        <div class="story_photo"><img src="${pageContext.request.contextPath}/assets/img/sample/img_glamping_N7_1.png"></div>
        <div class="story_title">즐거운 캠핑장</div>
        <div class="story_content">5 즐겁게 캠핑을 다녀왔다즐겁게 캠핑을 다녀왔다즐겁게 캠핑을 다녀왔다즐겁게 캠핑을 다녀왔다즐겁게 캠핑을 다녀왔다즐겁게 캠핑을 다녀왔다즐겁게 캠핑을 다녀왔다즐겁게 캠핑을 다녀왔다즐겁게 캠핑을 다녀왔다즐겁게 캠핑을 다녀왔다즐겁게 캠핑을 다녀왔다즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다</div>
        <div class="show_all" onclick="showAll(this)">자세히보기</div>
        <div class="stroy_writer_date">
            <div class="story_writer">금쪽일</div>
            <div class="story_date">2024-03-19</div>
          </div>
    </div>

    <div class="storybox">
        <div class="story_photo"><img src="${pageContext.request.contextPath}/assets/img/sample/img_glamping_N7_1.png"></div>
        <div class="story_title">즐거운 캠핑장</div>
        <div class="story_content">6 즐겁게 캠핑을 다녀왔다즐겁게 캠핑을 다녀왔다즐겁게 캠핑을 다녀왔다즐겁게 캠핑을 다녀왔다즐겁게 캠핑을 다녀왔다즐겁게 캠핑을 다녀왔다즐겁게 캠핑을 다녀왔다즐겁게 캠핑을 다녀왔다즐겁게 캠핑을 다녀왔다즐겁게 캠핑을 다녀왔다즐겁게 캠핑을 다녀왔다즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다 즐겁게 캠핑을 다녀왔다즐겁게 캠핑을 다녀왔다 </div>
        <div class="show_all" onclick="showAll(this)">자세히보기</div>
        <div class="stroy_writer_date">
            <div class="story_writer">금쪽일</div>
            <div class="story_date">2024-03-19</div>
          </div>
    </div>



</div>
</div>
</body>
</html>