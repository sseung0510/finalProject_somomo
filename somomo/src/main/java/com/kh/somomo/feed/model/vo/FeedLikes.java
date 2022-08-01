package com.kh.somomo.feed.model.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Getter
@Setter
@ToString
public class FeedLikes {
	
	// 테이블 : FEED_LIKES (관심글)
	private String userId;
	private int boardNo;
}
