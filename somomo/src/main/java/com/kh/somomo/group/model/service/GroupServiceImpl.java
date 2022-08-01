package com.kh.somomo.group.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.somomo.group.model.dao.GroupDao;

@Service
public class GroupServiceImpl implements GroupService{

	@Autowired
	private GroupDao groupDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
}
