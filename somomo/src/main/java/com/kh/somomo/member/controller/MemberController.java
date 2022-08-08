package com.kh.somomo.member.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.somomo.member.model.service.MemberService;
import com.kh.somomo.member.model.vo.Member;

@Controller
public class MemberController {

	@Autowired
	private MemberService memberService;
	
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	@RequestMapping("login.me")
	public ModelAndView loginMember(Member m, HttpSession session, ModelAndView mv) {
		
		/*
	      System.out.println(loginUser);
	      if(loginUser != null) {
	         session.setAttribute("loginUser", loginUser);
	         mv.setViewName("common/mainFeed");
	      }else {
	         mv.setViewName("member/memberenrollForm");
	      }
	      return mv;
	      */
		Member loginUser = memberService.loginMember(m);
		//System.out.println(loginUser);
		if(loginUser != null && bcryptPasswordEncoder.matches(m.getUserPwd(), loginUser.getUserPwd())) {
			session.setAttribute("loginUser", loginUser);
			mv.setViewName("redirect:main.fd");
		} else {
			mv.setViewName("member/memberEnrollForm");
		}
		return mv;
	}
	
	@RequestMapping("logout.me")
	public String logoutMember(HttpSession session) {
		session.invalidate();
		return "member/login";
	}
	
	@RequestMapping("enrollForm.me")
	public String memberEnrollForm() {
		return "member/memberEnrollForm";
	}
	
	@RequestMapping("insert.me")
	public String insertMember(Member m, Model model, HttpSession session) {

		String encPwd = bcryptPasswordEncoder.encode(m.getUserPwd());
		System.out.println(encPwd);
		
		m.setUserPwd(encPwd);
		
		int result = memberService.insertMember(m);
		
		if(result>0) { 
			session.setAttribute("alertMsg", "성공적으로 회원가입이 되었습니다");
			return "redirect:/";
		} else {
			return "main";
		}
	}
	@ResponseBody
	@RequestMapping(value="idCheck.me")
	public String idCheck(String checkId) {
		/*
		int result = memberService.idCheck(checkId);
		
		if(result>0) {// 이미 존재하는 아이디 => 사용 불가능(NNNNN)
			return "NNNNN";
		} else { // 사용가능(NNNNY)
			return "NNNNY";
		}
		*/
		//result >0 ? "true" : "false"
		return memberService.idCheck(checkId) > 0 ? "NNNNN" : "NNNNY";
		
	}
	
	@ResponseBody
	@RequestMapping(value="nickNameCheck.me")
	public String NickNameCheck(String checkNickName) {
		/*
		int result = memberService.idCheck(checkId);
		
		if(result>0) {// 이미 존재하는 아이디 => 사용 불가능(NNNNN)
			return "NNNNN";
		} else { // 사용가능(NNNNY)
			return "NNNNY";
		}
		*/
		//result >0 ? "true" : "false"
		return memberService.NickNameCheck(checkNickName) > 0 ? "NNNNN" : "NNNNY";
		
	}
	
	@ResponseBody
	@RequestMapping(value = "phoneCheck", method = RequestMethod.GET)
	public String sendSMS(@RequestParam("phone") String userPhoneNumber) { // 휴대폰 문자보내기
		int randomNumber = (int)((Math.random()* (9999 - 1000 + 1)) + 1000);//난수 생성

		memberService.certifiedPhoneNumber(userPhoneNumber,randomNumber);
		
		return Integer.toString(randomNumber);
	}
	
	
}
