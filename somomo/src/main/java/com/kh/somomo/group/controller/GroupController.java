package com.kh.somomo.group.controller;


import static com.kh.somomo.common.template.FileRename.saveFile;

import java.io.File;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.kh.somomo.common.model.vo.Attachment;
import com.kh.somomo.common.model.vo.Likes;
import com.kh.somomo.common.model.vo.PageInfo;
import com.kh.somomo.common.model.vo.Reply;
import com.kh.somomo.common.template.FileRename;
import com.kh.somomo.common.template.Pagination;
import com.kh.somomo.common.template.Time;
import com.kh.somomo.group.model.service.GroupService;
import com.kh.somomo.group.model.vo.CalendarPlan;
import com.kh.somomo.group.model.vo.GroupBoard;
import com.kh.somomo.group.model.vo.GroupJoinApply;
import com.kh.somomo.group.model.vo.GroupMember;
import com.kh.somomo.group.model.vo.GroupRoom;
import com.kh.somomo.member.model.service.MemberService;
import com.kh.somomo.member.model.vo.Member;


@Controller
public class GroupController {
	
	@Autowired
	private GroupService groupService;
	
	@Autowired
	private JavaMailSender sender;
	
	//그룹방 리스트 전체 화면 : community 화면
	@RequestMapping("groupRoom.gr")
	public ModelAndView selectGroupList(@RequestParam(value="cpage", defaultValue="1") int currentPage, 
										@RequestParam(value = "cno", defaultValue = "0") String categoryNo,
										HttpSession session, ModelAndView mv) throws ParseException {

		String userId = ((Member)session.getAttribute("loginUser")).getUserId();
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("userId", userId);
		map.put("categoryNo", categoryNo);
		
		PageInfo pi = Pagination.getPageInfoFeed(groupService.selectGroupListCount(map), currentPage, 9); // 페이징처리

		// 카테고리 버튼을 클릭해서 요청이 들어오면 해당 카테고리 번호를 페이지에 포워딩
		// 카테고리 번호
		// 개발 : 1, 스터디 : 2, 운동/취미 : 3, 기타 : 4
		// 전체 목록의 경우 따로 지정된 번호가 없어 RequestParam의 defaultValue를 0으로 지정함
		if(!categoryNo.equals("0")) {  
			mv.addObject("cno", categoryNo);
		}
		
		mv.addObject("pi", pi)										  // 페이징
		  .addObject("cList", groupService.selectGroupCategoryList()) // 그룹카테고리
		  .addObject("myGroupList", groupService.myGroupList(userId)) // 내가 관리/가입한 그룹 리스트
		  .setViewName("group/community");			
		
		System.out.println(pi);
		
		return mv;
	}
	
	//그룹방 리스트 
	@RequestMapping(value="list.gr")
	public String groupList(PageInfo pi,
						    @RequestParam(value = "cno", defaultValue = "0") String categoryNo,
										  String userId, Model model) {
		
		// userId와 categoryNo를 넘겨주기 위해 해시 맵 사용 
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("userId", userId);
		map.put("categoryNo", categoryNo);
		
		System.out.println(categoryNo);
		
		ArrayList<GroupRoom> gList = groupService.selectGroupList(pi, map); 			
		model.addAttribute("gList", gList);
	
		return "group/ajaxGroupList";
	}
	
	// 그룹방 개설 페이지로 요청 처리
	@RequestMapping("insertForm.gr")
	public String insertForm(Model model) {
		model.addAttribute("rList",groupService.selectRegionCategoryList())
			 .addAttribute("cList", groupService.selectGroupCategoryList());
		return "group/createGroup";
	}
	
