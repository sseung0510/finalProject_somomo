<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-A3rJD856KowSb7dwlZdYEkO39Gagi7vIsF0jrRAoQmDKKtQBHUuLZ9AsSv4jD4Xa" crossorigin="anonymous"></script>

    <!----------- CSS --------------->
    <link rel="stylesheet" href="resources/css/groupHeader.css?ver=1.0.6">
    <link rel="stylesheet" href="resources/css/style2.css?ver=1.1.5">
    <link rel="stylesheet" href="resources/css/groupLeft.css?ver=1.0.5">
    <link rel="stylesheet" href="resources/css/groupRight.css?ver=1.0.4">
	<link rel="stylesheet" href="resources/css/choModal.css?ver=1.0.7">
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
								<a onclick="postForm(1);">
									변경
								</a>
							</div>
						</li>
						<li class="setting-item">
							<div class="itemContent">
								<span class="label">그룹 공개</span>
								<span class="label-data">${g.groupType}</span>
							</div>
							<div class="itemSide">
								<a class="chooseType">
									변경
								</a>

							</div>
						</li>
						<li class="setting-item">
							<div class="itemContent">
								<span class="label">그룹 삭제</span>
							</div>
							<div class="itemSide delete">
								<a onclick="postForm(2);">
									그룹 삭제
								</a>
							</div>
						</li>
					</ul>
				</div>
			</div>

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
										<input name="groupType" value="C" type="radio" id="private">
										<label for="private">비공개 그룹</label>
									</div>
									<div class="content-row__desc">그룹과 게시글이 공개되지 않습니다. 초대를 통해서만 가입할 수 있습니다.</div>
								</div>

								<div class="content-row">
									<div class="content-row__btn">
										<input name="groupType" value="B" type="radio" id="public">
										<label for="public">그룹명 공개 그룹</label> 
									</div>
									<div class="content-row__desc">누구나 그룹을 검색으로 찾아 그룹 소개를 볼 수 있지만, 게시글은 멤버만 볼 수 있습니다.</div>
								</div>

								<div class="content-row">
									<div class="content-row__btn">
										<input name="groupType" value="A" type="radio" id="public-toAll">
										<label for="public-toAll">공개 그룹</label>
									</div>
									<div class="content-row__desc">누구나 그룹을 검색해 찾을 수 있고, 그룹 소개와 게시글을 볼 수 있습니다.</div>
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

        </div>

        <div class="main-right">
            <jsp:include page="groupDetailCommon/rightSidebar.jsp"/>
        </div>

    </div>
    
    <!-- 세팅페이지에서 각각의 POST요청을 처리해주는 form태그와 script -->
    <form id="postForm" method="post">
		<input type="hidden" value="${g.groupNo}" name="groupNo"/>
    </form>	
    
	<script>
		// 모달창의 그룹 타입들중 현재 그룹방에 설정되어있는 타입을 기본값으로 세팅
		let curType = "";

		// 처음에 정보 받아올때 DECODE를 사용해서 변환 시키기 때문에 다시 
		switch("${g.groupType}"){
				case "공개" : curType = "A";
				break;
				case "그룹명 공개" : curType = "B";
				break;
				case "비공개" : curType = "C";
				break;
			}

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
		function postForm(num){
			switch(num){
				case 1: $('#postForm').attr('action', 'updateForm.gr').submit();
				break;
				case 2:
					const warning = confirm("주의!! 정말 그룹을 삭제하시겠습니까? 모든 피드와 기록들이 사라지고 되돌릴 수  없습니다.");

					if(warning){
						$('#postForm').attr('action', 'delete.gr').submit();
					}

				break;

			}
		}
	</script>
    
    <script src="resources/js/GroupDetail.js"></script>
</body>
</html>
