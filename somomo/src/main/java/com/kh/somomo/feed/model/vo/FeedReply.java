package com.kh.somomo.feed.model.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;
import lombok.Setter;

@NoArgsConstructor
@Getter
@Setter
@ToString
public class FeedReply {
	
	// 테이블 : FEED_REPLY (피드댓글)
	private int replyNo;
	private int boardNo;
	private String replyWriter;
	private String replyContent;
	private int rgroup; // 이부분 rGroup 으로 하면 롬복 사용시 에러 발생할 수 있어 필드명 살짝 수정합니다.
	private int rdepth; // 이부분 rGroup 으로 하면 롬복 사용시 에러 발생할 수 있어 필드명 살짝 수정합니다.
	private String replyDate;
	private String status;
}
