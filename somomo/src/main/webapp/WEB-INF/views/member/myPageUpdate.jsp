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
				<div id="myInfo">정보 변경</div>
	        	<form action="update.me" method="post" id="updateForm" enctype="multipart/form-data">
	        		<table>
	        			<tr>
	        				<td>
	        					<div>나의 프로필</div>
								<img id="titleImg" width="240" height="180" src="${loginUser.profileImg}">
	        				</td>
	        				<td>
	        				<label class="input-file-button" for="profileImg">
	        					프로필 사진
	        				</label>
	        					<input type="file" id="profileImg" name="upfile" style="display:none;"  onchange="loadImg(this);">
	        					<input type="hidden" name="profileImg" value="${loginUser.profileImg}">
	        				</td>
	        			</tr>
	        		</table>
					<table class="form-group">
						<tr>
							<td colspan="2">
								<div>아이디</div>
								<input type="text" name="userId" id="userId" value="${loginUser.userId}" readonly>
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<div>닉네임</div>
			                    <input type="text" class="inputcolor" id="nickname" placeholder="Please Enter NickName" name="nickname" value="${loginUser.nickname }" required> <br>
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<div>전화번호</div>
			                    <input type="text" class="telCheck inputcolor" id="phone" placeholder="Please Enter Tel" name="phone" required maxlength="13" value="${loginUser.phone }" oninput="autoHyphen2(this)"> 
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<div>이메일</div>
			                    <input type="text" class="inputcolor" id="email" placeholder="Please Enter Email" name="email" value="${loginUser.email }" required> <br>
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<div>현재 비밀번호</div>
			                    <input type="password" class="inputcolor" id="userPwd" placeholder="Please Enter Password" name="userPwd" required>
							</td>
						</tr>
					</table>
					<button id="updateBtn">정보 수정</button>
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
		//바꾸려는 프로필사진 미리보기
		function loadImg(inputFile){
			//console.log(inputFile.files.length);
			
			if(inputFile.files.length == 1){
				var reader = new FileReader();
				
				reader.readAsDataURL(inputFile.files[0]);

                reader.onload = function(e){
                	$('#titleImg').attr('src', e.target.result);
				}
			}
		}
		
		var msg='${alertMsg}'
		if(msg==='비밀번호가 틀렸습니다.'){
			
			setTimeout(function() {
				alert("비밀번호가 틀렸습니다. 다시 확인해주세요.");
			}, 100);
		}
			
	</script>
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

	
	
</body>
</html>