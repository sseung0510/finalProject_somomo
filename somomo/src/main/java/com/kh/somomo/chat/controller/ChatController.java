package com.kh.somomo.chat.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.kh.somomo.chat.model.service.ChatService;
import com.kh.somomo.chat.model.vo.*;
import com.kh.somomo.common.template.Time;
import com.kh.somomo.feed.model.vo.FeedBoard;
import com.kh.somomo.member.model.vo.Member;

@Controller
public class ChatController {

	@Autowired
	private ChatService chatService;
	
	// 채팅방 생성 (테스트용)
	@ResponseBody
	@RequestMapping("insertChatRoom.ch")
	public String ajaxInsertChatRoom(String roomName, String userId, String profileImg) {
		
		FeedBoard fb = new FeedBoard();
		
		fb.setBoardTitle(roomName);
		fb.setBoardWriter(userId);
		fb.setProfileImg(profileImg);
		
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
		
		if (chatService.checkInsertUser(cm) > 0) {
			return "fail";
		} else {
			return chatService.insertUserInChatRoom(cm) > 0 ? "success" : "fail";
		}
	}
	
	// 채팅 페이지 메인
	@RequestMapping("chat.ch")
	public String selectMyChatRoom(HttpSession session, Model model) throws ParseException {
		
		String userId = ((Member)session.getAttribute("loginUser")).getUserId();
		
		// 채팅방 조회
		ArrayList<ChatRoom> myChatRoomList =  chatService.selectMyChatRoom(userId);
		
		for(ChatRoom cr : myChatRoomList) {
			if (cr.getChatDate() != null) {
				
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				
				Date chatDate = sdf.parse(cr.getChatDate());
				Date insertDate = sdf.parse(cr.getInsertDate());
				
				// 사용자가 채팅방에 입장한 일시보다 해당 채팅방의 마지막 메시지가 온 일시가
				int result = chatDate.compareTo(insertDate);
				
				if (result < 0) { // 이전이라면 해당 채팅방의 채팅목록에서 마지막 메시지와 메시지가 온 시간을 보여주지 않음
					cr.setChatContent(null);
					cr.setChatDate(null);
				}
				if (cr.getChatDate() != null) {
					cr.setChatDate(Time.getDiffTime(cr.getChatDate()));
				}
			}
			if (cr.getRoomThumbnail() == null) {
				cr.setRoomThumbnail("resources/img/web_logo.jpg");
			}
		}
		
		model.addAttribute("myChatRoomList", myChatRoomList);
		
		return "chat/chatMain";
	}
	
	// 채팅방 채팅 내용 조회
	@ResponseBody
	@RequestMapping(value = "selectChatInChatRoom.ch", produces = "application/json; charset=UTF-8")
	public String ajaxSelectChatInChatRoom(int roomNo, String userId) {
		
		ChatMember cm = new ChatMember();
		
		cm.setRoomNo(roomNo);
		cm.setUserId(userId);
		
		return new Gson().toJson(chatService.selectChatInChatRoom(cm));
	}
	
	// 채팅방 유저 목록 조회
	@ResponseBody
	@RequestMapping(value = "selectUserInChatRoom.ch", produces = "application/json; charset=UTF-8")
	public String ajaxSelectUserInChatRoom(int roomNo) {
		return new Gson().toJson(chatService.selectUserInChatRoom(roomNo));
	}
	
	// 채팅방 나가기
	@ResponseBody
	@RequestMapping("leaveChatRoom.ch")
	public String ajaxLeaveChatRoom(int roomNo, String userId) {
		
		ChatMember cm = new ChatMember();
		
		cm.setRoomNo(roomNo);
		cm.setUserId(userId);
		
		return chatService.leaveChatRoom(cm) > 0 ? "success" : "fail";
	}
	
	// 채팅방 조회 Ajax
	@ResponseBody
	@RequestMapping(value = "selectMyChatRoom.ch", produces = "application/json; charset=UTF-8")
	public String ajaxSelectMyChatRoom(String userId) throws ParseException {
		
		ArrayList<ChatRoom> myChatRoomList =  chatService.selectMyChatRoom(userId);
		
		for(ChatRoom cr : myChatRoomList) {
			if (cr.getChatDate() != null) {
				
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				
				Date chatDate = sdf.parse(cr.getChatDate());
				Date insertDate = sdf.parse(cr.getInsertDate());
				
				// 사용자가 채팅방에 입장한 일시보다 해당 채팅방의 마지막 메시지가 온 일시가
				int result = chatDate.compareTo(insertDate);
				
				if (result < 0) { // 이전이라면 해당 채팅방의 채팅목록에서 마지막 메시지와 메시지가 온 시간을 보여주지 않음
					cr.setChatContent(null);
					cr.setChatDate(null);
				}
				if (cr.getChatDate() != null) {
					cr.setChatDate(Time.getDiffTime(cr.getChatDate()));
				}
			}
			if (cr.getRoomThumbnail() == null) {
				cr.setRoomThumbnail("resources/img/web_logo.jpg");
			}
		}
		
		return new Gson().toJson(myChatRoomList);
	}
}
