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
    <link rel="stylesheet" href="resources/css/style2.css?ver=1.1.4">
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
			                    <a onclick="postForm(2);">
			                        변경
			                    </a>
			                </div>
			            </li>
			            <li class="setting-item">
			                <div class="itemContent">
			                    <span class="label">그룹 삭제</span>
			                </div>
			                <div class="itemSide delete">
			                    <a onclick="postForm(3);">
			                        그룹 삭제
			                    </a>
			                </div>
			            </li>
			        </ul>
			    </div>
			</div>


        </div>

        <div class="main-right">
            <jsp:include page="groupDetailCommon/rightSidebar.jsp"/>
        </div>

    </div>
    
    <!-- 세팅페이지에서 각각의 POST요청을 처리해주는 form태그와 script -->
    <form id="postForm">
    	<input type="hidden" value="${g.groupNo}" name="groupNo"/>
    </form>
    
    <script>
		function postForm(num){
			switch(num){
				case 1: $('#postForm').attr('action', 'updateForm.gr').submit();
				break;
				case 2: $('#postForm').attr('action', 'grouptType.gr').submit();
				break;
				case 3: $('#postForm').attr('action', 'delete.gr').submit();
				break;
			}
		}
	</script>
    
    
    <script src="resources/js/GroupDetail.js"></script>
</body>
</html>
