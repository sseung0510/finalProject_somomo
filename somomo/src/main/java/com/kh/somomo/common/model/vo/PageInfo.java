package com.kh.somomo.common.model.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class PageInfo {
	
	private int listCount; // 게시글 총 개수
	private int currentPage; // 현재 페이지
	private int pageLimit; // 페이지 하단에 보여질 페이징바의 최대 개수
	private int boardLimit; // 한 페이지에 보여질 게시글 최대 개수
	
	private int maxPage; // 가장 마지막 페이지 (총 페이지의 개수)
	private int startPage; // 페이지 하단에 보여질 페이징바의 시작 수
	private int endPage; // 페이지 하단에 보여질 페이징바의 끝 수
		
}
