package com.kh.somomo.member.model.service;

import java.text.DecimalFormat;
import java.text.Format;
import java.util.HashMap;
import java.util.Random;

import org.json.simple.JSONObject;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.somomo.member.model.dao.MemberDao;
import com.kh.somomo.member.model.vo.CertVo;
import com.kh.somomo.member.model.vo.Member;

import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

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
	
	/*
	@Override
	public void certifiedPhoneNumber(String userPhoneNumber, int randomNumber) {
		String api_key = "NCSFKDN33QNJW4PJ";
	    String api_secret = "ACZFZZZAEFZN8LG6NKG9U7R3VQ9WJW3I";
	    Message coolsms = new Message(api_key, api_secret);

	    // 4 params(to, from, type, text) are mandatory. must be filled
	    HashMap<String, String> params = new HashMap<String, String>();
	    params.put("to", userPhoneNumber);    // 수신전화번호
	    params.put("from", "01058057544");  
	    params.put("type", "SMS");
	    params.put("text", "[소모모] 인증번호는" + "["+randomNumber+"]" + "입니다."); // 문자 내용 입력
	    params.put("app_version", "test app 1.2"); // application name and version

	    try {
	        JSONObject obj = (JSONObject) coolsms.send(params);
	        System.out.println(obj.toString());
	      } catch (CoolsmsException e) {
	        System.out.println(e.getMessage());
	        System.out.println(e.getCode());
	      }
	}
	*/
	@Override
	public Member selectMyPage(String userId) {
		return memberDao.selectMyPage(sqlSession, userId);
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
	
	
	
	
	
}
