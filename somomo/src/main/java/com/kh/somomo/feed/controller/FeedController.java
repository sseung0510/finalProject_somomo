package com.kh.somomo.feed.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.kh.somomo.feed.model.service.FeedService;

@Controller
public class FeedController {
	
	@Autowired
	private FeedService feedService;
}
