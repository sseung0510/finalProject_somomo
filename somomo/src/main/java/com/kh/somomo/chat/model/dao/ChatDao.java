package com.kh.somomo.chat.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.somomo.chat.model.vo.ChatMember;
import com.kh.somomo.chat.model.vo.ChatRoom;
import com.kh.somomo.feed.model.vo.FeedBoard;

@Repository
public class ChatDao {
	
	public int insertMeetBoard(SqlSessionTemplate sqlSession, FeedBoard fb) {
		return sqlSession.insert("chatMapper.insertMeetBoard", fb);
	}

	public int insertChatRoom(SqlSessionTemplate sqlSession, String roomName) {
		return sqlSession.insert("chatMapper.insertChatRoom", roomName);
	}

	public int insertChatMember(SqlSessionTemplate sqlSession, String boardWriter) {
		return sqlSession.insert("chatMapper.insertChatMember", boardWriter);
	}

	public ArrayList<ChatRoom> selectAllChatRoom(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("chatMapper.selectAllChatRoom");
	}

	public ArrayList<ChatRoom> selectMyChatRoom(SqlSessionTemplate sqlSession, String userId) {
		return (ArrayList)sqlSession.selectList("chatMapper.selectMyChatRoom", userId);
	}

	public int checkInsertUser(SqlSessionTemplate sqlSession, ChatMember cm) {
		return sqlSession.selectOne("chatMapper.checkInsertUser", cm);
	}

	public int insertUserInChatRoom(SqlSessionTemplate sqlSession, ChatMember cm) {
		return sqlSession.insert("chatMapper.insertUserInChatRoom", cm);
	}
}
