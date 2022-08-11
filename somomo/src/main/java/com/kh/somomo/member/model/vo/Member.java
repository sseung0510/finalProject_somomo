package com.kh.somomo.member.model.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Getter
@Setter
@ToString
public class Member {
	private String userId;
	private String userPwd;
	private String nickname;
	private String phone;
	private int age;
	private String email;
	private String gender;
	private String profileImg;
	private String enrollDate;
	private String kakaoLogin;
	private String status;

}
