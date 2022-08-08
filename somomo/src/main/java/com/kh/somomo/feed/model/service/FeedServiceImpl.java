package com.kh.somomo.feed.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.somomo.common.model.vo.Attachment;
import com.kh.somomo.common.model.vo.Likes;
import com.kh.somomo.common.model.vo.PageInfo;
import com.kh.somomo.common.model.vo.RegionCategory;
import com.kh.somomo.common.model.vo.Reply;
import com.kh.somomo.feed.model.dao.FeedDao;
import com.kh.somomo.feed.model.vo.FeedBoard;

@Service
public class FeedServiceImpl implements FeedService{
	
	@Autowired
	private FeedDao feedDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public int selectFeedListCount() {
		return feedDao.selectFeedListCount(sqlSession);
	}

	@Override
	public ArrayList<FeedBoard> selectFeedList(PageInfo pi, String userId) {
		return feedDao.selectFeedList(sqlSession, pi, userId);
	}
	
	@Override
	public ArrayList<Attachment> selectFeedAttachmentList(HashMap<String, Integer> boardRange) {
		return feedDao.selectFeedAttachmentList(sqlSession, boardRange);
	}
	
	@Override
	public ArrayList<RegionCategory> selectRegionList() {
		return feedDao.selectRegionList(sqlSession);
	}

	@Override
	public int insertGeneralBoard(FeedBoard fb, ArrayList<Attachment> atList) {
		
		int result1 = feedDao.insertGeneralBoard(sqlSession, fb);
		int result2 = 1;
		if(!atList.isEmpty()) {
			for(Attachment at : atList) {
				result2 *= feedDao.insertAttachment(sqlSession, at);
			}
		}

		return result1 * result2;
	}
	
	@Override
	public int insertMeetBoard(FeedBoard fb) {
		int result1 = feedDao.insertMeetBoard(sqlSession, fb);
		int result2 = feedDao.insertChatRoom(sqlSession);
		int result3 = feedDao.insertChatMember(sqlSession, fb.getBoardWriter());
		return result1 * result2 * result3;
	}
	
	@Override
	public int increaseCount(int boardNo) {
		return feedDao.increaseCount(sqlSession, boardNo);
	}

	@Override
	public String selectBoardType(int boardNo) {
		return feedDao.selectBoardType(sqlSession, boardNo);
	}
	
	@Override
	public FeedBoard selectGeneralBoard(int boardNo) {
		return feedDao.selectGeneralBoard(sqlSession, boardNo);
	}

	@Override
	public ArrayList<Attachment> selectAttachmentList(int boardNo) {
		return feedDao.selectAttachmentList(sqlSession, boardNo);
	}

	@Override
	public FeedBoard selectMeetBoard(int boardNo) {
		return feedDao.selectMeetBoard(sqlSession, boardNo);
	}
	
	@Override
	public int updateBoard(FeedBoard b) {
		return 0;
	}

	@Override
	public int deleteBoard(int boardNo) {
		return feedDao.deleteBoard(sqlSession, boardNo);
	}

	@Override
	public int insertNewAttachment(ArrayList<Attachment> atList) {
		return 0;
	}

	@Override
	public int deleteAttachment(ArrayList<Attachment> atList) {
		return 0;
	}

	@Override
	public ArrayList<Reply> selectReplyList(int boardNo) {
		return null;
	}

	@Override
	public int insertReply(Reply reply) {
		return 0;
	}

	@Override
	public int updateReply(Reply reply) {
		return 0;
	}

	@Override
	public int deleteReply(int replyNo) {
		return 0;
	}

	@Override
	public int insertLike(Likes like) {
		return feedDao.insertLike(sqlSession, like);
	}

	@Override
	public int deleteLike(Likes like) {
		return feedDao.deleteLike(sqlSession, like);
	}


}
