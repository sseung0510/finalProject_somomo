package com.kh.somomo.group.model.vo;

import lombok.ToString;
import lombok.Setter;
import lombok.Getter;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Getter
@Setter
@ToString
public class GroupMember {
	
	// 테이블 : GROUP_MEMBER (그룹방멤버)
	private int groupNo;
	private String userId;
	private String userRank;
	private String nickname; // 추가함
	private String profileImg; // 추가함
}
