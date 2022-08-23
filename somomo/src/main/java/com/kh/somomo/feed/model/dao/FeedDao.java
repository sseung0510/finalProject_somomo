package com.kh.somomo.feed.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.somomo.chat.model.vo.ChatMember;
import com.kh.somomo.common.model.vo.Attachment;
import com.kh.somomo.common.model.vo.Likes;
import com.kh.somomo.common.model.vo.PageInfo;
import com.kh.somomo.common.model.vo.RegionCategory;
import com.kh.somomo.common.model.vo.Reply;
import com.kh.somomo.feed.model.vo.FeedBoard;

@Repository
public class FeedDao {

	public int selectFeedListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("feedMapper.selectFeedListCount");
	}
	
	public int selectSearchListCount(SqlSessionTemplate sqlSession, HashMap<String, Object> map) {
		return sqlSession.selectOne("feedMapper.selectSearchListCount", map);
	}
	
	public ArrayList<FeedBoard> selectFeedList(SqlSessionTemplate sqlSession, PageInfo pi, HashMap<String, Object> map) {
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		int limit = pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("feedMapper.selectFeedList", map, rowBounds);
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

	public int insertChatRoom(SqlSessionTemplate sqlSession, String boardTitle) {
		return sqlSession.insert("feedMapper.insertChatRoom", boardTitle);
	}

	public int insertChatAdmin(SqlSessionTemplate sqlSession, String boardWriter) {
		return sqlSession.insert("feedMapper.insertChatAdmin", boardWriter);
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

	public int checkChatMember(SqlSessionTemplate sqlSession, ChatMember cm) {
		return sqlSession.selectOne("feedMapper.checkChatMember", cm);
	}

	public int selectMeetTotal(SqlSessionTemplate sqlSession, int roomNo) {
		return sqlSession.selectOne("feedMapper.selectMeetTotal",roomNo);
	}

	public int selectCountMember(SqlSessionTemplate sqlSession, int roomNo) {
		return sqlSession.selectOne("feedMapper.selectCountMember", roomNo);
	}

	public int insertChatMember(SqlSessionTemplate sqlSession, ChatMember cm) {
		return sqlSession.insert("feedMapper.insertChatMember", cm);
	}

	public int countOriginFile(SqlSessionTemplate sqlSession, int boardNo) {
		return sqlSession.selectOne("feedMapper.countOriginFile", boardNo);
	}
	public int deleteAttachment(SqlSessionTemplate sqlSession, int fileNo) {
		return sqlSession.delete("feedMapper.deleteAttachment", fileNo);
	}
	public int updateGeneralBoard(SqlSessionTemplate sqlSession, FeedBoard fb) {
		return sqlSession.update("feedMapper.updateGeneralBoard", fb);
	}
	
	public int updateAttachment(SqlSessionTemplate sqlSession, Attachment at) {
		return sqlSession.update("feedMapper.updateAttachment", at);
	}
	
	public int insertNewAttachment(SqlSessionTemplate sqlSession, Attachment at) {
		return sqlSession.insert("feedMapper.insertNewAttachment", at);
	}
	
	public int updateMeetBoard(SqlSessionTemplate sqlSession, FeedBoard fb) {
		return sqlSession.update("feedMapper.updateMeetBoard", fb);
	}
	
	public int deleteBoard(SqlSessionTemplate sqlSession, int boardNo) {
		return sqlSession.update("feedMapper.deleteBoard", boardNo);
	}
	
	public int deleteAllAttachment(SqlSessionTemplate sqlSession, int boardNo) {
		return sqlSession.delete("feedMapper.deleteAllAttachment", boardNo);
	}

	public ArrayList<Reply> selectReplyList(SqlSessionTemplate sqlSession, int boardNo) {
		return (ArrayList)sqlSession.selectList("feedMapper.selectReplyList", boardNo);
	}
	
	public int insertReply(SqlSessionTemplate sqlSession, Reply reply) {
		return sqlSession.insert("feedMapper.insertReply", reply);
	}
	
	public int insertReReply(SqlSessionTemplate sqlSession, Reply reply) {
		return sqlSession.insert("feedMapper.insertReReply", reply);
	}
	
	public int updateReply(SqlSessionTemplate sqlSession, Reply reply) {
		return sqlSession.update("feedMapper.updateReply", reply);
	}
	
	public int deleteReply(SqlSessionTemplate sqlSession, int replyNo) {
		return sqlSession.update("feedMapper.deleteReply", replyNo);
	}
	
	public int countRereply(SqlSessionTemplate sqlSession, int replyNo) {
		return sqlSession.selectOne("feedMapper.countRereply", replyNo);
	}
	
	public int deleteReplyContent(SqlSessionTemplate sqlSession, int replyNo) {
		return sqlSession.update("feedMapper.deleteReplyContent", replyNo);
	}
	
	public int countReplyNrereply(SqlSessionTemplate sqlSession, int rgroup) {
		return sqlSession.selectOne("feedMapper.countReplyNrereply", rgroup);
	}

	public int checkDeletedReply(SqlSessionTemplate sqlSession, int rgroup) {
		return sqlSession.selectOne("feedMapper.checkDeletedReply", rgroup);
	}
	
	public int deleteTwoReply(SqlSessionTemplate sqlSession, int rgroup) {
		return sqlSession.update("feedMapper.deleteTwoReply", rgroup);
	}
	
	public int countReply(SqlSessionTemplate sqlSession, int boardNo) {
		return sqlSession.selectOne("feedMapper.countReply", boardNo);
	}
	
	public int insertLike(SqlSessionTemplate sqlSession, Likes like) {
		return sqlSession.insert("feedMapper.insertLike", like);
	}

	public int deleteLike(SqlSessionTemplate sqlSession, Likes like) {
		return sqlSession.delete("feedMapper.deleteLike", like);
	}

	public int checkLike(SqlSessionTemplate sqlSession, Likes like) {
		return sqlSession.selectOne("feedMapper.checkLike", like);
	}

	public int countLike(SqlSessionTemplate sqlSession, int boardNo) {
		return sqlSession.selectOne("feedMapper.countLike", boardNo);
	}
	
}
