<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
   	<link rel="stylesheet" href="resources/css/login.css?ver=1.1.4">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="https://kit.fontawesome.com/567fbbaed5.js" crossorigin="anonymous"></script>
<title>로그인</title>
</head>
<body>
   	<div class="cover">
        <main>
            <div class="content">
                <img id="sample" src="https://www.instagram.com/static/images/homepage/screenshots/screenshot1-2x.png/cfd999368de3.png" alt="">
            </div>

            <div class="content">
                <div class="content-col">
                    <div class="form">
                        <div class="logo-area">
                            <div class="logo-title">
                                <span>SOMOMO</span>
                            </div>
                        </div>
                            
                        <form action="login.me" method="post">
                            <div class="normalLogin">
                                    <input type="text" class="form-control" id="userId" placeholder="Please Enter ID" name="userId" required>
                                    <input type="password" class="form-control" id="userPwd" placeholder="Please Enter Password" name="userPwd" required>
                                    <button class="loginBtn">로그인</button>
                            </div>
                        </form>
                        
                        <div class="vertical-line">
                            <div class="line"></div>
                            <div class="line-text">또는</div>
                            <div class="line"></div>
                        </div>
    
                        <div class="kakao-login">
                            <button onclick="kakaoLogin();">
                                <i class="fa-solid fa-comment"></i>
                                <span>카카오 회원가입</span>
                                <i class="fa-solid fa-arrow-right-long"></i>
                            </button>
                        </div>
                        
                        <div class="find-account">
                            <a href="searchMem.me" class="searchMem">로그인/비밀번호 찾기</a>
                        </div>
                        
                    </div>
                </div>
                
                <br><br>
                <div class="content-col">
                    <div class="enrollForm">
                        <a href="enrollForm.me">계정이 없으신가요? 가입하기</a>
                    </div>
                </div>
            </div>
        </main>

        <aside>
            <ul>
                <li>김유진</li>
                <li>민경태</li>
                <li>유형두</li>
                <li>윤자원</li>
                <li>조한울</li>
                <li>최승희</li>
            </ul>
            <span>이름은 지워도 됨요 ^.^</span>
        </aside>
    </div>
    
    <script>
		  function kakaoLogin() {
			    $.ajax({
			        url: 'getKakaoAuthUrl.do',
			        type: 'get',
			        async: false,
			        dataType: 'text',
			        success: function (url) {
			            location.href = url;
			        }
			    });

			  }
		  
		  var msg='${alertMsg}'
			if(msg==='가입되지 않은 회원이거나 탈퇴한 회원입니다'){
				
				setTimeout(function() {
					alert("가입되지 않은 회원이거나 탈퇴한 회원입니다.");
				}, 100);
			}
	</script>
</body>
</html>