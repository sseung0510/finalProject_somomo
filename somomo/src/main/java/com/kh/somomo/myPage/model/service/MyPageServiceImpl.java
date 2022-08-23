package com.kh.somomo.myPage.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.somomo.feed.model.vo.FeedBoard;
import com.kh.somomo.myPage.model.dao.MyPageDao;

@Service
public class MyPageServiceImpl implements MyPageService {


	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private MyPageDao myPageDao;
	
	
	@Override
	public ArrayList<FeedBoard> feedGeneralBoardList(String userId) {
		return myPageDao.feedGeneralBoardList(sqlSession, userId);
	}

	@Override
	public ArrayList<FeedBoard> feedMeetBoardList(String userId) {

		return myPageDao.feedMeetBoardList(sqlSession, userId);
	}
	
	

}
