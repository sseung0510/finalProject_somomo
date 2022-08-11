package com.kh.somomo.member.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder	
public class CertVo {

	private String who;
	private String secret;
	private String when;
	
}
