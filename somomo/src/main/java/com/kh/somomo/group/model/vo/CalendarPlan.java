package com.kh.somomo.group.model.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Getter
@Setter
@ToString
public class CalendarPlan {

	private int planNo;
	private int calendarNo;
	private String writer;
	private String title;
	private String memo;
	private String startDate;
	private String endDate;
	private String color;
	private String textColor;
	private boolean allDay;
}
