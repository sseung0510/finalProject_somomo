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
		height : 890px;
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
	.telCheck{
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
	
	#telBtn1, #telBtn2{
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
             <table class="form-group">
             	<tr>
             		<td colspan="2">
	             		<div>* 아이디</div>
	             		<input type="text" class="form-control" id="userId" placeholder="Please Enter ID" name="userId" onkeyup="checkSu();" required>
	             		<div id="checkResult" class="colorSubmit" style="font-size:12px">4-12자의 영문과 숫자와 일부 특수문자(._-)만 입력 가능</div>
             		</td>
             	</tr>
             	<tr>
             		<td colspan="2">
	             		<div>* 비밀번호</div>
	                    <input type="password" class="form-control" id="userPwd" placeholder="Please Enter Password" name="userPwd" onkeyup="RegPwdCheck(); checkSu();" required>
	             		<div id="regPwd" class="colorSubmit" style="font-size:12px">4-10자의 대소문자와 숫자와 특수문자 입력</div>
             		</td>
             	</tr>
             	<tr>
             		<td colspan="2">
	             		<div>* 비밀번호 확인</div>
	             	    <input type="password" class="form-control" id="checkPwd" placeholder="Please Enter Password" onkeyup="CheckPwd(); checkSu();" required>
	             	    <div id="samePwd" class="colorSubmit" style="font-size:12px">4-10자의 대소문자와 숫자와 특수문자 입력</div>
             		</td>
             	</tr>
             	<tr>
             		<td colspan="2">
	             		<div>* 닉네임</div>
	                    <input type="text" class="form-control" id="nickname" placeholder="Please Enter NickName" name="nickname" onkeyup="checkSu();" required> <br>
               	        <div id="nickNameResult" class="colorSubmit" style="font-size:12px">4-12자의 영문과 숫자와 일부 특수문자(._-)만 입력 가능</div>
             		</td>
             	</tr>
             	<tr>
             		<td colspan="2">
	             		<div>* 이메일</div>
	                    <input type="text" class="form-control" id="email" placeholder="Please Enter Email" name="email" onkeyup="checkEmail(); checkSu();" required> <br>
	                    <div id="regEmail" class="colorSubmit" style="font-size:12px">이메일형식에 맞춰서 입력</div>
             		</td>
             	</tr>
             	<tr>
             		<td colspan="2">
	             		<div>* 연락처</div>
	                    <input type="text" class="telCheck" id="phone" placeholder="Please Enter Tel" name="phone" required maxlength="13" oninput="autoHyphen2(this)"> 
	                   	<input type="button" id="telBtn1" value="인증"><br>
	                   	<input type="text" class="telCheck" id="phone2" placeholder="인증번호 입력" disabled required> 
	                   	<div class="point successPhoneChk colorSubmit" style="font-size:12px" onkeyup="checkSu();">휴대폰 번호 입력후 인증번호 보내기를 해주십시오.</div>
	                   	<input type="hidden"  id="telBtn2" class="phoneDoubleChk"/>
	                   	<div></div> 
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
                    <button type="submit" class="enrollSubmit" disabled="disabled">회원가입</button>
                    <button type="reset">초기화</button>
             </div>
             
            </form>
            
	</div>
	
	<script>
		//비밀번호 유휴성검사
		//비밀번호 조건체크(최소 4 자, 최대10자, 하나 이상의 대문자, 하나의 소문자, 하나의 숫자 및 하나의 특수 문자)
		const $userPwd = $('#enrollForm input[name=userPwd]');
		const regExpPwd = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{4,}$/;
		
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
				}
			}
			else{// 값이 비어 있을때
				$('#regPwd').show();
				$('#regPwd').css('color','black').text('4-10자의 대소문자와 숫자와 특수문자 입력');
			}
			return false;
			
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
				}
			} 
			else{
				$('#samePwd').show();
				$('#samePwd').css('color','black').text('4-10자의 대소문자와 숫자와 특수문자 입력');
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
					$('#regEmail').css('color','yellowgreen').text('사용가능한 이메일입니다.');
				}
			}
			else{// 값이 비어 있을때
				$('#regEmail').show();
				$('#regEmail').css('color','black').text('조건에 맞게 입력해주세요.');
			}
		}
		
		// 아이디 중복체크
		$(function(){
			const $idInput = $('#enrollForm input[name=userId]');

			$idInput.keyup(function(){
				if($idInput.val().length >= 5){
					$.ajax({
						url:'idCheck.me',
						data : {checkId:$idInput.val()},
						success:function(result){
							if(result == 'NNNNN'){ //사용불가능
								$('#checkResult').show();
								$('#checkResult').css('color', 'orangered').text('이미 중복된 아이디가 존재합니다');
							}
							else{ // 사용가능
								$('#checkResult').show();
								$('#checkResult').css('color', 'yellowgreen').text('사용가능한 아이디 입니다.');
							}
						}, error : function(){
							console.log("아이디 중복체크용 ajax통신 실패");
						}
					});				
				}
				else{
					$('#checkResult').hide();
				}
			});
		})
		
		const autoHyphen2 = (target) => {
			 target.value = target.value
			   .replace(/[^0-9]/g, '')
			  .replace(/^(\d{0,3})(\d{0,4})(\d{0,4})$/g, "$1-$2-$3").replace(/(\-{1,2})$/g, "");
		}
		
		// 닉네임
		$(function(){
			const $nickNameInput = $('#enrollForm input[name=nickname]');
			
			$nickNameInput.keyup(function(){
				if($nickNameInput.val().length>=2){
					$.ajax({
						url:'nickNameCheck.me',
						data : {checkNickName:$nickNameInput.val()},
						success:function(result){
							if(result == 'NNNNN'){ //사용불가능
								$('#nickNameResult').show();
								$('#nickNameResult').css('color', 'orangered').text('중복된 닉네임이 존재합니다');
							}
							else{ // 사용가능
								$('#nickNameResult').show();
								$('#nickNameResult').css('color', 'yellowgreen').text('사용가능한 닉네임입니다.');
							}
						}, error : function(){
							console.log("아이디 중복체크용 ajax통신 실패");
						}
					});				
				}
				else{
					$('#nickNameResult').hide();
				}
			})
			
			
		})
		// 문자인증 관련(숫자)
		var code2 = "";
		$("#telBtn1").click(function(){
			alert("인증번호 발송이 완료되었습니다.\n휴대폰에서 인증번호 확인을 해주십시오.");
			var phone = $("#phone").val();
			console.log(phone);
			$.ajax({
		        url:"phoneCheck?phone=" + phone,
		        cache : false,
		        success:function(data){
		        	if(data == "error"){
		        		alert("휴대폰 번호가 올바르지 않습니다.")
						$(".successPhoneChk").text("유효한 번호를 입력해주세요.");
						$(".successPhoneChk").css("color","orangered");
						$("#phone").attr("autofocus",true);
		        	}else{	        		
		        		$("#phone2").attr("disabled",false);
		        		$("#phoneChk2").css("display","inline-block");
		        		$(".successPhoneChk").text("인증번호를 입력한 뒤 본인인증을 눌러주십시오.");
		        		$(".successPhoneChk").css("color","yellowgreen");
		        		$("#phone").attr("readonly",true);
		        		code2 = data;
		        	}
		        }
		    });
		});
		
		//휴대폰 인증번호 대조
		$("#phoneChk2").click(function(){
			if($("#phone2").val() == code2){
				$(".successPhoneChk").text("인증번호가 일치합니다.");
				$(".successPhoneChk").css("color","yellowgreen");
				$("#phoneDoubleChk").val("true");
				$("#phone2").attr("disabled",true);
			}else{
				$(".successPhoneChk").text("인증번호가 일치하지 않습니다. 확인해주시기 바랍니다.");
				$(".successPhoneChk").css("color","orangered");
				$("#phoneDoubleChk").val("false");
				$(this).attr("autofocus",true);
			}
		});
		// 키업
		// 시점
		
		
		function checkSu(){
			//console.log(($('.colorSubmit').css('color')=='rgb(154, 205, 50)'));
			
			//변수만들기 6번
			var count = 0;
			$.each($('.colorSubmit'), function(index, items){
				
				if($(items).css('color')=='rgb(154, 205, 50)'){
					count+=1;
					if(count>=5){
						$(':submit').removeAttr("disabled");
					}
				}
			})
						
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	</script>
























</body>
</html>