package com.kh.somomo.member.model.dao;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

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

	public Member selectMyPage(SqlSessionTemplate sqlSession, String userId) {
		return sqlSession.selectOne("memberMapper.selectMyPage", userId);
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
	
	
	
	
	
	
	
	
	
}
