package com.kh.somomo.member.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.kh.somomo.feed.model.vo.FeedBoard;
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

	// 아이디찾기
	Member searchId(Member m);

	// 비밀번호 찾기
	int searchPwd(Member m);

	// 임시비밀번호 업데이트
	int changeUpPwd(HashMap<String, Object> map);

	// 내가누른 좋아요
	ArrayList<FeedBoard> likeList(String userId);

	// 내가누른 즐겨찾기
	ArrayList<FeedBoard> favoriteList(String userId);

	// 좋아요 취소
	int deleteLikeY(HashMap<String, String> map);
	
	// 카카오 회원 추가
	int insertKakaoMember(Member m);

	// 카카오 회원 탈퇴
	int deleteKakaoUser(String userId);

}
