<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   <!----------- CSS --------------->
   <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/feedstyle.css?ver=1.0.3">
   <!----------- 아이콘 CSS 링크 ------->
   <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css">
   <!----------- 아이콘 CSS 링크 version 2------->
   <!-- Boxicons CSS -->
   <link href='https://unpkg.com/boxicons@2.1.1/css/boxicons.min.css' rel='stylesheet'>
   
	<!-- jquery -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	
	<!-- Bootstrap-->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<title>메인 페이지</title>
<style>
	body{
		position : relative;
	}

	#updateForm{
		width : 400px;
    	margin-left:10px;
    	margin-top:10px;
		margin-left:20%;
		margin-top:8%;
   		font-size:18px;
	}
   	#mypage{
   		font-size:20px;
   		font-weight:bold;
   		margin-bottom:10px;
   		padding-left:5px;
   	}
	
	#updateBtn{
		width:150px;
		height:35px;
		background-color:#FCD9D7;
		border:1px solid #FEC8C6;
		border-radius:5px;
		margin-top:30px;
		margin-left:120px;
	}
	#updateBtn:hover{
		background-color:#FEC8C6;
	}
	.form-group input{
        margin-bottom: 15px;
        margin-top:5px;
        width:380px;
        height:40px;
        font-size:18px;
    }
    #myInfo{
    	font-size:25px;
    	color:lightgray;
   		font-weight:bold;
    }
    .form-group{
    	margin-top:20px;
    }
    .titleImg{
  		width:110px;
		height:30px;
		border-radius:5px;
		margin-top:190px;
    }
    .input-file-button{
		width:110px;
		height:40px;
		background-color:#FCD9D7;
		border:1px solid #FEC8C6;
		border-radius:5px;
		text-align:center;
		margin-top:180px;
		margin-left:30px;
		cursor:pointer;
		padding-top:5px;
	}
	.input-file-button:hover{
		background-color:#FEC8C6;
	}
	#updateCssForm{
		border-radius:5px;
		width:100%;
		height:900px;
		padding:5px;
	}
	input:focus {
		border-color:rgba(254, 200, 198, .5);
		outline:3px solid rgba(254, 200, 198, .6);
	}
	</style>
