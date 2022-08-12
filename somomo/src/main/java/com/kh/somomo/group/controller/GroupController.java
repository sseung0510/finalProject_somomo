package com.kh.somomo.group.controller;


import static com.kh.somomo.common.template.FileRename.saveFile;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.somomo.common.model.vo.PageInfo;
import com.kh.somomo.common.template.Pagination;
import com.kh.somomo.group.model.service.GroupService;
import com.kh.somomo.group.model.vo.GroupMember;
import com.kh.somomo.group.model.vo.GroupRoom;
import com.kh.somomo.member.model.vo.Member;


@Controller
public class GroupController {
	
	@Autowired
	private GroupService groupService;
	
	//그룹방 리스트 전체 화면
	@RequestMapping("groupRoom.gr")
	public ModelAndView selectGroupList(@RequestParam(value="cpage", defaultValue="1") int currentPage,
										HttpSession session, ModelAndView mv) throws ParseException {
		
		PageInfo pi = Pagination.getPageInfo(groupService.selectGroupListCount(), currentPage, 10, 9); // 페이징처리
		String userId = ((Member)session.getAttribute("loginUser")).getUserId();
		mv.addObject("pi", pi)										  // 페이징
		  .addObject("myGroupList", groupService.myGroupList(userId)) // 내가 관리/가입한 그룹 리스트
		  .addObject("cList", groupService.selectGroupCategoryList()) // 그룹카테고리
		  .setViewName("group/community");
		
		return mv;
	}
	
	//그룹방 리스트
	@RequestMapping(value="list.gr")
	public String groupList(@RequestParam(value="cpage", defaultValue="1") int currentPage,
				 			Model model) throws ParseException {
		PageInfo pi = Pagination.getPageInfo(groupService.selectGroupListCount(), currentPage, 10, 9); // 페이징처리
		
		ArrayList<GroupRoom> gList = groupService.selectList(pi); // 전체 그룹 리스트
		model.addAttribute("list", gList); 
		
		return "group/groupList";
	}
	
	// 그룹방 개설 페이지로 요청 처리
	@RequestMapping("insertForm.gr")
	public String insertForm(Model model) {
		model.addAttribute("rList",groupService.selectRegionCategoryList())
			 .addAttribute("cList", groupService.selectGroupCategoryList());
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
			return "redirect:detail.gr?gno=" + groupNo; // 쿼리스트링으로 전달
		}else { 
			model.addAttribute("errorMsg","그룹방 추가 실패");
			return "common/errorPage";
		}
	}
	
	// 그룹방 상세
	// 상세보기 페이지에서 필요한 정보 : 해당 그룹방에 대한 정보, 가입된 회원들의 리스트
	@RequestMapping("detail.gr")
	public ModelAndView groupDetail(int gno, ModelAndView mv) {
		
		GroupRoom gr = groupService.selectGroup(gno); 	     			   // 특정 그룹방에대한 정보를 담음
		ArrayList<GroupMember> mList = groupService.selectMemberList(gno); // 가입된 회원리스트
		
		System.out.println(groupService.selectMemberList(gno));
		
		if (gr != null) {
			mv.addObject("g", gr)
			  .addObject("mList", mList)
			  .setViewName("group/groupDetail");
		} else {
			mv.addObject("errorMsg", "그딴 그룹방은 없는디요??").setViewName("common/errorPage");
		}
		return mv;
	}
	
	// 그룹방 상세
	// 그룹방 설정 변경 => 사이드바 메뉴에 표시될 정보를 위해 계속 정보 가져옴
	@RequestMapping("setting.gr")
	public ModelAndView setting(int groupNo, ModelAndView mv) {
		
		mv.addObject("g", groupService.selectGroup(groupNo))
		  .addObject("mList", groupService.selectMemberList(groupNo))
		  .setViewName("group/groupSetting");
		
		return mv;
	}
	
	@RequestMapping("updateForm.gr")
	public String updateGroup(int groupNo, Model model) {
		
		model.addAttribute("g", groupService.selectGroup(groupNo));
		
		return "group/updateGroup";
	}
	
	@RequestMapping("grouptType.gr")
	public String changeType() {
		
		
		return "main";
	}
	
	@RequestMapping("delete.gr")
	public String deleteGroup() {
		
		
		return "main";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	// 이거는 임시 입니다.
//	@RequestMapping("apply.gr")
//	@ResponseBody
//	public String applyGroup(GroupJoinApply applyInfo) {
//		
//		System.out.println(applyInfo);
//		
//		int result = groupService.applyGroup(applyInfo);
//		
//		if(result > 0) { // 그룹 가입 신청 완료
//			return "NNNNY";
//		} else {
//			return "NNNNN";
//		}
//	}
	
}


