<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<!----------- CSS --------------->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/feedstyle.css">
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
	
	<title>일반글상세보기</title>
	
	<style>
		div{
			/*border : 1px solid green;*/
		}
		/**************** 게시글 부분 ********************/
		/* 글 테두리*/
		.fd-board {
			width: 100%;
			background: #fff;
			border-radius: 6px;
			padding: 20px;
			columns:#8d1b1b;
			box-shadow: 2px 2px 10px rgba(0, 0, 0, .2);
		}

		/* 글 상단의 일반글/모임모집 부분*/
		/* 일반글 태그 (General) */
		.fd-board-top a {
			text-decoration: none;
			color: black;
		}
		/* 일반글 태그 (General) */
           .btnBoardTypeG{
	        font-size: 12px;
	        border-radius: 20px;
	        border: 1px solid lightgray;
	        background-color: lightgray;
	        color: black;
	    }
		/* 모임모집 태그 (Meet) */
		.btnBoardTypeM{
	        font-size: 12px;
	        border-radius: 20px;
	        border: 1px solid pink;
	        background-color: pink;
	        color: black;
	    }

		/* 글 상단의 지역(경기도/서울/인천 등등)*/
	    .btnRegionNo{
	    	font-size: 12px;
	        border: 1px solid rgb(248, 248, 154);
	        border-radius: 20px;
	        background-color: rgb(248, 248, 154);
	        color: black;
	    }

		/* 작성자 정보, 시간, ...버튼(아이콘 등록 필요) */
       	.fd-board-writer-date{width: 100%;}

		/* 작성자 프로필이미지*/
		.profileImg-area{
			width: 50px;
			height: 50px;
		}
		.profileImg{
			border-radius: 50%;
			width:100%;
			height:50px;
		}

		/* 글 내용 부분 각 margin*/
		.fdm, .md{margin-top:10px;}

		/* 좋아요/찜 버튼 */
		.likeBtn{
			width:30px;
			height:30px;
		}

		/* 버튼 색 (다른 페이지와 통일 필요)*/
		.btnPink{
			display:block;
			width:100%;
			margin-top: 10px;
			padding: 10px;
			background-color: rgb(250,188,186);
			border: 1px solid rgb(250,188,186);
			border-radius: 20px;
			color: white;
			font-size: 18px;
			font-weight: bold;
		}
		
		.btnPink:hover{
     		background-color: #FEC8C6;
     		border: 1px solid #FEC8C6;
   		}
		
		/**************** 댓글 부분 ********************/
        .reply-input-area {
        	width: 100%;
            height: 50px;
            margin-top: 10px;
        }

        .reply-input-area > textarea {
            width: 78%;
            height: 40px;
            font-size: 12px;
            border-radius: 20px;
            padding-left: 10px;
            padding-right: 10px;
            border: none;
            outline: 1px solid var(--border-color);
            vertical-align:middle;
        }
        .reply-input-area > textarea:focus {
            outline: 1px solid rgb(250,188,186);
        }
        /* 작성 버튼 */
        .reply-input-area > button {
        	height: 40px;
            width: 15%;
            color: white;
            font-weight: bold;
            border: none;
            border-radius: 20px;
            background-color: rgb(250,188,186);
            margin-left: 10px;
            vertical-align:middle;
        }
        
        .reply-content-area .replyWrap {
		  position: relative;
		  min-height: 67px;
		  padding: 14px 10px 14px 44px;
		  border-top: 1px solid #f0f0f0;
		}
		
		.replyWrap .writeInfo {
		  display: flex;
		  text-align: left;
		  overflow: hidden;
		  max-height: 18.59px;
		  font-size: 13px;
		  white-space: normal;
		  max-width: 90%;
		  padding-right: 3px;
		  font-weight: 600;
		  color: #333;
		}
		
		.replyWrap  .writeInfo>.upProfile {
		  position: absolute;
		  left: 25px;
		  top: 15px;
		}
		
		.upProfile {
		  margin-left: -27px;
		}
		
		.upProfile .upProfileImg img{
		  width: 45px;
		  height: 45px;
		  border-radius: 50%;
		}

		.content-area {
		  font-size: 13px;
		  line-height: 1.4;
		  cursor: pointer;
		}
		
		 .reply-btn-area {
		  display: flex;
		  position: relative;
		  vertical-align: top;
		  margin-top: 5px;
		}
		
		.reply-btn-area {
			margin-top:50x;
		}
		
		.rBtn {
			font-weight: bold;
			color: gray;
			font-size: 13px;
			border: none;
			background: none;
			margin-right: 5px;
		}

		.reply-replyBtn {
		  margin-left: 10px;
		}
		
		#mUpReplyContent {
			overflow: hidden;
			resize: none;
		}
    </style>
