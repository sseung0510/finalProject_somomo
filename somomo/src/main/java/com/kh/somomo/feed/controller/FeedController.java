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

import com.kh.somomo.common.model.vo.Attachment;
import com.kh.somomo.common.model.vo.Likes;
import com.kh.somomo.common.model.vo.PageInfo;
import com.kh.somomo.common.template.FileRename;
import com.kh.somomo.common.template.Pagination;
import com.kh.somomo.common.template.Time;
import com.kh.somomo.feed.model.service.FeedService;
import com.kh.somomo.feed.model.vo.FeedBoard;

@Controller
public class FeedController {
	
	@Autowired
	private FeedService feedService;
	
	@RequestMapping("main.fd")
	public ModelAndView selectFeedList(@RequestParam(value="cpage", defaultValue="1") int currentPage,
			                           ModelAndView mv) throws ParseException {
		
		PageInfo pi = Pagination.getPageInfo(feedService.selectFeedListCount(), currentPage, 10, 5); // 페이징처리
		
		mv.addObject("pi", pi)
		  .addObject("rList", feedService.selectRegionList()) // 지역 카테고리 목록 가져오기
		  .setViewName("feed/mainFeed");
		
		return mv;
	}
	
	@RequestMapping(value="list.fd")
	public String ajaxSelectFeedList(@RequestParam(value="cpage", defaultValue="1") int currentPage,
	 		 						 String userId, Model model) throws ParseException {
		
		PageInfo pi = Pagination.getPageInfo(feedService.selectFeedListCount(), currentPage, 10, 5); // 페이징처리
		
		ArrayList<FeedBoard> fList = feedService.selectFeedList(pi, userId); // 사용자의 피드 목록 가져오기
		for(FeedBoard fb : fList) {
			
			fb.setBoardDate(Time.getDiffTime(fb.getBoardDate())); // 지난 날짜 설정
			
			if(fb.getBoardType().equals("M")) { // 모임글일 경우
				setMeetCondition(fb); // 모집조건 텍스트 설정
			}
		}
		
		ArrayList<Attachment> fatList = new ArrayList<>();
		if(!fList.isEmpty()) {
			HashMap<String, Integer> boardRange = new HashMap<>();
			boardRange.put("min", fList.get(fList.size()-1).getBoardNo()); // 첫번 째 글번호
			boardRange.put("max", fList.get(0).getBoardNo()); // 마지막 글번호
			
			//System.out.println(boardRange.get("min"));
			//System.out.println(boardRange.get("max"));
			//System.out.println(feedService.selectFeedAttachmentList(boardRange));
			fatList = feedService.selectFeedAttachmentList(boardRange);
		}
			
		model.addAttribute("fList", fList)
			 .addAttribute("fatList", fatList);
		
		return "feed/ajaxFeedList";
	}
	
	// 모집조건 텍스트 설정 (모집성별 + 모집나이)
	public void setMeetCondition(FeedBoard fb) {
		
		String condition = null;
		
		// 모집나이, 모집성별 모두 제한 없을 경우
		if(fb.getMeetAge().equals("A") && fb.getMeetGender().equals("A")) {
			fb.setMeetCondition("누구나 참여 가능");
			return;
		}
		
		// 모집나이 문구 설정
		if(fb.getMeetAge().equals("A")) condition = "나이 제한 없음 | ";
		else condition = fb.getMeetAge() + "세 | ";
		
		// 모집성별 문구 설정
		if(fb.getMeetGender().equals("A")) condition += "성별제한 없음";
		else if(fb.getMeetGender().equals("F")) condition += "여성만";
		else condition += "남성만";
		
		fb.setMeetCondition(condition);
	}
	
	@RequestMapping("insert.fd")
	public String enrollForm(FeedBoard fb, MultipartHttpServletRequest mtfRequest, HttpSession session, Model model) {
		
		int result = 0;
		
		// 일반글일 경우 (General)
		if(fb.getBoardType().equals("G")) { 
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

			result = feedService.insertGeneralBoard(fb, fatList);
			
		// 모임모집글일 경우 (Meet)
		} else { 
			fb.setMeetDate(fb.getMeetDate().replace("T", " ")); // 2022-08-05T15:33에서 T를 공백으로 대체
			
			if(fb.getMeetAge().equals("selectAge")) { // 모집나이 직접 입력했을 시
				fb.setMeetAge(fb.getMinAge() + "~" + fb.getMaxAge()); // 20~30 형태로 저장
			}
			
			result = feedService.insertMeetBoard(fb);
		}
		
		if(result > 0) {
			return "redirect:main.fd";
		} else {
			model.addAttribute("errorMsg", "게시글 작성 실패");
			return "common/errorPage";
		}
	}
	
	@RequestMapping("detail.fd")
	public ModelAndView selectFeedBoard(int bno, ModelAndView mv) {
		
		int result = feedService.increaseCount(bno); // 조회수 증가
		
		if(result > 0) {
			FeedBoard fb = new FeedBoard();
			String bType = feedService.selectBoardType(bno); // 게시글 타입(G/M) 받아오기
			
			// 일반글일 경우
			if(bType.equals("G")) { 
				fb = feedService.selectGeneralBoard(bno);
				mv.addObject("fb", fb).setViewName("feed/feedGeneralDetailView");
				
			// 모임모집글일 경우
			} else { 
				fb = feedService.selectMeetBoard(bno);
				setMeetCondition(fb); // 모집조건 텍스트 설정
				mv.addObject("fb", fb).setViewName("feed/feedMeetDetailView");
			}
			
		} else {
			mv.addObject("errorMsg", "상세조회 실패").setViewName("common/errorPage");
		}
		
		return mv;
	}
	
	@RequestMapping("delete.fd")
	public String deleteFeedBoard(int boardNo, HttpSession session, Model model) {
		
		
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
			session.setAttribute("alertMsg", "게시글 삭제 성공");
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
}
