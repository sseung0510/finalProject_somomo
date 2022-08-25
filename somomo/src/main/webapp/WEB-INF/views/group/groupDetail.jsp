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
    <link rel="stylesheet" href="resources/css/groupHeader.css?ver=1.0.9">
    <link rel="stylesheet" href="resources/css/style2.css?ver=1.1.3">
    <link rel="stylesheet" href="resources/css/groupLeft.css?ver=1.0.5">
    <link rel="stylesheet" href="resources/css/groupRight.css?ver=1.1.2">
    <!----------- 아이콘 CSS 링크 ------->
    <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css">
    <script src="https://kit.fontawesome.com/567fbbaed5.js" crossorigin="anonymous"></script>
    <!----------- 아이콘 CSS 링크 version 2------->
    <!-- Boxicons CSS -->
    <link href='https://unpkg.com/boxicons@2.1.1/css/boxicons.min.css' rel='stylesheet'>
    <!-- jquery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    
     <!-- Moment 라이브러리 -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment-with-locales.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/locale/ko.min.js"></script>
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
            
            
        </div>

        <div class="main-right">
            <jsp:include page="groupDetailCommon/rightSidebar.jsp"/>
        </div>

    </div>
        
	<script>
		console.log($('feed-profile'));
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
					
					// 응답된 문자열은 html형식(group/groupDetailList.jsp에 응답내용 있음)
					$('.main-middle').append(data);
					
					$('.likeBtn').click(function(){	
						changeLike(this);
						
					});


					$('.replyBtn').click(function(){
						insertReply(this);
					})
					
					/*$('.feed').click(function(){
						const feed = document.querySelector('.feed');
						const dropdownFeed = feed.querySelector('.feed-link');
						dropdownFeed.classList.toggle('show');
					})*/
					
					$('.feed').each(function(index){
						$(this).click(function(){
							const feed = document.querySelector('.feed');
							const dropdownFeed = feed.querySelector('.feed-link');
							dropdownFeed.classList.toggle('show');
						})
					});
					
					//댓글 열기
					$('.commentCountBtn').click(function(){
						let rno = $(this).data('rno');
						if($(this).children().eq(1).hasClass('uil uil-angle-up')){
							$(this).children().eq(1).removeClass('uil uil-angle-up').addClass('uil uil-angle-down');
							selectReplyList(rno);
						}else{
							$(this).children().eq(1).removeClass('uil uil-angle-down').addClass('uil uil-angle-up');
							$('.commnetWrap'+rno).html('');
						}
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
			
			
			
		// ajax 댓글 작성
		function insertReply(grReply){
			let rno = $(grReply).data('rno');
			console.log(rno);
			
			if($('#replyContent'+rno).val() != ''){
				$.ajax({
					url : 'insertReply.gr',
					data : {
						boardNo : rno,
						replyWriter : '${loginUser.userId}',
						replyContent : $('#replyContent'+rno).val()
					},
					success : function(result){
						if(result == 'success'){
							selectReplyList(rno);
							//console.log($('.replyContent').val());
							$('#replyContent'+rno).val('');
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
			
			

			
			
		function selectReplyList(rno){
			$.ajax({
				url : 'selectReplyList.gr',
				data : {
					boardNo : rno
				},
				success : function(list){
					$('.commentCount'+rno).html(list.length);
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
						result +=			'<div class="writeInfo">'
								+ 				'<a class="upProfile">'
								+					'<span class="upProfileImg">'
								+						'<img src="' + list[i].profileImg + '">'    
								+					'</span>'
								+ 				'</a>'
								+				'<div class="writeInfo-content">'
								+					'<span>' + list[i].nickname + '</span>'
								+					'<span>' + list[i].replyContent.replaceAll("\n", "<br/>") + '</span>'		
								+				'</div>'
								+			'</div>'
								+				'<div class="twiceComment">'
								+					'<time class="time" style="margin-left:5px; color:gray;">'+ list[i].replyDate +'</time>'
								+					'<div class="reply-btn-area" data-reply_no="' + list[i].replyNo + '">';
						// 일반 댓글일 경우, 답글달기 버튼 표시
						if(list[i].rdepth == 0){
							result +=				'<button class="rBtn reReplyBtn showArea" data-rboard="'+ rno +'" data-rgroup="' + list[i].rgroup + '">답글달기</button>';
						}
						// 댓글작성자일 경우, 댓글 수정/삭제 버튼 표시 + 삭제되지 않은 댓글일 경우
						if(list[i].replyWriter == '${loginUser.userId}' && list[i].replyContent != '삭제된 댓글입니다'){
							result += 	          '<button class="delReplyBtn" data-rboard="'+ rno +'">삭제</button>';
						}
						
						result +=						'</div>'
								+					'</div>'
								+				'</div>'
								+			'</div>';
						// 같은 댓글 그룹 중 마지막 댓글일 경우 <div id="reply-groupNo" + list[i].rgroup > 닫기        
						if(list[i].isLastRgroupReply == 'Y'){
							result +='</div>';
						}
						
					}
					
					// 댓글목록에 전체 댓글 출력
					$('.commnetWrap'+rno).html(result);
				}
			});
		}
			
        	
        	
        	

       	// 답글버튼(답글달기,답글취소) 클릭 시
		$(document).on('click', '.reReplyBtn', function(){
			let rgroupNo = $(this).data('rgroup');
			let rboardNo = $(this).data('rboard');
			//console.log(rboardNo);
			// 답글달기 버튼일 경우
			if($(this).hasClass('showArea')){
				let reReplyArea = '<div id="inputArea' + rgroupNo + '" class="reply-input-area rrArea" style="margin-left:40px;">'
								+ 	'<textarea class="reContent" type="text" placeholder="댓글을 입력해주세요..." rows="1" style="resize: none; vertical-align:middle;"></textarea>'
								+ 	'<button class="replyBtn" id="replyBtn'+rboardNo+'" onclick="insertReReply(this,'+ rboardNo +','+ rgroupNo +');">작성</button>'
								+ '</div>';
								
				$('#reply-groupNo'+ rgroupNo).append(reReplyArea);
				
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
		function insertReReply(target, rboardNo, rgroupNo){
			let inputArea = $(target).parent().attr('id'); // 답글 작성 칸 id
			let reContent = $(target).siblings('textarea').val().trim(); // 답글 작성 내용
			
			if(reContent != ''){
				$.ajax({
					url : 'insertReReply.gr',
					data : {
						boardNo : rboardNo,
						replyWriter : '${loginUser.userId}',
						replyContent : reContent,
						rgroup : rgroupNo
					},
					success : function(result){
						if(result == 'success'){
							//$('#'+inputArea).remove(); // 해당 답변 작성 칸 없애기
							selectReplyList(rboardNo);
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
        	
        	
		// ajax 댓글 삭제 버튼 클릭 시
		$(document).on('click', '.delReplyBtn', function(){
			let rboardNo = $(this).data('rboard');
			let replyNo = $(this).parent().data('reply_no'); // 해당 댓글 번호
			let rgroupNo = $(this).parent().data('rgroup'); // 해당 댓글그룹
			
			let replyContent = $(this).parent().parent().find('.content') // 해당 댓글 내용 요소
			let delReplyBtn = $(this); // 해당 댓글삭제버튼
			
			if(confirm("댓글을 삭제하시겠습니까?")){
				$.ajax({
					url : 'deleteReply.gr',
					data : {
						replyNo : replyNo,
						rgroup : rgroupNo
					},
					success : function(result){
						if(result == 'deleteReply'){ // 답변 없는 댓글일 경우 => 댓글 삭제 (STATUS='N')
							$('#replyNo' + replyNo).remove(); // 해당 답변 지우기
						}
						else if(result == 'deleteContent'){ // 답변 달린 댓글일 경우 => 댓글 내용 삭제
							replyContent.html('삭제된 댓글입니다'); // 해당 댓글 내용 변경
							upReplyBtn.attr('style', 'display:none;'); // 해당 댓글수정버튼 숨기기
							delReplyBtn.attr('style', 'display:none;'); // 해당 댓글삭제버튼 숨기기
						}
						else { // "deleteTwoReply" : 삭제된 댓글의 마지막 답변일 경우 => 댓글+답글 삭제
							$('#reply-groupNo'+rgroupNo).remove(); // 해당 댓글그룹 삭제
						}
						checkCountReply(rboardNo); // 댓글 개수 변경
					},
					error : function(){
						console.log('에러');
					}
				});
			}
		});
		
		// ajax 댓글 개수 가져오기
		function checkCountReply(rboardNo){
			$.ajax({
				url : 'countReply.gr',
				method : 'POST',
				data : {
					boardNo : rboardNo
				},
				success : function(count){
					$('.commentCount'+rboardNo).html(count);
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
	
	<script src="resources/js/GroupDetail.js?ver=1.0.3"></script>

	<script>
		// (게시글)수정 버튼 클릭 시
		$(document).on('click', '#updateForm', function(){
			var w = new updatePopup();
			w.show();
		});
		
		
		// (게시글)삭제 버튼 클릭 시
		$(document).on('click', '.deleteForm', function(){
			let bno = $(this).data('bno');
			console.log(bno);
    		if(confirm("삭제하시겠습니까?")){
				$('#deleteGroupForm input[name="boardNo"]').val(bno);
				console.log($('#deleteGroupForm input[name="boardNo"]').val());
				$('#deleteGroupForm').attr('action', 'deleteBoard.gr').submit();
			}
		});	
		
	</script>
    
    
    
    <script>
		// 다가오는 일정 목록 JS
		$(function(){
			calendarEventList();
		})

		function calendarEventList(){
				$.ajax({
					url:"calendarEventListEntire.gr",
					data:{
						groupNo : "${g.groupNo}"
					}, success: function(data){
						console.log(data);
						var result="";
						var diff =[];
						var somomo =[];
						var now = new Date();
						var year = now.getFullYear(); // 현재연도
						var month = now.getMonth()+1; // 월
						var day = now.getDate(); // 일
						for(var i in data){
						
							diff[i] = data[i].startDate.substr(0,10);
							somomo[i] = diff[i].split('-');
							
							var stDate = new Date(somomo[i][0],somomo[i][1],somomo[i][2]);
							var endDate = new Date(year, month, day);
							var btMs =  stDate.getTime()-endDate.getTime();
							var btDay = btMs / (1000*60*60*24); // 차이 일수로 계산
							if(btDay <= 14 && btDay > 0) {
								
								/*
								data[i].title
								var somomoDay = moment(diff[i]).format("Do");
								var momoDay = moment(diff[i]).format('dddd');
								*/
								
							result += '<ul>'
								   +  	'<li>'
								   + 		 '<a>'
								   +  			'<div class="eventCont">' + moment(diff[i]).format('dddd')
								   +  			'<span>' + moment(diff[i]).format("Do") + '</span>'
								   +  			'</div>'
								   +  			'<div class="cont">'
								   +  			'<strong>' + data[i].title + '</strong>'
								   +  			'</div>'
								   +  		'</a>'
								   +  	'</li>'
								   +  '</ul>'
						
							
							}
							
						
							
						
						}
						
						
						$('.schedule-body').append(result);
						
						
						
					}, error:function(){
						alert("ajax 통신 실패");
					}
				})
			}
	
</script>
	
    
    
</body>
</html>
