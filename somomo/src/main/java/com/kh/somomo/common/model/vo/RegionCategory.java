package com.kh.somomo.common.model.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Getter
@Setter
@ToString
public class RegionCategory {

	// 테이블 : LOCAL_CATEGORY (지역카테고리)
	private int regionNo;
	private String regionName;
	
}
