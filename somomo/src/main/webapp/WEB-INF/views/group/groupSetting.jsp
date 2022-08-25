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
    <link rel="stylesheet" href="resources/css/style2.css?ver=1.1.5">
    <link rel="stylesheet" href="resources/css/groupLeft.css?ver=1.0.5">
    <link rel="stylesheet" href="resources/css/groupRight.css?ver=1.0.5">
	<link rel="stylesheet" href="resources/css/choModal.css?ver=1.1.6">
    <!----------- 아이콘 CSS 링크 ------->
    <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css">
    <script src="https://kit.fontawesome.com/567fbbaed5.js" crossorigin="anonymous"></script>
    <!----------- 아이콘 CSS 링크 version 2------->
    <!-- Boxicons CSS -->
    <link href='https://unpkg.com/boxicons@2.1.1/css/boxicons.min.css' rel='stylesheet'>
    <!-- jquery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

	<style>
		#aCount{
			position: relative;
			top: -30px;
			left: 55px;
			display: flex;
			justify-content: center;
			align-items: center;
			background-color: #FEC8C6;
			width: 20px;
			height: 20px;
			border-radius: 10px;
			color: white;
		}
	</style>

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

            <div class="setting">
				<div class="setting-title">
					<h3>그룹 설정</h3>
				</div>

				<div class="setting-container">
					<ul class="setting-list">
						<li class="setting-item">
							<div class="itemContent">
								<span class="label">그룹 이름 및 커버</span>
							</div>
							<div class="itemSide">
								<a onclick="settingForm(1);">
									변경
								</a>
							</div>
						</li>
						<li class="setting-item">
							<div class="itemContent">
								<span class="label">그룹 공개</span>
								<span class="label-data">${g.groupTypeStr}</span>
							</div>
							<div class="itemSide">
								<a class="chooseType">
									변경
								</a>

							</div>
						</li>
						<c:if test="${g.groupType eq 'B'}">
							<li class="setting-item">
								<div class="itemContent">
									<span class="label">가입 요청</span>
									<c:if test="${aCount ne 0}">
										<span class="label-data">현재 대기 중인 요청 : ${aCount}개</span>							
									</c:if>
								</div>
								<div class="itemSide">
									<a class="application-form-btn" onclick="openModal();">
										확인
									</a>
									<c:if test="${aCount ne 0}">
										<div id="aCount">
											<span class="label-data">${aCount}</span>							
										</div>
									</c:if>
								</div>
							</li>
						</c:if>

						<c:if test="${g.groupType eq 'C'}">
							<li class="setting-item">
								<div class="itemContent">
									<span class="label">초대코드 보내기</span>
								</div>
								<div class="itemSide">
									<a onclick="openSearchModal();">
										사용자 검색
									</a>
								</div>
							</li>
						</c:if>

						<li class="setting-item">
							<div class="itemContent">
								<span class="label">그룹 삭제</span>
							</div>
							<div class="itemSide delete">
								<a onclick="settingForm(2);">
									그룹 삭제
								</a>
							</div>
						</li>
					</ul>
				</div>
			</div>

			<!-- 그룹 타입 변경 모달 -->
			<div id="type-modal" class="modal">
				<div class="modal-content-setting">
	
					<div class="modal-header">
						<div class="header-title">
							<div class="header-title__groupName"></div>
							<span>그룹 공개 설정을 변경합니다.</span>
						</div>
					</div>
					
					<form action="updateType.gr" method="post">
						<div class="modal-body">
							
							<div class="content">
								<input type="hidden" name="groupNo" value="${g.groupNo}">

								<div class="content-row">
									<div class="content-row__btn">
										<input name="groupType" value="A" type="radio" id="public-toAll">
										<label for="public-toAll">공개 그룹</label>
									</div>
									<div class="content-row__desc">누구나 그룹을 검색해 찾을 수 있고, 그룹 소개와 게시글을 볼 수 있습니다.</div>
								</div>
								
								<div class="content-row">
									<div class="content-row__btn">
										<input name="groupType" value="B" type="radio" id="public">
										<label for="public">그룹명 공개 그룹</label> 
									</div>
									<div class="content-row__desc">누구나 그룹을 검색으로 찾아 그룹 소개를 볼 수 있지만, 게시글은 멤버만 볼 수 있습니다.</div>
									<div class="content-row__question">
										<textarea class="hidden" name="applyQuestion" id="applyQuestion"></textarea>
									</div>
								</div>

								<div class="content-row">
									<div class="content-row__btn">
										<input name="groupType" value="C" type="radio" id="private">
										<label for="private">비공개 그룹</label>
									</div>
									<div class="content-row__desc">그룹과 게시글이 공개되지 않습니다. 초대를 통해서만 가입할 수 있습니다.</div>
								</div>
							</div>
						</div>
							
						<div class="modal-foot">
							<button type="button" class="close">취소</button>
							<button class="disabled" type="submit">변경하기</button>
						</div>
					</form>
				</div>
			</div>

			<!-- 가입승인 모달 -->
			<div id="application-modal" class="modal">
				<div class="modal-content-setting">
	
					<div class="modal-header">
						<div class="header-title-applyForm">
							<div class="header-title-applyForm__div1">
								<span>가입 신청 처리</span>
							</div>
							<button type="button" class="close">나가기</button>
						</div>
					</div>
					
					<div class="modal-body-apply">
						
						<div class="list-content">
							<!-- ajax로 요청된 리스트 : getApplicationList.gr -->
							<div class="list-header">
								<div class="list-header-row">회원닉네임</div>
								<div class="list-header-row">답변</div>
								<div class="list-header-row">처리</div>
							</div>
							<div class="list-body"></div>
						</div>
					</div>
				</div>
			</div>

			<!-- 초대코드 유저 검색 모달 -->
			<div id="searchUser-modal" class="modal">
				<div class="modal-content-search">
	
					<div class="modal-header-search">
						<div class="header-title-search">
							<div class="header-title-search__div1">
								<span>사용자 검색</span>
							</div>
							<button type="button" class="close">나가기</button>
						</div>
					</div>
					
					<div class="modal-body-search">
						<div class="search-input">
							<span>사용자 검색 : </span>
							<input type="text" name="keyword">
							<input type="hidden" name="inviteCode" id="code" value="${g.inviteCode}">
							<div class="searchBtn-area">
								<button onclick="searchUser();">검색</button>
							</div>
						</div>

						<div class="search-input-result"></div>
					</div>
				</div>
			</div>
        </div>

        <div class="main-right">
            <jsp:include page="groupDetailCommon/rightSidebar.jsp"/>
        </div>

    </div>
    
    <!-- 세팅페이지에서 각각의 POST요청을 처리해주는 form태그와 script -->
    <form id="settingForm" method="post">
		<input type="hidden" value="${g.groupNo}" name="groupNo"/>
    </form>	
    
	<script>
		// 모달창의 그룹 타입들중 현재 그룹방에 설정되어있는 타입을 기본값으로 세팅
		let curType = "${g.groupType}";
		
		$('input[name="groupType"]').each(function(){
			if(curType == $(this).val()){
				$(this).attr('checked', 'true');
			}
		})

		// modal창 관련
        $(function(){
            const modal = $('#type-modal');
    
            $('.chooseType').click(function(){
                
                modal.fadeIn(300);
                $('body').css({'overflow': 'hidden', 'height' : '100%'});
                
            })

            // 취소버튼 눌렀을때 모달 창 닫아주기
            $('.close').click(function(){
                modal.fadeOut(300);
				$('body').css({'overflow':'auto'});
            })
        })
	</script>

	<script>
		function openModal(){
			
			const modal = $('#application-modal');

			modal.fadeIn(300);
			$('body').css({'overflow': 'hidden', 'height' : '100%'});

			getApplicationList();

			$('.close').click(function(){
				modal.fadeOut(300);
				$('body').css({'overflow':'auto'});
			})

		} 
	</script>

	<script>
		function getApplicationList(){
			$.ajax({
				url : 'getApplicationList.gr',
				method : 'POST',
				data : {
					groupNo : "${g.groupNo}"
				},
				success : function(data){
					let value = "";

					if(data.length != 0){
						for(let i in data){
							value += 	'<div class="items">'
									+		'<div class="list-body-row">' + data[i].nickname + '</div>'
									+		'<div class="list-body-row">' + data[i].greeting + '</div>'
									+		'<div class="list-body-row">'
									+			'<input type="hidden" name="applyNo" value="'+ data[i].applyNo +'">'
									+	 		'<input type="hidden" name="userId" value="'+ data[i].userId +'">'
									+ 			'<input type="hidden" name="groupNo" value="'+ ${g.groupNo} + '">'
									+			'<button class="acceptApply">승인</button>'
									+			'<button class="rejectApply">거절</button>'
									+ 		'</div>'
									+	'</div>';
										

							$('.list-body').html(value);
						}
					} 
					else{
						$('.list-body').html("<div class='no-result'>대기중인 요청이 존재하지 않습니다.</div");
					}

				},
				error : function(){
					console.log("통신실패");
				}

			})
		}
	</script>

	<script>
		
		$(document).on('click', '.acceptApply', function(){
			const $applyNo = $(this).siblings().eq(0).val();
			const $userId = $(this).siblings().eq(1).val();
			const $groupNo = $(this).siblings().eq(2).val();

			$.ajax({
				url : 'accept',
				method : 'POST',
				data : {
					applyNo : $applyNo,
					userId : $userId,
					groupNo : $groupNo
				},
				success : function(result){
					if(result == "success"){
						alert('가입 승인')
						getApplicationList();
						location.reload();
					}
					else{
						
					}
				},
				error : function(){
					console.log("통신실패");
				}
			})
		})

		$(document).on('click', '.rejectApply', function(){
			const $applyNo = $(this).siblings().eq(0).val();
			const $userId = $(this).siblings().eq(1).val();
			const $groupNo = $(this).siblings().eq(2).val();

			$.ajax({
				url : 'reject',
				method : 'POST',
				data : {
					applyNo : $applyNo,
					userId : $userId,
					groupNo : $groupNo
				},
				success : function(result){
					if(result == "success"){
						alert('신청 거절!!');
						getApplicationList();
					}
					else{
						
					}
				},
				error : function(){
					console.log("통신실패");
				}
			})
		})

	</script>
	
    <script>
		function settingForm(num){
			switch(num){
				case 1: $('#settingForm').attr('action', 'updateForm.gr').submit();
				break;
				case 2:
					const warning = confirm("주의!! 정말 그룹을 삭제하시겠습니까? 모든 피드와 기록들이 사라지고 되돌릴 수  없습니다.");

					if(warning){
						$('#settingForm').attr('action', 'delete.gr').submit();
					}

				break;

			}
		}
	</script>
    
	<script>
		$('#public').click(function(){
			$('#applyQuestion').removeClass('hidden');
		})

		$('#private, #public-toAll').click(function(){
			$('#applyQuestion').addClass('hidden');
			$('#applyQuestion').val('');
		})

		$('#private').click(function(){
			if(confirm('정말 비공개로 변경하시겠습니까? 그룹이 목록에서 조회되지 않으며 초대코드로만 멤버를 추가할 수 있습니다.')){
				return true;
			}
			else{
				return false;
			}	
		})
	</script>

	<script>
		function openSearchModal(){
			const modal = $('#searchUser-modal');

			modal.fadeIn(300);
			$('body').css({'overflow': 'hidden', 'height' : '100%'});

			$('.close').click(function(){
				modal.fadeOut(300);
				$('input[name=keyword]').val("");
				$('.search-input-result').html("");
				$('body').css({'overflow':'auto'});

			})
		}
	</script>

	<script>
		function searchUser(){

			$('.search-input-result').html("");

			const $keyword = $('input[name=keyword]').val();
			const $groupNo = ${g.groupNo};

			if($keyword == ""){
				alert("검색어를 입력하세요!!");
				return false;
			} else{

				$.ajax({
					url : 'searchUser.gr',
					method : 'GET',
					data : {
						keyword : $keyword,
						groupNo : $groupNo
					},
					success : function(data){
						
						let result = "";
						
						if(data.length != 0){
		
							for(var i in data){
								result  += '<div class="search-input-result__items">'
										+ 	'<span>'+ data[i].userId +'</span>'
										+ 	'<input type="hidden" data-id="'+ data[i].userId +'" value="'+ data[i].email +'">'
										+ 	'<div>'
										+		'<button class="sendBtn">코드 전송</button>'
										+ 	'</div>'
										+ '</div>';
										
								$('.search-input-result').html(result);
							}
						}
						else{
							result = '<span>존재하지 않는 회원 입니다.</span>';

							$('.search-input-result').html(result);
						}

					},
							
					error : function(){
						console.log("통신 실패!");
					}
				})
			}
		}
	</script>

	<script>
		$(document).on('click', '.sendBtn', function(){
			// console.log("${g.inviteCode}");
			// console.log($(this).parent().siblings('input[type=hidden]').data('id'));
			// console.log($(this).parent().siblings('input[type=hidden]').val());

			// groupJoinApply에 필요한 정보
			const $groupNo = ${g.groupNo};
			const $userId = $(this).parent().siblings('input[type=hidden]').data('id');
			const $status = "J";

			// 메일전송에 필요한 정보들
			const $email = $(this).parent().siblings('input[type=hidden]').val();
			const $code = "${g.inviteCode}";
			const $groupName = "${g.groupName}";

			$.ajax({
				url : 'inviteMember.gr',
				method : 'POST',
				data : {
					groupNo : $groupNo,
					userId : $userId,
					status : $status,
					email : $email,
					groupName : $groupName,
					code : $code
				},
				success : function(result){
					console.log(result);
					if(result == "Y"){
						alert("메일 전송 완료!");
					}
					else{
						console.log("실패");
					}

				},
				error : function(){
					console.log("통신실패!");
				}
			})
		})
	</script>

    <script src="resources/js/GroupDetail.js"></script>
</body>
</html>
