<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="resources/css/community_style.css?ver=1.3.5">
	<link rel="stylesheet" href="resources/css/default.css?ver=1.0.0">
	<!----------- 아이콘 CSS 링크 ------->
	<link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css">
	<!----------- 아이콘 CSS 링크 version 2------->
	<!-- Boxicons CSS -->
	<link href='https://unpkg.com/boxicons@2.1.1/css/boxicons.min.css' rel='stylesheet'>
	<script src="https://kit.fontawesome.com/567fbbaed5.js" crossorigin="anonymous"></script>
	<!-- jquery -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<!-- Bootstrap-->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>

	<link rel="stylesheet" href="resources/css/choModal.css?ver=1.0.3">
	<title>Insert title here</title>
</head>
<body>

	<c:if test="${not empty alertMsg}">
		<script>
			alert('${alertMsg}');
		</script>
		<c:remove var="alertMsg" scope="session" />
	</c:if>

	<!-- 완쪽 사이드바 -->
	<jsp:include page="groupCommunityCommon/community_leftSidebar.jsp"></jsp:include>
	
	<!-- 메인컨텐츠 -->
	<section class="main-content">
		<jsp:include page="groupCommunityCommon/community_header.jsp"></jsp:include>
		<div class="group-outer">
			<div class="tag-group">
				<ul class="tag-body">
					<c:forEach var="gc" items="${cList}">
					<li class="category-list category-${gc.categoryNo}" value="${gc.categoryNo}">${gc.categoryName}</li>
					</c:forEach>
					<li class="category-list category-100" value="100">비공개</li>
					<!-- <div class="switch-holder">
						<div class="switch-label">
							<i class="fa-solid fa-lock"></i></i><span>비공개 그룹</span>
						</div>
						<div class="switch-toggle">
							<input type="checkbox" id="private">
							<label for="private"></label>
						</div>
					</div> -->

				</ul>
			</div>

			<div class="group-content">
				<!-- 그룹방 목록이 나오는 area -->

			</div>
		</div>

		<div id="applyModal" class="modal">
            <!-- Modal content -->
            <div class="modal-content">
                <input type="hidden" class="md-groupNo" name="groupNo">
                <input type="hidden" class="md-userId" name="userId">
                <input type="hidden" class="md-groupType" name="groupType">

                <div class="modal-header">
                    <div class="header-title">
                        <div class="header-title__groupName"></div>
                    </div>
                        
                        <div class="header-title__question"></div>
                </div>
                
                <div class="modal-body">
                    <textarea name="greeting" class="greeting" placeholder="가입 질문에 답 해주세요."></textarea>
                </div>
                <div class="modal-foot">
                    <button type="button" class="close">취소</button>
                    <button class="disabled" onclick="apply();">가입하기</button>
                </div>
            </div>
        </div>

		<div id="private-join-modal" class="modal">
            <!-- Modal content -->
			<form action="joinPrivateGroup.gr" method="POST">
				<div class="modal-content">
					<div class="modal-header">
						<div class="header-title">
							<div class="header-title__row">미공개 그룹 가입</div>
						</div>
					</div>
					
					<div class="modal-body-private">
						<span>가입 코드를 입력하세요</span>
						<input name="inviteCode" type="text">
						<input type="hidden" name="userId" value="${loginUser.userId}">
					</div>
		
					<div class="modal-foot">
						<button type="button" class="close">취소</button>
						<button type="submit" class="disabled">가입하기</button>
					</div>
				</div>
			</form>
        </div>

	</section>
	
	<div class="right-sidebar">
		<jsp:include page="groupCommunityCommon/community_rightSidebar.jsp" />
	</div>

	
	<script>
		// let togglePrivate = localStorage.getItem('privateMode');

		// const privateModeToggle = document.querySelector('#private');

		// const enableToggle = () => {
		// 	document.body.classList.add('privateMode');
		// 	localStorage.setItem('privateMode', 'enabled');
		// 	privateModeToggle.setAttribute('checked', true);
		// }

		// const disableToggle = () => {
		// 	document.body.classList.remove('privateMode');
		// 	localStorage.setItem('privateMode', null);
		// }

		// if (togglePrivate === 'enabled') {
		// 	enableToggle();
		// }

		// privateModeToggle.addEventListener('click', () => {
			
		// 	togglePrivate = localStorage.getItem('privateMode');
			
			
		// 	if (togglePrivate !== 'enabled') {
		// 		enableToggle();
			
		// 	} else {  
		// 		disableToggle(); 
		// 	}
		// });
	</script>

	<script>

        // 무한 스크롤 페이징
	    $(function(){

            let categoryNo = "${cno}";         
            // console.log("카테고리 번호 : " + "${cno}"); // 0, 1, 2, 3, 4

            let currentPage = ${pi.currentPage};

			selectGroupList(currentPage, categoryNo);
			
			//스크롤 할 때마다 호출되는 함수
			$(window).on('scroll', function(){

                if(${pi.maxPage eq 0}){
					console.log('마지막 페이지');
                    return; // 등록된 게시글이 없을 경우 종류
                }

				//위로 스크롤된 길이
				let scrollTop = $(window).scrollTop();

				//웹 브라우저 창의 높이
				let windowHeight = $(window).height();
				//문서 전체의 높이
				let documentHeight = $(document).height();
				//바닥까지 스크롤
				let isBottom = scrollTop + windowHeight  >= documentHeight;
				
				if(isBottom){

					if(currentPage == ${pi.maxPage}){

						// console.log("마지막임!!");
						return; //마지막 페이지라면 끝
					}
					
					currentPage ++;//요청 페이지 번호 1증가
					
					selectGroupList(currentPage, categoryNo);
				
				}
            });
        });
        

