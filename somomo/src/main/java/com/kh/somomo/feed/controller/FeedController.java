package com.kh.somomo.feed.controller;

import java.io.File;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.kh.somomo.chat.model.vo.ChatMember;
import com.kh.somomo.common.model.vo.Attachment;
import com.kh.somomo.common.model.vo.Likes;
import com.kh.somomo.common.model.vo.PageInfo;
import com.kh.somomo.common.model.vo.Reply;
import com.kh.somomo.common.template.FileRename;
import com.kh.somomo.common.template.Pagination;
import com.kh.somomo.common.template.Time;
import com.kh.somomo.feed.model.service.FeedService;
import com.kh.somomo.feed.model.vo.FeedBoard;
import com.kh.somomo.member.model.vo.Member;

@Controller
public class FeedController {
	
	@Autowired
	private FeedService feedService;
	
	@RequestMapping("main.fd")
	public ModelAndView selectFeedList(@RequestParam(value="cpage", defaultValue="1") int currentPage,
			                           ModelAndView mv) throws ParseException {
		
		PageInfo pi = Pagination.getPageInfoFeed(feedService.selectFeedListCount(), currentPage, 5); // 페이징처리(마지막페이지 번호 계산해서 추가로 받아옴)
		
		mv.addObject("pi", pi)
		  .addObject("rList", feedService.selectRegionList()) // 지역 카테고리 목록 가져오기
		  .setViewName("feed/mainFeed");
		
		return mv;
	}
	
	@RequestMapping(value="list.fd")
	public String ajaxSelectFeedList(PageInfo pi, String userId, Model model) throws ParseException {

		ArrayList<FeedBoard> fbList = feedService.selectFeedList(pi, userId); // 사용자의 피드 목록 가져오기 
		for(FeedBoard fb : fbList) {
			
			fb.setBoardDate(Time.getDiffTime(fb.getBoardDate())); // 지난 날짜 설정
			
			if(fb.getBoardType().equals("M")) { // 모임글일 경우
				setMeetCondition(fb); // 모집조건 텍스트 설정
			}
		}
		
		ArrayList<Attachment> fatList = new ArrayList<>();
		if(!fbList.isEmpty()) {
			HashMap<String, Integer> boardRange = new HashMap<>();
			boardRange.put("min", fbList.get(fbList.size()-1).getBoardNo()); // 첫번 째 글번호
			boardRange.put("max", fbList.get(0).getBoardNo()); // 마지막 글번호
			
			fatList = feedService.selectFeedAttachmentList(boardRange);
		}
			
		model.addAttribute("fbList", fbList)
			 .addAttribute("fatList", fatList);
		
		return "feed/ajaxFeedList";
	}
	
	// 모집조건 설정 (모집성별 + 모집나이)
	public void setMeetCondition(FeedBoard fb) {
		
		String condition = null;
		
		// 모집나이, 모집성별 모두 제한 없을 경우
		if(fb.getMeetAge().equals("A") && fb.getMeetGender().equals("A")) {
			fb.setMeetCondition("누구나 참여 가능");
			return;
		}
		
		// 모집나이 문구 설정
		if(fb.getMeetAge().equals("A")) {
			condition = "나이 제한 없음 | ";
		} else {
			condition = fb.getMeetAge() + "세 | ";
			// 최소나이, 최대나이 설정
			String[] meetAge = fb.getMeetAge().split("~");
			fb.setMinAge(meetAge[0]);
			fb.setMaxAge(meetAge[1]);
		}
		
		// 모집성별 문구 설정
		if(fb.getMeetGender().equals("A")) condition += "성별제한 없음";
		else if(fb.getMeetGender().equals("F")) condition += "여성만";
		else condition += "남성만";
		
		fb.setMeetCondition(condition);
	}
	