	/**
	 * 그룹방 만들기
	 * - 사용자정의 그룹이미지(upfile)가 없을경우 서버에 저장되어있는 기본 이미지중 하나가 자동 선택되고 gr.groupImg에 담겨 넘어옴
	 * - 3개의 insert문 실행 : GROUP_ROOM, GROUP_MEMBER, GROUP_CALENDAR
	 * - 성공적으로 그룹방 개설이 되면 상세페이지로 이동함
	 */
	@RequestMapping("insert.gr")
	public String insertGroup(GroupRoom gr, GroupMember gm, MultipartFile upfile, Model model, HttpSession session){
		
//		// 사용자가 자기 사진을 추가
//		// 기존의 profileImg에 등록된 사진을 변경해준다. 
//		// => 사용자가 그룹방 메인 사진을 따로 추가 하지 않을 경우, 서버에서 임의로 제공하는 사진의 경로가 gr.groupImg에 들어가 있음
	
		// 그룹타입이 비공개(C)일 경우 코드 생성해서 inviteCode에 셋 
		if(gr.getGroupType().equals("C")) {
			gr.setInviteCode(getInviteCode(5));
		}
		
		if(!upfile.getOriginalFilename().equals("")) {
			HashMap<String, String> map = saveFile(upfile, session, "img/group/userGroupImg");
			
			gr.setGroupImg(map.get("changeName"));	
		}
		
		int result = groupService.insertGroup(gr, gm);
		
		int groupNo = groupService.getGroupNo();     // 상세페이지로 이동하기위해 식별값인 groupNo를 조회해서 가져옴
		
		if(result > 0) {
			return "redirect:detail.gr?gno=" + groupNo; // 쿼리스트링으로 전달
		}else { 
			model.addAttribute("errorMsg","그룹방 추가 실패");
			return "common/errorPage";
		}
		
	}
	
