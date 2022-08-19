package com.kh.somomo.common.template;

import com.kh.somomo.common.model.vo.PageInfo;

public class Pagination {

	// 일반 게시판 형식
	public static PageInfo getPageInfo(int listCount, int currentPage, int pageLimit, int boardLimit) {
		
		int maxPage = (int)Math.ceil((double)listCount / boardLimit);
		int startPage = (currentPage - 1) / pageLimit * pageLimit + 1;
		int endPage = startPage + pageLimit - 1;
		
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		
		return new PageInfo(listCount, currentPage, pageLimit, boardLimit, maxPage, startPage, endPage);
	}
	
	// 피드 형식
	public static PageInfo getPageInfoFeed(int listCount, int currentPage, int boardLimit) {
		
		int maxPage = (int)Math.ceil((double)listCount / boardLimit);
		
		return new PageInfo(listCount, currentPage, boardLimit, maxPage);
	}
}

