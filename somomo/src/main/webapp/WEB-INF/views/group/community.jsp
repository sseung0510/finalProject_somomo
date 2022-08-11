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
    <link rel="stylesheet" href="resources/css/header.css?ver=1.0.1">
    <link rel="stylesheet" href="resources/css/groupList.css?ver=1.3.3">
    <link rel="stylesheet" href="resources/css/applyModal.css?ver=1.0.2">
    <!----------- 아이콘 CSS 링크 ------->
    <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css">
    <script src="https://kit.fontawesome.com/567fbbaed5.js" crossorigin="anonymous"></script>
    <!----------- 아이콘 CSS 링크 version 2------->

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

    <title>그룹리스트</title> 
</head>
<body>
    <div class="wrapper">
        <div>
            <header>
                <div class="logo-name">
                    <div class="logo-image">
                        <a href="main.fd"><img src="resources/img/web_logo.jpg" alt=""></a>
                    </div>
                    <span class="logo_name">SoMoMo</span>
                </div>
        
                <div class="top">
                    <form action="">
                        <div class="search-box">
                            <button type="submit"><i class="uil uil-search"></i></button>
                            <input type="text" placeholder="검색">
                        </div>
                    </form>
                </div>
    
                <ul class="menu-list">
                    <li><a href=""><i class="uil uil-bell"></i></a></li>
                    <li><a href=""><i class="uil uil-comment-dots"></i></a></li>
                    <li><a href=""><i class="uil uil-user"></i></a></li>
                </ul>
            </header>
        </div>
    </div>

    <section>
        <nav>
            <div class="nav-col">
                <h1 class="nav-title">Group</h1>
                <div class="nav-col-group">
                    <i class="fas fa-clipboard-list"></i>
                    <span>그룹 목록</span>
                </div>
                <div class="nav-col-group">
                    <i class="uil uil-search"></i>
                    <span>찾아보기</span>
                </div>
    
                <div class="create-newGroup">
                    <a href="insertForm.gr">
                        <button class="learn-more">
                            <i class="uil uil-plus"></i>
                            <span class="circle"></span>
                            <span class="button-text">새그룹 만들기</span>
                        </button>
                    </a>
                </div>

                <div class="horizontal"></div>

            </div>

            <div class="nav-col">
                <h2 class="m1">관리중인그룹</h2>
                <div class="adminGroup"></div>
                
                <div class="horizontal"></div>

                <h2>가입한 그룹</h2>
                <div class="memberGroup"></div>                
            </div>
        </nav>
		
		<c:forEach var="g" items="${myGroupList}">
			<script>
                var result = '<div class="nav-group-list">'
                                + '<input type="hidden" value="${g.groupNo}">'
                                + '<img src="${g.groupImg}" alt="">'
                                + '<span class="admingroup-name">${g.groupName}</span>'
                            + '</div>';

                if('${g.userRank}' == 'A'){
                    $('.adminGroup').append(result);
                } 
                else{
                    $('.memberGroup').append(result);
                }
            </script>
		</c:forEach>
		
        <script>
            
            $('.adminGroup').css({'disply':'flex', 'flex-direction':'column', 'width':'100%'})
            $('.memberGroup').css({'disply':'flex', 'flex-direction':'column', 'width':'100%'})
            
            var guide = "";

            if($('.adminGroup').html() == ""){
                guide = "<span>현재 관리중인 그룹이 없습니다.</span>";
                $('.adminGroup').append(guide);
            }
            if($('.memberGroup').html() == ""){
                guide = "<span>가입한 그룹이 없습니다.</span>";
                $('.memberGroup').append(guide);
            }
        </script>

        <main class="content">
            
            <div class="list-outer">
                <div class="tag-group">
                    <ul class="tag-body">
                        <li class="category-list">그룹 전체</li>
                        <li class="category-list">#개발</li>
                        <li class="category-list">#여행</li>
                        <li class="category-list">#운동</li>
                    </ul>
                </div>

                <div class="group-outer">

                    <c:forEach var="g" items="${list}">
                        <div class="group">
                            <div class="group-main">
                                <input class="groupNo" type="hidden" value="${g.groupNo}">
                                <div class="group-header">
                                    <img src="${g.groupImg}" alt="rover" />
                                </div>
                                <div class="group-body">
                                    <span class="tag tag-development">${g.categoryNo}</span>
                                    <h4 class="groupName">
                                        ${g.groupName}
                                    </h4>
                                    <div class="group-info">
                                        <span class="group-member">멤버 ${g.memberCount}명</span>
                                        <span>${g.groupType}</span>
                                    </div>
                                </div>
                            </div>
                            
                            
                            <div class="group-foot">
                                <div class="group-btn">
                                    <button class="apply">그룹 가입</button>
                                </div>
                            </div>
                            
                            
                            <div id="applyModal" class="modal">
                                <!-- Modal content -->
                                <div class="modal-content">
                                    <input type="hidden" class="md-groupNo" type="text" name="groupNo">
                                    <input type="hidden" name="userId" class="md-userId" value="${loginUser.userId}">
                    
                                    <div class="modal-header">
                                        <div class="header-title">
                                            <div class="header-title__groupName"></div>
                                            <span>간단한 자기소개를 입력해주세요.</span>
                                        </div>
                                    </div>
                                    
                                    <div class="modal-body">
                                        <textarea name="greeting" class="greeting" placeholder="여기에 작성하세요."></textarea>
                                    </div>
                                    <div class="modal-foot">
                                        <button type="button" class="close">취소</button>
                                        <button class="disabled" onclick="apply();">가입하기</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </main>
    </section>

    <script>

        // modal창 관련
        $(function(){
            const modal = $('#applyModal');
    
            // 아예 g를 넘겨 받는 법은? => 객체를 넘겨 받아야한다. => 어떻게....??
            $('.apply').click(function(){
                
                // 그룹방 번호
                const gno = $(this).parents('.group-foot').siblings('.group-main').children('.groupNo').val();
                
                // 그룹방 제목
                const gname = $(this).parents('.group-foot').siblings('.group-main').children('.group-body').children('.groupName').text().trim()
                
                $('.md-groupNo').val(gno);
                $('.header-title__groupName').text(gname);
    
                modal.fadeIn(300);
                $('body').css({'overflow': 'hidden', 'height' : '100%'});
                
            })

            // 취소버튼 눌렀을때 모달 창 닫아주기
            $('.close').click(function(){
                modal.fadeOut(300);
            })
        })

        function apply(){

            const modal = $('#applyModal');
            
            const $groupNo = $('.md-groupNo').val();
            //console.log($('.md-groupNo').val());

            const $greeting = $('.greeting').val();
            // console.log($('.greeting').val());

            const $userId = "${loginUser.userId}";
            //console.log($userId);

            $.ajax({
                url : "apply.gr",
                data : {groupNo : $groupNo, userId : $userId, greeting : $greeting},
                type : "post",
                success : function(result){
                    console.log(result);

                    modal.hide();
                    
                }, error : function(){
                    console.log("통신 실패!");
                }
            })
        }
    </script>

    <script>
        $('.group-main').click(function(){
            location.href = "detail.gr?gno=" + $(this).children().eq(0).val();
        })
        
        $('.nav-group-list').click(function(){
            location.href = "detail.gr?gno=" + $(this).children().eq(0).val();
        })
    </script>

</body>
</html>
