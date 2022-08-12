package com.kh.somomo.group.model.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Getter
@Setter
@ToString
public class GroupCategory {

	// 테이블 : GROUP_CATEGORY (그룹방카테고리)
	private int categoryNo;
	private String categoryName;
	
}
