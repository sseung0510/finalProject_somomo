<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
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
		height : 910px;
		width : 400px;
		position:absolute;
		left:50%;
    	top:50%;
    	margin-left:-200px;
    	margin-top:50px;
	}
	.form-group{
		margin-top:25px;
		margin-left: 20px;
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
	.form-control{
		width:350px;
		height:30px;
		margin-bottom:2px;
	}
	.emailCheck, .checkNick, .idCheck{
		width:280px;
		height:30px;
		margin-bottom:10px;
	}
	
	.age_gender{
		width:100px;
		height:30px;
	}
	.gender{
		width:100px;
		height:35px;
	}
	
	#emailBtn1, #emailBtn2, #checkNick, #checkId{
		width:65px;
		height:30px;
		background-color:#FCD9D7;
		border:1px solid #FEC8C6;
		border-radius:5px;
	} 
	#telBtn:hover{
		background-color:#FEC8C6;
	}
	.btns button{
		width:150px;
		height:30px;
		background-color:#FCD9D7;
		border:1px solid #FEC8C6;
		border-radius:5px;
		margin-top:50px;
	}
	/* 로고사진/ 사이트명 이동 */
    .logo-name{
        display: flex;
        align-items: center;
        margin-top : 10px;
        margin-left : 10px;
    }
    /* 이거 필셀 조절하면 간격 조절 가능 */
    td div:last-child{
        margin-bottom: 20px;
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
	
	
	<form action="insertKakao.me" method="post" id="enrollForm">
		<input type="hidden" value="${kakaoUser.profileImg}" id="profileImg" name="profileImg">
		<table class="form-group">
			<tr>
				<td colspan="2">
					<div>* 아이디</div>
					<input type="text" class="idCheck" id="userId" placeholder="Please Enter ID" name="userId" value="${kakaoUser.userId}" readonly>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<div>* 닉네임</div>
					<input type="text" class="checkNick" id="nickname" placeholder="Please Enter NickName" name="nickname" value="${kakaoUser.nickname}" required>
					<input type="button" id="checkNick" value="중복확인" onclick="nickCheck();"> <br>
					<div id="nickNameResult" class="colorSubmit" style="font-size:12px">2글자 이상인 닉네임을 입력해주세요</div>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<div>* 연락처</div>
					<input type="text" class="form-control" id="phone" placeholder="Please Enter Tel" name="phone" required maxlength="13" oninput="autoHyphen2(this)"> 
					<div style="font-size:12px">본인명의의 연락처를 입력해주세요</div> 
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<div>* 이메일</div>
					<input type="text" class="emailCheck" id="email" placeholder="Please Enter Email" name="email" onkeyup="checkEmail();"  value="${kakaoUser.email}" readonly>
				</td>
			</tr>
			<tr>
				<td>* 나이</td>
				<td>* 성별</td>
			</tr>
			<tr>
				<td>
					<input type="number" class="age_gender" id="age" placeholder="나이" name="age" min="15" max="50" required>
				</td>
				<td>
					<select name="gender" class="gender">
						<option value="F">여성</option>
						<option value="M">남성</option>
					</select>
				</td>
			</tr>
			
		</table>
 
		<div class="btns" align="center">
			<button type="submit" class="enrollSubmit" onclick="enroll()">회원가입</button>
			<button type="reset">초기화</button>
		</div>
 
	</form>
            
	</div>
	
	<script>
		
		function enroll() {
			if($('.age_gender').val()==""){
				alert("나이를 설정해주세요");
				return;
			}
			
			$(".enrollSubmit").attr('type',"submit");
		}
		
	</script>

	<c:if test="${!empty alertMsg }">
		<script>
			alert("${alertMsg}");
		</script>
	</c:if>

</body>
</html>