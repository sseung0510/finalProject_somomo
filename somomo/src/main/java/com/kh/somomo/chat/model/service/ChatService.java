package com.kh.somomo.chat.model.service;

import java.util.ArrayList;

import com.kh.somomo.chat.model.vo.*;
import com.kh.somomo.feed.model.vo.FeedBoard;

public interface ChatService {

	int insertChatRoom(FeedBoard fb);

	ArrayList<ChatRoom> selectAllChatRoom();

	ArrayList<ChatRoom> selectMyChatRoom(String userId);

	int checkInsertUser(ChatMember cm);

	int insertUserInChatRoom(ChatMember cm);
}
