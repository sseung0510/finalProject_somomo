package com.kh.somomo.chat.model.service;

import java.util.ArrayList;

import com.kh.somomo.chat.model.vo.*;
import com.kh.somomo.feed.model.vo.FeedBoard;

public interface ChatService {

	int insertChatRoom(FeedBoard fb);

	ArrayList<ChatRoom> selectAllChatRoom();

	int insertUserInChatRoom(ChatMember cm);
	
	int checkInsertUser(ChatMember cm);
	
	ArrayList<ChatRoom> selectMyChatRoom(String userId);

	ArrayList<Chat> selectChatInChatRoom(ChatMember cm);

	ArrayList<ChatMember> selectUserInChatRoom(int roomNo);

	ChatRoom selectChatRoom(int roomNo);

	int insertChat(Chat c);

	Chat selectChat(Chat c);

	int leaveChatRoom(ChatMember cm);
}
