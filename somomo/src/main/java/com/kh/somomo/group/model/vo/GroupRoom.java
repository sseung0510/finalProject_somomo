package com.kh.somomo.group.model.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Getter
@Setter
@ToString
public class GroupRoom {

	// 테이블 : GROUP (그룹방)
	private int groupNo;
	private int regionNo;   
	private int categoryNo; 
	private String groupName;
	private String groupImg;
	private String groupDetail;
	private String applyQuestion;
	private String inviteCode;
	private String groupType;
	private String groupDate;
	
	// 지역/그룹 카테고리 조인해서 들어올 값을 위한 필드
	private String regionName;
	private String categoryName;
	
	// GROUP_MEMBER와 조인해서 각 그룹의 소속된 회원의 수를 담아줄 필드
	private int memberCount;
	
	// GROUP_MEMBER와 조인할때 반환되는 값을 받아주기 위한것
	private String userRank;
	
	// GROUP_MEMBER와 조인 => 내가 가입/관리 중인 그룹인지 확인하는 값 : 'Y'
	private String myGroup;
	
	// GROUP_JOIN_APPLY와 조인 => 가입 요청중인 그룹인지 확인하는 값 : 'A'
	private String applying;
	
	// 그룹타입 : 공개/비공개/그룹명 공개 => 따로 테이블이 없어서 DECODE사용
	private String groupTypeStr;
}