	// 그룹방 상세
	// 상세보기 페이지에서 필요한 정보 : 해당 그룹방에 대한 정보, 가입된 회원들의 리스트
	@RequestMapping("detail.gr")
	public ModelAndView groupDetail(@RequestParam(value="cpage", defaultValue="1") int currentPage,
									int gno, ModelAndView mv) {
		PageInfo pi = Pagination.getPageInfo(groupService.selectBoardListCount(), currentPage, 10, 5); // 페이징처리
		
		
		GroupRoom gr = groupService.selectGroup(gno); 	     			   // 특정 그룹방에대한 정보를 담음
		ArrayList<GroupMember> mList = groupService.selectMemberList(gno); // 가입된 회원리스트
		
		if (gr != null) {
			mv.addObject("g", gr)
			  .addObject("pi", pi)
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
		  .addObject("aCount", groupService.countApplication(groupNo))
		  .setViewName("group/groupSetting");
		
		return mv;
	}
	
	@RequestMapping("updateForm.gr")
	public String updateGroup(int groupNo, Model model) {
		
		model.addAttribute("g", groupService.selectGroup(groupNo))
			 .addAttribute("rList",groupService.selectRegionCategoryList())
			 .addAttribute("cList", groupService.selectGroupCategoryList());;
		
		return "group/updateGroup";
	}
	
	@RequestMapping("update.gr")
	public String updateGroup(GroupRoom g, MultipartFile reupfile, String originFile, HttpSession session) {
		// 설정 변경에서 변경 가능한 정보들 : 지역/그룹 카테고리, 그룹명, 그룹 설명, 그룹사진
		
		// g.groupImg에는 들어있는 값 :
		// 	- 사이트 제공하는 기본 이미지 선택했을때는 해당 경로가..
		//  - 업로드 파일을 이용해 전송됐을때는 빈값...
		// originFile에는 이전에 사용중이던 대표이미지의 경로가 넘어옴
		
		// 수정 전 사용하던 그룹 대표 이미지가 사이트에서 제공하던 사진이였는지, 사용자가 직접 업로드한 사진이였는지 확인하는 메소드
		// true : 사이트에서 제공하는 사진, false : 사용자가 업로드한 파일
		
		boolean checkImg = checkDefaultImg(session, originFile); 
		
		// 새로운 업로드 파일이 있는지 확인
		if(!reupfile.getOriginalFilename().equals("")) {
			
			// 새로운 업로드 파일이 존재함 -> 기존의 사진이 사이트에서 제공한 기본 사진 이였는지 사용자가 업로드했던 사진인지 확인
			if(!checkImg) {
				// 사용자가 등록했던 사진 찾아서 삭제
				new File(session.getServletContext().getRealPath(originFile)).delete();
			} 
			// g.groupImg 필드에 새롭게 업로드된 파일경로 설정
			HashMap<String, String> map = saveFile(reupfile, session, "img/group/userGroupImg");
			g.setGroupImg(map.get("changeName"));	
			
		} else {
			// 새롭게 업로드된 파일이 없음 -> 그룹이미지가 변경 되었는지 확인해야됨
			// 사용자 지정 이미지의 경우 checkImg에 의해 걸러지기 때문에 사진을 따로 변경하지 않았을때는 지워주면 안됨
			if(!g.getGroupImg().equals(originFile)) {
				
				// 그룹이미지 정보가 변경됨 : 이경우에는 사용자가 업로드했던 파일을 내리고 사이트 제공 이미지를 재 선택함
				if (!checkImg) {
					// 사용자가 등록했던 사진은 삭제 해준다.
					new File(session.getServletContext().getRealPath(originFile)).delete();
				}				
			}
		}
		
		int result = groupService.updateGroup(g);

		return "redirect:setting.gr?groupNo=" + g.getGroupNo();
	}
	
	@RequestMapping("updateType.gr")
	public String updateType(GroupRoom g) {
		
		int result = groupService.updateType(g);
		
		return "redirect:setting.gr?groupNo=" + g.getGroupNo();
	}
	
	
	@RequestMapping("delete.gr")
	public String deleteGroup(int groupNo, HttpSession session) {
		
		GroupRoom g = groupService.selectGroup(groupNo);
		
		boolean checkImg = checkDefaultImg(session, g.getGroupImg());
		
		if(!checkImg) {
			// 사용자가 등록한 사진은 찾아서 삭제 해줌
			new File(session.getServletContext().getRealPath(g.getGroupImg())).delete();
		}
		
		int result = groupService.deleteGroup(groupNo);
		
		return "redirect:groupRoom.gr";
	}
	
	// -------------------------------------------------------- 
	//그룹 가입 요청 관련 ajax	
	@ResponseBody
	@RequestMapping("join.gr")
	public String joinGroup(GroupMember gm, GroupJoinApply applyInfo, 
							@RequestParam(value="groupType", defaultValue = "A") String groupType) {
		
		if(groupType.equals("A")) { // 공개그룹에 가입 : 바로 회원을 그룹에 추가함
			return groupService.insertRoomMember(gm) > 0 ? "success" : "fail";
		}else {
			return groupService.applyGroup(applyInfo) > 0 ? "success" : "fail";
		}
	}
	
	@ResponseBody
	@RequestMapping("cancelApply.gr")
	public String cancelApply(GroupMember applyInfo) {
		return groupService.delteApplyInfo(applyInfo) > 0 ? "success" : "fail";
	}
	
	@ResponseBody
	@RequestMapping(value = "getApplicationList.gr", produces = "application/json; charset=UTF-8")
	public String getApplicationList(int groupNo) {
		ArrayList<GroupJoinApply> aList = groupService.getApplicationList(groupNo);
		return new Gson().toJson(aList);
	}
	
	@ResponseBody
	@RequestMapping("accept")
	public String approveJoin(GroupMember applyInfo) {
		
//			System.out.println(applyInfo.getApplyNo()); // 신청번호
//			System.out.println(applyInfo.getUserId());  // 회원 아이디
//			System.out.println(applyInfo.getGroupNo()); // 그룹방번호
		
		int result = groupService.delteApplyInfo(applyInfo); // delete문을 사용해서 해당 신청번호를 지워준다.
		int result2 = 0;

		if(result > 0) { // 성공적으로 지워졌다면 == 가입 승인 완료
			GroupMember gm = new GroupMember();
			gm.setGroupNo(applyInfo.getGroupNo());
			gm.setUserId(applyInfo.getUserId());
			
			result2 = groupService.insertRoomMember(gm);
		}
		
		return result2 > 0 ? "success" : "fail";
	
	}
	
	

	@RequestMapping("exit.gr")
	public String exit(GroupMember gm, Model model) {
		System.out.println(gm.getUserId());
		int result = groupService.exitGroup(gm);
		if(result > 0) {
			return "redirect:groupRoom.gr";
		}else { 
			model.addAttribute("errorMsg","그룹방 추가 실패");
			return "common/errorPage";
		}
	}

	
	
	
	//--------------------------------GroupBoard
	
	//그룹방 게시글 정렬
	@RequestMapping(value="listBoard.gr")
	public String ajaxSelectBoardList(@RequestParam(value="cpage", defaultValue="1") int currentPage,
									GroupMember gm, HttpSession session, Model model)throws ParseException {
		PageInfo pi = Pagination.getPageInfo(groupService.selectBoardListCount(), currentPage, 10, 5); // 페이징처리
		
		ArrayList<GroupBoard>  grList = groupService.selectBoardList(pi, gm); //그룹 피드 리스트 가져오기
		
		ArrayList<Attachment> atList = new ArrayList<>();//그룹 피드 첨부파일 리스트 
		
		for(GroupBoard gb : grList) {
			gb.setCreateDate(Time.getDiffTime(gb.getCreateDate()));
		}
		
		
		if(!grList.isEmpty()) { 
			HashMap<String, Integer> boardRange = new HashMap<>();
			boardRange.put("min", grList.get(grList.size()-1).getBoardNo()); // 첫번 째 글번호
			boardRange.put("max", grList.get(0).getBoardNo()); // 마지막 글번호
			
			atList = groupService.selectBoardAttachmentList(boardRange);
		}
		
		model.addAttribute("grList", grList)
			 .addAttribute("atList", atList);
		
//		System.out.println(grList);
		System.out.println(atList);
		
		
		return "group/groupDetailList";
	}
	
	//그룹방 게시글 작성
	@RequestMapping("insertBoard.gr")
	public String insertBoard(GroupBoard gb,  MultipartHttpServletRequest mtfRequest, HttpSession session, Model model) {
		int result = 0;
		
		ArrayList<Attachment> boardList = new ArrayList<>();
		
		Iterator<String> fileNames = mtfRequest.getFileNames();
		
		while(fileNames.hasNext()) { // file1 ~ file4
			
			String file = fileNames.next(); // file 하나씩 접근해서
			
			MultipartFile upfile = mtfRequest.getFile(file); // 실제 파일 객체 뽑아오기
			
			if(!upfile.getOriginalFilename().equals("")) { // 실제로 파일이 첨부됐을 경우
				
				// 지정경로에 해당 파일을 저장하고 원본명,수정명(경로+파일수정명) 반환받음
				HashMap<String, String> map = FileRename.saveFile(upfile, session, "img/group");
				
	            Attachment at = new Attachment();
	            at.setOriginName(map.get("originName"));
	            at.setChangeName(map.get("changeName"));
	            boardList.add(at);
			}
		}

		result = groupService.insertGroupBoard(gb, boardList);
	
	
		if(result > 0) {
			return "redirect:detail.gr?gno=" + gb.getGroupNo();
		} else {
			model.addAttribute("errorMsg", "게시글 작성 실패");
			return "common/errorPage";
		}
		
	}
	
	@RequestMapping("deleteBoard.gr")
	public String deleteBoard(int boardNo, int groupNo, HttpSession session, Model model) {
		System.out.println(boardNo);
		
		int result = groupService.deleteBoard(boardNo);
		
		System.out.println(result);
		System.out.println(groupNo);
		
		// 글 삭제 성공했을 경우
		if(result > 0) { 
			ArrayList<Attachment> atList = groupService.selectAttachmentList(boardNo);
			// 첨부파일 존재했을 경우
			if(!atList.isEmpty()) {
				groupService.deleteAllAttachment(boardNo); // DB에서 삭제
				for(Attachment at : atList) {
					new File(session.getServletContext().getRealPath(at.getChangeName())).delete(); // 실제 파일 삭제
				}
			}
			//session.setAttribute("alertMsg", "게시글 삭제 성공");
			
			return "redirect:detail.gr?gno=" + groupNo;
		} else {
			model.addAttribute("errorMsg", "게시글 삭제 실패");
			return "common/errorPage";
		}
	}
	
	
	@ResponseBody
	@RequestMapping("insertLike.gr")
	public String ajaxInsertLike(Likes like) {
		return groupService.insertLike(like) > 0 ? "success" : "fail";
	}
	
	@ResponseBody
	@RequestMapping("deleteLike.gr")
	public String ajaxDeleteLike(Likes like) {
		return groupService.deleteLike(like) > 0 ? "success" : "fail";
	}
	
	
	
	@ResponseBody
	@RequestMapping("countLike.gr")
	public int ajaxCountLikes(int boardNo) {
		return groupService.countLike(boardNo);
	}
	
	
	@ResponseBody
	@RequestMapping(value="selectReplyList.gr", produces="application/json; charset=UTF-8")
	public String ajaxSelectReplyList(int boardNo) {
		
		ArrayList<Reply> rpList = groupService.selectReplyList(boardNo);
		for(Reply rp : rpList) {
			if(rp.getProfileImg() == null) rp.setProfileImg("resources/img/member/profile_img.png");
			if(rp.getReplyContent() == null) rp.setReplyContent("삭제된 댓글입니다");
		}
		return new Gson().toJson(rpList);
	}

	
	@ResponseBody
	@RequestMapping("insertReply.gr")
	public String ajaxInsertReply(Reply reply) {
		return groupService.insertReply(reply) > 0 ? "success" : "fail";
	}
	
	
	@ResponseBody
	@RequestMapping("insertReReply.gr")
	public String ajaxInsertReReply(Reply reply) {
		return groupService.insertReReply(reply) > 0 ? "success" : "fail";
	}
	
	
	@ResponseBody
	@RequestMapping("deleteReply.gr")
	public String ajaxDeleteReply(Reply reply) {
		
		int replyNo = reply.getReplyNo();
		int rgroup = reply.getRgroup();
		
		boolean isReplyWithRereply = groupService.checkHasRereply(replyNo);
		// 답글이 달린 댓글인 경우
		if(isReplyWithRereply) {
			// 댓글 내용 삭제 (STATUS는 그대로 Y)
			return groupService.deleteReplyContent(replyNo) > 0 ? "deleteContent" : "fail";
		// 답글 없는 댓글인 경우 (답글도 해당)
		} else {
			// 삭제된 댓글에 달린 댓글(답글)인 경우 + 답글이 마지막 남은 1개일 경우
			if(groupService.isSingleRereplyNdeleteReply(rgroup)) {
				// 댓글과 답글 모두 삭제 (STATUS 모두 N으로)
				return groupService.deleteTwoReply(rgroup) > 0 ? "deleteTwoReply" : "fail";
			}
			// 위의 모든 경우에 해당하지 않으면 해당 댓글만 삭제 (STATUS N)
			return groupService.deleteReply(replyNo) > 0 ? "deleteReply" : "fail";
		}
	}

	
	@ResponseBody
	@RequestMapping("countReply.gr")
	public int ajaxCountReply(int boardNo) {
		return groupService.countReply(boardNo);
	}
	
	


	
	@RequestMapping("calendar.gr")
	public String calendarForm(int groupNo, Model model) {	
		
		model.addAttribute("c", groupService.selectCalendar(groupNo));
		model.addAttribute("g", groupService.selectGroup(groupNo));
		model.addAttribute("mList", groupService.selectMemberList(groupNo));
		
		
		return "group/groupCalendar";
		
	

	}
	
	
	@RequestMapping("insertCalendarEvent.gr")
	public String insertCalendarEvent(CalendarPlan gp, HttpSession session, RedirectAttributes redirectAttributes) {

		if(gp.getStartTime() !=null && gp.getEndTime() !=null) {
			String startTime = gp.getStartDate() +"\s" + gp.getStartTime() ;
			String endTime = gp.getEndDate() +"\s" + gp.getEndTime();
			 
			gp.setStartTime(startTime);
			gp.setEndTime(endTime);
		}
		int groupNo = groupService.getGroupNo();

		int result = groupService.insertCalendarEvent(gp);
		redirectAttributes.addAttribute("groupNo", groupNo);
		return "redirect:/calendar.gr?cNo=" + groupNo;
	}
//	 "redirect:setting.gr?groupNo=" + g.getGroupNo();

	
	// 사진첩
	
	@RequestMapping("gallery.gr")
	public ModelAndView galleryList(@RequestParam("gno") int groupNo, ModelAndView mv) {
		
		mv.addObject("g", groupService.selectGroup(groupNo))
		  .addObject("mList", groupService.selectMemberList(groupNo))
		  .setViewName("group/groupGallery");
		return mv;
	}
	
	
	
	
	
	@ResponseBody
	@RequestMapping(value = "groupGalleryAttachmentList.gr", produces="application/json; charset=UTF-8")
	public String groupGalleryAttachmentList(@RequestParam(value = "groupNo") int groupNo) {
		return new Gson().toJson(groupService.groupGalleryAttachmentList(groupNo));
	}
	
	
	
	
	
	
	
	
	
	
	@ResponseBody
	@RequestMapping(value = "selectCalendarEvents.gr", produces="application/json; charset=UTF-8")
	public List<Map<String, Object>> calendarEventList(@RequestParam(value = "calendarNo") int calendarNo) {
		
//		System.out.println(CalendarNo);
		int cNo = calendarNo;
		
		List<CalendarPlan> eventList = groupService.selectCalendarEventList(cNo);
		
//		System.out.println(eventList);
		JSONObject jsonObj = new JSONObject();
        JSONArray jsonArray = new JSONArray();
 
        HashMap<String, Object> hash = new HashMap<>();
        
      
        for (int i = 0; i < eventList.size(); i++) {
            hash.put("title", eventList.get(i).getTitle());
            
            if(eventList.get(i).getStartTime() !=null) {
	            hash.put("start", eventList.get(i).getStartTime());
	            hash.put("end", eventList.get(i).getEndTime());
            }
            else {
            	hash.put("start", eventList.get(i).getStartDate());
	            hash.put("end", eventList.get(i).getEndDate());
            }
            hash.put("color", eventList.get(i).getColor());
            hash.put("textColor",eventList.get(i).getTextColor());
            hash.put("id",eventList.get(i).getMemo());
            hash.put("groupId",eventList.get(i).getUserId());
            
            System.out.println(eventList.get(i).getUserId());
            hash.put("allDay", eventList.get(i).isAllDay());
 
            jsonObj = new JSONObject(hash);
            jsonArray.add(jsonObj);
        }

        return jsonArray;
	}
	
	
	
	// 전체 그룹 일정 불러오기
	
	@ResponseBody
	@RequestMapping(value="calendarEventListEntire.gr", produces="application/json; charset=UTF-8")
	public String calendarEventListEntire(@RequestParam(value = "groupNo") int groupNo) {
		System.out.println(groupService.calendarEventListEntire(groupNo));
		return new Gson().toJson(groupService.calendarEventListEntire(groupNo));
	}
	
	
	
	
	
	// 그룹방 멤버
	@RequestMapping("member.gr")
	public ModelAndView memberList(ModelAndView mv, @RequestParam("gno") int groupNo) {
		
		mv.addObject("g", groupService.selectGroup(groupNo))
		  .addObject("mList", groupService.selectMemberList(groupNo))
		  .setViewName("group/groupMember");
		
		return mv;
	}
	
	// 비공개 그룹 사용자 검색
	@ResponseBody
	@RequestMapping(value = "searchUser.gr", produces="application/json; charset=UTF-8")
	public String searchUser(String keyword, String groupNo){
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("keyword", keyword);
		map.put("groupNo", groupNo);
		
		ArrayList<Member> mList = groupService.searchUser(map);
		
		return new Gson().toJson(mList);
	}
	
	@ResponseBody
	@RequestMapping(value = "inviteMember.gr")
	public String sendInviteCode(String email, String code, String groupName,
								 GroupJoinApply ja) throws MessagingException {
		
		// insertGroupMember에 추가
		ja.setGreeting("invitation Code sent");
		int result = groupService.applyGroup(ja);
		
		
		if (result > 0) {
			MimeMessage message = sender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
			helper.setTo(email);
			helper.setSubject(groupName + " 인증코드 입니다.");
			helper.setText("인증코드 : " + code);
			
			sender.send(message);
			
			return "Y";
		} else {
			return "N";			
		}
		
	}
	
	@RequestMapping(value = "joinPrivateGroup.gr")
	public String joinPrivateGroup(String inviteCode, String userId, Model model, HttpSession session) {
		
		// 코드와 그룹방을 매칭해서 그룹방번호를 반환받음
		GroupMember gm = groupService.matchGroup(inviteCode);
		
		if (gm != null) { // 사용자가 입력한 그룹코드와 일치하는 그룹방이 없다면 실패!
			gm.setUserId(userId);
			
			int result = groupService.matchJoinApply(gm);
			
			if(result > 0) {
				session.setAttribute("alertMsg", "그룹가입 성공!!");
			} else {
				session.setAttribute("alertMsg", "그룹가입 실패!!");
			}
		}else {
			session.setAttribute("alertMsg", "그룹가입 실패!!");
		}
		
		return "redirect:groupRoom.gr";
	}
	
	@ResponseBody
	@RequestMapping("reject")
	public String rejectMember(GroupMember applyInfo) {
		
		int result = groupService.delteApplyInfo(applyInfo);
		
		if(result > 0) {
			return "success";
		} else {
			return "fail";
		}
		
		
	}

	
	//////////////////////////////// 
	public boolean checkDefaultImg(HttpSession session, String originFile) {
			
		String IMG_DRIECTORY = session.getServletContext().getRealPath("/resources/img/group/defaultGroupImg");
		
		String checkImg = originFile.substring(36);
		
		File dir = new File(IMG_DRIECTORY);
		
		String[] defaultImgs = dir.list();
		
		for(String img : defaultImgs) {
			if (img.equals(checkImg)) {
				return true;
			}
		}
		return false;
	}
	
	// 초대코드 생성
	public static String getInviteCode(int length) {
		
		String inviteCode = "";
		
		for(int i = 0; i < length; i++) {
			char ch = (char)((int)(Math.random()*25) + 65);
			inviteCode += ch;
		}
		
		return inviteCode;
	}
	
	
}


