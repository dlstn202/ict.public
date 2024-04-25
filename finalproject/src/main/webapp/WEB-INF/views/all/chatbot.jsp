<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>캠프로버</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/chatbot.css">
<script>
    function openChatBotModal(){

        $.ajax({
            type: "POST",
            url: "chat_start.do",
            success: function (result) {

                if(result.thread_id!=null){
                    $("#thread_id_input").val(result.thread_id);

                    $("#ChatbotModal").modal('show');
                    $("#ChatbotModal").modal({backdrop : "static"});
                }else{
                    alert("다시 시도해주세요");
                }
                
            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.table(jqXHR)
            }
        });

        
    }
</script>
<script>

    function send_gpt(f, event) {
        event.preventDefault();

        // let content = document.getElementById('content');
        let content     = f.content.value.trim();
        let thread_id   = f.thread_id.value.trim();

        f.content.value = '';
        
        $('#chat-messages').append('<div class="message">' + content + '</div>');
        scrollToEnd();

        $.ajax({
            url: "chat_send.do",
            data:{ "content":content, "thread_id":thread_id },
            dataType:"json",
            success: function (result) {
                // 결과를 화면에 추가
                $('#chat-messages').append('<div class="message">' + result.message + '</div>');
                scrollToEnd(); // 새 메시지가 추가될 때마다 스크롤

            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.table(jqXHR)
            }
        });

    }

    // 스크롤을 맨 아래로 이동시키는 함수
function scrollToEnd() {
    var chatContainer = $('#chat-messages');
    chatContainer.scrollTop(chatContainer.prop('scrollHeight'));
}


</script>
<script>


$(document).ready(function(){
    $('#ChatbotModal').on('hidden.bs.modal', function () {
        // 모달이 닫힐 때 실행할 함수 호출
        close_chat();
    });
});

function close_chat() {

    let thread_id = $("#thread_id_input").val();

    $.ajax({
            type: "POST",
            data:{"thread_id":thread_id},
            dataType:"json",
            url: "chat_finish.do",
            success: function (result) {
                if(result.deleted=="true"){
                    alert("채팅이 종료되었습니다");
                }else{
                    alert("채팅이 비정상적으로 종료되었습니다");
                }
                
            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.table(jqXHR)
            }
        });
}
</script>


</head>
<body>

<!-- 챗봇 모달 -->
<div id="ChatbotModal" class="modal fade" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <p class="modal-title"><a onclick="">캠프로버에 질문해보세요</a></p>
            </div>
            <div class="modal-body">

                <form>
                    <div class="chatbot_wrap">
                        <div id="chat-container">
                            <div id="chat-messages"></div>
                            <div id="user-input">   
                                <input type="text" class="form-control chat_input" id="content" name="content" value="" placeholder="질문을 보내주세요" />
                                <!-- <input type="button" class="gptbtn" value="전송" onclick="send_gpt(this.form);"> -->
                                <input type="hidden" id="thread_id_input" name="thread_id" value="${thread_id}">
                                <button class="gptbtn" onclick="send_gpt(this.form, event);">전송</button>
                
                            </div>
                        </div>
                    </div>
                </form>


            </div>
        </div>
    </div>
</div>
</body>
</html>