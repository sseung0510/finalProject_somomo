package com.kh.somomo.chat.model.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;
import lombok.Setter;

@NoArgsConstructor
@Getter
@Setter
@ToString
public class ChatMember {
	
	// 테이블 : CHAT_MEMBER (채팅방회원)
	private int roomNo;
	private String userId;
	private String userRank;

}
