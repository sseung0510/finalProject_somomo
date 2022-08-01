package com.kh.somomo.group.model.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;
import lombok.Setter;

@NoArgsConstructor
@Getter
@Setter
@ToString
public class GroupReply {

	// 테이블 : GROUP_REPLY (그룹방댓글)
	private int replyNo;
	private int boardNo;
	private String replyWriter;
	private String replyContent;
	private int group;
	private int depth;
	private String replyDate;
	private String status;
	
}
