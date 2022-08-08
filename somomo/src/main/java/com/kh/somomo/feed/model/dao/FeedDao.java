package com.kh.somomo.feed.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.somomo.common.model.vo.Attachment;
import com.kh.somomo.common.model.vo.Likes;
import com.kh.somomo.common.model.vo.PageInfo;
import com.kh.somomo.common.model.vo.RegionCategory;
import com.kh.somomo.feed.model.vo.FeedBoard;

@Repository
public class FeedDao {

	public int selectFeedListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("feedMapper.selectFeedListCount");
	}
	
	public ArrayList<FeedBoard> selectFeedList(SqlSessionTemplate sqlSession, PageInfo pi, String userId) {
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		int limit = pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("feedMapper.selectFeedList", userId, rowBounds);
	}
	
	public ArrayList<Attachment> selectFeedAttachmentList(SqlSessionTemplate sqlSession,
			HashMap<String, Integer> boardRange) {
		return (ArrayList)sqlSession.selectList("feedMapper.selectFeedAttachmentList", boardRange);
	}
	
	public ArrayList<RegionCategory> selectRegionList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("feedMapper.selectRegionList");
	}

	public int insertGeneralBoard(SqlSessionTemplate sqlSession, FeedBoard b) {
		return sqlSession.insert("feedMapper.insertGeneralBoard", b);
	}

	public int insertAttachment(SqlSessionTemplate sqlSession, Attachment at) {
		return sqlSession.insert("feedMapper.insertAttachment", at);
	}
	
	public int insertMeetBoard(SqlSessionTemplate sqlSession, FeedBoard fb) {
		return sqlSession.insert("feedMapper.insertMeetBoard", fb);
	}

	public int insertChatRoom(SqlSessionTemplate sqlSession) {
		return sqlSession.insert("feedMapper.insertChatRoom");
	}

	public int insertChatMember(SqlSessionTemplate sqlSession, String boardWriter) {
		return sqlSession.insert("feedMapper.insertChatMember", boardWriter);
	}

	public int increaseCount(SqlSessionTemplate sqlSession, int boardNo) {
		return sqlSession.update("feedMapper.increaseCount", boardNo);
	}

	public String selectBoardType(SqlSessionTemplate sqlSession, int boardNo) {
		return sqlSession.selectOne("feedMapper.selectBoardType", boardNo);
	}
	
	public FeedBoard selectGeneralBoard(SqlSessionTemplate sqlSession, int boardNo) {
		return sqlSession.selectOne("feedMapper.selectGeneralBoard", boardNo);
	}
	
	public ArrayList<Attachment> selectAttachmentList(SqlSessionTemplate sqlSession, int boardNo) {
		return (ArrayList)sqlSession.selectList("feedMapper.selectAttachmentList", boardNo);
	}
	
	public FeedBoard selectMeetBoard(SqlSessionTemplate sqlSession, int boardNo) {
		return sqlSession.selectOne("feedMapper.selectMeetBoard", boardNo);
	}

	public int deleteBoard(SqlSessionTemplate sqlSession, int boardNo) {
		return sqlSession.update("feedMapper.deleteBoard", boardNo);
	}

	public int insertLike(SqlSessionTemplate sqlSession, Likes like) {
		return sqlSession.insert("feedMapper.insertLike", like);
	}

	public int deleteLike(SqlSessionTemplate sqlSession, Likes like) {
		return sqlSession.delete("feedMapper.deleteLike", like);
	}


}
