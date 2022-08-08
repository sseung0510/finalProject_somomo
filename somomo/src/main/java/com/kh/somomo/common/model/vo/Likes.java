package com.kh.somomo.common.model.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Getter
@Setter
@ToString
public class Likes {
	
	// 테이블 : FEED_LIKES, GROUP_LIKES (관심글)
	private String userId;
	private int boardNo;
}
