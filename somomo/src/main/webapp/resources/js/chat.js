/* ---------- 웹소켓 ---------- */
let socket
		
/* 채팅 내용(DB + WebSocket) 담는 변수 */
let chatView = '';

/* 채팅 내용에서 날짜 구분하는 변수 */
let dateGroup = '';

/* 메시지 표시 영역 최하단으로 스크롤 내릴 때 사용하는 변수 */
let chatViewHeight = document.querySelector('.chat-view');

/* 페이지 접속 시 자동 실행할 함수 */
$(function() {
    selectAllChatRoom();

    /* 웹소켓 서버 접속 */
    connect();
})

/* 웹소켓 서버 접속 */
function connect() {

    let webSocketStatus = document.getElementById('webSocketStatus');
    let uri = "ws://localhost:8888/somomo/cs";

    socket = new WebSocket(uri);

    socket.onopen = function() {
        console.log('웹소켓 서버 연결');
    }
    socket.onclose = function() {
        console.log('웹소켓 서버 종료');
    }
    socket.onerror = function(e) {
        console.log('웹소켓 서버 에러');
    }
    socket.onmessage = onMessage;
}

/* 웹소켓 메시지 발신 */
function send(roomNo) {

    let chatInput = document.querySelector('.chat-input');
    
    if (chatInput.children[0].value != '' && chatInput.children[0].value != ' ' && chatInput.children[0].value != null) {
        
        let data = {
            'roomNo' : roomNo,
            'chatWriter' : '${loginUser.userId}',
            'chatContent' : chatInput.children[0].value
        };

        let jsonData = JSON.stringify(data);

        socket.send(jsonData);

        chatInput.children[0].value = '';
    }
}

/* 웹소켓 메시지 수신 */
function onMessage(e) {

    let newChat = e.data.split(",");
    

    let data = {
        "chatDate" : newChat[0],
        "chatWriter" : newChat[1],
        "profileImg" : newChat[2],
        "nickname" : newChat[3],
        "chatContent" : newChat[4],
        "chatTime" : newChat[5]
    }

    /* 채팅방 날짜 표시 */
    if (dateGroup != newChat[0]) {

        dateGroup = newChat[0];

        chatView += '<div class="chat-date-wrap">'
                  + '<div class="chat-date">' + newChat[0] + '</div></div>'
    }

    /* 채팅방 상대방 메시지 */
    if ('${loginUser.userId}' != newChat[1]) {
        chatView += '<div class="another-user-chat-wrap">'
                  + '<div class="another-user-picture">'
                  + '<div><img src="${pageContext.request.contextPath}/' + newChat[2] + '"></div></div>'
                  + '<div class="another-user-message-wrap-1">'
                  + '<div class="another-user-nickname">' + newChat[3] + '</div>'
                  + '<div class="another-user-message-wrap-2">'
                  + '<div class="another-user-chat-message">' + newChat[4] + '</div>'
                  + '<div class="another-user-chat-message-time">' + newChat[5] +'</div></div></div></div>'
    }

    /* 채팅방 내 메시지 */
    if ('${loginUser.userId}' == newChat[1]) {
        chatView += '<div class="my-chat-wrap">'
                  + '<div class="my-chat-message-time">' + newChat[5] + '</div>'
                  + '<div class="my-chat-message">' + newChat[4] + '</div></div>'
    }

    $('.chat-view').html(chatView);

    /* 메시지 표시 영역 최하단으로 스크롤 내리기 */
    chatViewHeight.scrollTop = chatViewHeight.scrollHeight;
}

/* ---------- 웹소켓 테스트 ---------- */
function insertChatRoom() {
    $.ajax({
        url : 'insertChatRoom.ch', 
        data : {
            roomName : $('#roomName').val(), 
            userId : '${loginUser.userId}',
            profileImg : '${loginUser.profileImg}'
        }, success : function(result) { 
            if (result == 'success') {
                selectAllChatRoom();
                alert('채팅방 생성 성공');
                setTimeout("location.reload()", 1000);
            }
            if (result == 'fail') {
                alert('채팅방 생성 실패');
            }
        }, error : function() {
            alert('insertChatRoom error');
        }
    });
}

