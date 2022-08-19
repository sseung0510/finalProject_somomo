<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <!----------- CSS --------------->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/feedstyle.css?ver=1.0.6">
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
        
             <!----------------------------- 버튼 ------------------------------------->
			<div class="edit-navigation">
				<div class="menuToggle">
					<i class="uil uil-edit"></i>
					<div class="menu">
						<ul>
							<li><button type="button" data-toggle="modal" data-target="#enrollBoardModal" class="btn btn-primary">일반글</button></li>
							<li><button type="button" data-toggle="modal" data-target="#enrollMeetBoardModal" class="btn btn-primary">모임모집</button></li>
						</ul>
					</div>
				</div>
			</div>
			<script>
				// 글쓰기 버튼 Toggle javascript
				const menu = document.querySelector('.menuToggle');
				menu.addEventListener('click', function() {
					menu.classList.toggle('active');
				});
       		</script>
           	
			<!-----------글 목록 띄워지는 공간----------->
           	<div class="fd-board-area">

       
           	</div>

		</div>
        
        <form action="" method="post" id="postForm">
        	<input type="hidden" name="boardNo" value="">
        </form>
        
        
        <script>
	    	$(function(){
	    		
	    		let currentPage = ${pi.currentPage} ;
	    		//let currentPage = 1 ;
	    		
	    		selectFeedList(currentPage);
	    		
	    		// 무한스크롤 이벤트 처리
				$(window).on('scroll', function(){
					if(${pi.maxPage eq 0}){
						return; // 등록된 게시글이 없을 경우 종료
					}
					
					// 현재 스크롤바 위치 값 (맨 위로 올릴 경우 $(window).scrollTop(0))
					// 스크롤 위치에 따라 변하는 값
					let scrollTop = $(window).scrollTop(); 
					
					// 현재 보고 있는 브라우저 창의 높이
					let windowHeight = $(window).height();
					
					// jsp, html 등 문서의 높이
					// windowHeight 보다 documentHeight가 길면 스크롤이 생김
					let documentHeight = $(document).height();
					
					// 스크롤이 바닥에 닿았을 때
					let isBottom = scrollTop + windowHeight + 5 >= documentHeight;
					//console.log('바닥인가?' + isBottom);
					if(isBottom){
						// 현재가 마지막 페이지일 경우
						if(currentPage == ${pi.maxPage}){
							console.log('종료');
							return; // 종료
						}
						
						currentPage++; // 다음 페이지 요청
						
						// 다음페이지 가져오기
						selectFeedList(currentPage);
					}
				});
				
	    	});
        
        	function selectFeedList(currentPage){
        		
        		console.log("요청페이지:" + currentPage);
        		
        		$.ajax({
        			url : 'list.fd',
        			method : 'POST',
        			data : {
        				userId : '${loginUser.userId}',
        				currentPage : currentPage,
        				boardLimit : '${pi.boardLimit}'
        			},
        			success : function(data){
        				// 응답된 문자열은 html형식(feed/ajaxFeedList.jsp에 응답내용 있음)
						$('.fd-board-area').append(data);

						// 게시글 내용 클릭 시 상세페이지로 이동
		            	$('.fd-board-contents').click(function(){
		            		//let bno = $(this).closest('div[class="fd-board"]').find('input[name="boardNo"]').val();
		            		let boardNo = $(this).parent().find('input[name="boardNo"]').val();
		            		location.href = "detail.fd?boardNo=" + boardNo;
		            	});
						
						// 게시글 삭제
						$('.checkDelete').click(function(){
			        		if(confirm("삭제하시겠습니까?")){
			    				let bno = $(this).closest('div[class="fd-board"]').find('input[name="boardNo"]').val();
			    				$('#postForm input[name="boardNo"]').val(bno);
			    				$('#postForm').attr('action', 'delete.fd').submit();
			    			}
						});
						
						// 좋아요 버튼 클릭 시 ajax로 변경
						$('.likeBtn').click(function(){	
							changeLike(this);
							
						});
       				}
        		});
			}
 
        	
        	function changeLike(likeImg){
        		
        		let bno = $(likeImg).data('bno');
        		let boardType = $(likeImg).data('btype');

				// 기존에 좋아요 안 눌렀을 경우 => 좋아요 등록
        		if($(likeImg).children('img').hasClass('likeN')){ 
        			
        			//console.log('좋아요 등록');
            		
        			$.ajax({
            			url : 'insertLike.fd',
            			method : 'POST',
            			data : { 
            				userId : '${loginUser.userId}',
            				boardNo : bno
            			},
            			success : function(result){
            				
            				if(result == 'success'){
            					if(boardType == 'G'){ // 일반글이었을 경우
            						$(likeImg).html('<img class="likeY" src="resources/img/heart-on.png">');
            					}
            					else{ // 모임모집글이었을 경우
            						$(likeImg).html('<img class="likeY" src="resources/img/star-on.png">');
            					}
            				}
            			},
            			error : function(){
            				//console.log('에러');
            			}
            		});
            	}
        		
        		// 기존에 좋아요 눌렀을 경우 => 좋아요 취소
        		else{ 
        			
        			//console.log('좋아요 취소');
        			
            		$.ajax({
            			url : 'deleteLike.fd',
            			data : { 
            				boardNo : bno,
            				userId : '${loginUser.userId}'
            			},
            			success : function(result){
            				
            				if(result == 'success'){
            					
            					if(boardType == 'G'){ // 일반글이었을 경우
            						$(likeImg).html('<img class="likeN" src="resources/img/heart-off.png">');
            					}
            					else{ // 모임모집글이었을 경우
            						$(likeImg).html('<img class="likeN" src="resources/img/star-off.png">');
            					}
            				}
            			},
            			error : function(){
            				//console.log('에러');
            			}
            		});
        		}

        	}
        	

        </script>
            
	    <!--------------------- Modal 창 --------------------->
	            
	    <!------- 일반글 작성 모달 ------->
		<div class="modal fade" id="enrollBoardModal">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
					    
					<div class="modal-header">
						<h4 class="modal-title w-100 text-center">일반게시글</h4>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>
								
					<div class="modal-body">
						<form action="insertG.fd" method="post" enctype="multipart/form-data">
							<input type="hidden" name="boardWriter" value="${loginUser.userId}">
							<input type="hidden" name="boardType" value="G">
									
							<div><b>지역</b></div>
							<select name="regionNo" class="custom-select" style="width:200px;" required>
								<option value="">지역선택</option>
								<c:forEach var="r" items="${rList}">
									<option value="${r.regionNo}">${r.regionName}</option>
								</c:forEach>
							</select>
							
							<div class="mdm"><b>제목</b></div>
							<input type="text" name="boardTitle" class="form-control" maxlength="50" placeholder="제목을 입력해주세요" required></textarea>
							
							<div class="mdm"><b>내용</b></div>
							<textarea name="boardContent" class="form-control" rows="8" placeholder="내용을 입력해주세요" style="resize: none;" required></textarea>
							
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
		
	    <!------- 모임모집글 작성 모달 ------->
		<div class="modal fade" id="enrollMeetBoardModal">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
					    
					<div class="modal-header">
						<h4 class="modal-title w-100 text-center">모집게시글</h4>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>
								
					<div class="modal-body">
						<form action="insertM.fd" method="post">
							<input type="hidden" name="boardWriter" value="${loginUser.userId}">
							<input type="hidden" name="boardType" value="M">
									
							<div><b>지역</b></div>
							<select name="regionNo" class="custom-select" style="width:150px;" required>
								<option value="">지역선택</option>
								<c:forEach var="r" items="${rList}">
									<option value="${r.regionNo}">${r.regionName}</option>
								</c:forEach>
							</select>
							
							<div class="mdm"><b>제목</b></div>
							<input type="text" name="boardTitle" class="form-control" maxlength="50" placeholder="제목을 입력해주세요" required></textarea>
							
							<div class="mdm"><b>내용</b></div>
							<textarea name="boardContent" class="form-control" rows="8" placeholder="내용을 입력해주세요" style="resize: none;" required></textarea>
	
									
							<div class="mdm"><b>모임날짜</b></div>
							<input type="datetime-local" id="dateTimeLocal" name="meetDate" class="form-control" required>
							
							<div class="mdm"><b>모임장소</b></div>
							<input type="text" name="meetPlace" class="form-control" placeholder="장소입력" required></textarea>
	
							<div class="mdm"><b>모임인원</b></div>
							<input type="number" name="meetTotal" min="2" max="10" class="form-control" style="width:120px;" value="2">
							
							<div class="mdm"><b>모집성별</b></div>
							<select name="meetGender" class="custom-select" style="width:120px;" required>
								<option value="A" selected>누구나</option>
								<option value="F">여성만</option>
								<option value="M">남성만</option>
							</select>
					
							<div class="mdm"><b>모집나이</b></div>
							<label for="anyAge">누구나</label>
							<input type="radio" name="meetAge" id="anyAge" value="A" checked>
							<label for="selectAge">직접입력</label>
							<input type="radio" name="meetAge" id="selectAge" value="selectAge">
							
							<div class="row" id="selectAge-area" style="display:none">
								<div class="col-sm-3">
									<input type="number" min="15" class="selAge form-control" id="minAge" name="minAge" style="width:100px;" value="15">
								</div>
								~
								<div class="col-sm-3">
									<input type="number" class="selAge form-control" id="maxAge" name="maxAge" style="width:100px;" value="15">
								</div>
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
           	$(function(){
           		
            	// 모임날짜 현재날짜부터 선택 가능하게 처리
                let today = new Date(Date.now() - new Date().getTimezoneOffset() * 60000).toISOString().substring(0, 16);
                $('#dateTimeLocal').attr('min', today);
                $('#dateTimeLocal').val(today);
           		
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
			
        <!------ 메인 피드 끝----------->
        
    <!----------- 헤더 , 메인 컨텐츠 끝---------->        
    </section>

    <!------ 오른쪽 사이드 바 --------->
    <div class="right-sidebar">
		<jsp:include page="feedCommon/feed_rightSidebar.jsp" />
    </div>
    <!-- 오른쪽 사이드 바 끝-->
	<script src="${pageContext.request.contextPath}/resources/js/feed.js"></script>
</body>
</html>