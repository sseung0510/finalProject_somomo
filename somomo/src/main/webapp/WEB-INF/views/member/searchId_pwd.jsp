<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디/비밀번호 찾기</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script><!-- 스위트얼럿 -->
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
		height : 650px;
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
	    margin-left: 60px;
	}
	.searchIdForm input{
		width:350px;
		height:30px;
		margin-top:10px;
		border-radius:5px;
	}
	.searchPwdForm input{
		width:350px;
		height:30px;
		margin-top:10px;
		border-radius:5px;
	}
	.searchBtn{
		width:358px;
		height:40px;
		background-color:#FCD9D7;
		border:1px solid #FEC8C6;
		border-radius:5px;
		display:inline-block;
		text-align:center;
		line-height:40px;
		font-size:15px;
		cursor:pointer;
		margin-top:15px;
	}
	.searchPwdBtn{
		width:358px;
		height:40px;
		background-color:#FCD9D7;
		border:1px solid #FEC8C6;
		border-radius:5px;
		display:inline-block;
		text-align:center;
		line-height:40px;
		font-size:15px;
		cursor:pointer;
		margin-top:15px;
	}
	.toLogin{
		width:358px;
		height:40px;
		background-color:#FCD9D7;
		border:1px solid #FEC8C6;
		border-radius:5px;
		font-size:15px;
		margin-left:23px;
		margin-top:20px;
		cursor:pointer;
	}
	.searchPwdBtn:hover, .toLogin:hover, .searchBtn:hover{
		background-color:#FEC8C6;
	}
	.hr-sect{
		display: flex;
        flex-basis: 100%;
        align-items: center;
        color: rgba(0, 0, 0, 0.35);
        font-size: 18px;
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

            <span class="logo_name">ID / Password 찾기</span>
        </div>
		
		<div class="searchIdForm" style="position: relative; left: 22px; top: 25px;">
		<div>아이디 찾기</div>
			<input type="tel" class="inPhone" id="phone" placeholder="가입 시 인증한 연락처" name="phone" oninput="autoHyphen2(this)" required>
			<input type="email" class="inEmail" id="email" placeholder="가입 시 인증한 이메일" name="email" required>
			<button class="searchBtn" onclick="searchId()">아이디 찾기</button>
		</div>
		<br><br><br>
		
		<div class="hr-sect">또는</div>
		
		<div class="searchPwdForm" style="position: relative; left: 22px; top: 25px;">
		<div>비밀번호 찾기</div>
			<input type="text" class="ID" id="userId" placeholder="가입 시 입력한 아이디" name="userId" required>
			<input type="email" class="emailNum" id="email" placeholder="가입 시 인증한 이메일" name="email" required> <br>
			<a class="searchPwdBtn" onclick="searchPwd()">비밀번호 찾기</a>
		</div>
		<br><br><br>
		
		<button class="toLogin" onclick="location.href='/somomo'">로그인으로</button>
		
	</div>
		
	<script>
		const autoHyphen2 = (target) => {
			 target.value = target.value
			   .replace(/[^0-9]/g, '')
			  .replace(/^(\d{0,3})(\d{0,4})(\d{0,4})$/g, "$1-$2-$3").replace(/(\-{1,2})$/g, "");
		}
	
		
		var $inputEmail = $('.inEmail');
		var $inputId = $('.ID');
		var $inputPwdEmail = $('.emailNum');
		var $inputPhone = $('.inPhone')
		function searchId(){
			$.ajax({
				url	: "searchId.me",
				data : {email:$inputEmail.val(),
					    phone:$inputPhone.val()
				},
				success:function(result){
					if(result!=null){
						alert("이메일을 확인해주세요.")
					}
					else{
						alert("조회되는 회원이 없습니다.")
					}
				},error:function(){
					alert("회원가입 시 입력한 이메일을 적어주세요.")
				}
			})
		}
	
		function searchPwd(){
			$.ajax({
				url	: "searchPwd.me",
				data : {email:$inputPwdEmail.val(),
						userId:$inputId.val()
				},
				success:function(result){
					console.log(result);
					if(result=="Y"){
						alert("이메일로 임시비밀번호를 전송하였습니다. 반드시 로그인 후 비밀번호를 변경해주세요.")
					}
					else{
						alert("조회되는 회원이 없습니다.")
					}
				},error:function(){
					alert("회원가입 시 입력한 이메일을 적어주세요.")
				}
			})
		}
	</script>
	

</body>
</html>