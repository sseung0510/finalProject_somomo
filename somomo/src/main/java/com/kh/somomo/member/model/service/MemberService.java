package com.kh.somomo.member.model.service;

import java.util.Map;

import com.kh.somomo.member.model.vo.CertVo;
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

	/*
	// sms문자인증
	void certifiedPhoneNumber(String userPhoneNumber, int randomNumber);
	*/
	
	// 해당 멤버 리스트
	Member selectMyPage(String userId);

	// 멤버업데이트
	int updateMember(Member m);

	// 회원 탈퇴
	int deleteMember(String userId);

	// 비번 변경전 조회
	int oldUserPwd(Member m);

	// 비번 변경
	int updatePwd(Member m);

	// 이메일 보내기
	String sendEmail(String ip);

	// 인증번호 확인
	boolean validate(CertVo certVo);
	
}
