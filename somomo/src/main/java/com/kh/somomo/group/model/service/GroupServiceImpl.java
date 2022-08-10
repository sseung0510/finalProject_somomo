package com.kh.somomo.group.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.somomo.group.model.dao.GroupDao;
import com.kh.somomo.group.model.vo.GroupMember;
import com.kh.somomo.group.model.vo.GroupRoom;

@Service
public class GroupServiceImpl implements GroupService{

	@Autowired
	private GroupDao groupDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public ArrayList<GroupRoom> selectList() {
		return groupDao.selectList(sqlSession);
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
	public int insertMember(GroupMember gm) {
		return groupDao.insertMember(sqlSession, gm);
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

	
}
