package com.kh.somomo.group.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.google.gson.JsonElement;
import com.kh.somomo.common.model.vo.Attachment;
import com.kh.somomo.common.model.vo.Likes;
import com.kh.somomo.common.model.vo.PageInfo;
import com.kh.somomo.common.model.vo.RegionCategory;
import com.kh.somomo.common.model.vo.Reply;
import com.kh.somomo.group.model.vo.CalendarPlan;
import com.kh.somomo.group.model.vo.GroupBoard;
import com.kh.somomo.group.model.vo.GroupCalendar;
import com.kh.somomo.group.model.vo.GroupCategory;
import com.kh.somomo.group.model.vo.GroupJoinApply;
import com.kh.somomo.group.model.vo.GroupMember;
import com.kh.somomo.group.model.vo.GroupRoom;
import com.kh.somomo.member.model.vo.Member;

public interface GroupService {
	
	//------ 그룹방 리스트 조회 + 페이징 처리 ----- //
	//그룹방 개수 조회
	int selectGroupListCount(HashMap<String, String> map);
	
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
	int insertGroup(GroupRoom gr, GroupMember gm);
		
	// 그룹방 번호 가져오기
	int getGroupNo();
	
	// ----- 그룹방 상세 페이지에서 필요한 정보들 조회 ---- //
	// 그룹방
	GroupRoom selectGroup(int groupNo);
	
	GroupCalendar selectCalendar(int groupNo);
	
	// 그룹방 멤버 리스트
	ArrayList<GroupMember> selectMemberList(int groupNo);
	
	//그룹방 탈퇴
	int exitGroup(GroupMember gm);
	
	// 가입 요청 카운트
	int countApplication(int groupNo);
	
	// ----------- 그룹방 설정 변경 및 삭제 --------- //
	int updateGroup(GroupRoom g);
	
	int deleteGroup(int groupNo);
	
	int updateType(GroupRoom g);

	
	
	//------ 그룹방 피드 리스트 ---------- //
	//그룹 피드 게시글 전체 개수 조회
	int selectBoardListCount();
	
	//그룹 피드 게시글 목록 조회
	ArrayList<GroupBoard> selectBoardList(PageInfo pi, GroupMember gm);
	
	//그룹 피드 게시글 첨부파일(사진) 목록 조회
	ArrayList<Attachment> selectBoardAttachmentList(HashMap<String, Integer> boardRange);
	
	//그룹 피드 게시글 첨부파일 목록 조회
	ArrayList<Attachment> selectAttachmentList(int boardNo);

	//그룹 피드 게시글 추가
	int insertGroupBoard(GroupBoard gb, ArrayList<Attachment> boardList);
	
	//기존 첨부파일 삭제
	int deleteAttachment(ArrayList<Attachment> atList);
	
	//그룹 피드 게시글 삭제
	int deleteBoard(int boardNo);
	
	// 기존 첨부파일 전체 삭제
	int deleteAllAttachment(int boardNo);
	
	//좋아요 등록
	int insertLike(Likes like);

	//좋아요 삭제
	int deleteLike(Likes like);

	//좋아요 개수
	int countLike(int boardNo);
		
	//댓글 조회
	ArrayList<Reply> selectReplyList(int boardNo);
		
	//댓글 작성
	int insertReply(Reply reply);
	
	// 답글(대댓글) 작성
	int insertReReply(Reply reply);

	// 대댓글 존재 여부 확인
	boolean checkHasRereply(int replyNo);

	// 댓글 삭제
	int deleteReplyContent(int replyNo);

	// 댓글 내용 삭제 (답글 존재하는 댓글일 경우)
	int deleteReply(int replyNo);
	
	// 삭제된 댓글에 달린 답글이며, 답글이 마지막 남은 1개인 경우인지 확인
	boolean isSingleRereplyNdeleteReply(int rgroup);

	// 댓글 + 답글 삭제
	int deleteTwoReply(int rgroup);
	
	// 댓글 개수 확인
	int countReply(int boardNo);
	
	
	// 캘린더 이벤트 추가 
	
	int insertCalendarEvent(CalendarPlan gp);

	ArrayList<CalendarPlan> selectCalendarEventList(int calendarNo);

	
	// ------
	// 그룹 가입 신청
	int applyGroup(GroupJoinApply applyInfo);

	// 회원 그룹방에 추가
	int insertRoomMember(GroupMember gm);
	
	// 회원에 의한 가입 요청 취소 or 관리자 승인으로 인한 데이터 삭제
	int delteApplyInfo(GroupMember applyInfo);
	
	// 가입신청서리스트 조회
	ArrayList<GroupJoinApply> getApplicationList(int groupNo);

	// 초대코드 발송을 위한 사용자 검색
	ArrayList<Member> searchUser(HashMap<String, String> map);
	
	// 초대코드와 그룹을 매칭해서 그룹방 번호 반환
	GroupMember matchGroup(String inviteCode);
	
	// 그룹조인어플라이 테이블과 매칭후 결과가 있다면 제거
	int matchJoinApply(GroupMember gm);

	
	// 그룹별 전체 첨부파일 조회
	ArrayList<Attachment> groupGalleryAttachmentList(int groupNo);

	
	// 그룹별 일정 조회
	ArrayList<CalendarPlan> calendarEventListEntire(int groupNo);
	

	
	
}
