<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
    <meta charset="UTF-8">
    <!----------- CSS --------------->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css?version=1.0.0">
    <!----------- 아이콘 CSS 링크 ------->
    <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css">
    
    <title>채팅 테스트</title>
    <style>

        * {
            border: 1px solid var(--border-color);
        }

        .chat-wrap {
            height: 100vh;
            min-height: 400px;
            min-width: 740px;
            display: flex;
        }
        

        .chat-content {
            width: 500px;
        }
        
  
        .chat-message-view {
            height: calc(100% - 100px);
        }
        .chat-input-wrap {
            height: 60px;
            display: flex;
        }
        .chat-input {
            height: 30px;
            display: flex;
            margin: auto;
        }
        .chat-input > input {
            width: 400px;
            font-size: 12px;
            border-radius: 20px;
            padding-left: 10px;
            padding-right: 10px;
        }
        .chat-input > input:focus {
            outline: 1px solid rgb(255, 146, 139);
        }
        .chat-input > button {
            width: 40px;
            color: white;
            font-weight: bold;
            border: none;
            border-radius: 20px;
            background-color: rgb(255, 146, 139);
            margin-left: 10px;
        }
       

        .chat-list {
            width: 300px;
            overflow-y: scroll;
        }
        .chat-list::-webkit-scrollbar {
	        display: none;
        }

        .chat-room {
            width: 100%;
            height: 65px;
            display: flex;
        }
        .chat-room:hover {
            background-color: rgb(255, 248, 248);
        }
        .chat-room-picture {
            width: 20%;
            display: flex;
        }
        .chat-room-picture > div {
            width: 50px;
            height: 50px;
            border-radius: 30px;
            margin: auto;
            background-color: white;
            display: flex;
        }
        .chat-room-picture > div > img {
            width: 38px;
            height: 38px;
            margin: auto;
            border: none;
        }

        .chat-room-content {
            width: 80%;
        }
        .chat-room-title {
            height: 50%;
            font-size: 12px;
            font-weight: bold;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
            padding-top: 6px;
            padding-right: 4px;
        }
        .chat-room-last-message-wrap {
            height: 50%;
            display: flex;
            padding-right: 4px;
        }
        .chat-room-last-message{
            width: 75%;
            height: 100%;
            font-size: 12px;
            margin: auto;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
            padding-top: 6px;
        }
        .chat-room-last-message-time {
            width: 25%;
            height: 100%;
            font-size: 1px;
            text-align: right;
            margin: auto;
            padding-top: 6px;
        }

      

        .chat-user-list-accordion {
            height: 40px;
        }
        .accordion-switch {
            width: 44px;
            height: 100%;
            display: block;
            padding-left: 10px;
            border-bottom: 0;
        }
        .accordion-switch > i {
            font-size: 30px;
            width: 100%;
            height: 100%;
            display: flex;
            justify-content: center;
            align-items: center;
            cursor: pointer;
        }
        .chat-user-list {
            max-height: 0;
            transition: var(--tran-07);
            overflow: hidden;
            padding-left: 20px;
            padding-right: 20px;
            padding-bottom: 20px;
            display: none;
        }
 
        .chat-user {
            width: 100%;
            height: 50px;
            display: flex;
        }
        .chat-user:hover {
            background-color: rgb(255, 248, 248);
        }
        .chat-user-picture {
            width: 10%;
            height: 100%;
            display: flex;
        }
        .chat-user-picture > div {
            width: 40px;
            height: 40px;
            margin: auto;
            border-radius: 20px;
            background-color: white;
            display: flex;
        }
        .chat-user-picture > div > img {
            width: 30px;
            height: 30px;
            margin: auto;
            border: none;
        }
        .chat-user-nickname {
            width: 90%;
            height: 100%;
            padding-top: 15px;
            padding-left: 10px;
            font-size: 12px;
            font-weight: bold;
        }


        .contextmenu-wrap {
            position: absolute;
            width: 200px;
            display: none;
            padding: 10px;
            border-radius: 10px;
            background-color: white;
            box-shadow: 2px 2px 4px 0 grey;
        }
        .contextmenu {
            font-size: 12px;
            font-weight: bold;
            padding: 5px;
        }
        .contextmenu:hover {
            background-color: rgb(224, 224, 224);
            cursor: pointer;
        }


        .modal-overlay {
            width: 100%;
            height: 100%;
            position: absolute;
            top: 0;
            left: 0;
            display: none;
            background-color: rgba(95, 158, 160, 0.5);
        }
        .modal-wrap {
            width: 330px;
            height: 170px;
            margin: auto;
            text-align: center;
            padding: 10px;
            border-radius: 5px;
            background-color: white;
            box-shadow: 2px 2px 4px 0 grey;
        }
        .modal-message {
            height: 60%;
            padding-top: 34px;
            font-size: 14px;
        }
        .modal-button {
            height: 40%;
            display: flex;
            padding-left: 30px;
            padding-right: 30px;
        }
        .modal-button > div {
            width: 100px;
            height: 30px;
            border-radius: 5px;
            color: white;
            font-weight: bold;
            margin: auto;
            padding-top: 2px;
            cursor: pointer;
        }
        .modal-button-cancel {
            background-color: rgb(158, 158, 158);
        }
        .modal-button-confirm {
            background-color: rgb(250, 188, 186);
        }

    </style>
    </head>
    <body>

        

        <div class="chat-wrap">

            <div class="chat-content">

                <div class="chat-user-list-accordion">
                    
                    


                    <div class="accordion-switch" onclick="accordionSwitch();">
                        <i class="uil uil-angle-down"></i>
                    </div>

                    <div class="chat-user-list">
                        
                        <div class="chat-user">
                            <div class="chat-user-picture">
                                <div>
                                    <img src="${pageContext.request.contextPath}/resources/img/profile.png">
                                </div>
                            </div>
                            <div class="chat-user-nickname">
                                홍은동배드민턴맨
                            </div>
                        </div>
                        <div class="chat-user">
                            <div class="chat-user-picture">
                                <div>
                                    <img src="${pageContext.request.contextPath}/resources/img/profile.png">
                                </div>
                            </div>
                            <div class="chat-user-nickname">
                                귀여운어피치
                            </div>
                        </div>
                        <div class="chat-user">
                            <div class="chat-user-picture">
                                <div>
                                    <img src="${pageContext.request.contextPath}/resources/img/profile.png">
                                </div>
                            </div>
                            <div class="chat-user-nickname">
                                배드민턴 매니아
                            </div>
                        </div>

                    </div>


                </div>

                <div class="chat-message-view">

                </div>

                <div class="chat-input-wrap">

                    <div class="chat-input">

                        <input type="text" placeholder="메시지를 입력해주세요...">

                        <button>전송</button>

                    </div>

                </div>

            </div>

            <div class="chat-list">

                <div class="chat-room">

                    <div class="chat-room-picture">
                        <div>
                            <img src="${pageContext.request.contextPath}/resources/img/profile.png">
                        </div>
                    </div>

                    <div class="chat-room-content">

                        <div class="chat-room-title">
                            홍은동배드민턴맨님의 모임 채팅방
                        </div>

                        <div class="chat-room-last-message-wrap">

                            <div class="chat-room-last-message">
                                ㅎㅇㅎㅇㅎㅇㅎㅇㅎㅇㅎㅇㅎㅇㅎㅎㅇㅎㅇㅎ
                            </div>

                            <div class="chat-room-last-message-time">
                                24시간 전
                            </div>

                        </div>

                    </div>

                </div>

                <div class="chat-room">

                    <div class="chat-room-picture">
                        <div>
                            <img src="${pageContext.request.contextPath}/resources/img/profile.png">
                        </div>
                    </div>

                    <div class="chat-room-content">

                        <div class="chat-room-title">
                            홍은동배드민턴맨님의 모임 채팅방
                        </div>

                        <div class="chat-room-last-message-wrap">

                            <div class="chat-room-last-message">
                                ㅎㅇㅎㅇㅎㅇㅎㅇㅎㅇㅎㅇㅎㅇㅎㅎㅇㅎㅇㅎ
                            </div>

                            <div class="chat-room-last-message-time">
                                24시간 전
                            </div>

                        </div>

                    </div>

                </div>

            </div>

        </div>


        <div class="contextmenu-wrap chat-user-contextmenu">
            <div class="contextmenu" onclick="changeHost();">
                방장 위임
            </div>
            <div class="contextmenu">
                강퇴
            </div>
        </div>

        <div class="contextmenu-wrap chat-room-contextmenu">
            <div class="contextmenu">
                채팅방 이름 변경
            </div>
            <div class="contextmenu">
                채팅방 나가기
            </div>
        </div>

        <div class="modal-overlay change-host-modal">
            <div class="modal-wrap">
                <div class="modal-message">
                    OOO 님으로 변경하시겠습니까?
                </div>
                <div class="modal-button">
                    <div class="modal-button-cancel" onclick="cancelChangeHost();">취소</div>
                    <div class="modal-button-confirm" onclick="confirmChangeHost();">확인</div>
                </div>
            </div>
        </div>

        <script>

            /*  */
            var chatUserList = document.getElementsByClassName('chat-user-list')[0];
            var chatUserListStyle = window.getComputedStyle(chatUserList);
            var uilAngleDown = document.getElementsByClassName('uil-angle-down')[0];

            function accordionSwitch() {
                
                if (chatUserListStyle.display == 'none') {
                    
                    chatUserList.style.display = 'block';
                    chatUserList.style.maxHeight = '800px';
                    uilAngleDown.style.color = 'rgb(255, 146, 139)';
                }
                else {

                    chatUserList.style.display = 'none';
                    uilAngleDown.style.color = 'rgb(0, 0, 0)';
                }
            };

            /*  */
            var chatUserContextmenu = document.querySelector('.chat-user-contextmenu');
            var chatRoomContextmenu = document.querySelector('.chat-room-contextmenu');

            function showChatUserContextmenu (show = true) {

                chatUserContextmenu.style.display = show ? 'block' : 'none';
            };

            function showChatRoomContextmenu (show = true) {

                chatRoomContextmenu.style.display = show ? 'block' : 'none';
            };

            window.addEventListener('contextmenu', function(e) {

                e.preventDefault();
                
                var chatUser = document.getElementsByClassName('chat-user');
                var chatRoom = document.getElementsByClassName('chat-room');
                
                for (let i = 0; i < chatUser.length; i++) {

                    if (e.target.closest('.chat-user') == chatUser[i]) {
                        
                        showChatUserContextmenu();
                        break;
                    }
                    else {
                        
                         showChatUserContextmenu(false);
                    }
                }

                for (let i = 0; i < chatRoom.length; i++) {

                    if (e.target.closest('.chat-room') == chatRoom[i]) {
                        
                        showChatRoomContextmenu();
                        break;
                    }
                    else {
                        
                        showChatRoomContextmenu(false);
                    }
                }

                chatUserContextmenu.style.top = e.y + 'px';
                chatUserContextmenu.style.left = e.x + 'px';
                chatRoomContextmenu.style.top = e.y + 'px';
                chatRoomContextmenu.style.left = e.x + 'px';
            });

            window.addEventListener('click', function(e) {

                showChatUserContextmenu(false);
                showChatRoomContextmenu(false);
            });



            /* */
            var changeHostModal = document.getElementsByClassName('change-host-modal')[0];

            changeHostModal.addEventListener('click', function(e) {

                if (e.target.classList.contains('modal-overlay')) {
                    
                    changeHostModal.style.display = 'none';
                }
            });

            function changeHost() {

                changeHostModal.style.display = 'flex';
            };

            function cancelChangeHost() {

                changeHostModal.style.display = 'none';
            };

            function confirmChangeHost() {

                changeHostModal.style.display = 'none';
            };


















        </script>

    </body>
</html>