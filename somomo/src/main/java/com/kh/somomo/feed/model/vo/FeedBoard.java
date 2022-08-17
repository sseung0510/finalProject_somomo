package com.kh.somomo.feed.model.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Getter
@Setter
@ToString
public class FeedBoard {

	// 테이블 : FEED_BOARD (피드게시글)
	private int boardNo;
	private String boardWriter;
	private int regionNo;
	private String boardType;
	private String boardTitle;
	private String boardContent;
	private int count;
	private String boardDate;
	private String meetPlace;
	private String longitude;
	private String latitude;
	private String meetDate;
	private String meetTotal;
	private String meetGender;
	private String meetAge;
	private String status;
	
	
	private String minAge; // 모임 최소 나이
	private String maxAge; // 모임 최대 나이
	private String meetCondition; // 모임모집 신청조건 문구
	
	// REGION_CATEGORY테이블과 JOIN해서 받아온 값
	private String regionName; // 지역명
	
	// MEMBER테이블과 JOIN해서 받아온 값
	private String nickname; // 작성자 닉네임
	private String profileImg; // 작성자 프로필사진
	
	// REPLY테이블과 JOIN해서 받아온 값
	private int countReply; // 댓글 수
	
	// CHAT_ROOM, CHAT_MEMBER테이블과 JOIN해서 받아온 값
	private int countMember; // (채팅)참여자 수
	private int roomNo; // 채팅방 번호
	
	// FEED_LIKES테이블과 JOIN해서 받아온 값
	private String likeCheck; // 좋아요 클릭 여부
	private int countLike; // 좋아요 개수
	
}
