<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   <!----------- CSS --------------->
   <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/feedstyle2.css?ver=1.1.4">
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

	<!-- Scrollreveal js -->
	
	<script src="resources/js/scrollreveal.min.js"></script>
<title>메인 페이지</title>
<style>
	body{
		position : relative;
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
	
    .form-group{
    	margin-top:20px;
    }
	
	
	
	#card {
		display : flex;
		height: auto;
		max-width: 480px;
		border-radius: 25px;
		padding-bottom: 1px;
		box-shadow: 2px 2px 10px rgb(0 0 0 / 20%);
		}
	.card-left {
		width : 280px;
		position : relative;
		
	}
	
	
	.card-left i {
	    position: absolute;
	    right: 0;
	    top: 26px;
	    font-size: 28px;
	}
	
	.card-right {
		width : 170px;
		height : auto;
	}
	
	#card h1 {
		color: white;
		text-align: center;
		width: 100%;
		border-radius: 25px 25px 0 0;
		color: #393B45;
		padding-top: 30px;
		font-weight: 800;
		margin: 0;
		font-size: 30px
	}
	
	.image-crop {
		display: block;
		position: relative;
		width: 150px;
		height: 150px;
		margin: 0 auto;
		margin-top: 12px;
		overflow: hidden;
		border-radius: 50%;
	}
	
	#avatar {
		    position: absolute;
		    height: 160px;
		    width: 160px;
		    border-radius: 50%;
		    margin-left: -5px;
		    margin-top: -5px;
	}
	
	
	#stats {
		display: flex;
		flex-direction: row;
		height: auto;
		width: 280px;
		justify-content: space-between;
		align-items: center;
		margin: 10px auto;
		font-weight: 500;
	}
	
	#card .col {
		display: flex;
		flex-direction: column;
		justify-content: center;
		align-items: center;
		width: auto;
	}
	
	#card .stat {
		font-size: 25px;
		margin: 0;
	}
	
	#card .label {
		margin: 0;
		font-size : 13px;
	}
	
	.card-right i {
		color : pink;
	}
	
	.card-right p {
		font-size : 13px;
		margin : 0;
	}
	
	.card-rightContent {
	margin-top : 30px;
	display: flex;
    flex-direction: column;
    grid-gap: 10px;
    margin-left : 15px;
	}
	
	.card-rightContent span {
		margin-left : 5px;
		font-weight : 600;
	}
	
	
	.myList {
		width : 98%;
		margin-top  : 25px;
	}
	
	/* 일반모집글과 모임글 보여주기 */
	
	
	.myList [data-value] {
	  display: none;
	}
	
	.filters-active[data-value] {
	  display: flex;
	}
	
	.myList .title {
	  margin-title : 10px;
	}
	
	.myList .title i {
		font-size : 30px;
		color : pink;
	}
	.myList .title .text {
		font-size : 22px;
	}
	
	.activity-data,
	.activity-data2 {
		box-shadow: 2px 2px 10px rgb(0 0 0 / 20%);
	    margin-top: 10px;
	    width: 100%;
	    border-radius: 13px;
	}
	
	.activity-data .head,
	.activity-data2 .head{
		font-size: 17px;
    	font-weight: 600;
	}
	
	.data-names {
		cursor : pointer;
		display : flex;
		text-align : center;
		width : 100%;
	}
	
	
	.data-names .data-no {
		width : 12%;
		margin: 10px 0;
	}
	
	.data-names .data-title {
		width : 64%;
		margin: 10px 0;
	}
	
	.data-names .data-like,
	.data-names .data-favorites {
		width : 17%;
		margin: 10px 0;
	}
	
	.data-names .data-count {
		width : 17%;
		margin: 10px 0;
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
			
			
			
			 <div id="card">
			 	<div class = "card-left">
			    <h1>${loginUser.nickname}</h1>
			    <i class="uil uil-angle-double-right"></i>
			    <div class="image-crop">
			      <img id="avatar" src="${loginUser.profileImg }"></img>
			    </div>
	
			    <div id="stats">
	
			          <div class="col">
			        <p class="stat like">457</p>
			        <p class="label">좋아요</p>
			      </div>
			          <div class="col">
			        <p class="stat favorite">229</p>
			        <p class="label">찜</p>
			      </div>
			    </div>
			  </div>
			  <div class = "card-right">
			  	<div class="card-rightContent">
			  	<div class="card-id">
			  		<i class="uil uil-house-user"></i><span>ID</span>
			  		<p>${loginUser.userId}</p>
			  	</div>
			  	<div class="card-gender">
			  	
			  	
			  		<c:choose>
						<c:when test="${loginUser.gender eq 'F'}">
							<i class="uil uil-venus"></i><span>성별</span>
							<p class="card-text">여성</p>
						</c:when>
						<c:otherwise>
							<i class="uil uil-mars"></i><span>성별</span>
							<p class="card-text">남성</p>
						</c:otherwise>
					</c:choose> 
			  		
			  	</div>
			  	
			  	<div class="card-email">
			  		<i class="uil uil-envelope"></i><span>EMAIL</span>
			  			<p class="card-text">${loginUser.email}</p>
			  	</div>
			  	
			  	<div class="card-phone">
			  		<i class="uil uil-phone"></i><span>PHONE</span>
			  		<p class="card-text">${loginUser.phone}</p>
			  	</div>
			  	
			  	<div class="card-enrollDate">
			  		<i class="uil uil-calender"></i><span>가입일</span>
			  		<p class="card-text">${loginUser.enrollDate}</p>
			  	</div>
			  	</div>
			  </div>
			</div>
			
			
			
			<div class="myList">
			 	<div class="title">
                    <i class="uil uil-clock-three"></i>
                    <span class="text">나의 활동</span>
                </div>
				<div claas="myTab">
				<ul class="filters-content">
		        	<button class="filters-button filter-tab-active" data-name="#genearlBoard">
		        	   	일반 글
			        </button>
			        <button class="filters-button" data-name="#generaldetailView">
			                     모임 모집글
			        </button>
	    		</ul>
	    		</div>
	    		
	    		
				 <div class="filters-sections">
			        <!--=============== 일반 글 ===============-->
			        <div class="genearlBoard-content filters-active" data-value id="genearlBoard">
			         
			          
						 <div class="activity-data">
		                    <div class="data-names head">
		                        <span class="data-no">번호</span>
		                     	<span class="data-title">제목</span>
		                     	<span class="data-like"><i class="uil uil-thumbs-up"></i>좋아요</span>
		                     	<span class="data-count"><i class="uil uil-eye"></i>조회수</span>
		                    </div>
		                
           				 </div>
					  
			
			        </div>
			
			        <!--=============== 모임 모집글 ===============-->
			        <div class="generaldetailView-content" data-value id="generaldetailView">
			            
			           <div class="activity-data2">
		                    <div class="data-names head">
		                        <span class="data-no">번호</span>
		                     	<span class="data-title">제목</span>
		                     	<span class="data-favorites"><i class="uil uil-star"></i>찜</span>
		                     	<span class="data-count"><i class="uil uil-eye"></i>조회수</span>
		                    </div>
		                
           				 </div>
			        </div>
    			</div>
	    		
	    		
    		</div>
			
			
			
			
			
			
			
		</div>
			
			<!-- 
			<div class="card">
				<div class="img-cover">
					<img class="card-img-top" src="${loginUser.profileImg }" alt="Card image">
				</div>
				<div class="card-body">
					<h2 class="card-title">${loginUser.nickname}</h2>
					<h5 class="card-title">(${loginUser.userId})</h5> <br>
					<span class="card-text">${loginUser.age} / </span>
					<c:choose>
						<c:when test="${loginUser.gender eq 'F'}">
							<span class="card-text">여성</span>
						</c:when>
						<c:otherwise>
							<span class="card-text">남성</span>
						</c:otherwise>
					</c:choose> 
					<br><br>
					<p class="card-text">${loginUser.email}</p>
					<p class="card-text">${loginUser.phone}</p>
					<p class="card-text">${loginUser.enrollDate}</p>
					
				</div>
			</div>
			 -->
			 
        
        
        
        
  
      
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
	
	//전역 변수 설정해 ajax에서 받아온 값 담기
	
	
	
	$(function(){
		feedGeneralBoardList();
		feedMeetBoardList();
	})
	
	
	function feedGeneralBoardList(){
		
		$.ajax({
			url:"feedGeneralBoardList.me",
			data:{
				userId:"${loginUser.userId}"
			}, success: function(data){
				var result="";
				var countLike = 0;
				for(var i in data){
					  
					countLike += data[i].countLike;
					
					result +=  '<div class="data-names">'
                    	   + 	 '<span class="data-no">'+data[i].boardNo+'</span>'
	                   	   +	 '<span class="data-title">'+data[i].boardTitle+'</span>'
                   		   +	 '<span class="data-like">'+data[i].countLike+'</span>'
                   		   +	 '<span class="data-count">'+data[i].count+'</span>'
                 		   +   '</div>';
				}
				$('.activity-data').append(result);
				
				// 좋아요 횟수
				$('.like').text(countLike);
				
			}, error:function(){
			}
		})
	}
	
	function feedMeetBoardList(){
		$.ajax({
			url:"feedMeetBoardList.me",
			data:{
				userId:"${loginUser.userId}"
			}, success: function(data){
				
				var result="";
				var countFavorite = 0;
				for(var i in data){
					
					countFavorite += data[i].countLike;
					
					result +=  '<div class="data-names">'
                 	  	   + 	 '<span class="data-no">'+data[i].boardNo+'</span>'
	                   	   +	 '<span class="data-title">'+data[i].boardTitle+'</span>'
                		   +	 '<span class="data-like">'+data[i].countLike+'</span>'
                		   +	 '<span class="data-count">'+data[i].count+'</span>'
              		  	   +   '</div>';
				}
				
				
				$('.activity-data2').append(result);
				
				// 찜 횟수
				$('.favorite').text(countFavorite);
				
			}, error:function(){
			}
		})
	}
	
	
	
	
	
	
	// 일반글 / 모임모집글 JS
	const tabname = document.querySelectorAll('[data-name]'),
    tabValue = document.querySelectorAll('[data-value]')

	tabname.forEach(tab =>{
	  tab.addEventListener('click', () =>{
	      const target2 = document.querySelector(tab.dataset.name)
	
	      tabValue.forEach(tc =>{
	          tc.classList.remove('filters-active')
	         
	      })
	      target2.classList.add('filters-active')
			
			
	      tabname.forEach(t =>{
	          t.classList.remove('filter-tab-active')
	          
	      })
	      tab.classList.add('filter-tab-active')
	     
	  })
	})
	
	
	</script>
	
	<script>
	

	/*=============== 스크롤 애니매이션 ===============*/
	const sr = ScrollReveal({
	    origin: 'top',
	    distance: '60px',
	    duration: 2500,
	    delay: 400,
	})

	
	sr.reveal(`#card`, {delay: 500})
	sr.reveal(`.profile-info-group`, {interval: 100, delay: 600})
	sr.reveal(`.title`, {delay: 700})
	sr.reveal(`.filters-content`, {delay: 700})
	sr.reveal(`.likes-content`, {delay: 750})
	sr.reveal(`.activity-data`, {delay: 800})
	
	</script>
	
	
</body>
</html>