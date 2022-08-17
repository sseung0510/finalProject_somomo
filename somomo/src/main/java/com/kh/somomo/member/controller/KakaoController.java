package com.kh.somomo.member.controller;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.kh.somomo.member.model.service.MemberService;
import com.kh.somomo.member.model.vo.Member;

@Controller
public class KakaoController {

	@Autowired
	private MemberService memberService;
	
	private static final String REST_API_KEY = ""; // 등록 필요
	private static final String REDIRECT_URI = "http://localhost:8888/somomo/kakaoLogin.do";
	
	@RequestMapping(value = "getKakaoAuthUrl.do")
	public @ResponseBody String getKakaoAuthUrl(HttpServletRequest request) throws Exception {
		
		// API서버로 요청하는 url 만들기
		String url = "https://kauth.kakao.com/oauth/authorize";
			   url += "?client_id=" + REST_API_KEY; // 앱 REST API 키
			   url += "&redirect_uri=" + REDIRECT_URI; // 인가 코드가 리다이렉트될 uri
			   url += "&response_type=code"; // code로 고정
		
		return url;
	}
	
	// 카카오 로그인
	@RequestMapping(value = "kakaoLogin.do")
	public String oauthKakao(@RequestParam(value = "code", required = false) String code, HttpSession session, Model model) throws Exception {

		System.out.println("authorize_code : " + code);
        String access_token = getAccessToken(code); // 토큰 발급
        
        Member kakaoUser = getUserInfo(access_token); // 토큰 이용하여 사용자 정보 조회
        System.out.println("유저 정보:" + kakaoUser);

        int result = memberService.idCheck(kakaoUser.getUserId()); // 가입된 유저인지 확인
       
        if(result > 0) {  // 이미 가입된 유저일 경우 : 바로 로그인 => 메인피드로 이동
        	session.setAttribute("loginUser", memberService.loginMember(kakaoUser));
        	return "redirect:main.fd";
        } else { // 추가 정보 입력을 위해 회원가입 진행
        	model.addAttribute("kakaoUser", kakaoUser);
        	return "member/kakaoEnrollForm";
        }
        
	}
	
    // 카카오 유저 정보 요청을 위한 토큰 발급
	public String getAccessToken (String authorize_code) throws IOException {
		
		String url = "https://kauth.kakao.com/oauth/token";
        String access_token = ""; // 사용자 정보 요청을 위한 토큰 (유효기간 지나면 해당 토큰 사용 불가)
        String refresh_token = ""; // accessToken 유효기간 만료 시, 새로운 토큰 발급을 위해 필요한 토큰 (유효기간 있음, accessToken 보다는 긺)

    	// 요청하고자하는 url을 전달하면서 java.net.URL 객체 생성
        URL requestUrl = new URL(url);
        // 위에서 생성된 URL객체 가지고 HttpURLConnection객체 생성
        HttpURLConnection urlConnection = (HttpURLConnection) requestUrl.openConnection();

        urlConnection.setRequestMethod("POST");
        urlConnection.setDoOutput(true); // POST 요청을 하려면 setDoOutput을 true로 설정해야함 (setDoOutput의 기본값은 false)
        
        // POST 요청에 필요로 하는 파라미터 전송
        BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(urlConnection.getOutputStream()));
        StringBuilder sb = new StringBuilder();
        sb.append("grant_type=authorization_code");
        sb.append("&client_id=" + REST_API_KEY);
        sb.append("&redirect_uri=" + REDIRECT_URI);
        sb.append("&code=" + authorize_code);
        bw.write(sb.toString());
        bw.flush();
        
        // 결과 코드 200 : 성공
        int responseCode = urlConnection.getResponseCode();
        System.out.println("responseCode : " + responseCode);

        // 해당 API서버로 요청을 보낸 후 입력데이터로 읽어오기 (JSON타입의 Response 메시지)
        BufferedReader br = new BufferedReader(new InputStreamReader(urlConnection.getInputStream()));
        
        String responseText = "";
        String line = "";
        while ((line = br.readLine()) != null) {
        	responseText += line;
        }
        System.out.println("responseText: " + responseText);
        /*
         	// Sample
            {
        	    "token_type":"bearer",
			    "access_token":"${ACCESS_TOKEN}",
			    "expires_in":43199,
			    "refresh_token":"${REFRESH_TOKEN}",
			    "refresh_token_expires_in":25184000,
			    "scope":"account_email profile_image profile_nickname"
            }
        */
        
        
        // JsonObject 이용해서 파싱 => GSON에서 제공 (2.8.6이상)
        JsonObject responseObj = JsonParser.parseString(responseText).getAsJsonObject();
        
        access_token = responseObj.getAsJsonObject().get("access_token").getAsString();
        refresh_token = responseObj.getAsJsonObject().get("refresh_token").getAsString();
        System.out.println("access_token : " + access_token);
        System.out.println("refresh_token : " + refresh_token);

        br.close();
        bw.close();
        urlConnection.disconnect();

        return access_token;
    }
	
    // 카카오 유저 정보 받아오기
    public Member getUserInfo (String access_token) throws IOException {

    	String url = "https://kapi.kakao.com/v2/user/me";
        
        URL requestUrl = new URL(url);
        HttpURLConnection urlConnection = (HttpURLConnection) requestUrl.openConnection();
        urlConnection.setRequestMethod("GET");

        // 요청에 필요한 Header설정하기 (Authorization: Bearer {ACCESS_TOKEN} !!Bearer 뒤에 공백 필요!!)
        urlConnection.setRequestProperty("Authorization", "Bearer " + access_token);

        // 결과 코드 200 : 성공
        int responseCode = urlConnection.getResponseCode();
        System.out.println("responseCode : " + responseCode);

        BufferedReader br = new BufferedReader(new InputStreamReader(urlConnection.getInputStream()));

        String responseText = "";
        String line = "";
        while ((line = br.readLine()) != null) {
        	responseText += line;
        }
        System.out.println("responseText: " + responseText);

        JsonObject responseObj = JsonParser.parseString(responseText).getAsJsonObject();
        JsonObject kakao_account = responseObj.getAsJsonObject("kakao_account");
        JsonObject properties = responseObj.getAsJsonObject("properties");

        String userId = responseObj.get("id").getAsString();
        String email = kakao_account.getAsJsonObject().get("email").getAsString();
        String nickname = properties.getAsJsonObject().get("nickname").getAsString();
        String profileImg = properties.getAsJsonObject().get("profile_image").getAsString();
        
        // 사용자 정보 설정
        Member userInfo = new Member();
        userInfo.setUserId(userId); // 아이디
        userInfo.setEmail(email); // 이메일
        userInfo.setNickname(nickname); // 닉네임
        userInfo.setProfileImg(profileImg); // 프로필사진

        return userInfo;
    }

	@RequestMapping("insertKakao.me")
	public String insertKakaoMember(Member m, Model model, HttpSession session) {

		int result = memberService.insertKakaoMember(m);
		
		if(result > 0) { 
			session.setAttribute("alertMsg", "성공적으로 회원가입이 되었습니다");
			return "redirect:/";
		} else {
			model.addAttribute("errorMsg", "회원가입 실패");
			return "common/errorPage";
		}
	}
 }
