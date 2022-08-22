package com.kh.somomo.member.controller;

import static com.kh.somomo.common.template.FileRename.saveFile;

import java.io.File;
import java.util.HashMap;
import java.util.Random;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
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
	
	
	// 로그인
	@RequestMapping("login.me")
	public ModelAndView loginMember(Member m, HttpSession session, ModelAndView mv) {
		
		Member loginUser = memberService.loginMember(m); // 정보가 일치하는 회원찾기
		if(loginUser != null && bcryptPasswordEncoder.matches(m.getUserPwd(), loginUser.getUserPwd())) { // 로그인유저가 널이아니고, 암호화된 비밀번호가 일치하면 로그인 성공
			session.setAttribute("loginUser", loginUser);
			mv.setViewName("redirect:main.fd");
			session.setAttribute("alertMsg", "로그인성공");

		} else {
			mv.addObject("alertMsg", "가입되지 않은 회원이거나 탈퇴한 회원입니다");
			mv.setViewName("member/login");
		}
		return mv;
	}
	
	// 로그아웃
	@RequestMapping("logout.me")
	public String logoutMember(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
	
	// 회원가입 폼으로 이동
	@RequestMapping("enrollForm.me")
	public String memberEnrollForm() {
		return "member/memberEnrollForm";
	}
	
	// 회원가입
	@RequestMapping("insert.me")
	public String insertMember(Member m, Model model, HttpSession session) {

		String encPwd = bcryptPasswordEncoder.encode(m.getUserPwd()); // 받아오는 비밀번호 인코딩
		
		m.setUserPwd(encPwd); // 멤버객체에 인코딩된 비밀번호 셋팅
		
		int result = memberService.insertMember(m); // 회원가입에 성공하면 result값 1
		
		if(result>0) {  // 회원가입 성공할 경우
			session.setAttribute("alertMsg", "성공적으로 회원가입이 되었습니다");
			return "redirect:/";
		} else { // 회원가입 실패할 경우
			model.addAttribute("alertMsg", "회원가입에 실패했습니다. 다시 진행해주세요");
			return "member/memberEnrollForm";
		}
	}
	
	//회원가입(아이디중복체크)
	@ResponseBody
	@RequestMapping("idCheck.me")
	public String idCheck(String checkId) {
		return memberService.idCheck(checkId) > 0 ? "NNNNN" : "NNNNY"; // 중복되는 아이디가 있으면 NNNNN으로 반환
	}
	
	// 회원가입(닉네임중복체크)
	@ResponseBody
	@RequestMapping(value="nickNameCheck.me")
	public String NickNameCheck(String checkNickName) {
		System.out.println(checkNickName);
		return memberService.NickNameCheck(checkNickName) > 0 ? "NNNNN" : "NNNNY"; // 중복되는 닉네임이 있으면 NNNNN으로 반환
		
	}
	
	// 마이페이지로 이동
	@RequestMapping("myPage.me")
	public String myPage() {
		return "member/myPage";
	}
	
	// 정보변경 페이지로 이동
	@RequestMapping("updateInfo.me")
	public String myPageInfo() {
		return "member/myPageUpdate";
	}
	
	
	// 정보변경
	@RequestMapping("update.me")
	public String updateMember(Member m, String userPwd, MultipartFile upfile,HttpSession session, Model model, RedirectAttributes rttr) {
		String iskakaoLogin=((Member)session.getAttribute("loginUser")).getKakaoLogin();
		System.out.println(m);
		if(iskakaoLogin.equals("Y")) { // 카카오 로그인인 경우
			if(!upfile.getOriginalFilename().equals("")) { // 오리지날파일네임이 빈문자열이 아닐 경우
				System.out.println(m.getProfileImg());
				if(m.getProfileImg()!=null) { // 프로필 이미지가 널이 아닐경우
					
					if(session.getServletContext().getRealPath(m.getProfileImg()) != null ) {
						//File ('http://k.kakaocdn.net/dn/dpk9l1/btqmGhA2lKL/Oz0wDuJn1YV2DIn92f6DVK/img_640x640.jpg')
						new File(session.getServletContext().getRealPath(m.getProfileImg())).delete(); // 프로필 이미지를 삭제
					}					
				}
				HashMap<String, String> map = saveFile(upfile,session,"img/member/profile_img");
				m.setProfileImg(map.get("changeName"));
			}
			int result = memberService.updateMember(m); //정보수정이 성공하면 result == 1
			if(result>0) {// 업데이트에 성공했을 경우
				session.setAttribute("loginUser", memberService.loginMember(m));
				rttr.addFlashAttribute("alertMsg", "정보변경이 완료됐습니다.");
				return "redirect:updateInfo.me";
			}else {
				return "member/login";
			}
			
		} else { // 일반 회원일 경우
			
			String encPwd = ((Member)session.getAttribute("loginUser")).getUserPwd(); // 현재 로그인 된 유저의 비밀번호
			
			if(bcryptPasswordEncoder.matches(userPwd, encPwd)) { // 유저가 입력한 비밀번호와 DB상의 정보가 일치하는지 확인
				
				if(!upfile.getOriginalFilename().equals("")) { // 오리지날파일네임이 빈문자열이 아닐 경우
					if(m.getProfileImg()!=null) { // 프로필 이미지가 널이 아닐경우
						new File(session.getServletContext().getRealPath(m.getProfileImg())).delete(); // 프로필 이미지를 삭제
					}
					
					HashMap<String, String> map = saveFile(upfile,session,"img/member/profile_img");
					m.setProfileImg(map.get("changeName"));
				}
				
				int result = memberService.updateMember(m); //정보수정이 성공하면 result == 1
				if(result>0) {  // 업데이트에 성공했을 경우
					session.setAttribute("loginUser", memberService.loginMember(m));
					rttr.addFlashAttribute("alertMsg", "정보변경이 완료됐습니다.");
					return "redirect:updateInfo.me";
				}else {
					return "member/login";
				}
				
			}else {
				rttr.addFlashAttribute("alertMsg", "비밀번호가 틀렸습니다.");
				return "redirect:updateInfo.me";
			}
		}
	}
	
	// 비밀번호 변경폼으로 이동
	@RequestMapping("updatePwd.me")
	public String updatePwd() {
		return "member/myPagePassword";
	}

	// 비밀번호 변경
	@RequestMapping("updatePassword.me")
	public String pwdUpdate(Member m, String oldUserPwd,  HttpSession session, RedirectAttributes rttr) {
		
		String encPwd = ((Member)session.getAttribute("loginUser")).getUserPwd();
		if(bcryptPasswordEncoder.matches(oldUserPwd, encPwd)) {
			int result = memberService.oldUserPwd(m);
			if(result>0) {
				String encPwd1 = bcryptPasswordEncoder.encode(m.getUserPwd());
				m.setUserPwd(encPwd1);
				int result1 = memberService.updatePwd(m);
			}
			return "member/login";
		}else {
			rttr.addFlashAttribute("alertMsg", "현재 비밀번호가 일치하지 않습니다.");
			return "redirect:updatePwd.me";
		}
		
	}
	
	//회원탈퇴폼으로 이동
	@RequestMapping("deleteMem.me")
	public String deleteMember() {
		return "member/myPageDelete";
	}
	
	// 회원탈퇴
	@RequestMapping("delete.me")
	public String deleteMember(String userId, String userPwd, HttpSession session, RedirectAttributes rttr) {
		
		String iskakaoLogin=((Member)session.getAttribute("loginUser")).getKakaoLogin();
		if(iskakaoLogin.equals("Y")) { // 카카오 로그인인 경우
			int result = memberService.deleteKakaoUser(userId);
			if(result>0) {
				// 탈퇴처리 성공 => session에서 loginUser 지움, alert문구담기 => 메인페이지url요청
				session.removeAttribute("loginUser");
				return "redirect:/";
			}else {
				
				return "member/login";
			}
			
		}else {
			
			String encPwd = ((Member)session.getAttribute("loginUser")).getUserPwd();
			if(bcryptPasswordEncoder.matches(userPwd, encPwd)) {
				int result = memberService.deleteMember(userId);
				if(result>0) {
					// 탈퇴처리 성공 => session에서 loginUser 지움, alert문구담기 => 메인페이지url요청
					session.removeAttribute("loginUser");
					return "redirect:/";
				}else {
					
					return "member/login";
				}
			}else {
				rttr.addFlashAttribute("alertMsg", "비밀번호가 틀렸습니다.");
				return "redirect:deleteMem.me";
			}
		}
	}

	// 회원가입시 이메일 전송
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
	
	// 인증번호 체크
	@ResponseBody
	@RequestMapping("checkEmail.me")
	public String checkEmail(String secret, HttpServletRequest request) {
		boolean result = memberService.validate(CertVo.builder()
									  .who(request.getRemoteAddr())
									  .secret(secret)
									  .build());
		return result == true ? "NNNNY" : "NNNNN";
	}
	
	// 아이디/비밀번호찾기 폼으로 이동
	@RequestMapping("searchMem.me")
	public String seachMem() {
		return "member/searchId_pwd";
	}
	
	// 아이디 찾기
	@ResponseBody
	@RequestMapping("searchId.me")
	public String searchId(Member m, HttpServletRequest request) throws MessagingException {
		
		Member searchId = memberService.searchId(m);
		
		//System.out.println(searchId);
		MimeMessage message = sender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");		
		
		helper.setTo(m.getEmail());
		helper.setSubject("소모모 ");
		helper.setText("아이디 찾기 : " + searchId.getUserId());
		
		sender.send(message);
		
		String search = searchId.getUserId();
		
		return search;
	}
	
	// 비밀번호 찾기
	@ResponseBody
	@RequestMapping("searchPwd.me")
	public String searchPwd(Member m, HttpServletRequest request) throws MessagingException {
		
		
		int searchPwd = memberService.searchPwd(m);
		//System.out.println(searchPwd);
		if(searchPwd>0) {
			String memberkey = this.randomCode();
			String memberPw = BCrypt.hashpw(memberkey,BCrypt.gensalt());
			//System.out.println(memberkey);
			//System.out.println(memberPw);
				HashMap<String, Object> map = new HashMap<String, Object>();
				map.put("m", m);
				map.put("memberPw", memberPw);
			//System.out.println(map);
			int changeUpPwd = memberService.changeUpPwd(map);
			
			if(changeUpPwd > 0) {
				
				MimeMessage message = sender.createMimeMessage();
				MimeMessageHelper helper = new MimeMessageHelper(message, false, "UTF-8");		
				
				helper.setTo(m.getEmail());
				helper.setSubject("소모모의 임시 비밀번호 입니다");
				helper.setText("<h1>임시 비밀번호 발급</h1>"
							   +"<br/>"+m.getUserId()+"님"
							   +"<br/>비밀번호 찾기를 통한 임시 비밀번호입니다."
							   +"<br/>임시비밀번호 : "+ memberkey
							   +"<br/>반드시 로그인 후 비밀번호 변경을 해주세요."
							   +"<a href='http://localhost:8888/spring'>"
							   +"소모모 로그인 페이지</a>", true);
				
				sender.send(message);
			}
			
		}
		return searchPwd > 0 ? "Y" : "N";
	}
	
	// 랜덤값으로 나오는 임시비밀번호
	public String randomCode() {
		 int leftLimit = 48; // numeral '0'
		    int rightLimit = 122; // letter 'z'
		    int targetStringLength = 10;
		    Random random = new Random();
		    String generatedString = random.ints(leftLimit, rightLimit + 1)
		                                   .filter(i -> (i <= 57 || i >= 65) && (i <= 90 || i >= 97))
		                                   .limit(targetStringLength)
		                                   .collect(StringBuilder::new, StringBuilder::appendCodePoint, StringBuilder::append)
		                                   .toString();
		    
		    return generatedString;
	}

	// 내가 누른 좋아요 리스트 불러오기
	@ResponseBody
	@RequestMapping(value="likeList.me", produces="application/json; charset=UTF-8")
	public String likeList(String userId) {
		
		//System.out.println(memberService.likeList(userId));
		return new Gson().toJson(memberService.likeList(userId));
		
		
	}
	
	// 내가 누른 즐겨찾기 리스트 불러오기
	@ResponseBody
	@RequestMapping(value="favoriteList.me", produces="application/json; charset=UTF-8")
	public String favoriteList(String userId) {
		
		return new Gson().toJson(memberService.favoriteList(userId));
		
		
	}
	
	@ResponseBody
	@RequestMapping("UnlikeY.me")
	public String unlikeY(String boardNo, String userId) {
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("boardNo", boardNo);
		map.put("userId", userId);
		
		return memberService.deleteLikeY(map) > 0 ? "success" : "fail";
	}

	
	
	
	
	
	
	
	
}
