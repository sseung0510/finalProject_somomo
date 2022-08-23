package com.kh.somomo.myPage.model.service;

import java.util.ArrayList;

import com.google.gson.JsonElement;
import com.kh.somomo.feed.model.vo.FeedBoard;

public interface MyPageService {
	
	
	
		// 내가 쓴 일반 글
		ArrayList<FeedBoard> feedGeneralBoardList(String userId);

		// 내가 쓴 모임모집 글
		ArrayList<FeedBoard> feedMeetBoardList(String userId);

		

		

}
