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
	private String insertDate; // 테이블에 새로 추가된 컬럼
	private int chatCount; // 테이블에 새로 추가된 컬럼
	
	// MEMBER 테이블 JOIN 시 가져올 값
	private String profileImg;
	private String nickname;
}
