package com.kh.somomo.group.model.vo;

import lombok.ToString;
import lombok.Setter;
import lombok.Getter;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Getter
@Setter
@ToString
public class GroupAttachment {
	
	// 테이블 : GROUP_ATTACHEMENT (그룹방첨부파일)
	private int fileNo;
	private int boardNo;
	private String originName;
	private String changeName;
	
}
