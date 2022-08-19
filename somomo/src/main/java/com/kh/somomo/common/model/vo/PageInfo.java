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
	
	// 피드형식(무한스크롤)으로 보여줄 땐 listCount, currentPage, boardLimit, maxPage 4개만 사용
	// pageLimit, startPage, endPage : 일반 게시판 형태 만들 때 사용
	
	private int listCount; // 게시글 총 개수
	private int currentPage; // 현재 페이지
	private int pageLimit; // 페이지 하단에 보여질 페이징바의 최대 개수
	private int boardLimit; // 한 페이지에 보여질 게시글 최대 개수
	
	private int maxPage; // 가장 마지막 페이지 (총 페이지의 개수)
	private int startPage; // 페이지 하단에 보여질 페이징바의 시작 수
	private int endPage; // 페이지 하단에 보여질 페이징바의 끝 수
	
	// 피드형식(무한스크롤) 만들 때 사용
	public PageInfo(int listCount, int currentPage, int boardLimit, int maxPage) {
		super();
		this.listCount = listCount;
		this.currentPage = currentPage;
		this.boardLimit = boardLimit;
		this.maxPage = maxPage;
	}
		
}
