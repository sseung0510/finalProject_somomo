package com.kh.somomo.feed.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.somomo.feed.model.dao.FeedDao;

@Service
public class FeedServiceImpl implements FeedService{
	
	@Autowired
	private FeedDao feedDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
}
