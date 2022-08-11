package com.kh.somomo.member.controller;

import static com.kh.somomo.common.template.FileRename.saveFile;

import java.io.File;
import java.util.HashMap;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.somomo.member.model.service.MemberService;
import com.kh.somomo.member.model.vo.CertVo;
import com.kh.somomo.member.model.vo.Member;

@Controller
public class MemberController {

	@Autowired
	private MemberService memberService;
	
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	@Autowired
	private JavaMailSender sender;
	
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
			session.setAttribute("alertMsg", "로그인성공");

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
	/*
	@ResponseBody
	@RequestMapping(value = "phoneCheck", method = RequestMethod.GET)
	public String sendSMS(@RequestParam("phone") String userPhoneNumber) { // 휴대폰 문자보내기
		int randomNumber = (int)((Math.random()* (9999 - 1000 + 1)) + 1000);//난수 생성

		memberService.certifiedPhoneNumber(userPhoneNumber,randomNumber);
		
		return Integer.toString(randomNumber);
	}
	*/
	
	@RequestMapping("myPage.me")
	public ModelAndView myPage(String userId, ModelAndView mv) {
		
		mv.addObject("list", memberService.selectMyPage(userId)).setViewName("member/myPageUpdate");
		return mv;
	}
	
	@RequestMapping("update.me")
	public String updateMember(Member m, String userPwd, MultipartFile upfile,HttpSession session, Model model) {
		
		String encPwd = ((Member)session.getAttribute("loginUser")).getUserPwd();
		
		if(bcryptPasswordEncoder.matches(userPwd, encPwd)) {
			
			if(!upfile.getOriginalFilename().equals("")) {
				if(m.getProfileImg()!=null) {
					new File(session.getServletContext().getRealPath(m.getProfileImg())).delete();
				}
				
				HashMap<String, String> map = saveFile(upfile,session,"img/member/profile_img");
				m.setProfileImg(map.get("changeName"));
			}
			
			int result = memberService.updateMember(m);
			//System.out.println(m);
			if(result>0) {
				session.setAttribute("loginUser", memberService.loginMember(m));
				return "member/myPageUpdate";
			}else {
				
				return "member/login";
			}
		}else {
			session.setAttribute("errorMsg", "회원탈퇴에 실패했습니다");
			return "main";
		}
		
	}
	
	@RequestMapping("updatePwd.me")
	public ModelAndView updatePwd(String userId, ModelAndView mv) {
		
		mv.addObject("list", memberService.selectMyPage(userId)).setViewName("member/myPagePassword");
		return mv;
	}

	@RequestMapping("deleteMem.me")
	public ModelAndView deleteMember(String userId, ModelAndView mv) {
		
		mv.addObject("list", memberService.selectMyPage(userId)).setViewName("member/myPageDelete");
		return mv;
	}
	
	@RequestMapping("delete.me")
	public String deleteMember(String userId, String userPwd, HttpSession session) {
		
		String encPwd = ((Member)session.getAttribute("loginUser")).getUserPwd();
		if(bcryptPasswordEncoder.matches(userPwd, encPwd)) {
			int result = memberService.deleteMember(userId);
			if(result>0) {
				// 탈퇴처리 성공 => session에서 loginUser 지움, alert문구담기 => 메인페이지url요청
				session.removeAttribute("loginUser");
				session.setAttribute("alertMsg", "잘가가가가");
				return "redirect:/";
			}else {
				
				return "member/login";
			}
		}else {
			session.setAttribute("errorMsg", "회원탈퇴에 실패했습니다");
			return "main";
		}
		
	}

	@RequestMapping("updatePassword.me")
	public String pwdUpdate(Member m, String oldUserPwd, HttpSession session, Model model) {
		
		String encPwd = ((Member)session.getAttribute("loginUser")).getUserPwd();
		if(bcryptPasswordEncoder.matches(oldUserPwd, encPwd)) {
			int result = memberService.oldUserPwd(m);
			System.out.println(result);
			if(result>0) {
				String encPwd1 = bcryptPasswordEncoder.encode(m.getUserPwd());
				m.setUserPwd(encPwd1);
				int result1 = memberService.updatePwd(m);
				System.out.println(m);
			}
		}
		
		
		return "member/login";
	}

	@ResponseBody
	@RequestMapping("sendEmail.me")
	public String sendEmail(String email, HttpServletRequest request) throws MessagingException {
		
		String ip = request.getRemoteAddr();
		//System.out.println(ip);
		String secret = memberService.sendEmail(ip);
		//System.out.println(secret);
		MimeMessage message = sender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");		
		
		helper.setTo(email);
		helper.setSubject("소모모 ");
		helper.setText("인증번호:" + secret);
		//System.out.println(message);
		sender.send(message);
		String num = secret;
		
		return num;
		
	}
	
	@ResponseBody
	@RequestMapping("checkEmail.me")
	public String checkEmail(String secret, HttpServletRequest request) {
		boolean result = memberService.validate(CertVo.builder()
									  .who(request.getRemoteAddr())
									  .secret(secret)
									  .build());
		//System.out.println(result);
		//System.out.println(secret);
		return result == true ? "NNNNY" : "NNNNN";
	}
	
	@RequestMapping("searchMem.me")
	public String seachMem() {
		return "member/searchId_pwd";
	}
	
	
	
	
	

}
