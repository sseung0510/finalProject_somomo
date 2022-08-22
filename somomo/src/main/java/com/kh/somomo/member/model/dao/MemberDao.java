package com.kh.somomo.member.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.somomo.feed.model.vo.FeedBoard;
import com.kh.somomo.member.model.vo.CertVo;
import com.kh.somomo.member.model.vo.Member;

@Repository
public class MemberDao {
	
	public Member loginMember(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.selectOne("memberMapper.loginMember", m);
	}

	public int insertMember(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.insert("memberMapper.insertMember",m);
	}

	public int idCheck(SqlSessionTemplate sqlSession, String checkId) {
		return sqlSession.selectOne("memberMapper.idCheck", checkId);
	}

	public int NickNameCheck(SqlSessionTemplate sqlSession, String checkNickName) {
		return sqlSession.selectOne("memberMapper.NickNameCheck", checkNickName);
	}

	public int updateMember(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.update("memberMapper.updateMember", m);
	}

	public int deleteMember(SqlSessionTemplate sqlSession, String userId) {
		return sqlSession.update("memberMapper.deleteMember", userId);
	}

	public int oldUserPwd(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.selectOne("memberMapper.oldUserPwd", m);
	}

	public int updatePwd(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.update("memberMapper.updatePwd", m);
	}

	public void insertSecret(SqlSessionTemplate sqlSession, CertVo certVo) {
		sqlSession.insert("memberMapper.regist", certVo);
	}

	public boolean validate(SqlSessionTemplate sqlSession, CertVo certVo) {
		CertVo result = sqlSession.selectOne("memberMapper.validate", certVo);
		if(result!=null) {
			sqlSession.delete("memberMapper.remove", certVo);
		}
		return result != null;
	}

	public Member searchId(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.selectOne("memberMapper.searchId", m);
	}
	/*
	public int searchPwd(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
		return sqlSession.selectOne("memberMapper.searchPwd", map);
	}
	*/
	public int searchPwd(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.selectOne("memberMapper.searchPwd", m);
	}

	public int changeUpPwd(SqlSessionTemplate sqlSession, HashMap<String, Object> map) {
		return sqlSession.update("memberMapper.changeUpPwd", map);
	}

	public ArrayList<FeedBoard> likeList(SqlSessionTemplate sqlSession, String userId) {
		return (ArrayList)sqlSession.selectList("memberMapper.likeList", userId);
	}

	public ArrayList<FeedBoard> favoriteList(SqlSessionTemplate sqlSession, String userId) {
		return (ArrayList)sqlSession.selectList("memberMapper.favoriteList", userId);
	}

	public int deleteLikeY(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
		return sqlSession.delete("memberMapper.deleteLikeY", map);
	}
	
	// 카카오 회원 추가
	public int insertKakaoMember(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.insert("memberMapper.insertKakaoMember",m);
	}

	public int deleteKakaoUser(SqlSessionTemplate sqlSession, String userId) {
		return sqlSession.delete("memberMapper.deleteKakaoUser", userId);
	}
	
	
	
}
