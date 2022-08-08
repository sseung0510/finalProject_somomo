package com.kh.somomo.common.model.vo;

import lombok.Getter;

import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Getter
@Setter
@ToString
public class Attachment {

	// 테이블 : FEED_ATTACHMENT, GROUP_ATTACHMENT (피드,그룹 첨부파일)
	private int fileNo;
	private int boardNo;
	private String originName;
	private String changeName;
}
