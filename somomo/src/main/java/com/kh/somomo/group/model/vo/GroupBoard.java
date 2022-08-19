package com.kh.somomo.group.model.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Getter
@Setter
@ToString
public class GroupBoard {

	// 테이블 : GROUP_BOARD (그룹방게시글)
	private int boardNo;
	private int groupNo;
	private String boardWriter;
	private String calendarNo;
	private String boardTitle;
	private String boardContent;
	private String createDate;
	private int count;
	private String boardType;
	private String status;
	
	private String profileImg;
	
	private int countReply;
	private String likeCheck;
	private int countLike;
}