// 클릭된 카테고리 버튼은 색상 변경 / 클릭 X
		$(function(){
			$('.category-${cno}').css({'background-color':'var(--toggle-color)', 'cursor' : 'default'}).off('click');

		})

        // 그룹 리스트 ajax
        function selectGroupList(currentPage, categoryNo){
            
            // console.log("요청페이지 : " + currentPage);
            console.log("카테고리 번호 : " + categoryNo);
            $.ajax({
                url : 'list.gr',
                method : 'POST',
                data : {
                    userId : '${loginUser.userId}',
                    currentPage : currentPage,
                    boardLimit : '${pi.boardLimit}',
                    cno : categoryNo
                },
                success : function(data){
                    $('.group-content').append(data);
                    
                },
                error : function(){
                    console.log("통신실패");
                }

            })

        }

        // 카테고리 별 클릭시
        $('.tag-body li').click(function(){
            
            const cno = $(this).val();
            
            console.log(cno); // 1,2,3,4

            location.href = "groupRoom.gr?cno=" + cno;
            
        })

		// $('#private').click(function(){

		// 	if($('body').hasClass('privateMode')){
		// 		$('.group-content').html("비밀글 나올예정");
				
		// 		$('.category-list').css({'background-color':'var(--toggle-color)', 'cursor' : 'default'}).off('click');
		// 	}
		// 	else{
		// 		// $('.group-content').html("");

		// 		// $('.category-list').css({'background-color':'white', 'cursor' : 'pointer'});

		// 		// selectGroupList(0, 0);

		// 		location.href = "groupRoom.gr";
		// 	}

		// })
        
    </script>

	<script>
		// 그룹타입을 식별해서 가입 모달창을 열어주거나 / 바로 가입진행 시켜줌
		$(document).on('click', '.apply', function(){
			
			// 공개 : 바로 가입완료
			// 그룹명 공개 : 가입신청서 작성
			// 비공개는 보이지 않음 => 방장이 초대 코드를 보내서 가입 할 수 있음 
			
			// 필요 변수 세팅
			const groupType = $(this).siblings().val();
			const $groupNo = $(this).parents('.group-foot').siblings('.group-main').children('.groupNo').val();
			const $userId = "${loginUser.userId}";
			const groupTitle = $(this).parents('.group-foot').siblings('.group-main').children('.group-body').children('h4').text();
			const question = $(this).parents('.group-foot').siblings('.group-main').children('.question').val();
			
			const modal = $('#applyModal');

			console.log(groupTitle);

			if(groupType == "A"){
				// ajax를 사용해서 현재 로그인된 회원 해당 그룹방에 멤버로 추가
				$.ajax({
					url : 'join.gr',
					method : 'POST',
					data : {
						userId : $userId,
						groupNo : $groupNo
					},
					success : function(result){
						if(result == "success"){
							alert("가입 완료했습니다.");
							location.reload(true);
						}
						else{
							alert("정원 초과 되어 가입에 실패하였습니다");
							location.reload(true);
						}
					},
					error : function(){
						console.log("통신실패");
					}
				})
			}
			else{
				modal.fadeIn(300);                                          // 가입 모달 열기
				$('body').css({'overflow' : 'hidden', 'height' : '100%'});  // 모달 열리면 뒷배경 스크롤 안되게

				$('.md-groupNo').val($groupNo);                             // 그룹넘버: 
				$('.md-userId').val($userId);                               // 로그인한 회원의 아이디 : 자주 사용해서 그냥 상수로 뺐습니다
				$('.md-groupType').val(groupType);                          // 그룹타입: 사실상 무조건 B
				$('.header-title__groupName').text(groupTitle);
				$('.header-title__question').html(question);

				// 취소버튼 눌렀을때 모달 창 닫아주기
				$('.close').click(function(){
					modal.fadeOut(300);                                     // 모달 닫기
					$('body').css({'overflow':'auto'});
					$('.greeting').val('');                                 // 모달 닫히면 다시 스크롤 가능하게 !필수임
				})
			}
			
		})  
	</script>

	<script>
		// 가입신청서(모달)을 전달해주는 함수
		function apply(){

			

			const modal = $('#applyModal');
			
			const $groupNo = $('.md-groupNo').val();
			const $greeting = $('.greeting').val();
			const $userId = $('.md-userId').val();
			const $groupType = $('.md-groupType').val();

			$.ajax({
				url : 'join.gr',
				method : 'POST',
				data : {
					groupNo : $groupNo, 
					userId : $userId, 
					greeting : $greeting,
					groupType : $groupType
				},
				success : function(result){
					
					if(result == "success"){
						alert("가입요청 성공");
						location.reload(true);
					}
					else{
						alert("가입요청 실패");
						modal.fadeOut(300);
						$('body').css({'overflow':'auto'});
					}

				}, error : function(){
					console.log('통신 실패!');
				}
			})
		}
	</script>

	<script>
		// 가입요청 취소
		$(document).on('click', '.cancel-apply', function(){
			
			const ask = confirm("가입요청을 취소하시겠습니까?");
			
			const $userId = "${loginUser.userId}";
			const $groupNo = $(this).siblings().eq(0).val();

			if(ask){
				$.ajax({
					url : 'cancelApply.gr',
					method : 'POST',
					data : {
						userId : $userId,
						groupNo : $groupNo
					},
					success : function(result){
						if(result == "success"){
							location.reload(true);
						}
						else{
							alert("요청 처리에 실패하였습니다. 다시 시도해 주세요.");
							location.reload(true);
						}
					},
					error : function(){
						console.log("통신실패");
					}
				})
			}


		})
	</script>

	<script>
		// 동적으로 생성된 리스트 목록을 클릭하면 해당 상세 페이지로 이동
		$(document).on('click', '.group-main, .enter-group, .group-list li', function(){
			const gno = $(this).data('gno');
			location.href = "detail.gr?gno=" + gno;
		})
	</script>

	<script>
		// nav에 .close가 붙으면 myGroup Text변환
		$('.sidebar-toggle').click(function(){
			
		})
	</script>

	<script>
		function privateJoinModal(){

			const modal = $('#private-join-modal');

			// ah
			modal.fadeIn(300);
			$('body').css({'overflow' : 'hidden', 'height' : '100%'});


			// 취소버튼 눌렀을때 모달 창 닫아주기
			$('.close').click(function(){
				modal.fadeOut(300);                                     // 모달 닫기
				$('body').css({'overflow':'auto'});	
			})
		}	
	</script>

	<script src="resources/js/feed.js"></script>

</body>
</html>