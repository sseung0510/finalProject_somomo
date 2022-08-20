package com.kh.somomo.common.model.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;
import lombok.Setter;

@NoArgsConstructor
@Getter
@Setter
@ToString
public class Reply {
	
	// 테이블 : FEED_REPLY, GROUP_REPLY (피드, 그룹 게시글 댓글)
	private int replyNo;
	private int boardNo;
	private String replyWriter;
	private String replyContent;
	private int rgroup; // 이부분 rGroup 으로 하면 롬복 사용시 에러 발생할 수 있어 필드명 살짝 수정합니다.
	private int rdepth; // 이부분 rGroup 으로 하면 롬복 사용시 에러 발생할 수 있어 필드명 살짝 수정합니다.
	private String replyDate;
	private String status;
	
	private String isLastRgroupReply; // 댓글 그룹 별 마지막 댓글 번호 판별
	private String isDeletedContent; // 답글 존재하는 댓글이 삭제됐을 경우를 판별
	
	// MEMBER테이블과 JOIN해서 받아온 값
	private String nickname; // 작성자 닉네임
	private String profileImg; // 작성자 프로필사진
}
