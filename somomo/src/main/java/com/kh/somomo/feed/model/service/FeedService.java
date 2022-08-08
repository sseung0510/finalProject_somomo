package com.kh.somomo.feed.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.kh.somomo.common.model.vo.Attachment;
import com.kh.somomo.common.model.vo.Likes;
import com.kh.somomo.common.model.vo.PageInfo;
import com.kh.somomo.common.model.vo.RegionCategory;
import com.kh.somomo.common.model.vo.Reply;
import com.kh.somomo.feed.model.vo.FeedBoard;

public interface FeedService {

	//------- 피드 리스트 조회 + 페이징처리 -------//
	// 피드 게시글 전체 개수 조회
	int selectFeedListCount();
	// 피드 게시글 목록 조회
	//ArrayList<FeedBoard> selectFeedList(PageInfo pi);
	// 피드 게시글 목록 조회 (로그인 회원)
	ArrayList<FeedBoard> selectFeedList(PageInfo pi, String userId);
	// 피드 게시글 첨부파일(사진) 목록 조회
	ArrayList<Attachment> selectFeedAttachmentList(HashMap<String, Integer> boardRange);
	
	// 지역 카테고리 목록 조회
	ArrayList<RegionCategory> selectRegionList();
	
	
	//------- 글 작성 서비스 -------//
	// 일반게시글 : 글 + 첨부파일
	int insertGeneralBoard(FeedBoard fb, ArrayList<Attachment> atList);
	// 모임모집글 : 글 + 채팅방 생성 및 채팅멤버 등록
	int insertMeetBoard(FeedBoard fb);
	
	//------- 게시글 상세 조회 서비스 -------//
	// 게시글 조회수 증가
	int increaseCount(int boardNo);
	// 게시글 타입 조회 (일반 / 모임모집)
	String selectBoardType(int boardNo);
	// 일반게시글 조회
	FeedBoard selectGeneralBoard(int boardNo);
	// 게시글 첨부파일 목록 조회
	ArrayList<Attachment> selectAttachmentList(int boardNo);
	// 모임모집글 조회
	FeedBoard selectMeetBoard(int boardNo);
	
	//------- 게시글 수정/삭제 서비스 -------//
	// 게시글 내용 수정
	int updateBoard(FeedBoard fb);
	// 새 첨부파일 추가
	int insertNewAttachment(ArrayList<Attachment> atList);
	// 기존 첨부파일 삭제
	int deleteAttachment(ArrayList<Attachment> atList);
	// 게시글 삭제
	int deleteBoard(int boardNo);

	//------- 댓글 서비스 -------//
	// 댓글 목록 조회
	ArrayList<Reply> selectReplyList(int boardNo);
	// 댓글 작성
	int insertReply(Reply reply);
	// 댓글 수정
	int updateReply(Reply reply);
	// 댓글 삭제
	int deleteReply(int replyNo);
	
	//------- 좋아요 서비스 -------//
	// 좋아요 등록
	int insertLike(Likes like);
	// 좋아요 삭제
	int deleteLike(Likes like);
	
}
