package com.kh.somomo.group.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.somomo.common.model.vo.PageInfo;
import com.kh.somomo.common.model.vo.RegionCategory;
import com.kh.somomo.group.model.dao.GroupDao;
import com.kh.somomo.group.model.vo.CalendarPlan;
import com.kh.somomo.group.model.vo.GroupCalendar;
import com.kh.somomo.group.model.vo.GroupCategory;
import com.kh.somomo.group.model.vo.GroupJoinApply;
import com.kh.somomo.group.model.vo.GroupMember;
import com.kh.somomo.group.model.vo.GroupRoom;

@Service
public class GroupServiceImpl implements GroupService{

	@Autowired
	private GroupDao groupDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	
	@Override
	public int selectGroupListCount(String categoryNo) {
		return groupDao.selectGroupListCount(sqlSession, categoryNo);
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
	public int insertGroup(GroupRoom gr) {
		return groupDao.insertGroup(sqlSession, gr);
	}
	
	@Override
	public int insertRoomAdmin(GroupMember gm) {
		return groupDao.insertRoomAdmin(sqlSession, gm);
	}
	
	@Override
	public int insertCalendar() {
		return groupDao.insertCalendar(sqlSession);
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
	public int delteApplyInfo(GroupJoinApply applyInfo) {
		return groupDao.delteApplyInfo(sqlSession, applyInfo);
	}

	
	

		

	
	
}
