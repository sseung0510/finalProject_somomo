package com.kh.somomo.member.model.service;

import java.text.DecimalFormat;
import java.text.Format;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Random;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.somomo.feed.model.vo.FeedBoard;
import com.kh.somomo.member.model.dao.MemberDao;
import com.kh.somomo.member.model.vo.CertVo;
import com.kh.somomo.member.model.vo.Member;

@Service
public class MemberServiceImpl implements MemberService{

	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public Member loginMember(Member m) {
		return memberDao.loginMember(sqlSession, m);
	}

	@Override
	public int insertMember(Member m) {
		return memberDao.insertMember(sqlSession, m);
	}

	@Override
	public int idCheck(String checkId) {
		return memberDao.idCheck(sqlSession, checkId);
	}

	@Override
	public int NickNameCheck(String checkNickName) {
		return memberDao.NickNameCheck(sqlSession, checkNickName);
	}
	
	@Override
	public int updateMember(Member m) {
		return memberDao.updateMember(sqlSession, m);
	}

	@Override
	public int deleteMember(String userId) {
		return memberDao.deleteMember(sqlSession, userId);
	}

	
	@Override
	public int oldUserPwd(Member m) {
		return memberDao.oldUserPwd(sqlSession, m);
	}

	@Override
	public int updatePwd(Member m) {
		return memberDao.updatePwd(sqlSession, m);
	}

	@Override
	public String sendEmail(String ip) {
		String secret = this.generateSecret();
		
		CertVo certVo = CertVo.builder()
						.who(ip)
						.secret(secret)
						.build();
		
		memberDao.insertSecret(sqlSession, certVo);
		
		return secret;
	}
	
	public String generateSecret() {
		Random d = new Random();
		int n = d.nextInt(100000);
		Format f = new DecimalFormat("000000");
		String secret = f.format(n);
		
		return secret;
	}

	@Override
	public boolean validate(CertVo certVo) {
		return memberDao.validate(sqlSession, certVo);
	}

	@Override
	public Member searchId(Member m) {
		return memberDao.searchId(sqlSession, m);
	}
	/*
	@Override
	public int searchPwd(HashMap<String, String> map) {
		return memberDao.searchPwd(sqlSession, map);
	}
	*/
	@Override
	public int searchPwd(Member m) {
		return memberDao.searchPwd(sqlSession, m);
	}

	@Override
	public int changeUpPwd(HashMap<String, Object> map) {
		return memberDao.changeUpPwd(sqlSession, map);
	}

	@Override
	public ArrayList<FeedBoard> likeList(String userId) {
		return memberDao.likeList(sqlSession, userId);
	}

	@Override
	public ArrayList<FeedBoard> favoriteList(String userId) {
		return memberDao.favoriteList(sqlSession, userId);
	}

	@Override
	public int deleteLikeY(HashMap<String, String> map) {
		return memberDao.deleteLikeY(sqlSession, map);
	}
	
	// 카카오 회원 추가
	@Override
	public int insertKakaoMember(Member m) {
		return memberDao.insertKakaoMember(sqlSession, m);
	}

	@Override
	public int deleteKakaoUser(String userId) {
		return memberDao.deleteKakaoUser(sqlSession, userId);
	}

	
	
}
