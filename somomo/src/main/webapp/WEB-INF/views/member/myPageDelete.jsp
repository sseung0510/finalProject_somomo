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

	#deleteForm{
		width : 800px;
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
	
	#deleteBtn, #kakaoDeleteBtn{
		width:150px;
		height:35px;
		background-color:#FCD9D7;
		border:1px solid #FEC8C6;
		border-radius:5px;
		margin-top:30px;
		margin-left:120px;
	}
	#deleteBtn:hover{
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
	 #deleteQ{
    	font-size:25px;
    	font-weight:bold;
    	padding-bottom:20px;
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
			<div id="deleteCssForm">
				<div id="myInfo">회원 탈퇴</div>
	        	<form action="delete.me" method="post" id="deleteForm">
	        		<table class="form-group">
	        			<tr>
	        				<td id="deleteQ">
	        					회원 탈퇴하시겠습니까?
	        				</td>
	        			</tr>
	        			
	        			<tr>
	     					<td colspan="2">
								<div>아이디</div>
								<input type="text" name="userId" value="${loginUser.userId}" id="userId" readonly>
							</td>
	        			</tr>
						<c:if test="${loginUser.kakaoLogin eq 'N' }">
	        			<tr>
	        				<td colspan="2">
								<div>비밀번호 확인</div>
			                    <input type="password" class="form-control" id="userPwd" placeholder="Please Enter Password" name="userPwd" onkeyup="deletePass()"required>
							</td>
	        			</tr>
	        			</c:if>
	        		</table>
				<c:if test="${loginUser.kakaoLogin eq 'N' }">
	       		<pre>
2개월동안 재 가입여부 판단을 목적으로 고객님의 최소 정보를 보관합니다.
고객님의 기본정보는 2개월 후 완전소실 됩니다.
회원탈퇴 후 2개월 동안 재 가입이 불가 합니다.
	       		</pre>
	       		</c:if>
	       		<c:choose>
	       			<c:when test="${loginUser.kakaoLogin eq 'N'}">
	       				<input type="checkbox" name="deleteOk" >&nbsp; 위 약관에 동의하시겠습니까? <br>
	       			</c:when>
	       			<c:otherwise>
	       				<input type="checkbox" name="kakaoDeleteOk" onclick="kakaoCheck()">&nbsp; 정말 탈퇴하시겠습니까? <br>
	       			</c:otherwise>
	       		</c:choose>
	       		<c:choose>
	       			<c:when test="${loginUser.kakaoLogin eq 'N'}">
	        			<button id="deleteBtn" disabled>회원 탈퇴</button>
	        		</c:when>
	        		<c:otherwise>
	        			<button id="kakaoDeleteBtn" disabled>회원 탈퇴</button>
	        		</c:otherwise>
	        	</c:choose>	
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
		function deletePass(){
			if($('#userPwd').val()!=""){
				$('input:checkbox[name="deleteOk"]').click(function(){
					if($("input:checkbox[name='deleteOk']").is(":checked")==true){
						console.log("됐나?")
						$(':submit').removeAttr('disabled');
					} else{
						console.log("안됐나?")
					}
				})
			}

		}
		
		function kakaoCheck(){
			console.log($('#userId').val());
			if($("input:checkbox[name='kakaoDeleteOk']").is(":checked")==true){
				console.log("됐나?")
				$(':submit').removeAttr('disabled');
			} else{
				console.log("안됐나?")
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