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
	private String latitude;
	private String longitude;
	private String meetDate;
	private String meetTotal;
	private String meetGender;
	private int meetAge;
	private String status;
}
