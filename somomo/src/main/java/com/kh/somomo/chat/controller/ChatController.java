package com.kh.somomo.chat.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.kh.somomo.chat.model.service.ChatService;
import com.kh.somomo.chat.model.vo.*;
import com.kh.somomo.feed.model.vo.FeedBoard;
import com.kh.somomo.member.model.vo.Member;

@Controller
public class ChatController {

	@Autowired
	private ChatService chatService;
	
	// 채팅방 생성 (테스트용)
	@ResponseBody
	@RequestMapping("insertChatRoom.ch")
	public String ajaxInsertChatRoom(String roomName, String userId) {
		
		FeedBoard fb = new FeedBoard();
		
		fb.setBoardTitle(roomName);
		fb.setBoardWriter(userId);
		
		return chatService.insertChatRoom(fb) > 0 ? "success" : "fail";
	}
	
	// 전체 채팅방 조회 (테스트용)
	@ResponseBody
	@RequestMapping(value = "selectAllChatRoom.ch", produces = "application/json; charset=UTF-8")
	public String ajaxSelectAllChatRoom() {
		return new Gson().toJson(chatService.selectAllChatRoom());
	}
	
	// 채팅방 참가 (테스트용)
	@ResponseBody
	@RequestMapping("insertUserInChatRoom.ch")
	public String ajaxInsertUserInChatRoom(int roomNo, String userId) {
		
		ChatMember cm = new ChatMember();
		
		cm.setRoomNo(roomNo);
		cm.setUserId(userId);
		
		int result = chatService.checkInsertUser(cm);
		System.out.println(result);
		if (result > 0) {
			return "fail";
		} else {
			return chatService.insertUserInChatRoom(cm) > 0 ? "success" : "fail";
		}
	}
	
	// 채팅 페이지 메인
	@RequestMapping("chat.ch")
	public String selectMyChatRoom(HttpSession session, Model model) {
		
		String userId = ((Member)session.getAttribute("loginUser")).getUserId();
		
		model.addAttribute("myChatRoomList", chatService.selectMyChatRoom(userId));
		
		return "chat/chatMain";
	}
}
