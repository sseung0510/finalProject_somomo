package com.kh.somomo.chat.model.vo;

import lombok.ToString;

import lombok.Setter;
import lombok.Getter;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Getter
@Setter
@ToString
public class Chat {

	// 테이블 : CHAT (채팅방 내용)
	private int chatNo;
	private int roomNo;
	private String chatWriter;
	private String chatContent;
	private String chatDate;
	private String chatTime; // 테이블에 새로 추가된 컬럼
	
	// MEMBER 테이블 JOIN 시 가져올 값
	private String profileImg;
	private String nickname;
}
