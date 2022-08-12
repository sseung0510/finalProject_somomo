package com.kh.somomo.chat.model.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Getter
@Setter
@ToString
public class ChatRoom {
	
	// 테이블 : CHAT_ROOM (채팅방)
	private int roomNo;
	private int boardNo;
	private int roomDate;
}
