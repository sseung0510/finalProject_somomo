package com.kh.somomo.group.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.somomo.common.model.vo.Attachment;
import com.kh.somomo.common.model.vo.Likes;
import com.kh.somomo.common.model.vo.PageInfo;
import com.kh.somomo.common.model.vo.RegionCategory;
import com.kh.somomo.common.model.vo.Reply;
import com.kh.somomo.group.model.dao.GroupDao;
import com.kh.somomo.group.model.vo.CalendarPlan;
import com.kh.somomo.group.model.vo.GroupBoard;
import com.kh.somomo.group.model.vo.GroupCalendar;
import com.kh.somomo.group.model.vo.GroupCategory;
import com.kh.somomo.group.model.vo.GroupJoinApply;
import com.kh.somomo.group.model.vo.GroupMember;
import com.kh.somomo.group.model.vo.GroupRoom;
import com.kh.somomo.member.model.vo.CertVo;
import com.kh.somomo.member.model.vo.Member;

@Service
public class GroupServiceImpl implements GroupService{

	@Autowired
	private GroupDao groupDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	
	@Override
	public int selectGroupListCount(HashMap<String, String> map) {
		return groupDao.selectGroupListCount(sqlSession, map);
	}
	
	@Override
	public ArrayList<RegionCategory> selectRegionCategoryList() {
		return groupDao.selectRegionCategoryList(sqlSession);
	}

	@Override
	public ArrayList<GroupCategory> selectGroupCategoryList() {
		return groupDao.selectGroupCategoryList(sqlSession);
	}

	@Override
	public ArrayList<GroupRoom> selectGroupList(PageInfo pi, HashMap<String, String> map) {
		return groupDao.selectGroupList(sqlSession, pi, map);
	}
	
	@Override
	public ArrayList<GroupRoom> searchGroup(String search) {
		// TODO Auto-generated method stub
		return groupDao.searchGroup(sqlSession, search);
	}
	
	@Override
	public ArrayList<GroupRoom> myGroupList(String userId) {
		return groupDao.myGroupList(sqlSession, userId);
	}
	
	@Override
	@Transactional
	public int insertGroup(GroupRoom gr, GroupMember gm) {
		
		int result1 = groupDao.insertGroup(sqlSession, gr);
		int result2 = groupDao.insertRoomAdmin(sqlSession, gm);
		int result3 = groupDao.insertCalendar(sqlSession);
		return result1*result2*result3;
	}
	
	@Override
	public int getGroupNo() {
		return groupDao.getGroupNo(sqlSession);
	}

	@Override
	public GroupRoom selectGroup(int groupNo) {
		return groupDao.selectGroup(sqlSession, groupNo);
	}

	@Override
	public ArrayList<GroupMember> selectMemberList(int groupNo) {
		return groupDao.selectMemberList(sqlSession, groupNo);
	}

	@Override
	public int updateGroup(GroupRoom g) {
		return groupDao.updateGroup(sqlSession, g);
	}

	@Override
	public int deleteGroup(int groupNo) {
		return groupDao.deleteGroup(sqlSession, groupNo);
	}

	@Override
	public int updateType(GroupRoom g) {
		return groupDao.updateType(sqlSession, g);
	}

	@Override
	public GroupCalendar selectCalendar(int groupNo) {
		return groupDao.selectCalendar(sqlSession, groupNo);
	}

	@Override
	public int insertCalendarEvent(CalendarPlan gp) {

		return groupDao.insertCalendarEvent(sqlSession, gp);
	}

	@Override
	public ArrayList<CalendarPlan> selectCalendarEventList(int calendarNo) {
		return groupDao.selectCalendarEventList(sqlSession, calendarNo);
	}

	@Override
	public int insertRoomMember(GroupMember gm) {
		return groupDao.insertRoomMember(sqlSession, gm);
	}
	
	@Override
	public int applyGroup(GroupJoinApply applyInfo) {
		return groupDao.applyGroup(sqlSession, applyInfo);
	}

	@Override
	public int countApplication(int groupNo) {
		return groupDao.countApplication(sqlSession, groupNo);
	}

	@Override
	public ArrayList<GroupJoinApply> getApplicationList(int groupNo) {
		return groupDao.getApplicationList(sqlSession, groupNo);
	}

	@Override
	public int delteApplyInfo(GroupMember applyInfo) {
		return groupDao.delteApplyInfo(sqlSession, applyInfo);
	}

	
	@Override
	public int selectBoardListCount() {
		return groupDao.selectBoardListCount(sqlSession);
	}
	