	@RequestMapping("insertG.fd")
	public String enrollGeneralForm(FeedBoard fb, MultipartHttpServletRequest mtfRequest, HttpSession session, Model model) {
		
		
		ArrayList<Attachment> fatList = new ArrayList<>();
		
		Iterator<String> fileNames = mtfRequest.getFileNames(); // name 전부 받아오기 (file1, file2, file3, file4)
		
		while(fileNames.hasNext()) { // file1 ~ file4
			
			String file = fileNames.next(); // file 하나씩 접근해서
			
			MultipartFile upfile = mtfRequest.getFile(file); // 실제 파일 객체 뽑아오기
			
			if(!upfile.getOriginalFilename().equals("")) { // 실제로 파일이 첨부됐을 경우
				
				// 지정경로에 해당 파일을 저장하고 원본명,수정명(경로+파일수정명) 반환받음
				HashMap<String, String> map = FileRename.saveFile(upfile, session, "img/feedUploadFiles");
				
	            Attachment at = new Attachment();
	            at.setOriginName(map.get("originName"));
	            at.setChangeName(map.get("changeName"));
	            fatList.add(at);
			}
		}

		int result = feedService.insertGeneralBoard(fb, fatList);
		
		if(result > 0) {
			//session.setAttribute("alertMsg", "게시글 작성 성공");
			return "redirect:main.fd";
		} else {
			model.addAttribute("errorMsg", "게시글 작성 실패");
			return "common/errorPage";
		}
	}
	
	@RequestMapping("insertM.fd")
	public String enrollMeetForm(FeedBoard fb, HttpSession session, Model model) {
		
		fb.setMeetDate(fb.getMeetDate().replace("T", " ")); // 2022-08-05T15:33에서 T를 공백으로 대체
		
		if(fb.getMeetAge().equals("selectAge")) { // 모집나이 직접 입력했을 시
			fb.setMeetAge(fb.getMinAge() + "~" + fb.getMaxAge()); // 20~30 형태로 저장
		}
		
		int result = feedService.insertMeetBoard(fb);

		
		if(result > 0) {
			//session.setAttribute("alertMsg", "게시글 작성 성공");
			return "redirect:main.fd";
		} else {
			model.addAttribute("errorMsg", "게시글 작성 실패");
			return "common/errorPage";
		}
	}
	
	@RequestMapping("detail.fd")
	public ModelAndView selectFeedBoard(int boardNo, ModelAndView mv) {
		
		int result = feedService.increaseCount(boardNo); // 조회수 증가
		
		FeedBoard fb = new FeedBoard();
		
		if(result > 0) {
			String bType = feedService.selectBoardType(boardNo); // 게시글 타입(G/M) 받아오기

			// 일반글일 경우
			if(bType.equals("G")) { 
				fb = feedService.selectGeneralBoard(boardNo);
				mv.addObject("fatList", feedService.selectAttachmentList(boardNo))
				  .setViewName("feed/feedGeneralDetailView");
				
			// 모임모집글일 경우
			} else { 
				fb = feedService.selectMeetBoard(boardNo);
				setMeetCondition(fb); // 모집조건 텍스트 설정
				mv.setViewName("feed/feedMeetDetailView");
			}
			
		} else {
			mv.addObject("errorMsg", "상세조회 실패").setViewName("common/errorPage");
		}
		
		mv.addObject("fb", fb)
		  .addObject("rList", feedService.selectRegionList());
		return mv;
	}
	
	@RequestMapping("selectNewBoard.fd")
	public String ajaxSelectNewBoard(int boardNo, Model model) {
		
		FeedBoard fb = new FeedBoard();
		String bType = feedService.selectBoardType(boardNo); //게시글 타입(G/M) 받아오기
		// 일반글일 경우
		if(bType.equals("G")) { 
			fb = feedService.selectGeneralBoard(boardNo);
			model.addAttribute("fb", fb);
			return "feed/ajaxGeneralBoard";
			
		// 모임모집글일 경우
		} else { 
			fb = feedService.selectMeetBoard(boardNo);
			setMeetCondition(fb); // 모집조건 텍스트 설정
			model.addAttribute("fb", fb);
			return "feed/ajaxMeetBoard";
		}
		
	}
	
