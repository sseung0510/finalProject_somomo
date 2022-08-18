package com.kh.somomo.chat.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.somomo.chat.model.dao.ChatDao;
import com.kh.somomo.chat.model.vo.ChatMember;
import com.kh.somomo.chat.model.vo.ChatRoom;
import com.kh.somomo.feed.model.vo.FeedBoard;

@Service
public class ChatServiceImpl implements ChatService{

	@Autowired
	private ChatDao chatDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	@Transactional
	public int insertChatRoom(FeedBoard fb) {
		
		int result1 = chatDao.insertMeetBoard(sqlSession, fb);
		int result2 = chatDao.insertChatRoom(sqlSession, fb.getBoardTitle());
		int result3 = chatDao.insertChatMember(sqlSession, fb.getBoardWriter());
		
		return result1 * result2 * result3;
	}

	@Override
	public ArrayList<ChatRoom> selectAllChatRoom() {
		return chatDao.selectAllChatRoom(sqlSession);
	}

	@Override
	public ArrayList<ChatRoom> selectMyChatRoom(String userId) {
		return chatDao.selectMyChatRoom(sqlSession, userId);
	}

	@Override
	public int checkInsertUser(ChatMember cm) {
		return chatDao.checkInsertUser(sqlSession, cm);
	}

	@Override
	public int insertUserInChatRoom(ChatMember cm) {
		return chatDao.insertUserInChatRoom(sqlSession, cm);
	}
}
