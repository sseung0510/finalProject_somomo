package com.kh.somomo.myPage.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.google.gson.Gson;
import com.kh.somomo.myPage.model.service.MyPageService;


@Controller
public class MyPageController {

	@Autowired
	private MyPageService myPageService;
	
	
	

	// 내가 작성한 일반 글 불러오기
	@ResponseBody
	@RequestMapping(value="feedGeneralBoardList.me", produces="application/json; charset=UTF-8")
	public String feedGeneralBoardList(String userId) {
	
		return new Gson().toJson(myPageService.feedGeneralBoardList(userId));
	}
	
	
	
	// 내가 작성한 모임모집글 불러오기
	@ResponseBody
	@RequestMapping(value="feedMeetBoardList.me", produces="application/json; charset=UTF-8")
	public String feedMeetBoardList(String userId) {
		
		return new Gson().toJson(myPageService.feedMeetBoardList(userId));
	}
	
	
	
	
	
}
