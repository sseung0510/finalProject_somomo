<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<style>
	body{
		width : 100%;
		height : 100%;
		background-color : #f3f6fd;
		position : relative;
	}

	.form{
		background-color : white;
		border : 1px solid lightgrey; 
		height : 500px;
		width : 400px;
		position:absolute;
		left:50%;
    	top:50%;
    	margin-left:-200px;
    	margin-top:150px;
	}
	.logo-image img{
    	display: flex;
    	justify-content: center;
	    height:50px;
	    width:50px;
	}
	.logo_name{
		font-size: 22px;
	    font-weight: 600;
	    color: var(--text-color);
	    margin-left: 14px;
	}
	.normalLogin input{
		width:350px;
		height:30px;
		margin-bottom:10px;
	}
	.loginBtn {
		width:358px;
		height:40px;
		background-color:#FCD9D7;
		border:1px solid #FEC8C6;
		border-radius:5px;
	}
	.loginBtn:hover{
		background-color:#FEC8C6;
	}
	.hr-sect{
		display: flex;
        flex-basis: 100%;
        align-items: center;
        color: rgba(0, 0, 0, 0.35);
        font-size: 18px;
        margin: 8px 0px;
	}
	.hr-sect::before, .hr-sect::after {
        content: "";
        flex-grow: 1;
        background: rgba(0, 0, 0, 0.35);
        height: 1px;
        font-size: 0px;
        line-height: 0px;
        margin: 0px 16px;
      }
     .searchMem{
     	margin-left:223px;
     	text-decoration:none;
     	color:black;
     }
     .enrollForm{
     	background-color : white;
		border : 1px solid lightgrey; 
		height : 100px;
		width : 400px;
		position:absolute;
		left:50%;
    	top:50%;
    	margin-left:-200px;
    	margin-top:665px;
    	display: flex;
		align-items: center;
     }
     .enrollForm a{
     	margin-left:100px;
     	text-decoration:none;
     	color:black;
     }
     .kakaoBtn img{
     	height:45px;
     	width:358px;
     	margin-left: 23px;
     	margin-top:15px;
     }
      .logo-name{
        display: flex;
        align-items: center;
        margin-top:10px;
    }
</style>
</head>
<body>

	<div class="form">
		
		<div class="logo-name">
            <div class="logo-image">
                <img src="${pageContext.request.contextPath}/resources/img/web_logo.jpg" alt="peach">
            </div>

            <span class="logo_name">SoMoMo</span>
        </div>
		
			
		<div class="normalLogin" style="position: relative; left: 22px; top: 50px;">
			<form action="login.me" method="post">
				<input type="text" class="form-control" id="userId" placeholder="Please Enter ID" name="userId" required> <br>
				<input type="password" class="form-control" id="userPwd" placeholder="Please Enter Password" name="userPwd" required> <br>
				<button class="loginBtn">로그인</button>
			</form>
		</div>
		<br><br><br>
		
		<a href="#" class="searchMem">로그인/비밀번호 찾기</a>
		
		
		
		<div class="hr-sect">또는</div>
		
		<div class="kakaoBtn">
			<img src="resources/img/kakao_loginBtn.png" alt="카카오" onclick="qwer();">
		</div>
		
		<script>
			function qwer(){
				console.log("야야");
			}
		</script>
	</div>
		
	<div class="enrollForm">
		<a href="enrollForm.me">계정이 없으신가요? 가입하기</a>
	</div>
	
	
	
	
	

</body>
</html>