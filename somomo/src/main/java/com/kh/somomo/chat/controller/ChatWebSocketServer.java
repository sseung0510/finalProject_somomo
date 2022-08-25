package com.kh.somomo.chat.controller;

import java.util.ArrayList;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.kh.somomo.chat.model.service.ChatService;
import com.kh.somomo.chat.model.vo.*;

public class ChatWebSocketServer extends TextWebSocketHandler {
	
	@Autowired
	ChatService chatService;
	
    // 채팅방 목록 (각 채팅방에 속한 session을 담기 위해 ArrayList 사용)
    private Map<String, ArrayList<WebSocketSession>> chatRoomList = new ConcurrentHashMap<String, ArrayList<WebSocketSession>>();
    
    // session 목록 (각 session은 채팅방 번호를 가지고 있음)
    private Map<WebSocketSession, String> sessionList = new ConcurrentHashMap<WebSocketSession, String>();
    
    private int connectedUsers;
    
    // Jackson - Json <-> Java Object 변환
    private ObjectMapper objectMapper = new ObjectMapper();

    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
    	
    	connectedUsers++;
    	
        System.out.println("[웹소켓 서버 연결 성공] | [" + session.getId() + "] | [총 접속 인원 : " + connectedUsers + "명]");
    }
 
    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
    	
    	connectedUsers--;
        
    	if(sessionList.get(session) != null) {
    		
    		// chatRoomList에 남아있는 session 전부 찾아서 제거
    		for (String key : chatRoomList.keySet()) {
    			if (chatRoomList.get(key).contains(session)) {
    				chatRoomList.get(key).remove(session);
				}
            }
	    	sessionList.remove(session);
    	}
    	System.out.println("[웹소켓 서버 연결 종료] | [" + session.getId() + "] | [총 접속 인원 : " + connectedUsers + "명]");
    }
 
	@Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
 
        // 전달받은 메세지 (Json객체로 전달 받음 / 가져오는 값 : roomNo, chatWriter, chatContent)
        String messageReceived = message.getPayload();
        
        // 전달받은 메세지(Json)를 Java Object로 변환
        Chat chatReceived = objectMapper.readValue(messageReceived, Chat.class);
        
        // 받은 메세지에 담긴 roomNo로 해당 채팅방이 DB에 존재하는지 확인
        ChatRoom chatRoom = chatService.selectChatRoom(chatReceived.getRoomNo());
        
        String roomNoReceived = Integer.toString(chatRoom.getRoomNo());
        
        // 채팅방 목록(chatRoomList)에 채팅방이 없고, DB에 채팅방이 있고, 처음 들어왔을 때(특정 메시지를 수신했을 때)
        if(chatRoomList.get(roomNoReceived) == null && chatRoom != null && chatReceived.getChatContent().equals("enterChatRoom220826")) {
            
            // 채팅방 목록(chatRoomList)에서 session들을 담을 ArrayList sessions를 생성
            ArrayList<WebSocketSession> sessions = new ArrayList<>();
            
            // ArrayList sessions에 session을 담음
            sessions.add(session);
            
            // 채팅방 목록(chatRoomList)에 채팅방 번호와 sessions를 담음 (웹소켓 서버에 채팅방 생성)
            // 앞으로 동일한 채팅방 유저들 접속 시 유저들의 session은 이곳에 보관됨
            chatRoomList.put(roomNoReceived, sessions);
            
            // session 목록에 session과 현재 속한 채팅방 번호 담음
            sessionList.put(session, roomNoReceived);
            
            System.out.println("[웹소켓 서버에 " + chatRoom.getRoomNo() + "번 채팅방 생성] | [" + session.getId() + "] | [입장]");
            
        // 채팅방 목록(chatRoomList)에 채팅방이 있고, DB에 채팅방이 있고, 처음 들어왔을 때(특정 메시지를 수신했을 때)
        } else if(chatRoomList.get(roomNoReceived) != null && chatRoom != null 
        		&& chatReceived.getChatContent().equals("enterChatRoom220826")) {
        	
        	if (!chatRoomList.get(roomNoReceived).contains(session)) {
        		
        		//채팅방 목록에서 채팅방 번호가 일치하는 채팅방에 session 추가
                chatRoomList.get(roomNoReceived).add(session);
                
                // session 목록에 session과 현재 속한 채팅방 번호 담음
                sessionList.put(session, roomNoReceived);
                
                System.out.println("[" + roomNoReceived + "번 채팅방] | [" + session.getId() + "] | [입장]");
			}
        } 
        
        // 채팅 내용 전송, DB 저장
        if(chatRoomList.get(roomNoReceived) != null && chatRoom != null && !chatReceived.getChatContent().equals("enterChatRoom220826")) {
            
            // DB에 채팅 저장
            int result = chatService.insertChat(chatReceived);
            
            // DB에 저장된 채팅을 다시 불러옴
            Chat chat = chatService.selectChat(chatReceived);
            
            if(result > 0) { // DB에 채팅 저장 성공 시
            	
            	// DB에서 가저온 채팅 내용을 담아줌 (사용할 값 : chatDate, chatWriter, profileImg, nickname, chatContent, chatTime)
            	TextMessage newChat = new TextMessage(chat.getChatDate() 
            			                      + "`" + chat.getChatWriter() 
            			                      + "`" + chat.getProfileImg() 
            			                      + "`" + chat.getNickname()
            			                      + "`" + chat.getChatContent()
            			                      + "`" + chat.getChatTime());
            	
            	// 채팅방에 속한 session들에게 채팅 전송
            	if(!chatRoomList.isEmpty()) {
            		for(WebSocketSession ws : chatRoomList.get(roomNoReceived)) {
            			ws.sendMessage(newChat);
            		}
            	} else {
            		chatRoomList.get(sessionList.get(session)).remove(session);
            	}
                System.out.println("[채팅 메시지 전송 성공] | [DB 저장 성공]");
            } else { // DB에 채팅 저장 실패 시
                System.out.println("[채팅 메시지 전송 실패] | [DB 저장 실패]");
            }
        }
    }
}