	@Override
	public ArrayList<GroupBoard> selectBoardList(PageInfo pi, GroupMember gm) {
		return groupDao.selectBoardList(sqlSession,pi, gm);
	}
	
	@Override
	public ArrayList<Attachment> selectBoardAttachmentList(HashMap<String, Integer> boardRange) {
		return groupDao.selectBoardAttachmentList(sqlSession, boardRange);
	}
	
	
	@Override
	public int insertGroupBoard(GroupBoard gb, ArrayList<Attachment> boardList) {
		int result1 = groupDao.insertGroupBoard(sqlSession, gb);
		int result2 = 1;
		if(!boardList.isEmpty()) {
			for(Attachment at : boardList) {
				result2 *= groupDao.insertAttachment(sqlSession, at);
			}
		}

		return result1 * result2;
	}

	@Override
	public int insertLike(Likes like) {
		return groupDao.insertLike(sqlSession,like);
	}

	@Override
	public int deleteLike(Likes like) {
		return groupDao.deleteLike(sqlSession,like);
	}

	@Override
	public int countLike(int boardNo) {
		return groupDao.countLike(sqlSession, boardNo);
	}

	@Override
	public int insertReply(Reply reply) {
		return groupDao.insertReply(sqlSession, reply);
	}
	
	@Override
	public ArrayList<Reply> selectReplyList(int boardNo) {
		return groupDao.selectReplyList(sqlSession, boardNo);
	}
	
	@Override
	public int insertReReply(Reply reply) {
		return groupDao.insertReReply(sqlSession, reply);
	}
	

	@Override
	public boolean checkHasRereply(int replyNo) {
		int countRereply = groupDao.countRereply(sqlSession, replyNo);
		return countRereply > 0 ? true : false;
	}
	
	@Override
	public int deleteReply(int replyNo) {
		return groupDao.deleteReply(sqlSession, replyNo);
	}
	
	@Override
	public int deleteReplyContent(int replyNo) {
		return groupDao.deleteReplyContent(sqlSession, replyNo);
	}
	
	@Override
	public boolean isSingleRereplyNdeleteReply(int rgroup) {
		boolean flag = false;
		// 그룹번호로 댓글+답글 개수 체크
		int countReply = groupDao.countReplyNrereply(sqlSession, rgroup);
		if(countReply == 2) { // 댓글 1개 + 답글 1개일 경우
			// 댓글 내용이 삭제되어있을 경우 => true
			flag = groupDao.checkDeletedReply(sqlSession, rgroup) > 0 ? true : false;
		}
		return flag;
	}

	@Override
	public int deleteTwoReply(int rgroup) {
		return groupDao.deleteTwoReply(sqlSession, rgroup);
	}

	@Override
	public int countReply(int boardNo) {
		return groupDao.countReply(sqlSession, boardNo);
	}

	@Override
	public ArrayList<Member> searchUser(HashMap<String, String> map) {
		return groupDao.searchUser(sqlSession, map);
	}

	@Override
	public GroupMember matchGroup(String inviteCode) {
		return groupDao.matchGroup(sqlSession, inviteCode);
	}


@Override
	public int matchJoinApply(GroupMember gm) {
		
		int result = groupDao.matchJoinApply(sqlSession, gm);
		int result2 = 0;
		int result3 = 0;
		if (result > 0) {
			result2 = groupDao.delteApplyInfo(sqlSession, gm);
			result3 = groupDao.insertRoomMember(sqlSession, gm);			
		}
		
		return result*result2*result3;
	}

	@Override
	public int deleteBoard(int boardNo) {
		return groupDao.deleteBoard(sqlSession, boardNo);
	}

	@Override
	public int deleteAllAttachment(int boardNo) {
		return groupDao.deleteAllAttachment(sqlSession, boardNo);
	}

	@Override
	public ArrayList<Attachment> selectAttachmentList(int boardNo) {
		return groupDao.selectAttachmentList(sqlSession, boardNo);
	}

	@Override
	public int deleteAttachment(ArrayList<Attachment> atList) {
		return 0;
	}

	@Override
	public ArrayList<Attachment> groupGalleryAttachmentList(int groupNo) {
		return groupDao.groupGalleryAttachmentList(sqlSession, groupNo);
	}

	@Override
	public ArrayList<CalendarPlan> calendarEventListEntire(int groupNo) {
		return groupDao.calendarEventListEntire(sqlSession, groupNo);
	}
	
	@Override
	public int exitGroup(GroupMember gm) {
		return groupDao.exitGroup(sqlSession, gm);
	}

	
}
