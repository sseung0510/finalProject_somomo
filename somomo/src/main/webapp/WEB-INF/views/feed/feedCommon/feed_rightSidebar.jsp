<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	.search-area{
    	position: relative;
    	top: 75px;
    	left: 15%;
    	background-color:rgba(248, 230, 226, 0.863);
    	padding : 15px;
    	border-radius: 10px;
	}
	.search-area>div{
		margin-top:10px;
	}
	.search-region{
		margin-bottom: 10px;
	}
	.search-btn{
		text-align: right;
	}
	.btnPink-sm{
		/*display:block;*/
		/*width:100%;*/
		width: 70px;
		margin-top: 10px;
		padding: 5px;
		background-color: rgb(250,188,186);
		border: 1px solid rgb(250,188,186);
		border-radius: 8px;
		color: white;
		font-size: 18px;
		font-weight: bold;
	}
	.btnPink-sm:hover{
		background-color: #FEC8C6;
		border: 1px solid #FEC8C6;
	}
	
</style>
</head>
<body>
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
        
        <div class="search-area">
        	<form action="search.fd" method="get">

	        	<div class="search-boardType">
	     			<div><b>글 종류</b></div>
					<input type="radio" id="btypeA" name="boardType" value="A" checked>
					<label for="btypeA">전체</label>&nbsp;
					<input type="radio" id="btypeG"name="boardType" value="G">
					<label for="btypeG">일반글</label>&nbsp;
					<input type="radio" id="btypeM" name="boardType" value="M">
					<label for="btypeM">모임모집글</label>
	        	</div>
	        	
	        	<div class="search-region">
	        		<div ><b>검색 지역</b></div>
	        		<input type="checkbox" name="regionNo" value="0" checked>전체지역<br>
	        		<c:forEach var="t" items="${rList}">
	        			<input type="checkbox" name="regionNo" value="${t.regionNo}">${t.regionName}
	        		</c:forEach>
	        	</div>
	        	
	        	<div class="search-keyword">
	        		<div><b>검색 내용</b></div>
	        		<input type="text" class="form-control" name="keyword" value="">
	        	</div>
	        	
	        	<div class="search-btn">
		        	<button type="submit" class="searchBtn btnPink-sm" style="text-align:center;">검색</button>
	        	</div>
        	</form>
        	

        </div>
</body>
</html>