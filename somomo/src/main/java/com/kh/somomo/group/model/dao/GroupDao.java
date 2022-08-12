package com.kh.somomo.group.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.somomo.common.model.vo.PageInfo;
import com.kh.somomo.common.model.vo.RegionCategory;
import com.kh.somomo.group.model.vo.GroupCategory;
import com.kh.somomo.group.model.vo.GroupMember;
import com.kh.somomo.group.model.vo.GroupRoom;

@Repository
public class GroupDao {
	
	public int selectGroupListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("groupMapper.selectGroupListCount");
	}
	
	public ArrayList<RegionCategory> selectRegionCategoryList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("groupMapper.selectRegionCategoryList");
	}
	
	public ArrayList<GroupCategory> selectGroupCategoryList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("groupMapper.selectGroupCategoryList");
	}

	public ArrayList<GroupRoom> selectList(SqlSessionTemplate sqlSession, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		int limit = pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("groupMapper.selectList", null, rowBounds);
	}
	
	public ArrayList<GroupRoom> myGroupList(SqlSessionTemplate sqlSession, String userId) {
		return (ArrayList)sqlSession.selectList("groupMapper.myGroupList", userId);
	}
	
	public int insertGroup(SqlSessionTemplate sqlSession, GroupRoom gr) {
		return sqlSession.insert("groupMapper.insertGroup", gr);
	}

	public int insertMember(SqlSessionTemplate sqlSession, GroupMember gm) {
		return sqlSession.insert("groupMapper.insertGroupMember",gm);
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

}