</head>
<body>
	<!--------------------- 왼쪽 사이드 바 ------------------------>
	<jsp:include page="memberCommon/memberLeftSidebar.jsp"/>
	<!--------------------- 왼쪽 사이드 바 끝 ------------------------>

	<!----------- 헤더 , 메인 컨텐츠 ---------->
	<section class="main-content">
		<!------- 헤더 --------->
		<div class="top">
			<i class="uil uil-bars sidebar-toggle"></i>

			<div class="search-box">
            	<i class="uil uil-search"></i>
                <input type="text" placeholder="검색">
            </div>
		</div>
        <!------- 헤더 끝--------->



		<!------ 메인 피드----------->
        <div class="main-feed">
           	
           	
			<!-----------글 목록 띄워지는 공간----------->
			<div id="updateCssForm">
				<div id="myInfo">비밀번호 변경</div>
        	<form action="updatePassword.me" method="post" id="updateForm">
				<table class="form-group">
					<tr>
						<td>
							<div>아이디</div>
							<input type="text" name="userId" value="${loginUser.userId}" readonly>
						</td>
					</tr>
					<tr>
						<td>
							<div>닉네임</div>
		                    <input type="text" class="form-control" id="nickname" placeholder="Please Enter NickName" name="nickname" value="${loginUser.nickname }" readonly> <br>
						</td>
					</tr>
					<tr>
						<td>
							<div>현재 비밀번호</div>
		                    <input type="password" class="form-control" id="oldUserPwd" placeholder="Please Enter Password" name="oldUserPwd" onkeyup="userPwd();" required>
		                    <div></div>
						</td>
					</tr>
					<tr>
						<td>
							<div>새 비밀번호</div>
		                    <input type="password" class="form-control" id="newUserPwd" placeholder="Please Enter Password" name="userPwd" onkeyup="RegPwdCheck();"required>
		                    <div id="regPwd" style="font-size:13px">영문자와 숫자로 이루어진 5~16글자 비밀번호를 입력해주세요</div>
						</td>
					</tr>
					<tr>
						<td>
							<div>새 비밀번호 확인</div>
	             	  		<input type="password" class="form-control" id="checkPwd" placeholder="Please Enter Password" onkeyup="CheckPwd();" required>
	             	  		<div id="samePwd" style="font-size:13px">일치하는 비밀번호를 적어주세요.</div>
						</td>
					</tr>
				</table>
				<button id="updateBtn" type="button" onclick="changePwd()">정보변경</button>
			</form>
	        </div>
        </div>
        <!------ 메인 피드 끝----------->
        
    <!----------- 헤더 , 메인 컨텐츠 끝---------->        
    </section>

    <!------ 오른쪽 사이드 바 --------->
    <div class="right-sidebar">
        <div class="right-top">
            <i class="uil uil-bell"></i>
            <i class="uil uil-comment-dots"></i>
            <i class="uil uil-user-circle profile">
                <ul class="profile-link">
                    <li><a href=""><i class="uil uil-user-circle"></i> 프로필</a></li>
                    <li><a href=""><i class="uil uil-setting"></i> Settings</a></li>
                    <li><a href=""><i class="uil uil-signout"></i> 로그아웃</a></li>
                </ul>
            </i>
        </div>
		<div class="right-main">
			<jsp:include page="myLikes_Favorites.jsp"/>
		</div>
    </div>
    <!-- 오른쪽 사이드 바 끝-->
	<script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
	
	<script>
		const $userPwd = $('#newUserPwd');
		const regExpPwd = /^[a-zA-Z0-9]{5,16}$/;
		
		function RegPwdCheck(){
			
			//들어온 값이 빈 문자열이 아닐때
			if($userPwd.val()!=""){
				//표현식에 맞지않는 비번일 경우
				if(!regExpPwd.test($userPwd.val())){
					$('#regPwd').show();
					$('#regPwd').css('color','red').text('조건에 맞게 입력해주세요.');
				}
				else{// 사용가능한 비밀번호
					$('#regPwd').show();
					$('#regPwd').css('color','yellowgreen').text('사용가능한 비밀번호입니다.');
					var ok="Y";
					return ok;
				}
			}
			else{// 값이 비어 있을때
				$('#regPwd').show();
				$('#regPwd').css('color','black').text('영문자와 숫자로 이루어진 5~16글자 비밀번호를 입력해주세요');
			}
			
		}
		
		//비밀번호 확인
		function CheckPwd(){
			if(regExpPwd.test($userPwd.val())){ // 비밀번호 사용가능일 경우
				if($('#checkPwd').val() != $userPwd.val()){ // 비밀번호가 일치하지 않을 경우
					$('#samePwd').show();
					$('#samePwd').css('color','orangered').text('비밀번호가 일치하지 않습니다.');
				}
				else{ // 비밀번호가 일치할 경우
					$('#samePwd').show();
					$('#samePwd').css('color','yellowgreen').text('비밀번호가 일치합니다.');
					var ok1="Y";
					return ok1;
				}
			} 
			else{
				$('#samePwd').show();
				$('#samePwd').css('color','black').text('일치하는 비밀번호를 적어주세요.');
			}
		}
		
			 
		function changePwd(){
			var success="";
			success=RegPwdCheck()+CheckPwd();
			
			if(success == 'YY'){
				$("#updateBtn").removeAttr('type',"submit");
			}else{
				$("#updateBtn").attr('type',"button");
			}
			
		}
		
			 
		
		var msg='${alertMsg}'
		if(msg==='현재 비밀번호가 일치하지 않습니다.'){
			
			setTimeout(function() {
				alert("현재 비밀번호가 아닙니다. 다시 확인해주세요.");
			}, 100);
		}
		
		
		
	</script>
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

	
	
</body>
</html>