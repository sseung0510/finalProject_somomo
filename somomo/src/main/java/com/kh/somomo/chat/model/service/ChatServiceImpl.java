package com.kh.somomo.chat.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.somomo.chat.model.dao.ChatDao;

@Service
public class ChatServiceImpl implements ChatService{

	@Autowired
	private ChatDao chatDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
}
