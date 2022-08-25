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
    	top: 35px;
    	left: 2%;
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
        
        <%-- boardType이 존재할 경우, region과 keyword도 존재함 --%>
		<c:if test="${not empty boardType}">
			<script>
				$(function(){
					// 글 종류 세팅
					$('.search-boardType input[value=${boardType}]').attr('checked', true);
					
					// 검색 지역 세팅
					let regionNoList = ${regionNoList}; // 선택지역 목록 가져오기
					
					for(let i = 0; i < regionNoList.length; i++){
						$('.regionSelect').each(function(){
							if(regionNoList[i] == $(this).val()){ // 선택지역의 값과 동일하면
								$('.regionAll').prop('checked', false); // 전체지역 체크 해제
								$(this).prop('checked', true); // 선택지역 체크
							}
						});
					}

					// 검색 내용 세팅
					$('.search-keyword input').val('${keyword}');
				})
			</script>
		</c:if>
        	
        
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
	        		<input type="checkbox" class="regionAll" name="regionNo" value="0" checked>전체지역<br>
	        		<c:forEach var="t" items="${rList}">
	        			<input type="checkbox"  class="regionSelect" name="regionNo" value="${t.regionNo}">${t.regionName}
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
        
        <script>
        	$(function(){
        		// 검색지역 > 전체지역 클릭했을 경우
				$('.regionAll').click(function(){
					if($('.regionAll').is(':checked')){ // 전체지역 체크했다면
						$('.regionSelect').prop('checked', false); // 나머지 지역 체크 해제
					}
				});
				
        		// 검색지역 > 전체지역 외의 지역(선택지역)을 클릭했을 경우
				$('.regionSelect').click(function(){
					if($('.regionSelect').is(':checked')){ // 다른 지역 체크했다면
						$('.regionAll').prop('checked', false); // 전체지역 체크 해제
					}
					
					let checked = $('input[class=regionSelect]:checked').length; // 다른 지역 체크된 개수가
					if(checked == 0){ // 하나도 없다면
						$('.regionAll').prop('checked', true); // 전체지역 체크
					}
				});
        	});
        </script>
        
</body>
</html>