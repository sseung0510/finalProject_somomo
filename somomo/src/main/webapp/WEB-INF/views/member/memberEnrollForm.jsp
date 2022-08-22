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
	
	
	<form action="insert.me" method="post" id="enrollForm">
		<input type="hidden" value="resources/img/member/profile_img/profile_img.png" id="profileImg" name="profileImg">
		<table class="form-group">
			<tr>
				<td colspan="2">
					<div>* 아이디</div>
					<input type="text" class="idCheck" id="userId" placeholder="Please Enter ID" name="userId" required>
					<input type="button" id="checkId" value="중복확인" onclick="idCheck();"> <br>
					<div id="checkResult" class="colorSubmit" style="font-size:12px">대소문자와 숫자로 이루어진 4~15자의 아이디를 입력해주세요</div>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<div>* 닉네임</div>
					<input type="text" class="checkNick" id="nickname" placeholder="Please Enter NickName" name="nickname" required>
					<input type="button" id="checkNick" value="중복확인" onclick="nickCheck();"> <br>
					<div id="nickNameResult" class="colorSubmit" style="font-size:12px">2글자 이상인 닉네임을 입력해주세요</div>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<div>* 비밀번호</div>
					<input type="password" class="form-control" id="userPwd" placeholder="Please Enter Password" name="userPwd" onkeyup="RegPwdCheck();" required>
					<div id="regPwd" class="colorSubmit" style="font-size:12px">영문자와 숫자로 이루어진 5~16글자 비밀번호를 입력해주세요</div>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<div>* 비밀번호 확인</div>
					<input type="password" class="form-control" id="checkPwd" placeholder="Please Enter Password" onkeyup="CheckPwd();" required>
					<div id="samePwd" class="colorSubmit" style="font-size:12px">위와 동일한 비밀번호를 입력해주세요</div>
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
					<input type="text" class="emailCheck" id="email" placeholder="Please Enter Email" name="email" onkeyup="checkEmail();"  required>
					<input type="button" id="emailBtn1" value="인증" onclick="sendEmail();"><br>
					<input type="text" class="emailCheck" id="email2" placeholder="인증번호 입력" disabled required> 
					<div id="regEmail" class="colorSubmit" style="font-size:12px">이메일형식에 맞춰서 입력해주세요</div>
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
		//비밀번호 유휴성검사
		//비밀번호 조건체크(숫자와 영문자 조합으로 8~16자리를 사용해야 합니다.)
		const $userPwd = $('#enrollForm input[name=userPwd]');
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
					var Ok1 = "Y";
					return Ok1;
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
					var O2 = "Y";
					return O2;
				}
			} 
			else{
				$('#samePwd').show();
				$('#samePwd').css('color','black').text('영문자와 숫자로 이루어진 5~16글자 비밀번호를 입력해주세요');
			}
		}
		
		// 이메일
		function checkEmail(){
			const $email = $('#enrollForm input[name=email]');
			var RegEmail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;

			if($email.val()!=""){
				//표현식에 맞지않는 이메일일 경우
				if(!RegEmail.test($email.val())){
					$('#regEmail').show();
					$('#regEmail').css('color','orangered').text('조건에 맞게 입력해주세요.');
				}
				else{// 사용가능한 이메일
					$('#regEmail').show();
					$('#regEmail').css('color','green').text('사용가능한 이메일입니다.');
					var O3 = "Y";
					return O3;
				}
			}
			else{// 값이 비어 있을때
				$('#regEmail').show();
				$('#regEmail').css('color','black').text('조건에 맞게 입력해주세요.');
			}
		}
		
		const regExpId = /^[a-zA-Z0-9]{4,15}$/;
		// 아이디 중복체크
		function idCheck(){
			const $idInput = $('#enrollForm input[name=userId]');
			var O4;
			if(regExpId.test($idInput.val())){
				$.ajax({
					url:'idCheck.me',
					data : {checkId:$idInput.val()},
					async : false,
					success:function(result){
							console.log(result);
						if(result == 'NNNNN'){ //사용불가능
							$('#checkResult').show();
							$('#checkResult').css('color', 'orangered').text('이미 중복된 아이디가 존재합니다');
						}
						else{ // 사용가능
							$('#checkResult').show();
							$('#checkResult').css('color', 'yellowgreen').text('사용가능한 아이디 입니다.');
							O4 = result;
						}
					}, error : function(){
						console.log("아이디 중복체크용 ajax통신 실패");
					}
				});				
			}else{
				$('#checkResult').show();
				$('#checkResult').css('color', 'orangered').text('대소문자와 숫자로 이루어진 4~15자의 아이디를 입력해주세요');
			}
			return O4;
		}
		
		const autoHyphen2 = (target) => {
			 target.value = target.value
			   .replace(/[^0-9]/g, '')
			  .replace(/^(\d{0,3})(\d{0,4})(\d{0,4})$/g, "$1-$2-$3").replace(/(\-{1,2})$/g, "");
		}
		
		// 닉네임
		function nickCheck(){
			const $nickNameInput = $('#enrollForm input[name=nickname]');
			var O5;
			
			if($nickNameInput.val().length >= 2){
			$.ajax({
				url:'nickNameCheck.me',
				data : {checkNickName:$nickNameInput.val()},
				async : false,
				success:function(result){
					if(result == 'NNNNN'){ //사용불가능
						$('#nickNameResult').show();
						$('#nickNameResult').css('color', 'orangered').text('중복된 닉네임이 존재합니다');
					}
					else{ // 사용가능
						$('#nickNameResult').show();
						$('#nickNameResult').css('color', 'yellowgreen').text('사용가능한 닉네임입니다.');
						O5 = result;
					}
				}, error : function(){
					console.log("아이디 중복체크용 ajax통신 실패");
				}
			});		
			return O5;
			}
		}
		                                                              
		// 인증메일 보내기
		function sendEmail(){
			
			const email = $('#email').val();
			
			$.ajax({
				url:'sendEmail.me',
				data : {email : email},
				success:function(num){
					//console.log(num);
					if(num != null){
						alert("인증번호를 발송했습니다.");
						$('.emailCheck').removeAttr("disabled");
					}
				}, error : function(){
					console.log("이메일전송 실패");
				}
			});
		}
	
		// 인증번호 입력
		function sendCheck(){
			const checkEmail = $('#email2').val();
			var O6="";
			$.ajax({
				url:'checkEmail.me',
				data:{ secret : checkEmail},
				async : false,
				success:function(result){
					//console.log(result);
					if(result=='NNNNY'){
						$('#regEmail').show();
						$('#regEmail').css('color','yellowgreen').text('이메일 인증 성공했습니다.');
						console.log(result);
						O6 = result;
					}else{
						$('#regEmail').show();
						$('#regEmail').css('color','orangered').text('인증번호가 일치하지 않습니다.');
						alert("인증번호가 일치하지 않았습니다. 다시 인증해주세요")
						O6=result;
					}
					
				}, error: function(){
					console.log("인증 실패");
				}
			});
			return O6;
		}
		
		// 키업
		// 시점
		<%--
		function checkSu(){
			//console.log(($('.colorSubmit').css('color')=='rgb(154, 205, 50)'));
			var success="";
			success = sendCheck();
			//변수만들기 6번
			var count = 0;
			$.each($('.colorSubmit'), function(index, items){
				console.log(index);
				if($(items).css('color')=='rgb(154, 205, 50)'){
					count+=1;
					console.log(count);
					if(count==4 && success=="Y"){
						$(':submit').removeAttr("disabled");
					}
				}else{
					count-1;
				}
			})
		}
		--%>
		
		function enroll() {
			if($('.age_gender').val()==""){
				alert("나이를 설정해주세요");
				return;
			}
			
			var success = "";
			success = idCheck() + nickCheck() + RegPwdCheck() + CheckPwd() + checkEmail() + sendCheck();
			// console.log(success);
			if(success == 'NNNNYNNNNYYYYNNNNY'){
				$(".enrollSubmit").attr('type',"submit");
			}else{
				$(".enrollSubmit").attr('type',"button");
			}
		}
		
	</script>

	<c:if test="${!empty alertMsg }">
		<script>
			alert("${alertMsg}");
		</script>
	</c:if>

</body>
</html>