</head>
<body>
	<!--------------------- 왼쪽 사이드 바 ------------------------>
	<jsp:include page="feedCommon/feed_leftSidebar.jsp" />
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
	        <!-- 글 내용 띄우줄 공간 -->
			<div class="board-area">
				<div class="fd-board">
					<div class="fd-board-top">
						<a href="#" class="tag btnBoardTypeG">일반글</a>&nbsp;
					    <a href="#" class="tag btnRegionNo">${fb.regionName}</a>
			   		</div>
					<table class="fd-board-writer-date">
						<tr>
							<td rowspan="2" class="profileImg-area">
								<c:choose>
									<c:when test="${fb.profileImg ne null}">
										<img class="profileImg" src="${fb.profileImg}" style="width:100%;">
									</c:when>
									<c:otherwise>
										<img class="profileImg" src="resources/img/member/profile_img.png" style="width:100%;">
									</c:otherwise>
								</c:choose>
							</td>
							<td>${fb.nickname}</td>
							<c:if test="${loginUser.userId eq fb.boardWriter}">
								<td align="right">
									<div class="form-icon">
										<i class='bx bx-dots-vertical-rounded feed'>
										<ul class="feed-link">
											<li><a class="updateGeneralBoard">수정</a></li>
											<li><a class="checkDelete">삭제</a></li>
										</ul>
										</i>
									</div>
								</td>
							</c:if>
						</tr>
						<tr><td class="fd-board-date">${fb.boardDate}</td></tr>
					</table>
					<div class="fd-board-contents fdm">
						<div class="title">
							${fb.boardTitle}
						</div>
						<div class="content fdm">
							<% pageContext.setAttribute("newLine", "\n"); %>
							<p id="content">${fn:replace(fb.boardContent, newLine, '<br/>')}</p>
							<c:if test="${not empty fatList}">
								<c:forEach var="fat" items="${fatList}">
									<img src="${fat.changeName}" style="width:100%; height:200px;">
								</c:forEach>
							</c:if>
						</div>
					</div>
					<div style="margin-top:20px;">
						<span class="likeBtn">
							<img class="likeN" src="resources/img/heart-off.png">
						</span>
						<span class="countLike">좋아요${fb.countLike}개</span>
					</div>
				
					<div class="reply-area">
						<div id="replyCount">댓글 0개</div>
		                <div class="reply-input-area">
	                        <textarea id="replyContent" placeholder="댓글을 입력해주세요..." rows="1" style="resize: none;" ></textarea>
	                        <button id="replyBtn" onclick="insertReply();">작성</button>
	               	 	</div>
	               	 	<!-- ajax 댓글 목록 출력 부분 -->
	               	 	<div class="reply-content-area">

	               	 	</div>
					</div>
				</div>
			</div>
		</div>
	

        <%-- 게시글 삭제용 (POST방식) --%> 
		<form action="" method="post" id="postForm">
     		<input type="hidden" name="boardNo" value="">
     	</form>
     
     	
		<script>
        	$(function(){
        		// 좋아요 등록 여부 확인
        		checkLike();
        		// 댓글 목록 가져오기
        		selectReplyList();
        	});
        	
        	//-----------------------------------------------
        	//------------------- 댓글 관련 --------------------
        	//-----------------------------------------------
        	// ajax 댓글 목록 가져오기
        	function selectReplyList(){
        		$.ajax({
        			url : 'selectReplyList.fd',
        			data : {
        				boardNo : '${fb.boardNo}'
        			},
        			success : function(list){
        				
        				// 총 댓글 수 출력
        				$('#replyCount').html('댓글 ' + list.length + '개');
        				
        				let result = '';
        				for(let i in list){
        					// 일반 댓글일 경우
        					if(list[i].rdepth == 0){
	        					result += '<div id="reply-groupNo' + list[i].rgroup + '">'
        						        + 	'<div id="replyNo' + list[i].replyNo + '" class="replyWrap reply">';
        					}
        					// 답글일 경우
        					else{
        						result += 	'<div id="replyNo' + list[i].replyNo + '" class="replyWrap re-reply" style="margin-left:35px;">';
        					}
        					// 공통 부분(작성자, 작성일, 프로필사진, 댓글 내용)
       						result +=			'<div class="writeInfo">' + list[i].nickname + '<span style="margin-left:5px; color:gray;">' + list[i].replyDate + '</span>'
       						        +				'<a class="upProfile">'
		                            +					'<span class="upProfileImg">'
		                            +						'<img src="' + list[i].profileImg + '">'    
		                            +					'</span>'        
		                            + 				'</a>'
		                            +			'</div>'
		                        	+			'<div class="content-area">'
		                        	+				'<div class="content">' + list[i].replyContent.replaceAll("\n", "<br/>") + '</div>'
		                        	+				'<div class="reply-btn-area" data-reply_no="' + list[i].replyNo + '">';
                        	// 일반 댓글일 경우, 답글달기 버튼 표시
                        	if(list[i].rdepth == 0){
                        		result +=				'<button class="rBtn reReplyBtn showArea" data-rgroup="' + list[i].rgroup + '">답글달기</button>';
                        	}
                        	// 댓글작성자일 경우, 댓글 수정/삭제 버튼 표시 + 삭제되지 않은 댓글일 경우
                            if(list[i].replyWriter == '${loginUser.userId}' && list[i].replyContent != '삭제된 댓글입니다'){
                            	result +=				'<button class="rBtn upReplyBtn">수정</button>'
                            			+				'<button class="rBtn delReplyBtn">삭제</button>';
                            }
                        	
                        	result +=				'</div>'
                        			+			'</div>'
	                                +		'</div>';
	                        // 같은 댓글 그룹 중 마지막 댓글일 경우 <div id="reply-groupNo" + list[i].rgroup > 닫기        
	                        if(list[i].isLastRgroupReply == 'Y'){
	                        	result +='</div>';
	                        }
							
        				}
        				
        				// 댓글목록에 전체 댓글 출력
        				$('.reply-content-area').html(result);
        			}
        		});
        	}
        	
        	// ajax 댓글 작성
        	function insertReply(){
        		if($('#replyContent').val().trim() != ''){
	        		$.ajax({
	        			url : 'insertReply.fd',
	        			data : {
	        				boardNo : '${fb.boardNo}',
	        				replyWriter : '${loginUser.userId}',
	        				replyContent : $('#replyContent').val()
	        			},
	        			success : function(result){
	        				if(result == 'success'){
	        					selectReplyList();
	        					$('#replyContent').val('');
	        					//$(document).scrollTop($(document).height());
	        				}
	        			},
	        			error : function(){
	        				console.log('에러');
	        			}
	        		});
        		}
        		else{
        			alert('내용을 입력해주세요');
        		}
        	}
        	
       		// 답글버튼(답글달기,답글취소) 클릭 시
       		$(document).on('click', '.reReplyBtn', function(){
       			
				let rgroupNo = $(this).data('rgroup');
				// 답글달기 버튼일 경우
				if($(this).hasClass('showArea')){
					let reReplyArea = '<div id="inputArea' + rgroupNo + '" class="reply-input-area" style="margin-left:40px;">'
				   					+ 	'<textarea class="reContent" type="text" placeholder="댓글을 입력해주세요..." rows="2" style="resize: none;"></textarea>'
				   					+ 	'<button class="replyBtn" onclick="insertReReply(this,' + rgroupNo +');">작성</button>'
				  					+ '</div>';
				  					
					$('#reply-groupNo' + rgroupNo).append(reReplyArea);
					
					$(this).html('답글취소');
					$(this).removeClass('showArea');
				}
				// 답글취소 버튼일 경우
				else {
					$('#inputArea' + rgroupNo).remove();
					$(this).html('답글달기');
					$(this).addClass('showArea');
				}
			});
        	
        	// ajax 답글(대댓글) 작성
        	function insertReReply(target, rgroupNo){
        		
				let inputArea = $(target).parent().attr('id'); // 답글 작성 칸 id
				let reContent = $(target).siblings('textarea').val().trim(); // 답글 작성 내용

				if(reContent != ''){
					$.ajax({
						url : 'insertReReply.fd',
						data : {
							boardNo : '${fb.boardNo}',
							replyWriter : '${loginUser.userId}',
							replyContent : reContent,
							rgroup : rgroupNo
						},
						success : function(result){
							if(result == 'success'){
								//$('#'+inputArea).remove(); // 해당 답변 작성 칸 없애기
								selectReplyList();
							}
						},
	        			error : function(){
	        				console.log('에러');
	        			}
					});
				}
				else {
					alert('내용을 입력해주세요');
				}	
        	}
       		
        	// 댓글 수정 버튼 클릭 시
        	$(document).on('click', '.upReplyBtn', function(){
        		
        		let replyNo = $(this).parent().data('reply_no'); // 해당 댓글 번호
        		let replyContent = $(this).parent().parent().find('.content').html(); // 해당 댓글 내용
        		// 댓글 수정 모달창에 값 전달 한 뒤 띄우기
				$('#mUpReplyNo').val(replyNo);
        		$('#mUpReplyContent').val(replyContent.replaceAll("<br>", "\n"));
        		$('#updateReplyModal').modal('toggle');
        	});
        	
         	// ajax 댓글 수정 모달창 안에서 수정 버튼 클릭 시
         	$(document).on('click', '#mUpdateReplyBtn', function(){
         		if($('#mUpReplyContent').val().trim() != ''){
	         		$.ajax({
	         			url : 'updateReply.fd',
	         			method : 'POST',
	         			data : $('#updateReplyForm').serialize(),
	         			success : function(result){
	         				if(result == "success"){
	         					//!!!!해당 댓글 부분만 변경되게 수정 필요!!!!
	         					selectReplyList();
	         				}
	         				else{
	         					alert('댓글 수정 실패');
	         				}
	         				$('#updateReplyModal').modal('hide');
	         			},
	         			error : function(){
	         				console.log('에러');
	         			}
	         		});
         		}
         		else{
         			alert('내용을 입력해주세요');
         		}
         	});
        	
       		// ajax 댓글 삭제 버튼 클릭 시
       		$(document).on('click', '.delReplyBtn', function(){
       			
				let replyNo = $(this).parent().data('reply_no'); // 해당 댓글 번호
       			let replyContent = $(this).parent().parent().find('.content'); // 해당 댓글 내용 요소
       			let upReplyBtn = $(this).parent().find('.upReplyBtn'); // 해당 댓글수정버튼
       			let delReplyBtn = $(this).parent().find('.delReplyBtn'); // 해당 댓글삭제버튼
				
        		if(confirm("댓글을 삭제하시겠습니까?")){
        			$.ajax({
        				url : 'deleteReply.fd',
        				data : {
        					replyNo : replyNo
        				},
        				success : function(result){
        					if(result == 'deleteReply'){ // 답변 없는 댓글일 경우 => 댓글 삭제 (STATUS='N')
        						$('#replyNo' + replyNo).remove(); // 해당 답변 지우기
        					}
        					else if(result == 'deleteContent'){ // 답변 달린 댓글일 경우 => 댓글 내용 삭제
        						replyContent.html('삭제된 댓글입니다');
        						upReplyBtn.attr('style', 'display:none;'); // 해당 댓글수정버튼 숨기기
        						delReplyBtn.attr('style', 'display:none;'); // 해당 댓글삭제버튼 숨기기
        					}
        				},
        				error : function(){
        					console.log('에러');
        				}
        			});
    			}
			});
        	
       		
			//-----------------------------------------------
       		//------------------- 좋아요 관련 -------------------
       		//-----------------------------------------------
       		// 좋아요 버튼 클릭 시
       		$(document).on('click', '.likeBtn', function(){
				changeLike(this);		
       		});

        	// ajax 좋아요 등록 여부 확인
    		function checkLike(){
        		$.ajax({
        			url : 'checkLike.fd',
        			method : 'POST',
        			data : {
        				userId : '${loginUser.userId}',
        				boardNo : '${fb.boardNo}'
        			},
        			success : function(result){
        				if(result == 'Y'){
        					$('.likeBtn').html('<img class="likeY" src="resources/img/heart-on.png">');
        				}
        				else{
        					$('.likeBtn').html('<img class="likeN" src="resources/img/heart-off.png">');
        				}
        				
        			},
        			error : function(){
        				console.log('에러');
        			}
        		});
    		}
    		
			// ajax 좋아요 클릭 이벤트 (등록/취소)
     		function changeLike(likeImg){
				// 기존에 좋아요 안 눌렀을 경우 => 좋아요 등록
	     		if($(likeImg).children('img').hasClass('likeN')){ 
	     			//console.log('좋아요 등록');
	     			$.ajax({
	         			url : 'insertLike.fd',
	         			method : 'POST',
	         			data : { 
	         				userId : '${loginUser.userId}',
	         				boardNo : '${fb.boardNo}'
	         			},
	         			success : function(result){
	         				if(result == 'success'){
	         					// 채워진 별로 변경
	        						$(likeImg).html('<img class="likeY" src="resources/img/heart-on.png">');
	        						// 좋아요(찜) 개수 변경
	        						checkCountLike();
	         				}
	         			},
	         			error : function(){
	         				console.log('에러');
	         			}
	         		});
	         	}
	     		// 기존에 좋아요 눌렀을 경우 => 좋아요 취소
	     		else{ 
	     			//console.log('좋아요 취소');
	         		$.ajax({
	         			url : 'deleteLike.fd',
	         			data : { 
	         				boardNo : '${fb.boardNo}',
	         				userId : '${loginUser.userId}'
	         			},
	         			success : function(result){
	         				if(result == 'success'){
	         					// 빈 별로 변경
	         					$(likeImg).html('<img class="likeN" src="resources/img/heart-off.png">');
	         					// 좋아요(찜) 개수 변경
	         					checkCountLike();
	         				}
	         			},
	         			error : function(){
	         				console.log('에러');
	         			}
	         		});
	     		}
	
	     	}
    		
        	// ajax 좋아요 개수 가져오기
    		function checkCountLike(){
    			$.ajax({
    				url : 'countLike.fd',
    				method : 'POST',
    				data : {
    					boardNo : '${fb.boardNo}'
    				},
    				success : function(count){
    					$('.countLike').html('좋아요'+ count + '개');
    				},
    				error : function(){
    					console.log('에러');
    				}
    			});
    		}
    		
        	//------------------------------------------------------
       		//------------------- 게시글 수정/삭제 관련 -------------------
       		//------------------------------------------------------
      		// 게시글 수정/삭제 DROPDOWN
		    $(document).on('click', '.feed', function(){
		    	const feed = document.querySelector('.feed');
		        const dropdownFeed = feed.querySelector('.feed-link');
		        dropdownFeed.classList.toggle('show');
		    });
        	
       		// (게시글)수정 버튼 클릭 시
			$(document).on('click', '.updateGeneralBoard', function(){
				setModalContent(); // 수정 모달창에 기존 게시글 내용 세팅
				$('#updateGeneralBoardModal').modal('toggle'); // 수정 모달창 띄우기
			});
               		
			// (게시글)삭제 버튼 클릭 시
			$(document).on('click', '.checkDelete', function(){
        		if(confirm("삭제하시겠습니까?")){
    				$('#postForm input[name="boardNo"]').val(${fb.boardNo});
    				$('#postForm').attr('action', 'delete.fd').submit();
    			}
			});	
        	
        	// ajax 수정버튼 클릭 시 모달창 내용 세팅
    		function setModalContent(){
    			$.ajax({
    				url : 'getModalContent.fd',
    				data : {
    					boardNo : '${fb.boardNo}'
    				},
    				success : function(data){
    					$('#gmRegion option[value=' + data.regionNo +']').attr('selected', true);
    					$('#gmTitle').val(data.boardTitle);
    					$('#gmContent').val(data.boardContent);
    					
    					// !!!!!!!!!!!!!!!!!!!!첨부파일 세팅 필요 => controller 수정!!!!!!!!!!!!!!!!!!!!!
    				}
    			});
        	}
    		/*
           	// ajax 게시글 수정 후 새로 정보 가져오기
           	function selectMeetBoard(){
           		$.ajax({
           			url : 'selectBoard.fd',
           			method : 'POST',
           			data : {
           				boardNo : '${fb.boardNo}'
           			},
           			success : function(data){
           				// 응답된 문자열은 html형식(feed/ajaxMeetDetail.jsp에 응답내용 있음)
           				$('.board-area').html(data);
           				checkLike();
           			},
           			error : function(){
           				console.log('에러');
           			}
           		});
           	}
            	
           	
         	// 수정 모달창 안에서 글수정 버튼 클릭 시
         	$(document).on('click', '#updateGeneralBtn', function(){
         			
         		//var formData = new FormData($('#updateMeetForm')[0]);
         		//contentType : false,
         		//processData : false
         		$.ajax({
         			url : 'updateM.fd',
         			method : 'POST',
         			data : $('#updateGeneralForm').serialize(),
         			success : function(result){
         				$('#updateGeneralBoardModal').modal('hide');
         				if(result == "success"){
             				selectMeetBoard();
         				}
         				else{
         					alert('게시글 수정 실패');
         				}
         			},
         			error : function(){
         				console.log('에러');
         			}
         		});
         	});
           	*/
		</script>
		
		<!---------------- 모달창 ---------------->
		<!------- 댓글 수정 모달 ------->
		<div class="modal fade" id="updateReplyModal">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
					    
					<div class="modal-header">
						<h4 class="modal-title w-100 text-center">댓글 수정</h4>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>
								
					<div class="modal-body">
						<form id="updateReplyForm" method="post">
							<input type="hidden" id="mUpReplyNo" name="replyNo" value="">
							
							<textarea id="mUpReplyContent" name="replyContent" class="form-control" rows="5"></textarea>
							
							<div style="margin-top:10px;">
								<button type="button" id="mUpdateReplyBtn" class="btnPink">수정</button>
							</div>
						</form>
					</div>				
					
				</div>
			</div>
		</div>
		
	    <!------- 일반글 수정 모달 ------->
		<div class="modal fade" id="updateGeneralBoardModal">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
					    
					<div class="modal-header">
						<h4 class="modal-title w-100 text-center">일반게시글</h4>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>
								
					<div class="modal-body">
						<form id="updateGeneralForm" method="post" enctype="multipart/form-data">
							<input type="hidden" name="boardNo" value="${fb.boardNo}">
							<input type="hidden" name="boardType" value="G">
									
							<div><b>지역</b></div>
							<select id="gmRegion" name="regionNo" class="custom-select" style="width:200px;" required>
								<option value="">지역선택</option>
								<c:forEach var="r" items="${rList}">
									<option value="${r.regionNo}">${r.regionName}</option>
								</c:forEach>
							</select>
							
							<div class="mdm"><b>제목</b></div>
							<input type="text" id="gmTitle" name="boardTitle" class="form-control" maxlength="50" placeholder="제목을 입력해주세요" required></textarea>
							
							<div class="mdm"><b>내용</b></div>
							<textarea id="gmContent" name="boardContent" class="form-control" rows="8" placeholder="내용을 입력해주세요" style="resize: none;" required></textarea>
							
							<div class="mdm file-area">
								<input type="file" name="file1" id="file1"><input type="button" value="파일 삭제" onclick="fileReset(1);">
								<input type="file" name="file2" id="file2"><input type="button" value="파일 삭제" onclick="fileReset(2);">
								<input type="file" name="file3" id="file3"><input type="button" value="파일 삭제" onclick="fileReset(3);">
								<input type="file" name="file4" id="file4"><input type="button" value="파일 삭제" onclick="fileReset(4);">
							</div>
							
							<div style="margin-top:10px;">
								<button type="submit" class="btnPink">글작성</button>
							</div>
						</form>
					</div>				
					
				</div>
			</div>
		</div>
		
		<script>
			// 첨부파일 삭제
			function fileReset(num){
				$('#file'+num).val('');
			}
		</script>
		

        <!-- 메인 피드 끝 -->
	<!----------- 헤더 , 메인 컨텐츠 끝---------->    
    </section>
    

    <!------ 오른쪽 사이드 바 --------->
    <div class="right-sidebar">
		<jsp:include page="feedCommon/feed_rightSidebar.jsp" />
    </div>
    <!-- 오른쪽 사이드 바 끝-->
    
    <script src="${pageContext.request.contextPath}/resources/js/feed.js"></script>
    <br><br><br><br>
</body>
</html>