	@ResponseBody
	@RequestMapping("updateM.fd")
	public String updateBoard(FeedBoard fb, Model model) {

		fb.setMeetDate(fb.getMeetDate().replace("T", " ")); // 2022-08-05T15:33에서 T를 공백으로 대체
		
		if(fb.getMeetAge().equals("selectAge")) { // 모집나이 직접 입력했을 시
			fb.setMeetAge(fb.getMinAge() + "~" + fb.getMaxAge()); // 20~30 형태로 저장
		}
		
		int result = feedService.updateMeetBoard(fb);

		return result > 0 ? "success" : "fail";
	}
	
	@ResponseBody
	@RequestMapping(value="getModalContent.fd", produces="application/json; charset=UTF-8")
	public String ajaxModalContent(int boardNo) {
		
		FeedBoard fb = new FeedBoard();
		String bType = feedService.selectBoardType(boardNo); //게시글 타입(G/M) 받아오기
		// 일반글일 경우
		if(bType.equals("G")) { 
			fb = feedService.selectGeneralBoard(boardNo);
			
		// 모임모집글일 경우
		} else { 
			fb = feedService.selectMeetBoard(boardNo);
			setMeetCondition(fb);
		}
		
		return new Gson().toJson(fb);
	}
	
	@RequestMapping("delete.fd")
	public String deleteBoard(int boardNo, HttpSession session, Model model) {
		
		
		int result = feedService.deleteBoard(boardNo);
		
		// 글 삭제 성공했을 경우
		if(result > 0) { 
			ArrayList<Attachment> atList = feedService.selectAttachmentList(boardNo);
			// 첨부파일 존재했을 경우
			if(!atList.isEmpty()) {
				feedService.deleteAllAttachment(boardNo); // DB에서 삭제
				for(Attachment at : atList) {
					new File(session.getServletContext().getRealPath(at.getChangeName())).delete(); // 실제 파일 삭제
				}
			}
			//session.setAttribute("alertMsg", "게시글 삭제 성공");
			return "redirect:main.fd";
		} else {
			model.addAttribute("errorMsg", "게시글 삭제 실패");
			return "common/errorPage";
		}
	}
	
	@ResponseBody
	@RequestMapping("insertLike.fd")
	public String ajaxInsertLike(Likes like) {
		return feedService.insertLike(like) > 0 ? "success" : "fail";
	}
	
	@ResponseBody
	@RequestMapping("deleteLike.fd")
	public String ajaxDeleteLike(Likes like) {
		return feedService.deleteLike(like) > 0 ? "success" : "fail";
	}
	
	@ResponseBody
	@RequestMapping("checkLike.fd")
	public String ajaxCheckLike(Likes like) {
		return feedService.checkLike(like) > 0 ? "Y" : "N";
	}
	
	@ResponseBody
	@RequestMapping("countLike.fd")
	public int ajaxCountLikes(int boardNo) {
		return feedService.countLike(boardNo);
	}
	
	@ResponseBody
	@RequestMapping("checkChatMember.fd")
	public String ajaxCheckChatMember(ChatMember cm) {
		return feedService.checkChatMember(cm) > 0 ? "Y" : "N";
	}
	
	@ResponseBody
	@RequestMapping("checkJoinCondition.fd")
	public String ajaxCheckJoinCondition(int boardNo, Member m) {
		
		FeedBoard fb = feedService.selectMeetBoard(boardNo);
		setMeetCondition(fb);
		
		// 모집 조건 충족하는 지 판별
		return checkJoinCondition(fb, m) ? "Y" : "N";
	}
	
	// 신청자가 모집 조건을 충족하는지 판별
	public boolean checkJoinCondition(FeedBoard fb, Member m) {
		
		// 모집나이, 모집성별 모두 제한 없을 경우
		if(fb.getMeetAge().equals("A") && fb.getMeetGender().equals("A")) {
			return true;
		}
		
		boolean isSatisfy = true;
		// 모집나이 조건 있을 경우
		if(!fb.getMeetAge().equals("A")) {
			int minAge = Integer.parseInt(fb.getMinAge());
			int maxAge = Integer.parseInt(fb.getMaxAge());
			if(m.getAge() < minAge  || maxAge < m.getAge()) isSatisfy = false;
		}
		
		// 모집나이 조건 있는 경우는 바로 전에 걸러졌고, 모집나이+성별 제한 없는 경우도 처음에 걸러졌기 때문에
		// 모집성별은 A인지 확인할 필요가 없고 F,M만 비교하면 됨
		if(!m.getGender().equals(fb.getMeetGender())) isSatisfy = false;
		
		return isSatisfy;
	}
	
