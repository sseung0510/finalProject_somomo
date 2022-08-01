package com.kh.somomo.group.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.kh.somomo.group.model.service.GroupService;

@Controller
public class GroupController {
	
	@Autowired
	private GroupService groupService;
}