function selectAllChatRoom () {
    $.ajax({
        url : 'selectAllChatRoom.ch', 
        success : function(list) { 

            let value = '';

            if (list != '') {
                for(let i in list){
                    value += '<tr>'
                           + '<td>' + list[i].roomNo + '</th>'
                           + '<td>' + list[i].boardNo + '</th>'
                           + '<td>' + list[i].roomName + '</th>'
                           + '<td>' + list[i].roomDate + '</th>'
                           + '<td>' + '<button onclick="insertUserInChatRoom(' + list[i].roomNo + ');">참가</button>' + '</th>'
                           + '</tr>'
                }
                $('.tableWrap tbody').html(value);
            }
            if (list == '') {
                value += '<tr>'
                       + '<td colspan=5>' + '조회되는 채팅방 없음' + '</th>'
                       + '</tr>'

                $('.tableWrap tbody').html(value);
            }
        }, error : function() {
            alert('selectAllChatRoom error');
        }
    });
}

function insertUserInChatRoom(roomNo) {
    $.ajax({
        url : 'insertUserInChatRoom.ch', 
        data : {
            roomNo : roomNo, 
            userId : '${loginUser.userId}'
        }, success : function(result) { 
            if (result == 'success') {
                alert('채팅방 참가 성공');
                setTimeout("location.reload()", 1000);
            }
            if (result == 'fail') {
                alert('이미 참가한 채팅방 입니다.');
            }
        }, error : function() {
            alert('insertUserInChatRoom error');
        }
    });
}

function disconnect() {
    socket.close();
}

/* ---------- 채팅방 회원 목록 ON / OFF 기능 ---------- */
let chatUserList = document.getElementsByClassName('chat-user-list')[0];
let uilAngleDown = document.getElementsByClassName('uil-angle-down')[0];

function accordionSwitch() {
    if (chatUserList.style.maxHeight == '800px') {
        chatUserList.style.maxHeight = '0px';
        chatUserList.style.transition = 'all .4s';
        uilAngleDown.style.color = 'rgb(0, 0, 0)';
    }
    else {
        chatUserList.style.maxHeight = '800px';
        chatUserList.style.transition = 'all 1s';
        uilAngleDown.style.color = 'rgb(255, 146, 139)';
    }
};

/* ---------- 채팅방 회원 목록, 채팅방 목록 Contextmenu 기능 ---------- */
let chatUserContextmenu = document.querySelector('.chat-user-contextmenu');
let chatRoomContextmenu = document.querySelector('.chat-room-contextmenu');

function showChatUserContextmenu (show = true) {
    chatUserContextmenu.style.display = show ? 'block' : 'none';
};

function showChatRoomContextmenu (show = true) {
    chatRoomContextmenu.style.display = show ? 'block' : 'none';
};

