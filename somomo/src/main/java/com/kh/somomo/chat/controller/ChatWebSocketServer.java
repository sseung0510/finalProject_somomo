package com.kh.somomo.chat.controller;

import java.util.Set;
import java.util.concurrent.CopyOnWriteArraySet;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

public class ChatWebSocketServer extends TextWebSocketHandler {
	
	private Set<WebSocketSession> users = new CopyOnWriteArraySet<WebSocketSession>();

	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		
		System.out.println(session);
		users.add(session);
	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		
		System.out.println(session);
		System.out.println(message);
		TextMessage newMessage = new TextMessage(message.getPayload());
		
		for(WebSocketSession ws : users) {
			ws.sendMessage(newMessage);
		}
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		
		System.out.println(session);
		System.out.println(status);
		users.remove(session);
	}
}
