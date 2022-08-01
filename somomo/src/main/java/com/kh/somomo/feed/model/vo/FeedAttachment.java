package com.kh.somomo.feed.model.vo;

import lombok.Getter;

import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Getter
@Setter
@ToString
public class FeedAttachment {

	// 테이블 : FEED_ATTACHMENT (피드첨부파일)
	private int fileNo;
	private int boardNo;
	private String originName;
	private String changeName;
}