/* 마우스 오른쪽 버튼 클릭 시 */
window.addEventListener('contextmenu', function(e) {

    e.preventDefault();
    
    let chatUser = document.getElementsByClassName('chat-user');
    let chatRoom = document.getElementsByClassName('chat-room');
    
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
let changeHostModal = document.querySelector('.change-host-modal');
let kickMemberModal = document.querySelector('.kick-member-modal');
let changeChatRoomNameModal = document.querySelector('.change-chat-room-name-modal');
let leaveChatRoomModal = document.querySelector('.leave-chat-room-modal');

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

/* ---------- 선택한 채팅방의 채팅 내용 불러오기 ---------- */
function selectChatInChatRoom(e) {

    /* 웹소켓 서버의 채팅방에 들어가기 */
    let data = {
        'roomNo' : e.children[1].value,
        'chatWriter' : '${loginUser.userId}',
        'chatContent' : 'enterChatRoom220826'
    };

    let jsonData = JSON.stringify(data);

    socket.send(jsonData);

    /* 모든 채팅방 input checked를 false로 변경 */
    let chatRoomFlags = document.getElementsByName('chat-room-flag');
    
    chatRoomFlags.forEach((crf) => {

        crf.checked = false;

        /* 한번이라도 선택됬던 채팅방에 호버 기능 다시 넣어주기 */
        if (crf.parentNode.style.backgroundColor == 'rgb(255, 224, 217)') {

            crf.parentNode.style.backgroundColor = 'white';

            if (crf.parentNode.style.backgroundColor == 'white') {
                crf.parentNode.addEventListener('mouseover', function() {
                    crf.parentNode.style.backgroundColor = 'rgb(255, 248, 248)';
                });
                crf.parentNode.addEventListener('mouseout', function() {
                    crf.parentNode.style.backgroundColor = 'white';
                });
            }
        }
    });

    /* 선택한 채팅방만 input checked를 true로 변경 */
    e.children[0].checked = true;

    if (e.children[0].checked == true) {
        
        if (e.style.backgroundColor == 'rgb(255, 224, 217)') {

            e.style.backgroundColor = 'white';

            if (e.style.backgroundColor == 'white') {
                e.addEventListener('mouseover', function() {
                    e.style.backgroundColor = 'rgb(255, 248, 248)';
                })

                e.addEventListener('mouseout', function() {
                    e.style.backgroundColor = 'white';
                })
            }
        }
        else {

            /* 선택한 채팅방 색상 변경 */
            e.style.backgroundColor = 'rgb(255, 224, 217)';

            if (e.style.backgroundColor == 'rgb(255, 224, 217)') {
                e.addEventListener('mouseover', function() {
                    e.style.backgroundColor = 'rgb(255, 224, 217)';
                })
                e.addEventListener('mouseout', function() {
                    e.style.backgroundColor = 'rgb(255, 224, 217)';
                })
            }

            /* 다른 채팅방에서 유저 목록 열어 놨었다면 닫기 */
            if (chatUserList.style.maxHeight == '800px') {
                chatUserList.style.maxHeight = '0px';
                chatUserList.style.transition = 'all .01s';
                uilAngleDown.style.color = 'rgb(0, 0, 0)';
            }

            /* 채팅방 선택하면 유저 목록 영역, 메시지 입력 영역 표시 */
            let chatUserListAccordion = document.querySelector('.chat-user-list-accordion');

            chatUserListAccordion.style.display = 'block';

            let chatInput = '<div class="chat-input">'
                          + '<input type="text" placeholder="메시지를 입력해주세요..." maxlength="1000" onkeyup="if(window.event.keyCode==13) send(' + e.children[1].value + ');">'
                          + '<button onclick="send(' + e.children[1].value + ');">전송</button></div>'

            $('.chat-input-wrap').html(chatInput);

            /* 선택한 채팅방 메시지 불러오는 AJAX */
            $.ajax({
                url : 'selectChatInChatRoom.ch', 
                data : {
                    roomNo : e.children[1].value, 
                    userId : '${loginUser.userId}'
                }, success : function(list) { 
                    
                    if (list != '') {
                        for(let i in list){

                            /* 채팅방 날짜 표시 */
                            if (dateGroup != list[i].chatDate) {

                                dateGroup = list[i].chatDate;

                                chatView += '<div class="chat-date-wrap">'
                                          + '<div class="chat-date">' + list[i].chatDate + '</div></div>'
                            }

                            /* 채팅방 상대방 메시지 */
                            if ('${loginUser.userId}' != list[i].chatWriter) {
                                chatView += '<div class="another-user-chat-wrap">'
                                          + '<div class="another-user-picture">'
                                          + '<div><img src="${pageContext.request.contextPath}/' + list[i].profileImg + '"></div></div>'
                                          + '<div class="another-user-message-wrap-1">'
                                          + '<div class="another-user-nickname">' + list[i].nickname + '</div>'
                                          + '<div class="another-user-message-wrap-2">'
                                          + '<div class="another-user-chat-message">' + list[i].chatContent + '</div>'
                                          + '<div class="another-user-chat-message-time">' + list[i].chatTime +'</div></div></div></div>'
                            }

                            /* 채팅방 내 메시지 */
                            if ('${loginUser.userId}' == list[i].chatWriter) {
                                chatView += '<div class="my-chat-wrap">'
                                          + '<div class="my-chat-message-time">' + list[i].chatTime + '</div>'
                                          + '<div class="my-chat-message">' + list[i].chatContent + '</div></div>'
                            }
                        }
                        $('.chat-view').html(chatView);

                        /* 메시지 표시 영역 최하단으로 스크롤 내리기 */
                        chatViewHeight.scrollTop = chatViewHeight.scrollHeight;
                    }
                    else {
                        $('.chat-view').html(chatView);
                    }
                }, error : function() {
                    alert('selectChatInChatRoom error');
                }
            });

            /* 선택한 채팅방 유저 목록 불러오는 AJAX */
            $.ajax({
                url : 'selectUserInChatRoom.ch', 
                data : {
                    roomNo : e.children[1].value
                }, success : function(list) { 

                    let value = '';

                    for(let i in list){
                        value += '<div class="chat-user">'
                               + '<div class="chat-user-picture">'
                               + '<div><img src="${pageContext.request.contextPath}/' + list[i].profileImg + '"></div></div>'
                               + '<div class="chat-user-nickname">' + list[i].nickname + '</div></div>'
                    }
                    $('.chat-user-list').html(value);
                }, error : function() {
                    alert('selectUserInChatRoom error');
                }
            });
        }
    }
};