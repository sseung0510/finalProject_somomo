<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
   	<link rel="stylesheet" href="resources/css/login.css?ver=1.1.5">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="https://kit.fontawesome.com/567fbbaed5.js" crossorigin="anonymous"></script>
<title>로그인</title>
</head>


<style>

		.container {
		    height: 100vh;
		    display: flex;
		    flex-direction: column;
		}
		
		.main-container {
		    display: flex;
		    flex-grow: 1;
		}
		
		.main-content {
		    margin: 32px auto;
		    display: flex;
		    align-items: center;
		    justify-content: center;
		    max-width: 935px;
		    flex-grow: 1;
		}
		
		.slide-container {
		    height: 570px;
    		width: 480px;
		    background-image: url(resources/img/main-frame.png);
		    background-size: cover;
		    background-position: center;
		    
		}
		
		.slide-content {
		    margin: 99px 0 0 151px;
		    position: relative;
		}
		
		.slide-content img {
		    position: absolute;
		    right: 22px;
		    top: -68px;
		    height: 517px;
		    opacity: 0;
		    visibility: hidden;
		    transition: all 0.5s ease-in-out;
		}
		
		.slide-content img.active {
		    opacity: 1;
		    visibility: visible;
		}



</style>
<body>
   	<div class="cover">
        <main>
            <div class="container">
			        <div class="main-container">
			            <div class="main-content">
			                <div class="slide-container" >
			                    <div class="slide-content" id="slide-content">
			                        <img src="resources/img/somomo-main.png" alt="slide image" class="active">
			                        <img src="resources/img/somomo-main2.png" alt="slide image">
			                    </div>
			                </div>
			            </div>
			        </div>
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
                            <input type="checkbox" name="saveId" id="rememberId"> <label id="memberId">아이디 저장</label>
                        </form>
                        
                        <div class="vertical-line">
                            <div class="line"></div>
                            <div class="line-text">또는</div>
                            <div class="line"></div>
                        </div>
    
                        <div class="kakao-login">
                            <button onclick="kakaoLogin();">
                                <i class="fa-solid fa-comment"></i>
                                <span>카카오 로그인</span>
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
		  
		  
	        /*쿠키값저장코드*/   
	        function setCookie(cookieName, value, exdays){
	            var exdate = new Date();
	            exdate.setDate(exdate.getDate() + exdays);
	            var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toGMTString());
	            document.cookie = cookieName + "=" + cookieValue;
	        }
	        // 쿠키값 삭제
	        function deleteCookie(cookieName){
	            var expireDate = new Date();
	            expireDate.setDate(expireDate.getDate() - 1);
	            document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
	        }
	        // 쿠키값 가져오기
	        function getCookie(cookieName) {
	            cookieName = cookieName + '=';
	            var cookieData = document.cookie;
	            var start = cookieData.indexOf(cookieName);
	            var cookieValue = '';
	            if(start != -1){
	                start += cookieName.length;
	                var end = cookieData.indexOf(';', start);
	                if(end == -1)end = cookieData.length;
	                cookieValue = cookieData.substring(start, end);
	            }
	            return unescape(cookieValue);
	        }

	        var userId = getCookie("userId"); // 저장된 쿠키값 가져오기
	        $("input[name='userId']").val(userId); // 저장된 쿠키값을 가져와서 input 태그에 넣어준다.
	        
	        if($("input[name='userId']").val() != ""){ // 페이지를 로드했을때 아이디 입력창이 비어있지 않으면
	            $("#rememberId").attr("checked", true); // 체크박스를 체크된 상태로 두기
	        }
	        
	        $("#rememberId").change(function(){ // 체크박스에 변화가 있다면 (체크 / 체크해지)
	            if($("#rememberId").is(":checked")){ // 체크박스가 체크되면
	                var userId = $("input[name='userId']").val(); // userId 변수에 입력값을 넣고
	                setCookie("userId", userId, 7); // 그 입력값을 7일동안 쿠키 보관
	            }else{ 
	                deleteCookie("userId"); // 체크해지시 쿠키삭제
	            }
	        });
	        
	        $("input[name='userId']").keyup(function(){ // 아이디를 입력할 때
	            if($("#rememberId").is(":checked")){ // 체크박스가 체크되어있으면
	                var userId = $("input[name='userId']").val(); // 입력값을 
	                setCookie("userId", userId, 7); // 7일동안 보관
	            }
	        });
	        
	        
	        
	        // 모바일 슬라이드 JS
	        let slide_content = document.querySelector('#slide-content')

			let slide_index = 0
			
			slide = () => {
			    let slide_items = slide_content.querySelectorAll('img')
			    slide_items.forEach(e => e.classList.remove('active'))
			    slide_index = slide_index + 1 === slide_items.length ? 0 : slide_index + 1
			    slide_items[slide_index].classList.add('active')
			}
			
			setInterval(slide, 2000)


	</script>
</body>
</html>