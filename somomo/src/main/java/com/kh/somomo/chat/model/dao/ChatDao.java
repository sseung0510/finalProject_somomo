package com.kh.somomo.chat.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.somomo.chat.model.vo.*;
import com.kh.somomo.feed.model.vo.FeedBoard;

@Repository
public class ChatDao {
	
	public int insertMeetBoard(SqlSessionTemplate sqlSession, FeedBoard fb) {
		return sqlSession.insert("chatMapper.insertMeetBoard", fb);
	}

	public int insertChatRoom(SqlSessionTemplate sqlSession, FeedBoard fb) {
		return sqlSession.insert("chatMapper.insertChatRoom", fb);
	}

	public int insertChatMember(SqlSessionTemplate sqlSession, String boardWriter) {
		return sqlSession.insert("chatMapper.insertChatMember", boardWriter);
	}

	public ArrayList<ChatRoom> selectAllChatRoom(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("chatMapper.selectAllChatRoom");
	}
	
	public int insertUserInChatRoom(SqlSessionTemplate sqlSession, ChatMember cm) {
		return sqlSession.insert("chatMapper.insertUserInChatRoom", cm);
	}
	
	public int checkInsertUser(SqlSessionTemplate sqlSession, ChatMember cm) {
		return sqlSession.selectOne("chatMapper.checkInsertUser", cm);
	}

	public ArrayList<ChatRoom> selectMyChatRoom(SqlSessionTemplate sqlSession, String userId) {
		return (ArrayList)sqlSession.selectList("chatMapper.selectMyChatRoom", userId);
	}

	public ArrayList<Chat> selectChatInChatRoom(SqlSessionTemplate sqlSession, ChatMember cm) {
		return (ArrayList)sqlSession.selectList("chatMapper.selectChatInChatRoom", cm);
	}
	
	public int clearChatCount(SqlSessionTemplate sqlSession, ChatMember cm) {
		return sqlSession.update("chatMapper.clearChatCount", cm);
	}

	public ArrayList<ChatMember> selectUserInChatRoom(SqlSessionTemplate sqlSession, int roomNo) {
		return (ArrayList)sqlSession.selectList("chatMapper.selectUserInChatRoom", roomNo);
	}

	public ChatRoom selectChatRoom(SqlSessionTemplate sqlSession, int roomNo) {
		return sqlSession.selectOne("chatMapper.selectChatRoom", roomNo);
	}

	public int insertChat(SqlSessionTemplate sqlSession, Chat c) {
		return sqlSession.insert("chatMapper.insertChat", c);
	}
	
	public int insertChatCount(SqlSessionTemplate sqlSession, Chat c) {
		return sqlSession.insert("chatMapper.insertChatCount", c);
	}

	public Chat selectChat(SqlSessionTemplate sqlSession, Chat c) {
		return sqlSession.selectOne("chatMapper.selectChat", c);
	}

	public int leaveChatRoom(SqlSessionTemplate sqlSession, ChatMember cm) {
		return sqlSession.delete("chatMapper.leaveChatRoom", cm);
	}
}
