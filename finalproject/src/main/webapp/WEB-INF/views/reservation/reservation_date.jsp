<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <!DOCTYPE html>
  <html>

  <head>
    <meta charset="UTF-8">
    <title>캠프로버</title>
  </head>
  <script>
    var min = "${room_vo.room_min}";
    var max = "${room_vo.room_max}";
    var room_in = "${room_vo.room_in}";
    var room_out = "${room_vo.room_out}";
    var res_checkindate ="";
    var res_checkoutdate="";
    var dateArray;
    var checkDate;
    var checkDays;
    var indete = "";
    var outdete = "";
  </script>
  
  <script>
    function getAllDates(startDate, endDate) {
        var dates = [];
        var currentDate = new Date(startDate);

        while (currentDate < endDate) {
            // Date 객체를 추가하기 전에 새 Date 인스턴스를 만들어서 원본 날짜가 변하지 않도록 함
            dates.push(new Date(currentDate));
            // 현재 날짜에 하루를 더함
            currentDate.setDate(currentDate.getDate() + 1);
        }

        return dates;
    }

    // Date 객체 배열을 ISO 문자열 배열로 변환
    function formatDateArray(dates) {
        return dates.map(function(date) {
            return date.toISOString().substring(0, 10);  // YYYY-MM-DD 형식으로 변환
        });
    }

  </script>
  <script>
    $(document).ready(function(){
        const $calendar = $(".contents-date");
        var currentDate = new Date();
        var endDate = new Date(currentDate.getFullYear(), currentDate.getMonth() + 3, currentDate.getDate()-1); // 현재일로부터 3개월 후의 마지막 날짜 계산
        $.ajax({

          url: "select_res_list.do",
          data:{"room_idx":"${room_idx}"},
          dataType: "json",
          success: function (res_list) {
            $(".glamping-N33").each(function() {
            const $calendar = $(".contents-date");
            $calendar.dateRangePicker({ 
              container: '.glamping-N33 .contents-top',
              language: 'custom',
              inline: true,
              alwaysOpen: true,
              startDate: currentDate,
              endDate: endDate,
              beforeShowDay: function(date) {
                // 각 예약 정보에 대해 루프를 돌면서 선택 가능한 날짜인지 확인
                for (var i = 0; i < res_list.length; i++) {
                  var checkin = new Date(res_list[i].res_checkindate);
                  var checkout = new Date(res_list[i].res_checkoutdate);

                  // 현재 날짜가 예약 기간 내에 있는지 확인하여 선택 가능한 날짜 결정
                  if (date >= checkin && date <= checkout) {
                    return [false, "booked", "This date is booked"]; // 선택 불가능한 날짜
                  }
                }
                return [true, "", ""]; // 선택 가능한 날짜
              }
            }).bind('datepicker-first-date-selected', function(event, obj) {
              $('.separator-day').html("~");
            }).bind('datepicker-change', function(event, obj) {
              $('.separator-day').html("~");
              var dateString = obj.value;
              dateArray = dateString.split(" to ");
              res_checkindate = convertToMySQLDate(dateArray[0])+" "+room_in;
              res_checkoutdate = convertToMySQLDate(dateArray[1])+" "+room_out;
              indate = convertToMySQLDate(dateArray[0]);
              outdate = convertToMySQLDate(dateArray[1]);
              date1 = new Date(convertToMySQLDate(dateArray[0]));
              date2 = new Date(convertToMySQLDate(dateArray[1]));
              console.log(date1);
              console.log(date2);

              var difference = date2.getTime() - date1.getTime(); // 밀리초 단위의 차이

              // 밀리초를 일수로 변환
              checkDays = difference / (1000 * 3600 * 24);
              

              var allDates = getAllDates(date1, date2);
              checkDate = formatDateArray(allDates);
              
              console.log(checkDate);

              
            });
            }); 
          },
          error: function (jqXHR, textStatus, errorThrown) {
            console.table(jqXHR)
          }
        });
        

    })
  </script>
  <script>
    function convertToMySQLDate(dateString) {
    var parts = dateString.split("-");
    return parts[0] + "-" + parts[1] + "-" + parts[2];
    }
  </script>
  <script>
    function reservation(){
      var res_peopleadult  = parseInt($("#adult").text());
      var res_peoplechild  = parseInt($("#child").text());
      var res_peopletoddler = parseInt($("#infant").text());
      var animalCmgCl = $("#animalCmgCl").text();
      var room_idx = "${room_vo.room_idx}";

      if(res_checkindate == "" || res_checkoutdate==""){
        alert("체크인/체크아웃일자를 선택해주세요.");
        return;
      }

      if(indate == outdate){
        alert("체크인/체크아웃일자는 같은 일자일 수 없습니다.");
        return;
      }
      console.log(room_idx);
      var formData = new FormData();
      formData.append('room_idx', room_idx);
      formData.append('res_peopleadult', res_peopleadult);
      formData.append('res_peoplechild', res_peoplechild);
      formData.append('res_peopletoddler', res_peopletoddler);
      formData.append('animalCmgCl', animalCmgCl);
      formData.append('res_checkindate', res_checkindate);
      formData.append('res_checkoutdate', res_checkoutdate);
      formData.append('checkDays', checkDays);
      checkDate.forEach(function(date) {
          formData.append('checkDate', date);
      });


      $.ajax({
        method:"post",
        url: "isert_form.do",
        data: formData,
        processData: false,
        contentType: false,
        success: function (res_data) {
          $("#container").html(res_data);
          $.getScript("${pageContext.request.contextPath}/assets/js/domain.js");
          $.getScript("${pageContext.request.contextPath}/assets/js/template.js");
        },
        error: function (jqXHR, textStatus, errorThrown) {
          console.table(jqXHR)
        }
      });


    }
  </script>
  <body>

  <main class="th-layout-main ">
    
    <!-- [S]glamping-N33 -->
    <div class="glamping-N33" data-bid="vfLtWpiFmM">
      <div class="contents-inner">
        <div class="contents-container container-md">
          <div class="contents-top">
            <div class="contents-date"></div>
          </div>
          <div class="contents-bottom">
            <h2 class="contents-tit">인원선택</h2>
            <ul class="contents-list">
              <!-- <li class="contents-item">
                <p class="contents-label">기간</p>
                <div class="contents-amount">
                  <button class="contents-btn btn-minus" type="button">
                    <img src="../assets/icons/ico_minus_black.svg" alt="마이너스 아이콘">
                  </button>
                  <p class="contents-amount-num">
                    <span>2</span>박
                  </p>
                  <button class="contents-btn btn-plus" type="button">
                    <img src="../assets/icons/ico_plus_black.svg" alt="플러스 아이콘">
                  </button>
                </div>
              </li> -->
              <li class="contents-item">
                <p class="contents-label">성인</p>
                <div class="contents-amount">
                  <button class="contents-btn btn-minus" type="button">
                    <img src="../assets/icons/ico_minus_black.svg" alt="마이너스 아이콘">
                  </button>
                  <p class="contents-amount-num">
                    <span id="adult">2</span>명
                  </p>
                  <button class="contents-btn btn-plus" type="button">
                    <img src="../assets/icons/ico_plus_black.svg" alt="플러스 아이콘">
                  </button>
                </div>
              </li>
              <li class="contents-item">
                <p class="contents-label">소인</p>
                <div class="contents-amount">
                  <button class="contents-btn btn-minus" type="button">
                    <img src="../assets/icons/ico_minus_black.svg" alt="마이너스 아이콘">
                  </button>
                  <p class="contents-amount-num">
                    <span id="child">0</span>명
                  </p>
                  <button class="contents-btn btn-plus" type="button">
                    <img src="../assets/icons/ico_plus_black.svg" alt="플러스 아이콘">
                  </button>
                </div>
              </li>
              <li class="contents-item">
                <p class="contents-label">유아</p>
                <div class="contents-amount">
                  <button class="contents-btn btn-minus" type="button">
                    <img src="../assets/icons/ico_minus_black.svg" alt="마이너스 아이콘">
                  </button>
                  <p class="contents-amount-num">
                    <span id="infant">0</span>명
                  </p>
                  <button class="contents-btn btn-plus" type="button">
                    <img src="../assets/icons/ico_plus_black.svg" alt="플러스 아이콘">
                  </button>
                </div>
              </li>
              <li class="contents-item">
                <p class="contents-label">반려견 동행</p>
                <div class="selectset selectset-round selectset-md">
                  <button class="selectset-toggle btn" type="button">
                    <span class="span_pre_si2" id="animalCmgCl">미동행</span>
                  </button>
                  <ul class="selectset-list">
                    <ul class="ul_list">
                      <li class="selectset-item">
                        <button class="selectset-prefer btn" type="button" data-value="동행">
                          <span>동행</span>
                        </button>
                      </li>
                      <li class="selectset-item">
                        <button class="selectset-prefer btn" type="button" data-value="미동행">
                          <span>미동행</span>
                        </button>
                      </li>
                    </ul>
                  </ul>
                </div>
              </li>
            </ul>
            <span class="contents-desc">* 성인은 20세이상, 소인은 8~19세, 유아는 0세~7세까지 입니다.</span>
          </div>
          <input class="btnset btnset-round" type="button" onclick="reservation();" value="예약하기">
        </div>
      </div>
    </div>
    <!-- [E]glamping-N33 -->
  </main>
  <script>
    $(".glamping-N33").each(function() {
      const $block = $(this);
      // const $calendar = $block.find(".contents-date")
      // Date Range Picker
      // $calendar.dateRangePicker({
      //   container: '.glamping-N33 .contents-top',
      //   //language:'ko',
      //   language: 'custom',
      //   inline: true,
      //   alwaysOpen: true,
      //   startDate: new Date(),
      // }).bind('datepicker-first-date-selected', function(event, obj) {
      //   $('.separator-day').html("~");
      //   // console.log(obj);
      // }).bind('datepicker-change', function(event, obj) {
      //   $('.separator-day').html("~");
      //   // console.log(obj);

      // });
      
      // Amount Count Button Click Event
      $block.find(".contents-amount").each(function() {
        
        const $this = $(this);
        const $amountNumElement = $this.find(".contents-amount-num span");
        $this.on("click", ".btn-minus", function() {
          // console.log("안녕");
          var adult = parseInt($("#adult").text());
          var child = parseInt($("#child").text());
          var infant = parseInt($("#infant").text());
          let amountNum = parseInt($amountNumElement.text());
          if(amountNum>0){
            if(min>=(adult+child+infant)){
              alert("최소인원 보다 적은 인원수를 예약 할 수 없습니다.");
            }else{
              amountNum--;
            }
          }
          $amountNumElement.text(amountNum);
        });
        $this.on("click", ".btn-plus", function() {
          var adult = parseInt($("#adult").text());
          var child = parseInt($("#child").text());
          var infant = parseInt($("#infant").text());
          let amountNum = parseInt($amountNumElement.text());
          if(max>(adult+child+infant)){
            amountNum++;
          }else{
            alert("최대인원을 초과하여 예약하실 수 없습니다.");
          }
          $amountNumElement.text(amountNum);
        });
      });
    });
  </script>
  </body>

  </html>