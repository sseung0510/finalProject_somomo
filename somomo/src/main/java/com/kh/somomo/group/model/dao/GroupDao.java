package com.kh.somomo.group.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.somomo.common.model.vo.PageInfo;
import com.kh.somomo.common.model.vo.RegionCategory;
import com.kh.somomo.group.model.vo.CalendarPlan;
import com.kh.somomo.group.model.vo.GroupCalendar;
import com.kh.somomo.group.model.vo.GroupCategory;
import com.kh.somomo.group.model.vo.GroupJoinApply;
import com.kh.somomo.group.model.vo.GroupMember;
import com.kh.somomo.group.model.vo.GroupRoom;

@Repository
public class GroupDao {
	
	public int selectGroupListCount(SqlSessionTemplate sqlSession, String categoryNo) {
		return sqlSession.selectOne("groupMapper.selectGroupListCount", categoryNo);
	}
	
	public ArrayList<RegionCategory> selectRegionCategoryList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("groupMapper.selectRegionCategoryList");
	}
	
	public ArrayList<GroupCategory> selectGroupCategoryList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("groupMapper.selectGroupCategoryList");
	}

	public ArrayList<GroupRoom> selectGroupList(SqlSessionTemplate sqlSession, PageInfo pi, HashMap<String, String> map) {
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		int limit = pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("groupMapper.selectGroupList", map, rowBounds);
	}
	
	public ArrayList<GroupRoom> myGroupList(SqlSessionTemplate sqlSession, String userId) {
		return (ArrayList)sqlSession.selectList("groupMapper.myGroupList", userId);
	}
	
	public int insertGroup(SqlSessionTemplate sqlSession, GroupRoom gr) {
		return sqlSession.insert("groupMapper.insertGroup", gr);
	}

	public ArrayList<GroupRoom> searchGroup(SqlSessionTemplate sqlSession, String search) {
		return (ArrayList)sqlSession.selectList("groupMapper.searchGroup", search);
	}

	public int insertRoomAdmin(SqlSessionTemplate sqlSession, GroupMember gm) {
		return sqlSession.insert("groupMapper.insertRoomAdmin",gm);
	}
	
	public int insertCalendar(SqlSessionTemplate sqlSession) {
		return sqlSession.insert("groupMapper.insertCalendar");
	}

	public int getGroupNo(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("groupMapper.getGroupNo");
	}
	public GroupRoom selectGroup(SqlSessionTemplate sqlSession, int groupNo) {
		return sqlSession.selectOne("groupMapper.selectGroup", groupNo);
	}

	public ArrayList<GroupMember> selectMemberList(SqlSessionTemplate sqlSession, int groupNo) {
		return (ArrayList)sqlSession.selectList("groupMapper.selectMemberList", groupNo);
	}

	public int updateGroup(SqlSessionTemplate sqlSession, GroupRoom g) {
		return sqlSession.update("groupMapper.updateGroup", g);
	}

	public int deleteGroup(SqlSessionTemplate sqlSession, int groupNo) {
		return sqlSession.delete("groupMapper.deleteGroup", groupNo);
	}

	public int updateType(SqlSessionTemplate sqlSession, GroupRoom g) {
		return sqlSession.update("groupMapper.updateType", g);
	}

	public GroupCalendar selectCalendar(SqlSessionTemplate sqlSession, int groupNo) {
		return sqlSession.selectOne("groupMapper.selectGroupCalendar", groupNo);
	}

	public int insertCalendarEvent(SqlSessionTemplate sqlSession, CalendarPlan gp) {
		
		return sqlSession.insert("groupMapper.insertCalendarEvent", gp);
	}

	public ArrayList<CalendarPlan> selectCalendarEventList(SqlSessionTemplate sqlSession, int calendarNo) {
		
		return (ArrayList)sqlSession.selectList("groupMapper.selectCalendarEventList", calendarNo);
	}

	public int applyGroup(SqlSessionTemplate sqlSession, GroupJoinApply applyInfo) {
		return sqlSession.insert("groupMapper.applyGroup", applyInfo);
	}

	public ArrayList<GroupJoinApply> getApplicationList(SqlSessionTemplate sqlSession, int groupNo) {
		return (ArrayList)sqlSession.selectList("groupMapper.getApplicationList", groupNo);
	}

	public int insertRoomMember(SqlSessionTemplate sqlSession, GroupMember gm) {
		return sqlSession.insert("groupMapper.insertRoomMember", gm);
	}

	public int countApplication(SqlSessionTemplate sqlSession, int groupNo) {
		return sqlSession.selectOne("groupMapper.countApplication", groupNo);
	}

	public int delteApplyInfo(SqlSessionTemplate sqlSession, GroupJoinApply applyInfo) {
		return sqlSession.delete("groupMapper.delteApplyInfo", applyInfo);
	}


}
