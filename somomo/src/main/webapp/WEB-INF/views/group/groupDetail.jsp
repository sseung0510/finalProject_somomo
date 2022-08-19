<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <!----------- CSS --------------->
    <link rel="stylesheet" href="resources/css/groupHeader.css?ver=1.0.6">
    <link rel="stylesheet" href="resources/css/style2.css?ver=1.1.5">
    <link rel="stylesheet" href="resources/css/groupLeft.css?ver=1.0.5">
    <link rel="stylesheet" href="resources/css/groupRight.css?ver=1.0.4">
    <!----------- 아이콘 CSS 링크 ------->
    <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css">
    <script src="https://kit.fontawesome.com/567fbbaed5.js" crossorigin="anonymous"></script>
    <!----------- 아이콘 CSS 링크 version 2------->
    <!-- Boxicons CSS -->
    <link href='https://unpkg.com/boxicons@2.1.1/css/boxicons.min.css' rel='stylesheet'>
    <!-- jquery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <title>소모모 - ${g.groupName}</title> 
</head>
<body>
	<!--------------------- 헤더 ------------------------>
	<jsp:include page="groupDetailCommon/groupHeader.jsp"/>
    <!--------------------- 헤더 ------------------------>

    <!----------------------- 메인 컨텐츠 ------------------------------>
    <div class="main-section">

        <div class="main-left">
            <jsp:include page="groupDetailCommon/leftSidebar.jsp"/>
        </div>

        <div class="main-middle">
            <!---------------------- 글쓰기 Modal 창 --------------------->
            <jsp:include page="groupDetailCommon/modal.jsp"/>
			
			<!-- 공지사항 -->
			<!-- <div>
				<div class="notice">
					<h3>공지사항</h3>
					<ul>
						<li class="noticeItem" style="font-size:14px; border-top:1px solid #f5f5f5;">
							<a href="#">공지사항 내용 들어갈 자리</a>
						</li>
						<li class="noticeItem" style="font-size:14px; border-top:1px solid #f5f5f5;">
							<a href="#">공지사항 내용 들어갈 자리</a>
						</li>
						<li class="noticeItem" style="font-size:14px; border-top:1px solid #f5f5f5;">
							<a href="#">공지사항 내용 들어갈 자리</a>
						</li>
					</ul>
				</div>
			</div> -->
			
			
			<!-- ----------피드 게시글 들어갈 자리------- -->
            
            
        </div>

        <div class="main-right">
            <jsp:include page="groupDetailCommon/rightSidebar.jsp"/>
        </div>

    </div>
    
    <!-- 세팅페이지로 넘어감 : 그룹방 번호 숨겨주기 위해 post로 보냈습니다.-->
    <form id="settingForm" method="post">
    	<input type="hidden" name="groupNo" value="${g.groupNo}">
    </form>
    
    <!-- 일정페이지로 넘어감 : 그룹방 번호 숨겨주기 위해 post로 보냈습니다.-->
    
     <form id="calendarForm" method="post">
    	<input type="hidden" name="groupNo" value="${g.groupNo}">
     </form>
    
    <script>
    	function settingForm(){
    		$('#settingForm').attr('action', 'setting.gr').submit();
    	}
    </script>
    
    <script>
    	function calendarForm(){
    		$('#calendarForm').attr('action', 'calendar.gr').submit();
    	}
    </script>
    
     <script>
	    	$(function(){
	    		
	    		let currentPage = ${pi.currentPage} ;
	    		//let currentPage = 1 ;
	    		
	    		selectBoardList(currentPage);
	    		
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
						selectBoardList(currentPage);
						
						
					}
				});
				
	    	});
        
        	function selectBoardList(currentPage){
        		
        		console.log("요청페이지:" + currentPage);
        		
        		$.ajax({
        			url : 'listBoard.gr',
        			method : 'POST',
        			data : {
        				userId : '${loginUser.userId}',
        				groupNo : ${g.groupNo},
        				cpage : currentPage
        			},
        			success : function(data){
        				
        				// 응답된 문자열은 html형식(feed/ajaxFeedList.jsp에 응답내용 있음)
						$('.main-middle').append(data);
        				
						$('.likeBtn').click(function(){	
							changeLike(this);
							
						});

       				}
        		});
			}
        	
        	
			function changeLike(likeImg){
        		
        		let bno = $(likeImg).data('bno');
        		console.log(bno);
        		
				// 기존에 좋아요 안 눌렀을 경우 => 좋아요 등록
        		if($(likeImg).children('img').hasClass('likeN')){ 
        			
        			//console.log('좋아요 등록');
            		
        			
        			
        			$.ajax({
            			url : 'insertLike.gr',
            			method : 'POST',
            			data : { 
            				userId : '${loginUser.userId}',
            				boardNo : bno
            			},
            			success : function(result){
            				
            				if(result == 'success'){
            					$(likeImg).html('<img class="likeY" src="resources/img/heart-on.png">');
            					
            					
            					console.log($(likeImg));
            					checkCountLike(bno);
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
            			url : 'deleteLike.gr',
            			data : { 
            				boardNo : bno,
            				userId : '${loginUser.userId}'
            			},
            			success : function(result){
            				
            				if(result == 'success'){
            					
            					$(likeImg).html('<img class="likeN" src="resources/img/heart-off.png">');
            					
            					console.log($(likeImg));
            					// 좋아요 개수 변경
        						checkCountLike(bno);
            				}
            			},
            			error : function(){
            				//console.log('에러');
            			}
            		});
        		}

        	}
			
			
			
			
			function checkCountLike(bno){
				
				//var $inputBno = $('#inputBno').val(); 
				//console.log(bno);
				
				$.ajax({
    				url : 'countLike.gr',
    				method : 'POST',
    				data : {
    					boardNo : bno
    				},
    				success : function(count){
    					//$('.likeCount').html(count);
    					
    					$(".likeCount"+bno).html(count);
    					
    					
    					//console.log($('.likeCount'));
    					//console.log(count);
    				},
    				error : function(){
    					console.log('에러');
    				}
    			});
			}
        	
      </script>
    
      <script> 
			// 첨부파일 삭제
			function fileReset(num){
				$('#file'+num).val('');
			}
	  </script>
    
    
    
    
    
    
    <script src="resources/js/GroupDetail.js"></script>
</body>
</html>