	@RequestMapping("joinChat.fd")
	public String joinChat(int boardNo, ChatMember cm, HttpSession session, Model model) {
		
		boolean isJoinAvailable = feedService.checkChatMemberSpace(boardNo, cm.getRoomNo());
		if(isJoinAvailable) {
			int result = feedService.insertChatMember(cm);
			
			if(result > 0) {
				// 채팅 개발 후 경로 설정 필요
				session.setAttribute("alertMsg", "FeedController(joinChat.fd) : 해당 채팅방으로 경로 설정 필요");
				return "redirect:main.fd";
			} else {
				model.addAttribute("errorMsg", "모임 참여 실패");
				return "common/errorPage";
			}
		} else {
			session.setAttribute("alertMsg", "모임 정원이 초과됐습니다.");
			return "redirect:detail.fd?boardNo=" + boardNo;
		}
	}
	
	@ResponseBody
	@RequestMapping(value="selectReplyList.fd", produces="application/json; charset=UTF-8")
	public String ajaxSelectReplyList(int boardNo) {
		
		ArrayList<Reply> rpList = feedService.selectReplyList(boardNo);
		for(Reply rp : rpList) {
			if(rp.getProfileImg() == null) rp.setProfileImg("resources/img/member/profile_img.png");
			if(rp.getReplyContent() == null) {
				rp.setReplyContent("삭제된 댓글입니다");
				rp.setIsDeletedContent("Y");
			}
		}
		return new Gson().toJson(rpList);
	}
	
	@ResponseBody
	@RequestMapping("insertReply.fd")
	public String ajaxInsertReply(Reply reply) {
		return feedService.insertReply(reply) > 0 ? "success" : "fail";
	}
	
	@ResponseBody
	@RequestMapping("insertReReply.fd")
	public String ajaxInsertReReply(Reply reply) {
		return feedService.insertReReply(reply) > 0 ? "success" : "fail";
	}
	
	@ResponseBody
	@RequestMapping("updateReply.fd")
	public String ajaxUpdateReply(Reply reply) {
		return feedService.updateReply(reply) > 0 ? "success" : "fail";
	}
	
	@ResponseBody
	@RequestMapping("deleteReply.fd")
	public String ajaxDeleteReply(Reply reply) {
		
		int replyNo = reply.getReplyNo();
		int rgroup = reply.getRgroup();
		
		boolean isReplyWithRereply = feedService.checkHasRereply(replyNo);
		// 답글이 달린 댓글인 경우
		if(isReplyWithRereply) {
			// 댓글 내용 삭제 (STATUS는 그대로 Y)
			return feedService.deleteReplyContent(replyNo) > 0 ? "deleteContent" : "fail";
		// 답글 없는 댓글인 경우 (답글도 해당)
		} else {
			// 삭제된 댓글에 달린 댓글(답글)인 경우 + 답글이 마지막 남은 1개일 경우
			if(feedService.isSingleRereplyNdeleteReply(rgroup)) {
				// 댓글과 답글 모두 삭제 (STATUS 모두 N으로)
				return feedService.deleteTwoReply(rgroup) > 0 ? "deleteTwoReply" : "fail";
			}
			// 위의 모든 경우에 해당하지 않으면 해당 댓글만 삭제 (STATUS N)
			return feedService.deleteReply(replyNo) > 0 ? "deleteReply" : "fail";
		}
	}
	
	@ResponseBody
	@RequestMapping("countReply.fd")
	public int ajaxCountReply(int boardNo) {
		return feedService.countReply(boardNo);
	}
	
}
