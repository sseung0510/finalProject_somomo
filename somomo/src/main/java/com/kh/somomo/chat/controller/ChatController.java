package com.kh.somomo.chat.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.kh.somomo.chat.model.service.ChatService;

@Controller
public class ChatController {

	@Autowired
	private ChatService chatService;
}
