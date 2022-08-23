package com.kh.somomo.feed.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.kh.somomo.chat.model.vo.ChatMember;
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
	int selectSearchListCount(HashMap<String, Object>map);
	// 피드 게시글 목록 조회 (로그인 회원)
	//ArrayList<FeedBoard> selectFeedList(PageInfo pi, String userId);
	ArrayList<FeedBoard> selectFeedList(PageInfo pi, HashMap<String, Object> map);
	// 피드 게시글 첨부파일(사진) 목록 조회
	ArrayList<Attachment> selectFeedAttachmentList(HashMap<String, Integer> boardRange);
	
	// 지역 카테고리 목록 조회
	ArrayList<RegionCategory> selectRegionList();
	
	
	//------- 글 작성 서비스 -------//
	// 일반게시글 : 글 + 첨부파일
	int insertGeneralBoard(FeedBoard fb, ArrayList<Attachment> fatList);
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
	// 채팅 멤버 확인
	int checkChatMember(ChatMember cm);
	// 채팅 공석 확인
	boolean checkChatMemberSpace(int boardNo, int roomNo);
	// 채팅방 멤버 추가
	int insertChatMember(ChatMember cm);
	
	//------- 게시글 수정/삭제 서비스 -------//
	// 게시글 수정(일반게시글)
	int updateGeneralBoard(FeedBoard fb, ArrayList<Integer> deleteFileList, ArrayList<Attachment> newFatList);
	// 게시글 수정(모임모집글)
	int updateMeetBoard(FeedBoard fb);
	// 게시글 삭제
	int deleteBoard(int boardNo);
	// 기존 첨부파일 전체 삭제
	int deleteAllAttachment(int boardNo);

	//------- 댓글 서비스 -------//
	// 댓글 목록 조회
	ArrayList<Reply> selectReplyList(int boardNo);
	// 댓글 작성
	int insertReply(Reply reply);
	// 답글(대댓글) 작성
	int insertReReply(Reply reply);
	// 댓글 수정
	int updateReply(Reply reply);
	// 댓글 삭제
	int deleteReply(int replyNo);
	// 답글(대댓글) 존재여부 확인 => 답글 존재하는 부모 댓글인지 판별용
	boolean checkHasRereply(int replyNo);
	// 댓글 내용 삭제 (답글 존재하는 댓글일 경우)
	int deleteReplyContent(int replyNo);
	// 삭제된 댓글에 달린 답글이며, 답글이 마지막 남은 1개인 경우인지 확인
	boolean isSingleRereplyNdeleteReply(int rgroup);
	// 댓글 + 답글 삭제
	int deleteTwoReply(int rgroup);
	// 댓글 개수 확인
	int countReply(int boardNo);
	
	//------- 좋아요 서비스 -------//
	// 좋아요 등록
	int insertLike(Likes like);
	// 좋아요 삭제
	int deleteLike(Likes like);
	// 좋아요 확인
	int checkLike(Likes like);
	// 좋아요 개수 확인
	int countLike(int boardNo);
	
}
