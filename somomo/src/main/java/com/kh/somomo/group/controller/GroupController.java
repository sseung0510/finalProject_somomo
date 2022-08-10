package com.kh.somomo.group.controller;


import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.somomo.group.model.service.GroupService;
import com.kh.somomo.group.model.vo.GroupMember;
import com.kh.somomo.group.model.vo.GroupRoom;
import com.kh.somomo.member.model.vo.Member;

import static com.kh.somomo.common.template.FileRename.*;


@Controller
public class GroupController {
	
	@Autowired
	private GroupService groupService;
	
	// 그룹방 목록 조회후 포워딩
	// 1) 전체 그룹방 리스트(페이징 아직 X, or 똑같이 무한스크롤??), 2) 관리/가입한그룹방 리스트
	@RequestMapping("list.gr")
	public ModelAndView selectList(ModelAndView mv, HttpSession session) {
		
		String userId = ((Member)session.getAttribute("loginUser")).getUserId();
		
		mv.addObject("list", groupService.selectList())				  // 전체 그룹방 목록
		  .addObject("myGroupList", groupService.myGroupList(userId)) // 내가 가입/관리하고있는 그룹방 목록 
		  .setViewName("group/community");
		
		return mv;
	}
	
	// 그룹방 개설 페이지로 요청 처리
	@RequestMapping("insertForm.gr")
	public String insertForm() {
		return "group/createGroup";
	}
	
	/**
	 * 그룹방 개설 처리
	 * - 사용자정의 그룹이미지(upfile)가 없을경우 서버에 저장되어있는 기본 이미지중 하나가 자동 선택되고 gr.groupImg에 담겨 넘어옴
	 * - 3개의 insert문 실행 : GROUP_ROOM, GROUP_MEMBER, GROUP_CALENDAR
	 * - 성공적으로 그룹방 개설이 되면 상세페이지로 이동함
	 */
	@RequestMapping("insert.gr")
	public String insertGroup(GroupRoom gr, GroupMember gm, MultipartFile upfile, Model model, HttpSession session){
		
		// 사용자가 자기 사진을 추가
		// 기존의 profileImg에 등록된 사진을 변경해준다. 
		// => 사용자가 그룹방 메인 사진을 따로 추가 하지 않을 경우, 서버에서 임의로 제공하는 사진의 경로가 gr.groupImg에 들어가 있음
		if(!upfile.getOriginalFilename().equals("")) {
			HashMap<String, String> map = saveFile(upfile, session, "img/group/userGroupImg");
			
			gr.setGroupImg(map.get("changeName"));	
		}
		
		int result = groupService.insertGroup(gr);   // GROUP_ROOM
		int result2 = groupService.insertMember(gm); // GROUP_MEMBEr
		int result3 = groupService.insertCalendar(); // GROUP_CALENDAR
		
		int groupNo = groupService.getGroupNo();     // 상세페이지로 이동하기위해 식별값인 groupNo를 조회해서 가져옴
		
		if(result*result2*result3 > 0) {
			return "redirect:groupDetail.gr?groupNo=" + groupNo; // 쿼리스트링으로 전달
		}else { 
			model.addAttribute("errorMsg","그룹방 추가 실패");
			return "common/errorPage";
		}
	}
	
	// 그룹방 상세 보기
	@RequestMapping("groupDetail.gr")
	public ModelAndView groupDetail(int groupNo, ModelAndView mv) {
		
		GroupRoom gr = groupService.selectGroup(groupNo); 	     // 특정 그룹방에대한 정보를 담음
		ArrayList<GroupMember> mList = groupService.selectMemberList(groupNo); // 가입된 회원리스트
		
		if (gr != null) {
			mv.addObject("gr", gr).addObject("mList", mList).setViewName("group/groupDetail");
		} else {
			mv.addObject("errorMsg", "그딴 그룹방은 없는디요??").setViewName("common/errorPage");
		}
		return mv;
	}
	
	@RequestMapping("setting.gr")
	public String setting(int groupNo, Model model) {
		
		model.addAttribute("gr", groupService.selectGroup(groupNo));
		
		return "group/groupSetting";
	}
}


