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

            <c:choose>
                <c:when test="${not empty fList}">
                    <div class="feed-profile">
                        <img src="../src/img/kh.jpeg">
                        <div>
                            <p>Test</p>
                            <small>지금 막</small>
                        </div>
                        <div class="form-icon">
                            <i class='bx bx-dots-vertical-rounded feed'>
                                <ul class="feed-link">
                                    <li><a href=""> 글 수정</a></li>
                                    <li><a href="">삭제하기</a></li>
                                    <li><a href="">공지로 등록</a></li>
                                </ul>
                            </i>
                        </div>
                    </div>

                    <div class="feed-content">
                        8월 2일 로즈애플입니다  <br>
                        🏖 8/7~8/9 휴무 <br>
                            👉 가락공판장 휴가에 맞춰 저희도 쉬어갑니다 <br>
                            👉 휴가 갈 생각에 벌써부터 설래 설램  <br>
                        📢 오늘의특가 <br>
                    </div>

                    <div class="postCount">
                        <div class="postCountLeft">
                            <span class="likeCountBtn"><img src="../src/img/redheart.png">좋아요
                                <span class="likeCount">2</span>
                            </span>
                        
                            <span class="commentCountBtn">댓글
                                <span class="commentCount">2</span>
                                <i class="uil uil-angle-up"></i>
                            </span>
                        </div>
                        <div class="postCountRight">
                            <i class="uil uil-heart"></i>
                        </div>
                    </div>

                    <div class="commentBox">
                        <div class="commnetWrap">
                            <div class="writeInfo">몽키스패너
                                <a class="upProfile">
                                    <span class="upProfileImg">
                                        <img src="../src/img/food.jpeg">
                                    </span>
                                </a>
                            </div>
                            <div class="text">몽키스패너 특가로 구매했어요!!!
                                <div class="twiceComment">
                                    <time class="time">8월 2일 오후 5:20</time>
                                    <div class="reply-replyBtn">답글쓰기</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="empty-content">
                        <div class="group-board">
                            <i class="uil uil-clipboard-alt"></i>
                        </div>
                        <div class="board-text">
                            <h3>그룹게시판</h3>
                            <small>첫 게시글을 작성해보세요  <br>
                            나와 멤버가 쓴 글이 여기에 표시됩니다.</small>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <div class="main-right">
            <jsp:include page="groupDetailCommon/rightSidebar.jsp"/>
        </div>

    </div>
    
    <!-- 세팅페이지로 넘어감 : 그룹방 번호 숨겨주기 위해 post로 보냈습니다.-->
    <form id="settingForm" method="post">
    	<input type="hidden" name="groupNo" value="${g.groupNo}">
    </form>
    
    <script>
    	function settingForm(){
    		$('#settingForm').attr('action', 'setting.gr').submit();
    	}
    </script>
    
    <script src="resources/js/GroupDetail.js"></script>
</body>
</html>
