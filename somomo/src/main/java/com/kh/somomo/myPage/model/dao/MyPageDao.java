package com.kh.somomo.myPage.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.somomo.feed.model.vo.FeedBoard;


@Repository
public class MyPageDao {

	public ArrayList<FeedBoard> feedGeneralBoardList(SqlSessionTemplate sqlSession, String userId) {
		
		return (ArrayList)sqlSession.selectList("memberMapper.feedGeneralBoardList", userId);
	}

	public ArrayList<FeedBoard> feedMeetBoardList(SqlSessionTemplate sqlSession, String userId) {
		
		return (ArrayList)sqlSession.selectList("memberMapper.feedMeetBoardList", userId);
	}

}
