package com.kh.somomo.feed.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.somomo.chat.model.vo.ChatMember;
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

	//------- 피드 리스트 조회 + 페이징처리 -------//
	@Override
	public int selectFeedListCount() {
		return feedDao.selectFeedListCount(sqlSession);
	}

	@Override
	public int selectSearchListCount(HashMap<String, Object> map) {
		return feedDao.selectSearchListCount(sqlSession, map);
	}
	
	@Override
	public ArrayList<FeedBoard> selectFeedList(PageInfo pi, HashMap<String, Object> map) {
		return feedDao.selectFeedList(sqlSession, pi, map);
	}
	
	@Override
	public ArrayList<Attachment> selectFeedAttachmentList(HashMap<String, Integer> boardRange) {
		return feedDao.selectFeedAttachmentList(sqlSession, boardRange);
	}
	
	@Override
	public ArrayList<RegionCategory> selectRegionList() {
		return feedDao.selectRegionList(sqlSession);
	}

	//------- 글 작성 서비스 -------//
	@Override
	@Transactional
	public int insertGeneralBoard(FeedBoard fb, ArrayList<Attachment> fatList) {
		
		int result1 = feedDao.insertGeneralBoard(sqlSession, fb);
		int result2 = 1;
		if(!fatList.isEmpty()) {
			for(Attachment at : fatList) {
				result2 *= feedDao.insertAttachment(sqlSession, at);
			}
		}
		
		return result1 * result2;
	}
	
	@Override
	@Transactional
	public int insertMeetBoard(FeedBoard fb) {
		
		int result1 = feedDao.insertMeetBoard(sqlSession, fb); // 모임모집글 추가
		int result2 = feedDao.insertChatRoom(sqlSession, fb.getBoardTitle()); // 채팅방 생성
		int result3 = feedDao.insertChatAdmin(sqlSession, fb.getBoardWriter()); // 채팅방 관리자 생성

		return result1 * result2 * result3;
	}
	
	//------- 게시글 상세 조회 서비스 -------//
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
	public int checkChatMember(ChatMember cm) {
		return feedDao.checkChatMember(sqlSession, cm);
	}
	
	@Override
	public boolean checkChatMemberSpace(int boardNo, int roomNo) {

		int meetTotal = feedDao.selectMeetTotal(sqlSession, boardNo);
		int countMember = feedDao.selectCountMember(sqlSession, roomNo);
		
		if(countMember < meetTotal) return true;
		else return false;
	}
	
	@Override
	public int insertChatMember(ChatMember cm) {
		return feedDao.insertChatMember(sqlSession, cm);
	}
	
	//------- 게시글 수정/삭제 서비스 -------//
	@Override
	@Transactional
	public int updateGeneralBoard(FeedBoard fb, ArrayList<Integer> deleteFileList, ArrayList<Attachment> newFatList) {
		
		int result1 = feedDao.updateGeneralBoard(sqlSession, fb); // 게시글 내용 수정
		
		int result2 = 1;
		if(!deleteFileList.isEmpty()) {
			for(int fileNo : deleteFileList) {
				result2 *= feedDao.deleteAttachment(sqlSession, fileNo); // 기존 파일 삭제
			}
		} 
		
		int result3 = 1;
		if(!newFatList.isEmpty()) {
			for(Attachment at : newFatList) {
				if(at.getFileNo() > 0) { // 파일번호가 존재한다면 해당 파일번호에 새 첨부파일 update
					result3 *= feedDao.updateAttachment(sqlSession, at);
				} else {
					result3 *= feedDao.insertNewAttachment(sqlSession, at); // 새 첨부파일 추가
				}
			}
		}
		
		return result1 * result2 * result3;
	}

	@Override
	public int updateMeetBoard(FeedBoard fb) {
		return feedDao.updateMeetBoard(sqlSession, fb);
	}
	
	@Override
	public int deleteBoard(int boardNo) {
		return feedDao.deleteBoard(sqlSession, boardNo);
	}
	
	@Override
	public int deleteAllAttachment(int boardNo) {
		return feedDao.deleteAllAttachment(sqlSession, boardNo);
	}

	//------- 댓글 서비스 -------//
	@Override
	public ArrayList<Reply> selectReplyList(int boardNo) {
		return feedDao.selectReplyList(sqlSession, boardNo);
	}

	@Override
	public int insertReply(Reply reply) {
		return feedDao.insertReply(sqlSession, reply);
	}

	@Override
	public int insertReReply(Reply reply) {
		return feedDao.insertReReply(sqlSession, reply);
	}
	
	@Override
	public int updateReply(Reply reply) {
		return feedDao.updateReply(sqlSession, reply);
	}

	@Override
	public int deleteReply(int replyNo) {
		return feedDao.deleteReply(sqlSession, replyNo);
	}
	
	@Override
	public boolean checkHasRereply(int replyNo) {
		return feedDao.countRereply(sqlSession, replyNo) > 0 ? true : false;
	}
	
	@Override
	public int deleteReplyContent(int replyNo) {
		return feedDao.deleteReplyContent(sqlSession, replyNo);
	}
	
	@Override
	public boolean isSingleRereplyNdeleteReply(int rgroup) {

		boolean flag = false;
		// 그룹번호로 댓글+답글 개수 체크
		int countReply = feedDao.countReplyNrereply(sqlSession, rgroup);
		if(countReply == 2) { // 댓글 1개 + 답글 1개일 경우
			// 댓글 내용이 삭제되어있을 경우 => true
			flag = feedDao.checkDeletedReply(sqlSession, rgroup) > 0 ? true : false;
		}
		
		return flag;
	}
	
	@Override
	public int deleteTwoReply(int rgroup) {
		return feedDao.deleteTwoReply(sqlSession, rgroup);
	}

	@Override
	public int countReply(int boardNo) {
		return feedDao.countReply(sqlSession, boardNo);
	}
	
	//------- 좋아요 서비스 -------//
	@Override
	public int insertLike(Likes like) {
		return feedDao.insertLike(sqlSession, like);
	}

	@Override
	public int deleteLike(Likes like) {
		return feedDao.deleteLike(sqlSession, like);
	}

	@Override
	public int checkLike(Likes like) {
		return feedDao.checkLike(sqlSession, like);
	}

	@Override
	public int countLike(int boardNo) {
		return feedDao.countLike(sqlSession, boardNo);
	}


}
