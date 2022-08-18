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
	
	<title>모임모집글상세보기</title>
	
	<style>
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
   		.btnDisabled{
			display:block;
			width:100%;
			margin-top: 10px;
			padding: 10px;
			background-color: rgb(190, 190, 190);
			border: rgb(190, 190, 190);
			border-radius: 20px;
			color: white;
			font-size: 18px;
			font-weight: bold;
		}
    </style>
</head>
<body>
	<!--------------------- 왼쪽 사이드 바 ------------------------>
	<div class="left-sidebar">
		<jsp:include page="feedCommon/feed_leftSidebar.jsp" />
	</div>
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
						<a href="#" class="tag btnBoardTypeM">모임모집</a>&nbsp;
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
											<li><a class="updateMeetBoard">수정</a></li>
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
							<c:choose>
								<c:when test="${fb.countMember lt fb.meetTotal}">
									<b>모집중&nbsp;</b>
								</c:when>
								<c:otherwise>
									<b>모집마감&nbsp;</b>
								</c:otherwise>
							</c:choose>
							${fb.boardTitle}
						</div>
						<div class="content fdm">
							<% pageContext.setAttribute("newLine", "\n"); %>
							<p id="content">${fn:replace(fb.boardContent, newLine, '<br/>')}</p>
						</div>
						<div class="meet-info fdm" style="padding:5px;">
							<div><img src="resources/img/test1.jpg" width="100%"></div>
							<div class="fdm">
								👉${fb.meetPlace} | ${fb.meetDate}<br>
								👉${fb.meetCondition}<br>
								👉${fb.countMember}/${fb.meetTotal}명 참여
							</div>
						</div>
					</div>
					<div style="margin-top:20px;">
						<span class="likeBtn">
							<img class="likeN" src="resources/img/star-off.png">
						</span>
						<span class="countLike">찜${fb.countLike}개</span>
					</div>
					<div class="fdm">${fb.countMember}명 참여중</div>
				
					<div class="joinChatBtn">
						<c:choose>
							<c:when test="${fb.countMember lt fb.meetTotal}">
								<button type="button" class="btnPink" onclick="checkJoinCondition();">모임 참여 신청</button>
							</c:when>
							<c:otherwise>
								<button type="button" class="btnDisabled" disabled>마감되었습니다</button>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>
		</div>
	
        <!-- 게시글 삭제용으로 사용 --> 
		<form action="" method="post" id="postForm">
     		<input type="hidden" name="boardNo" value="">
     	</form>
     
     	
		<script>
        	$(function(){
        		// 좋아요 등록 여부 확인
        		checkLike();
        		// 모임 참여자 여부 확인
        		checkChatMember();
        	});
        	
        	//------------------------------------------------------
       		//------------------- 모임(채팅) 관련 -------------------
       		//------------------------------------------------------
        	// ajax 모임 참여자 여부 확인
        	function checkChatMember(){
        		$.ajax({
        			url : 'checkChatMember.fd',
        			method : 'POST',
        			data : {
        				roomNo : '${fb.roomNo}',
        				userId : '${loginUser.userId}'
        			},
        			success : function(result){
        				if(result == 'Y'){
        					$('.joinChatBtn').html('<button type="button" class="btnPink" onclick="moveChat();">채팅 입장</button>');
        				}
        			},
        			error : function(){
        				console.log('에러');
        			}
        		});
        	}
        	
        	// 채팅방으로 이동
        	function moveChat(){
        		// 채팅 개발 후 경로 설정 필요
        		alert('feedMeetDetailView.jsp : 해당 채팅방으로 경로 설정 필요');
        		location.href = '#';
        	}
        	
			// 모임참여 버튼 클릭 시
			function checkJoinCondition(){
				$.ajax({
					url : 'checkJoinCondition.fd',
					method : 'POST',
					data : {
						boardNo : '${fb.boardNo}',
						age : '${loginUser.age}',
						gender : '${loginUser.gender}'
					},
					success : function(result){
						if(result == "isSatisfy"){
							// 모집조건 충족 시, 모임 참여 안내 모달창 띄우기
							$('#joinChatModal').modal('toggle');
						}
						else{
							alert('모집조건에 부합하지 않습니다.');
						}
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
			$(document).on('click', '.updateMeetBoard', function(){
				setModalContent(); // 수정 모달창 내용 세팅
				$('#updateMeetBoardModal').modal('toggle'); // 수정 모당창 띄우기
			});
               		
			// (게시글)삭제 버튼 클릭 시
			$(document).on('click', '.checkDelete', function(){
        		if(confirm("삭제하시겠습니까?")){
    				$('#postForm input[name="boardNo"]').val(${fb.boardNo});
    				$('#postForm').attr('action', 'delete.fd').submit();
    			}
			});	
    		

			//-----------------------------------------------
       		//------------------- 좋아요 관련 -------------------
       		//-----------------------------------------------
        	// ajax 좋아요 등록 여부 확인
    		function checkLike(){
        		$.ajax({
        			url : 'checkLike.fd',
        			method : 'POST',
        			data : {
        				boardNo : '${fb.boardNo}',
        				userId : '${loginUser.userId}'
        			},
        			success : function(result){
        				if(result == 'Y'){
        					$('.likeBtn').html('<img class="likeY" src="resources/img/star-on.png">');
        				}
        				else{
        					$('.likeBtn').html('<img class="likeN" src="resources/img/star-off.png">');
        				}
        				
        			},
        			error : function(){
        				console.log('에러');
        			}
        		});
    		}
			
       		// 좋아요(찜) 버튼 클릭 시
       		$(document).on('click', '.likeBtn', function(){
				changeLike(this); // 좋아요(찜) 사진 변경		
       		});
        	
			// ajax 좋아요 클릭 이벤트 (등록/취소)
     		function changeLike(likeImg){

				// 기존에 좋아요 안 눌렀을 경우 => 좋아요 등록
	     		if($(likeImg).children('img').hasClass('likeN')){ 
	     			
	     			//console.log('좋아요 등록');
	         		
	     			$.ajax({
	         			url : 'insertLike.fd',
	         			method : 'POST',
	         			data : { 
	        				boardNo : '${fb.boardNo}',
	        				userId : '${loginUser.userId}'
	         			},
	         			success : function(result){
	         				if(result == 'success'){
	         					// 채워진 별로 변경
        						$(likeImg).html('<img class="likeY" src="resources/img/star-on.png">');
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
	         					$(likeImg).html('<img class="likeN" src="resources/img/star-off.png">');
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
    					$('.countLike').html('찜'+ count + '개');
    				},
    				error : function(){
    					console.log('에러');
    				}
    			});
    		}
    		
        	// ajax 수정버튼 클릭 시 모달창 내용 세팅
    		function setModalContent(){
    			$.ajax({
    				url : 'getModalContent.fd',
    				data : {
    					boardNo : '${fb.boardNo}'
    				},
    				success : function(data){
    					$('#mRegion option[value=' + data.regionNo +']').attr('selected', true);
    					$('#mTitle').val(data.boardTitle);
    					$('#mContent').val(data.boardContent);
    					$('#dateTimeLocal').val(data.meetDate.replace(' ', 'T'));
    					$('#mMeetPlace').val(data.meetPlace);
    					$('#mMeetTotal').val(data.meetTotal);
    					$('input[name=meetGender][value=' + data.meetGender +']').attr('checked', true);
    					
						if(data.meetAge == 'A'){
							$('#anyAge').attr('checked', true);
						}
						else{
							$('#minAge').val(Number(data.minAge));
							$('#maxAge').val(Number(data.maxAge)); 
							$('#selectAge').attr('checked', true);
							$('#selectAge-area').attr('style', 'display:"";'); // 나이 입력 칸 보이게
						}
    				}
    			});
        	}
    			
           	// ajax 게시글 수정 후 새로 정보 가져오기
           	function selectMeetBoard(){
           		$.ajax({
           			url : 'selectNewBoard.fd',
           			method : 'POST',
           			data : {
           				boardNo : '${fb.boardNo}'
           			},
           			success : function(data){
           				// 응답된 문자열은 html형식(feed/ajaxMeetDetail.jsp에 응답내용 있음)
           				$('.board-area').html(data);
           				checkLike();
           				checkChatMember();
           			},
           			error : function(){
           				console.log('에러');
           			}
           		});
           	}
           	
         	// ajax 수정 모달창 안에서 글수정 버튼 클릭 시
         	$(document).on('click', '#updateMeetBtn', function(){
         		$.ajax({
         			url : 'updateM.fd',
         			method : 'POST',
         			data : $('#updateMeetForm').serialize(),
         			success : function(result){
         				if(result == "success"){
             				selectMeetBoard();
         				}
         				else{
         					alert('게시글 수정 실패');
         				}
         				$('#updateMeetBoardModal').modal('hide');
         			},
         			error : function(){
         				console.log('에러');
         			}
         		});
         	});
    	
		</script>

	   <!------- 모임모집글 수정 모달 ------->
		<div class="modal fade" id="updateMeetBoardModal">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
					    
					<div class="modal-header">
						<h4 class="modal-title w-100 text-center">모집게시글 수정</h4>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>
								
					<div class="modal-body">
						<form id="updateMeetForm" method="post">
							<input type="hidden" name="boardNo" value="${fb.boardNo}">
							<input type="hidden" name="boardType" value="M">
									
							<div><b>지역</b></div>
							<select id="mRegion" name="regionNo" class="custom-select" style="width:150px;" required>
								<option value="">지역선택</option>
								<c:forEach var="r" items="${rList}">
									<option value="${r.regionNo}">${r.regionName}</option>
								</c:forEach>
							</select>
							
							<div class="md"><b>제목</b></div>
							<input type="text" id="mTitle" name="boardTitle" class="form-control" maxlength="50" placeholder="제목을 입력해주세요" required>
							
							<div class="md"><b>내용</b></div>
							<textarea id="mContent" name="boardContent" class="form-control" rows="8" placeholder="내용을 입력해주세요" style="resize: none;" required></textarea>
			
							<div class="md"><b>모임날짜</b></div>
							<input type="datetime-local" id="dateTimeLocal" name="meetDate" class="form-control" required>
							
							<div class="md"><b>모임장소</b></div>
							<input type="text" id="mMeetPlace" name="meetPlace" class="form-control" placeholder="장소입력" required>
			
							<div class="md"><b>모임인원</b></div>
							<input type="number" id="mMeetTotal" name="meetTotal" min="2" max="10" class="form-control" style="width:120px;">
							
							<div class="md"><b>모집성별</b></div>
							<input type="radio" id="any" name="meetGender" value="A">
							<label for="any">누구나</label>&nbsp;
							<input type="radio" id="onlyM"name="meetGender" value="M">
							<label for="onlyM">남성만</label>&nbsp;
							<input type="radio" id="onlyF" name="meetGender" value="F">
							<label for="onlyF">여성만</label>
					
							<div class="md"><b>모집나이</b></div>
							<input type="radio" name="meetAge" id="anyAge" value="A">
							<label for="anyAge">누구나</label>&nbsp;
							<input type="radio" name="meetAge" id="selectAge" value="selectAge">
							<label for="selectAge">직접입력</label>
							
							<div class="row" id="selectAge-area" style="display:none">
								<div class="col-sm-3">
									<input type="number" min="15" class="selAge form-control" id="minAge" name="minAge" style="width:100px;" value="15">
								</div>
								~
								<div class="col-sm-3">
									<input type="number" class="selAge form-control" id="maxAge" name="maxAge" style="width:100px;" value="15">
								</div>
							</div>
							
							<div class="md">
								<button type="button" id="updateMeetBtn" class="btnPink">글수정</button>
							</div>
						</form>
					</div>				
							
				</div>
			</div>
		</div>
		
		<script>
			// =========모달 창 관련==========
			$(function(){
         		// 모임날짜 현재날짜부터 선택 가능하게 처리
             	let today = new Date(Date.now() - new Date().getTimezoneOffset() * 60000).toISOString().substring(0, 16);
             	$('#dateTimeLocal').attr('min', today);
             
        		// 모집나이 클릭 이벤트 처리
        		$('input:radio[name=meetAge]').click(function(){
        			if($('input[name=meetAge]:checked').val() == 'selectAge'){ // 모집나이>직접입력 선택했을 경우
        				$('#selectAge-area').attr('style', 'display:"";'); // 나이 입력 칸 보이게
        				$('.selAge').attr('required', true); // 나이 입력 필수
        			}
        			else{ // 모집나이>누구나 선택했을 경우
        				$('#selectAge-area').attr('style', 'display:none;'); // 나이 입력 칸 안 보이게
        				$('.selAge').attr('required', false); // 나이 입력 필수 x
        			}
        		});
        		
        		// 최대나이가 입력된 최소나이 이상이 되게끔 처리
    			$('#minAge').on('focus keyup input', function(){
        			let minAge = $(this).val();
        			
        			if($('#maxAge').val() < minAge){
        				$('#maxAge').val(minAge);
        			}
        			$('#maxAge').attr('min', minAge);	
        		});
			});
		</script>
		
		<!------- 모임 참여 모달 ------->
		<div class="modal fade" id="joinChatModal">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
					    
					<div class="modal-header">
						<h4 class="modal-title w-100 text-center">모임 참여</h4>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>
								
					<div class="modal-body" align="center">
						<form action="joinChat.fd" method="post">
							<input type="hidden" name="boardNo" value="${fb.boardNo}">
							<input type="hidden" name="roomNo" value="${fb.roomNo}">
							<input type="hidden" name="userId" value="${loginUser.userId}">
									
							<div><b>모임에 참여하면 그룹 채팅방에서 대화할 수 있어요</b></div>
							<div>구체적인 약속, 장소, 날짜 등을 함께 정해보세요.</div>
							<br>
		
							<div class="md">
								<button type="submit" class="btnPink">네, 참여할게요</button>
							</div>
						</form>
					</div>				
							
				</div>
			</div>
		</div>

        <!-- 메인 피드 끝 -->
	<!----------- 헤더 , 메인 컨텐츠 끝---------->    
    </section>
    

    <!------ 오른쪽 사이드 바 --------->
    <div class="right-sidebar">
		<jsp:include page="feedCommon/feed_rightSidebar.jsp" />
    </div>
    <!-- 오른쪽 사이드 바 끝-->

    <script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
    <br><br><br><br>
</body>
</html>