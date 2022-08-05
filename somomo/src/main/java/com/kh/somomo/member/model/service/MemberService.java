package com.kh.somomo.member.model.service;

import com.kh.somomo.member.model.vo.Member;

public interface MemberService {
	
	// 로그인
	Member loginMember(Member m);
	
	// 회원가입
	int insertMember(Member m);
	
	// 아이디중복체크
	int idCheck(String checkId);
	
	// 닉네임 중복체크
	int NickNameCheck(String checkNickName);

	// sms문자인증ㄴ
	void certifiedPhoneNumber(String userPhoneNumber, int randomNumber);
	
}
