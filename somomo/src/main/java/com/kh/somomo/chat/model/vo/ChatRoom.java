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
	private String roomName;
	private String roomDate;
	private String roomThumbnail; // 테이블에 새로 추가된 컬럼
	
	// CHAT 테이블 JOIN 시 가져올 값
	private String chatContent;
	private String chatDate;
	
	// CHAT_MEMBER 테이블 JOIN 시 가져올 값
	private String insertDate;
	private int chatCount;
}
