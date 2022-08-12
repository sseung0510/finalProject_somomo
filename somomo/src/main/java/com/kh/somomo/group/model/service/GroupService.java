package com.kh.somomo.group.model.service;

import java.util.ArrayList;

import com.kh.somomo.common.model.vo.PageInfo;
import com.kh.somomo.common.model.vo.RegionCategory;
import com.kh.somomo.group.model.vo.GroupCategory;
import com.kh.somomo.group.model.vo.GroupMember;
import com.kh.somomo.group.model.vo.GroupRoom;

public interface GroupService {
	
	//------ 그룹방 리스트 조회 + 페이징 처리 ----- //
	//그룹방 개수 조회
	int selectGroupListCount();
	
	//지역 카테고리 리스트 조회
	ArrayList<RegionCategory> selectRegionCategoryList();
	
	//그룹 카테고리 리스트 조회
	ArrayList<GroupCategory> selectGroupCategoryList();
	
	//그룹방 리스트 조회
	ArrayList<GroupRoom> selectList(PageInfo pi);
	
	//관리 그룹방 리스트
	ArrayList<GroupRoom> myGroupList(String userId);
	
	// ----- 그룹방 만들기 할때 필요한 메소드 ----- //
	//그룹방 추가
	int insertGroup(GroupRoom gr);
	
	//그룹방 멤버 추가
	int insertMember(GroupMember gm);
	
	//그룹방 캘린더 추가
	int insertCalendar();
	
	// 그룹방 번호 가져오기
	int getGroupNo();
	
	// ----- 그룹방 상세 페이지에서 필요한 정보들 조회 ---- //
	// 그룹방
	GroupRoom selectGroup(int groupNo);
	
	// 그룹방 멤버 리스트
	ArrayList<GroupMember> selectMemberList(int groupNo);
	
	// ------
	// 그룹 가입 신청
	//int applyGroup(GroupJoinApply applyInfo);


	

}
