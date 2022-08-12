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
        .chat-wrap {
            height: 100vh;
            min-height: 400px;
            min-width: 740px;
            display: flex;
        }

        /* ---------- 채팅 영역 ---------- */
        .chat-content {
            width: 600px;
            border-top: 1px solid var(--border-color);
            border-right: 1px solid var(--border-color);
        }

        /* ---------- 채팅방 유저 목록 영역 ---------- */
        .chat-user-list-accordion {
            height: 40px;
            border-bottom: 1px solid var(--border-color);
        }

        /* ---------- 채팅방 유저 목록 ON / OFF 스위치 ---------- */
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

        /* ---------- 채팅방 유저 목록 ---------- */
        .chat-user-list {
            max-height: 0;
            transition: all 2s;
            overflow: hidden;
            padding-left: 20px;
            padding-right: 20px;
            padding-bottom: 0;
            background-color: white;
            z-index: 1;
            position: relative;
            border-bottom: 1px solid var(--border-color);
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
            border: 1px solid var(--border-color);
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
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        /* ---------- 채팅방 메시지 표시 영역 ---------- */
        .chat-view {
            height: calc(100% - 100px);
            overflow-y: scroll;
        }
        .chat-view::-webkit-scrollbar {
	        display: none;
        }
        /* 채팅방 날짜 표시 */
        .chat-date-wrap {
            display: flex;
            padding: 10px 10px;
        }
        .chat-date {
            text-align: center;
            margin: auto;
            padding: 2px 20px;
            border-radius: 20px;
            font-size: 10px;
            font-weight: bold;
            color: rgb(131, 131, 131);
            background-color: rgb(230, 230, 230);
        }
        /* 채팅방 상대방 메시지 */
        .another-user-chat-wrap {
            width: 55%;
            display: flex;
            padding: 10px;
        }
        .another-user-picture {
            width: 42px;
            height: 100%;
            display: flex;
        }
        .another-user-picture > div {
            width: 40px;
            height: 40px;
            margin: auto;
            border-radius: 20px;
            background-color: white;
            display: flex;
            border: 1px solid var(--border-color);
        }
        .another-user-picture > div > img {
            width: 30px;
            height: 30px;
            margin: auto;
            border: none;
        }
        .another-user-message-wrap-1 {
            width: calc(100% - 42px);
            margin-left: 10px;
        }
        .another-user-nickname {
            font-size: 12px;
            font-weight: bold;
        }
        .another-user-message-wrap-2 {
            display: flex;
            margin-top: 5px;
        }
        .another-user-chat-message {
            max-width: 80%;
            font-size: 12px;
            word-break: break-all;
            padding: 10px;
            border-radius: 20px;
            background-color: white;
            border: 1px solid var(--border-color);
        }
        .another-user-chat-message-time {
            width: 20%;
            min-width: 55.91px;
            font-size: 10px;
            display: flex;
            justify-content: end;
            align-items: flex-end;
        }
        /* 채팅방 내 메시지 */
        .my-chat-wrap {
            width: 45%;
            display: flex;
            padding: 10px;
            margin-left: 55%;
            justify-content: right;
        }
        .my-chat-message-time {
            width: 20%;
            min-width: 55.91px;
            font-size: 10px;
            display: flex;
            align-items: flex-end;
        }
        .my-chat-message {
            max-width: 80%;
            font-size: 12px;
            word-break: break-all;
            padding: 10px;
            border-radius: 20px;
            background-color: rgb(224, 224, 224);
            border: 1px solid var(--border-color);
        }

        /* ---------- 채팅방 메시지 입력 영역 ---------- */
        .chat-input-wrap {
            height: 60px;
            display: flex;
        }
        /* 채팅 입력 */
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
            border: none;
            outline: 1px solid var(--border-color);
        }
        .chat-input > input:focus {
            outline: 1px solid rgb(255, 146, 139);
        }
        /* 전송 버튼 */
        .chat-input > button {
            width: 40px;
            color: white;
            font-weight: bold;
            border: none;
            border-radius: 20px;
            background-color: rgb(255, 146, 139);
            margin-left: 10px;
        }

        /* ---------- 채팅방 목록 영역 ---------- */
        .chat-list {
            width: 300px;
            overflow-y: scroll;
            border-top: 1px solid var(--border-color);
        }
        .chat-list::-webkit-scrollbar {
	        display: none;
        }

        /* ---------- 채팅방 목록 ---------- */
        .chat-room {
            width: 100%;
            height: 65px;
            display: flex;
        }
        .chat-room:hover {
            background-color: rgb(255, 248, 248);
        }
        /* 채팅방 대표 사진 */
        .chat-room-picture-wrap {
            min-width: 62px;
            display: flex;
            position: relative;
        }
        .chat-room-badge {
            position: absolute;
            min-width: 20px;
            height: 20px;
            text-align: center;
            padding-top: 1px;
            padding-left: 1px;
            padding-right: 1px;
            font-size: 12px;
            font-weight: bold;
            color: white;
            background-color: rgb(255, 146, 139);
            border-radius: 20px;
            top: 4px;
            left: 36px;
        }
        .chat-room-picture {
            width: 50px;
            height: 50px;
            border: 1px solid var(--border-color);
            border-radius: 30px;
            margin: auto;
            background-color: white;
            display: flex;
        }
        .chat-room-picture > img {
            width: 38px;
            height: 38px;
            margin: auto;
            border: none;
        }
        /* 채팅방 이름, 마지막 메시지 / 시간 */
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
            padding-top: 14px;
            padding-left: 5px;
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
            padding-left: 5px;
        }
        .chat-room-last-message-time {
            width: 25%;
            min-width: 57.19px;
            height: 100%;
            font-size: 1px;
            text-align: right;
            margin: auto;
            padding-right: 5px;
        }

        /* ---------- 채팅방 페이지 Contextmenu ---------- */
        .contextmenu-wrap {
            position: absolute;
            width: 200px;
            display: none;
            padding: 10px;
            border-radius: 10px;
            background-color: white;
            box-shadow: 2px 2px 4px 0 grey;
            z-index: 2;
            border: 1px solid var(--border-color);
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

        /* ---------- 채팅방 페이지 Modal ---------- */
        .modal-overlay {
            width: 100%;
            height: 100%;
            position: absolute;
            top: 0;
            left: 0;
            display: none;
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
            border: 1px solid var(--border-color);
        }
        .modal-message {
            height: 60%;
            padding-top: 34px;
            font-size: 14px;
        }
        .modal-messageAndInput {
            height: 60%;
            padding-top: 11px;
            font-size: 14px;
        }
        .modal-messageAndInput > input {
            margin-top: 15px;
            width: 72%;
            height: 30px;
            border-radius: 5px;
            padding-left: 10px;
            padding-right: 10px;
            border: none;
            outline: 1px solid var(--border-color);
        }
        .modal-messageAndInput > input:focus {
            outline: 1px solid rgb(255, 146, 139);
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

            <!-- ---------- 채팅 영역 ---------- -->
            <div class="chat-content">

                <!-- ---------- 채팅방 유저 목록 영역 ---------- -->
                <div class="chat-user-list-accordion">
                    
                    <!-- ---------- 채팅방 유저 목록 ON / OFF 스위치 ---------- -->
                    <div class="accordion-switch" onclick="accordionSwitch();">
                        <i class="uil uil-angle-down"></i>
                    </div>

                    <!-- ---------- 채팅방 유저 목록 ---------- -->
                    <div class="chat-user-list">
                        <div class="chat-user">
                            <div class="chat-user-picture">
                                <div><img src="${pageContext.request.contextPath}/resources/img/profile.png"></div>
                            </div>
                            <div class="chat-user-nickname">홍은동배드민턴맨</div>
                        </div>
                        <div class="chat-user">
                            <div class="chat-user-picture">
                                <div><img src="${pageContext.request.contextPath}/resources/img/profile.png"></div>
                            </div>
                            <div class="chat-user-nickname">귀여운어피치</div>
                        </div>
                        <div class="chat-user">
                            <div class="chat-user-picture">
                                <div><img src="${pageContext.request.contextPath}/resources/img/profile.png"></div>
                            </div>
                            <div class="chat-user-nickname">배드민턴 매니아</div>
                        </div>

                    </div>
                </div>

                <!-- ---------- 채팅방 메시지 표시 영역 ---------- -->
                <div class="chat-view">
                    <!-- 채팅방 날짜 표시 -->
                    <div class="chat-date-wrap">
                        <div class="chat-date">2022년 8월 3일 수요일</div>
                    </div>
                    <!-- 채팅방 상대방 메시지 -->
                    <div class="another-user-chat-wrap">
                        <div class="another-user-picture">
                            <div><img src="${pageContext.request.contextPath}/resources/img/profile.png"></div>
                        </div>
                        <div class="another-user-message-wrap-1">
                            <div class="another-user-nickname">귀여운어피치</div>
                            <div class="another-user-message-wrap-2">
                                <div class="another-user-chat-message">asdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasd</div>
                                <div class="another-user-chat-message-time">오전 10:08</div>
                            </div>
                        </div>
                    </div>
                    <!-- 채팅방 내 메시지 -->
                    <div class="my-chat-wrap">
                        <div class="my-chat-message-time">오전 10:08</div>
                        <div class="my-chat-message">asdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasd</div>
                    </div>

                    <!-- 채팅방 상대방 메시지 -->
                    <div class="another-user-chat-wrap">
                        <div class="another-user-picture">
                            <div><img src="${pageContext.request.contextPath}/resources/img/profile.png"></div>
                        </div>
                        <div class="another-user-message-wrap-1">
                            <div class="another-user-nickname">귀여운어피치</div>
                            <div class="another-user-message-wrap-2">
                                <div class="another-user-chat-message">네</div>
                                <div class="another-user-chat-message-time">오후 10:08</div>
                            </div>
                        </div>
                    </div>
                    <!-- 채팅방 내 메시지 -->
                    <div class="my-chat-wrap">
                        <div class="my-chat-message-time">오후 11:40</div>
                        <div class="my-chat-message">네?</div>
                    </div>

                </div>

                <!-- ---------- 채팅방 메시지 입력 영역 ---------- -->
                <div class="chat-input-wrap">
                    <!-- 채팅 입력, 전송 버튼 -->
                    <div class="chat-input">
                        <input type="text" placeholder="메시지를 입력해주세요...">
                        <button>전송</button>
                    </div>
                </div>

            </div>

            <!-- ---------- 채팅방 목록 영역 ---------- -->
            <div class="chat-list">
                <!-- ---------- 채팅방 목록 ---------- -->
                <div class="chat-room">
                    <!-- 채팅방 대표 사진 (= 방장 프로필) -->
                    <div class="chat-room-picture-wrap">
                        <div class="chat-room-picture"><img src="${pageContext.request.contextPath}/resources/img/profile.png"></div>
                    </div>
                    <!-- 채팅방 이름, 마지막 메시지 / 시간 -->
                    <div class="chat-room-content">
                        <div class="chat-room-title">홍은동배드민턴맨님의 모임 채팅방</div>
                        <div class="chat-room-last-message-wrap">
                            <div class="chat-room-last-message">ㅎㅇㅎㅇㅎㅇㅎㅇㅎㅇㅎㅇㅎㅇㅎㅎㅇㅎㅇㅎ</div>
                            <div class="chat-room-last-message-time">24시간 전</div>
                        </div>
                    </div>
                </div>
                <div class="chat-room">
                    <!-- 채팅방 대표 사진 (= 방장 프로필) -->
                    <div class="chat-room-picture-wrap">
                        <div class="chat-room-badge">1</div>
                        <div class="chat-room-picture"><img src="${pageContext.request.contextPath}/resources/img/profile.png"></div>
                    </div>
                    <!-- 채팅방 이름, 마지막 메시지 / 시간 -->
                    <div class="chat-room-content">
                        <div class="chat-room-title">홍은동배드민턴맨님의 모임 채팅방</div>
                        <div class="chat-room-last-message-wrap">
                            <div class="chat-room-last-message">ㅎㅇㅎㅇㅎㅇㅎㅇㅎㅇㅎㅇㅎㅇㅎㅎㅇㅎㅇㅎ</div>
                            <div class="chat-room-last-message-time">24시간 전</div>
                        </div>
                    </div>
                </div>
                <div class="chat-room">
                    <!-- 채팅방 대표 사진 (= 방장 프로필) -->
                    <div class="chat-room-picture-wrap">
                        <div class="chat-room-badge">10</div>
                        <div class="chat-room-picture"><img src="${pageContext.request.contextPath}/resources/img/profile.png"></div>
                    </div>
                    <!-- 채팅방 이름, 마지막 메시지 / 시간 -->
                    <div class="chat-room-content">
                        <div class="chat-room-title">홍은동배드민턴맨님의 모임 채팅방</div>
                        <div class="chat-room-last-message-wrap">
                            <div class="chat-room-last-message">ㅎㅇㅎㅇㅎㅇㅎㅇㅎㅇㅎㅇㅎㅇㅎㅎㅇㅎㅇㅎ</div>
                            <div class="chat-room-last-message-time">24시간 전</div>
                        </div>
                    </div>
                </div>
                <div class="chat-room">
                    <!-- 채팅방 대표 사진 (= 방장 프로필) -->
                    <div class="chat-room-picture-wrap">
                        <div class="chat-room-badge">99</div>
                        <div class="chat-room-picture"><img src="${pageContext.request.contextPath}/resources/img/profile.png"></div>
                    </div>
                    <!-- 채팅방 이름, 마지막 메시지 / 시간 -->
                    <div class="chat-room-content">
                        <div class="chat-room-title">홍은동배드민턴맨님의 모임 채팅방</div>
                        <div class="chat-room-last-message-wrap">
                            <div class="chat-room-last-message">ㅎㅇㅎㅇㅎㅇㅎㅇㅎㅇㅎㅇㅎㅇㅎㅎㅇㅎㅇㅎ</div>
                            <div class="chat-room-last-message-time">24시간 전</div>
                        </div>
                    </div>
                </div>
                <div class="chat-room">
                    <!-- 채팅방 대표 사진 (= 방장 프로필) -->
                    <div class="chat-room-picture-wrap">
                        <div class="chat-room-badge">+99</div>
                        <div class="chat-room-picture"><img src="${pageContext.request.contextPath}/resources/img/profile.png"></div>
                    </div>
                    <!-- 채팅방 이름, 마지막 메시지 / 시간 -->
                    <div class="chat-room-content">
                        <div class="chat-room-title">홍은동배드민턴맨님의 모임 채팅방</div>
                        <div class="chat-room-last-message-wrap">
                            <div class="chat-room-last-message">ㅎㅇㅎㅇㅎㅇㅎㅇㅎㅇㅎㅇㅎㅇㅎㅎㅇㅎㅇㅎ</div>
                            <div class="chat-room-last-message-time">24시간 전</div>
                        </div>
                    </div>
                </div>

            </div>
        </div>

        <!-- ---------- 채팅 페이지 Contextmenu 모음 ---------- -->
        <!-- 채팅방 유저 목록 Contextmenu -->
        <div class="contextmenu-wrap chat-user-contextmenu">
            <div class="contextmenu" onclick="openModal('changeHost');">방장 위임</div>
            <div class="contextmenu" onclick="openModal('kickMember');">강퇴</div>
        </div>
        <!-- 채팅방 목록 Contextmenu -->
        <div class="contextmenu-wrap chat-room-contextmenu">
            <div class="contextmenu" onclick="openModal('changeChatRoomName');">채팅방 이름 변경</div>
            <div class="contextmenu" onclick="openModal('leaveChatRoom');">채팅방 나가기</div>
        </div>

        <!-- ---------- 채팅 페이지 Modal 모음 ---------- -->
        <!-- 채팅방 방장 위임 Modal -->
        <div class="modal-overlay change-host-modal">
            <div class="modal-wrap">
                <div class="modal-message">방장을 OOO 님으로 변경하시겠습니까?</div>
                <div class="modal-button">
                    <div class="modal-button-cancel" onclick="cancelModal('changeHost');">취소</div>
                    <div class="modal-button-confirm" onclick="confirmModal('changeHost');">확인</div>
                </div>
            </div>
        </div>
        <!-- 채팅방 강퇴 Modal -->
        <div class="modal-overlay kick-member-modal">
            <div class="modal-wrap">
                <div class="modal-message">OOO 님을 강퇴하시겠습니까?</div>
                <div class="modal-button">
                    <div class="modal-button-cancel" onclick="cancelModal('kickMember');">취소</div>
                    <div class="modal-button-confirm" onclick="confirmModal('kickMember');">확인</div>
                </div>
            </div>
        </div>
        <!-- 채팅방 이름 변경 Modal -->
        <div class="modal-overlay change-chat-room-name-modal">
            <div class="modal-wrap">
                <div class="modal-messageAndInput">
                    채팅방 이름을 입력해주세요.
                    <input type="text">
                </div>
                <div class="modal-button">
                    <div class="modal-button-cancel" onclick="cancelModal('changeChatRoomName');">취소</div>
                    <div class="modal-button-confirm" onclick="confirmModal('changeChatRoomName');">확인</div>
                </div>
            </div>
        </div>
        <!-- 채팅방 나가기 Modal -->
        <div class="modal-overlay leave-chat-room-modal">
            <div class="modal-wrap">
                <div class="modal-message">채팅방을 나가시겠습니까?</div>
                <div class="modal-button">
                    <div class="modal-button-cancel" onclick="cancelModal('leaveChatRoom');">취소</div>
                    <div class="modal-button-confirm" onclick="confirmModal('leaveChatRoom');">확인</div>
                </div>
            </div>
        </div>

        <script>

            /* ---------- 채팅방 회원 목록 ON / OFF 기능 ---------- */
            var chatUserList = document.getElementsByClassName('chat-user-list')[0];
            var chatUserListStyle = window.getComputedStyle(chatUserList);
            var uilAngleDown = document.getElementsByClassName('uil-angle-down')[0];

            function accordionSwitch() {

                if (chatUserList.style.maxHeight == 0) {

                    chatUserList.style.maxHeight = '800px';
                    chatUserList.style.paddingBottom = '20px';
                    uilAngleDown.style.color = 'rgb(255, 146, 139)';
                }
                else {

                    chatUserList.style.maxHeight = '0';
                    chatUserList.style.paddingBottom = '0';
                    uilAngleDown.style.color = 'rgb(0, 0, 0)';
                }
            };

            /* ---------- 채팅방 회원 목록, 채팅방 목록 Contextmenu 기능 ---------- */
            var chatUserContextmenu = document.querySelector('.chat-user-contextmenu');
            var chatRoomContextmenu = document.querySelector('.chat-room-contextmenu');

            function showChatUserContextmenu (show = true) {

                chatUserContextmenu.style.display = show ? 'block' : 'none';
            };

            function showChatRoomContextmenu (show = true) {

                chatRoomContextmenu.style.display = show ? 'block' : 'none';
            };

            /* 마우스 오른쪽 버튼 클릭 시 */
            window.addEventListener('contextmenu', function(e) {

                e.preventDefault();
                
                var chatUser = document.getElementsByClassName('chat-user');
                var chatRoom = document.getElementsByClassName('chat-room');
                
                /* 채팅방 유저 목록을 마우스 오른쪽 버튼으로 누르면 Contextmenu 띄우기 */
                for (let i = 0; i < chatUser.length; i++) {

                    if (e.target.closest('.chat-user') == chatUser[i]) {

                        showChatUserContextmenu();
                        break;
                    }
                    else {

                         showChatUserContextmenu(false);
                    }
                }

                /* 채팅방 목록을 마우스 오른쪽 버튼으로 누르면 Contextmenu 띄우기 */
                for (let i = 0; i < chatRoom.length; i++) {

                    if (e.target.closest('.chat-room') == chatRoom[i]) {

                        showChatRoomContextmenu();
                        break;
                    }
                    else {

                        showChatRoomContextmenu(false);
                    }
                }

                /* Contextmenu 표시 위치 */
                chatUserContextmenu.style.top = e.y + 'px';
                chatUserContextmenu.style.left = e.x + 'px';
                chatRoomContextmenu.style.top = e.y + 'px';
                chatRoomContextmenu.style.left = e.x + 'px';
            });

            /* 마우스 왼쪽 버튼 클릭 시 Contextmenu 닫기 */
            window.addEventListener('click', function(e) {

                showChatUserContextmenu(false);
                showChatRoomContextmenu(false);
            });

            /* ---------- 채팅방 회원 목록, 채팅방 목록 Modal 기능 ---------- */
            var changeHostModal = document.querySelector('.change-host-modal');
            var kickMemberModal = document.querySelector('.kick-member-modal');
            var changeChatRoomNameModal = document.querySelector('.change-chat-room-name-modal');
            var leaveChatRoomModal = document.querySelector('.leave-chat-room-modal');
            
            /* Modal 열기 */
            function openModal(modalType) {

                if (modalType == 'changeHost') {
                    
                    changeHostModal.style.display = 'flex';
                }
                if (modalType == 'kickMember') {

                    kickMemberModal.style.display = 'flex';
                }
                if (modalType == 'changeChatRoomName') {

                    changeChatRoomNameModal.style.display = 'flex';
                }
                if (modalType == 'leaveChatRoom') {

                    leaveChatRoomModal.style.display = 'flex';
                }
            };

            /* Modal창에서 취소 시 Modal 창 닫기 */
            function cancelModal(modalType) {

                if (modalType == 'changeHost') {

                    changeHostModal.style.display = 'none';
                }
                if (modalType == 'kickMember') {

                    kickMemberModal.style.display = 'none';
                }
                if (modalType == 'changeChatRoomName') {

                    changeChatRoomNameModal.style.display = 'none';
                }
                if (modalType == 'leaveChatRoom') {

                    leaveChatRoomModal.style.display = 'none';
                }
            };

            /* Modal창에서 확인 시 ~ */
            function confirmModal(modalType) {

                if (modalType == 'changeHost') {

                    changeHostModal.style.display = 'none';
                }
                if (modalType == 'kickMember') {

                    kickMemberModal.style.display = 'none';
                }
                if (modalType == 'changeChatRoomName') {

                    changeChatRoomNameModal.style.display = 'none';
                }
                if (modalType == 'leaveChatRoom') {

                    leaveChatRoomModal.style.display = 'none';
                }
            };

            /* Modal창 바깥 영역 클릭 시 Modal창 닫기 */
            window.addEventListener('click', function(e) {

                if (e.target.classList.contains('modal-overlay')) {

                        changeHostModal.style.display = 'none';
                        kickMemberModal.style.display = 'none';
                        changeChatRoomNameModal.style.display = 'none';
                        leaveChatRoomModal.style.display = 'none';
                    }
            });

        </script>

    </body>
</html>