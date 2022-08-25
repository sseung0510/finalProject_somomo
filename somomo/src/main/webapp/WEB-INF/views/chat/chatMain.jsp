<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">

    <!-- CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/chat.css?ver=1.0.0">

    <!-- 아이콘 CSS 링크 -->
    <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css">

    <!-- Boxicons CSS -->
    <link href='https://unpkg.com/boxicons@2.1.1/css/boxicons.min.css' rel='stylesheet'>
    
	<!-- jquery -->
 	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
 	
	<!-- Bootstrap -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>

    <title>소모모 - 채팅</title>
    
</head>
<body>

	<!-- ---------- 왼쪽 사이드 바 ---------- -->
	<jsp:include page="../feed/feedCommon/feed_leftSidebar.jsp" />

	<!-- ---------- 헤더 , 메인 컨텐츠 ---------- -->
	<section class="main-content">

		<!-- 헤더 -->
		<div class="top">
			<i class="uil uil-bars sidebar-toggle"></i>
			<div class="search-box">
            	<i class="uil uil-search"></i>
            	<form action="search.fd" method="get">
                	<input type="text" placeholder="검색" name="keyword">
                </form>
            </div>
		</div>

		<!-- 메인 피드 -->
        <div class="main-feed">
			<div class="chat-wrap">

				<!-- ---------- 채팅 영역 ---------- -->
				<div class="chat-content">
	
					<!-- ---------- 채팅방 유저 목록 영역 ---------- -->
					<div class="chat-user-list-accordion">
						<!-- 채팅방 유저 목록 ON / OFF 스위치 -->
						<div class="accordion-switch" onclick="accordionSwitch();">
							<i class="uil uil-angle-down"></i>
						</div>
						<!-- 채팅방 유저 목록 -->
						<div class="chat-user-list"></div>
					</div>
	
					<!-- ---------- 채팅방 메시지 표시 영역 ---------- -->
					<div class="chat-view">
						<div class="chat-empty">
							<div>
								<img src="${pageContext.request.contextPath}/resources/img/apeach3.png">
								<div>메시지를 확인하려면 채팅방을 선택해주세요</div>
							</div>
						</div>
					</div>
	
					<!-- ---------- 채팅방 메시지 입력 영역 ---------- -->
					<div class="chat-input-wrap"></div>
	
				</div>
	
				<!-- ---------- 채팅방 목록 영역 ---------- -->
				<!-- ---------- 채팅방 목록 ---------- -->
				<c:choose>
					<c:when test="${ empty myChatRoomList }">
						<!-- 참여한 채팅방이 없을 때 -->
						<div class="chat-list-empty">참여한 채팅방이 없습니다</div>
					</c:when>
					<c:otherwise>
						<!-- 참여한 채팅방이 있을 때 -->
						<div class="chat-list">
							<c:forEach var="r" items="${ myChatRoomList }">
								<div class="chat-room" onclick="selectChatInChatRoom(this);">
									<input type="checkbox" name="chat-room-flag">
									<input type="hidden" value="${ r.roomNo }">
									<!-- 채팅방 대표 사진 (= 방장 프로필) -->
									<div class="chat-room-picture-wrap">
										<c:if test="${ r.chatCount ne 0 }">
											<div class="chat-room-badge">${ r.chatCount }</div>
										</c:if>
										<div class="chat-room-picture"><img src="${pageContext.request.contextPath}/${ r.roomThumbnail }"></div>
									</div>
									<!-- 채팅방 이름, 마지막 메시지 / 시간 -->
									<div class="chat-room-content">
										<div class="chat-room-title">${ r.roomName }</div>
										<div class="chat-room-last-message-wrap">
											<div class="chat-room-last-message">${ r.chatContent }</div>
											<div class="chat-room-last-message-time">${ r.chatDate }</div>
										</div>
									</div>
								</div>
							</c:forEach>
						</div>
					</c:otherwise>
				</c:choose>

			</div>
		</div>

    </section>

	<!-- ---------- 채팅 페이지 Contextmenu 모음 ---------- -->
	<!-- 채팅방 유저 목록 Contextmenu -->
	<div class="contextmenu-wrap chat-user-contextmenu" style="display:none;">
		<div class="contextmenu" onclick="openModal('changeHost');">방장 위임</div>
		<div class="contextmenu" onclick="openModal('kickMember');">강퇴</div>
	</div>
	<!-- 채팅방 목록 Contextmenu -->
	<div class="contextmenu-wrap chat-room-contextmenu">
		<!-- <div class="contextmenu" onclick="openModal('changeChatRoomName');">채팅방 이름 변경</div> -->
		<div class="contextmenu" onclick="openModal('leaveChatRoom');">채팅방 나가기</div>
	</div>

	<!-- ---------- 채팅 페이지 Modal 모음 ---------- -->
	<!-- 채팅방 방장 위임 Modal -->
	<!-- <div class="modal-overlay change-host-modal">
		<div class="modal-wrap">
			<div class="modal-message">방장을 OOO 님으로 변경하시겠습니까?</div>
			<div class="modal-button">
				<div class="modal-button-cancel" onclick="cancelModal('changeHost');">취소</div>
				<div class="modal-button-confirm" onclick="confirmModal('changeHost');">확인</div>
			</div>
		</div>
	</div> -->
	<!-- 채팅방 강퇴 Modal -->
	<!-- <div class="modal-overlay kick-member-modal">
		<div class="modal-wrap">
			<div class="modal-message">OOO 님을 강퇴하시겠습니까?</div>
			<div class="modal-button">
				<div class="modal-button-cancel" onclick="cancelModal('kickMember');">취소</div>
				<div class="modal-button-confirm" onclick="confirmModal('kickMember');">확인</div>
			</div>
		</div>
	</div> -->
	<!-- 채팅방 이름 변경 Modal -->
	<!-- <div class="modal-overlay change-chat-room-name-modal">
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
	</div> -->
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

    <!-- ---------- 오른쪽 사이드 바 ---------- -->
    <div class="right-sidebar">
		<jsp:include page="../group/groupCommunityCommon/community_rightSidebar.jsp" />
    </div>

	<script>

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
			/* 웹소켓 서버 접속 */
			connect();

			setInterval(function(){
                /* 내 채팅방들 불러오기(AJAX) */
                selectMyChatRoom();
            },1000);
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
			
			let newChat = e.data.split("`");
			
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
		
			$('.chat-view').append(chatView);
			
			/* chatView 비움 */
			chatView = '';
			
			/* 내 채팅방들 불러오기(AJAX) */
			selectMyChatRoom();

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

		let selecChatRoomNo = '';
		
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
			// for (let i = 0; i < chatUser.length; i++) {
			// 	if (e.target.closest('.chat-user') == chatUser[i]) {
			// 		console.log(e.target.closest('.chat-user'));
					
			// 		showChatUserContextmenu();
			// 		break;
			// 	}
			// 	else {
			// 		 showChatUserContextmenu(false);
			// 	}
			// }
		
			/* 채팅방 목록을 마우스 오른쪽 버튼으로 누르면 Contextmenu 띄우기 */
			for (let i = 0; i < chatRoom.length; i++) {
				if (e.target.closest('.chat-room') == chatRoom[i]) {
					selecChatRoomNo = e.target.closest('.chat-room').children[1].value;
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
				leaveChatRoom();
				location.reload();
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

		/* Modal창에서 확인 시 ~ 연결되는 기능 */
		function leaveChatRoom() {
			$.ajax({
				url : 'leaveChatRoom.ch', 
				data : {
					roomNo : selecChatRoomNo,
					userId : '${loginUser.userId}'
				}, success : function(result) { 
					if (result == 'success') {
						alert('채팅방 나가기 완료');
					}
					if (result == 'fail') {
						alert('채팅방 나가기 실패');
					}
				}, error : function() {
					alert('leaveChatRoom error');
				}
			});
		}

		/* 내 채팅방들 불러오기(AJAX) */
		function selectMyChatRoom() {
			$.ajax({
				url : 'selectMyChatRoom.ch', 
				data : {
					userId : '${loginUser.userId}'
				}, success : function(list) { 

					let chatRoomView = '';

					for(let i in list){

						let test = '';

						if (list[i].chatCount > 99) {
							test = '<div class="chat-room-badge">+99</div>';
						}
						if (list[i].chatCount < 99 && list[i].chatCount > 0) {
							test = '<div class="chat-room-badge">' + list[i].chatCount + '</div>';
						}
						chatRoomView += '<div class="chat-room" onclick="selectChatInChatRoom(this);">'
							          + '<input type="checkbox" name="chat-room-flag">'
								      + '<input type="hidden" value="' + list[i].roomNo + '">'
								      + '<div class="chat-room-picture-wrap">'
								      + test
								      + '<div class="chat-room-picture"><img src="${pageContext.request.contextPath}/' + list[i].roomThumbnail + '"></div></div>'
								      + '<div class="chat-room-content">'
								      + '<div class="chat-room-title">' + list[i].roomName + '</div>'
								      + '<div class="chat-room-last-message-wrap">'
								      + '<div class="chat-room-last-message">' + list[i].chatContent + '</div>'
								      + '<div class="chat-room-last-message-time">' + list[i].chatDate + '</div></div></div></div>'
					}
					$('.chat-list').html(chatRoomView);
				}, error : function() {
					alert('selectMyChatRoom error');
				}
			});
		}

		/* ---------- 선택한 채팅방의 채팅 내용 불러오기 ---------- */
		let flag = '';
		
		function selectChatInChatRoom(e) {
			
			if (flag != e.children[1].value) {
		
				flag = e.children[1].value
		
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
		
									chatView = '';
			
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
			}
		};

	</script>

	<script src="${pageContext.request.contextPath}/resources/js/feed.js"></script>

</body>
</html>