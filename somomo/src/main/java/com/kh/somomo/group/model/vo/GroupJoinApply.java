package com.kh.somomo.group.model.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Getter
@Setter
@ToString
public class GroupJoinApply {
	
	// 테이블 : GROUP_JOIN_APPLY (그룹가입신청)
	private int applyNo;
	private int groupNo;
	private String userId;
	private String greeting;
	private String applyDate;
	private String status;
	
	// MEMBER 테이블과의 조인
	private String nickname;
}
