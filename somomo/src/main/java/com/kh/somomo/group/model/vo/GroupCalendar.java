package com.kh.somomo.group.model.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Getter
@Setter
@ToString
public class GroupCalendar {

	// 테이블 : GROUP_CALENDAR (그룹방캘린더)
	private int calendarNo;
	private int groupNo;
	private String writer;
	private String title;
	private String memo;
	private String startDate;
	private String endDate;
}
