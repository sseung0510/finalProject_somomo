package com.kh.somomo.group.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.kh.somomo.common.model.vo.PageInfo;
import com.kh.somomo.common.model.vo.RegionCategory;
import com.kh.somomo.group.model.vo.CalendarPlan;
import com.kh.somomo.group.model.vo.GroupCalendar;
import com.kh.somomo.group.model.vo.GroupCategory;
import com.kh.somomo.group.model.vo.GroupJoinApply;
import com.kh.somomo.group.model.vo.GroupMember;
import com.kh.somomo.group.model.vo.GroupRoom;

public interface GroupService {
	
	//------ 그룹방 리스트 조회 + 페이징 처리 ----- //
	//그룹방 개수 조회
	int selectGroupListCount(String categoryNo);
	
	//지역 카테고리 리스트 조회
	ArrayList<RegionCategory> selectRegionCategoryList();
	
	//그룹 카테고리 리스트 조회
	ArrayList<GroupCategory> selectGroupCategoryList();
	
	//그룹방 리스트 조회
	ArrayList<GroupRoom> selectGroupList(PageInfo pi, HashMap<String, String> map);
	
	//검색시 그룹방 조회
	ArrayList<GroupRoom> searchGroup(String search);
	
	//관리 그룹방 리스트
	ArrayList<GroupRoom> myGroupList(String userId);
	
	// ----- 그룹방 만들기 할때 필요한 메소드 ----- //
	//그룹방 추가
	int insertGroup(GroupRoom gr);
	
	//그룹방 방장 추가
	int insertRoomAdmin(GroupMember gm);
	
	//그룹방 캘린더 추가
	int insertCalendar();
	
	// 그룹방 번호 가져오기
	int getGroupNo();
	
	// ----- 그룹방 상세 페이지에서 필요한 정보들 조회 ---- //
	// 그룹방
	GroupRoom selectGroup(int groupNo);
	
	GroupCalendar selectCalendar(int groupNo);
	
	// 그룹방 멤버 리스트
	ArrayList<GroupMember> selectMemberList(int groupNo);
	
	// 가입 요청 카운트
	int countApplication(int groupNo);
	
	// ----------- 그룹방 설정 변경 및 삭제 --------- //
	int updateGroup(GroupRoom g);
	
	int deleteGroup(int groupNo);
	
	int updateType(GroupRoom g);

	
	
	// 캘린더 이벤트 추가 
	
	int insertCalendarEvent(CalendarPlan gp);

	ArrayList<CalendarPlan> selectCalendarEventList(int calendarNo);

	
	// ------
	// 그룹 가입 신청
	int applyGroup(GroupJoinApply applyInfo);

	// 회원 그룹방에 추가
	int insertRoomMember(GroupMember gm);
	
	// 회원에 의한 가입 요청 취소 or 관리자 승인으로 인한 데이터 삭제
	int delteApplyInfo(GroupJoinApply applyInfo);
	
	// 가입신청서리스트 조회
	ArrayList<GroupJoinApply> getApplicationList(int groupNo);

	

}
