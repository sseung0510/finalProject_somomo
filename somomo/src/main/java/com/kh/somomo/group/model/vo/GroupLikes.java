package com.kh.somomo.group.model.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Getter
@Setter
@ToString
public class GroupLikes {

	// 테이블 : GROUP_LIKES(관심글)
	private String userId;
	private int boardNo;
}
