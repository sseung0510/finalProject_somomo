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
    <link rel="stylesheet" href="resources/css/groupList.css?ver=1.3.4">
    <link rel="stylesheet" href="resources/css/choModal.css?ver=1.0.7">
    <!----------- 아이콘 CSS 링크 ------->
    <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css">
    <script src="https://kit.fontawesome.com/567fbbaed5.js" crossorigin="anonymous"></script>
    <!----------- 아이콘 CSS 링크 version 2------->

	<!-- jQuery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <style>
        body{
            overflow: auto;
            background-color: #f7f8fc;
        }
    </style> 
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
                <a href="groupRoom.gr">
                    <div class="nav-col-group">
                        <i class="fas fa-clipboard-list"></i>
                        <span>전체 목록</span>
                    </div>
                </a>
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
		
		<c:forEach var="mg" items="${myGroupList}">
			<script>
                var result = '<div class="nav-group-list">'
                                + '<input type="hidden" value="${mg.groupNo}">'
                                + '<img src="${mg.groupImg}" alt="">'
                                + '<span class="admingroup-name">${mg.groupName}</span>'
                            + '</div>';

                if('${mg.userRank}' == 'A'){
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
                guide = "<br><span>현재 관리중인 그룹이 없습니다.</span><br>";
                $('.adminGroup').append(guide);
            }
            if($('.memberGroup').html() == ""){
                guide = "<br><span>가입한 그룹이 없습니다.</span><br>";
                $('.memberGroup').append(guide);
            }
        </script>
		
		<!-- 메인  (그룹방 리스트) -->
        <main class="content">
            <div class="list-outer">

                <div class="tag-group">
                    <ul class="tag-body">
                        <c:forEach var="gc" items="${cList}">
                        <li class="category-list" value="${gc.categoryNo}">${gc.categoryName}</li>
                        </c:forEach>
                    </ul>
                </div>

                <div class="group-outer">

					<!----------- 그룹방 목록이 띄워지는 공간 ------------>
                    

                </div>

            </div>
        </main>
        
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
    </section>
    
    <script>

        
        // 무한 스크롤 페이징
	    $(function(){

            let categoryNo = "${cno}";         
            console.log("카테고리 번호 : " + "${cno}"); // 0, 1, 2, 3, 4

            let currentPage = ${pi.currentPage};

			selectGroupList(currentPage, categoryNo);
			
			//스크롤 할 때마다 호출되는 함수
			$(window).on('scroll', function(){
				if(${pi.maxPage eq 0}){
					return; //등록된 게시글이 없을 경우 종료
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
                        console.log("마지막 페이지임!!");
						return; //마지막 페이지라면 끝
					}
					
					currentPage ++;//요청 페이지 번호 1증가
					
					selectGroupList(currentPage, categoryNo);
				
				}
            });
        });
        
        // 그룹 리스트 ajax
        function selectGroupList(currentPage, categoryNo){
            
            console.log("요청페이지 : " + currentPage);
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
                    $('.group-outer').append(data);
                    
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
        $(document).on('click', '.group-main', function(){
            location.href = "detail.gr?gno=" + $(this).children().eq(0).val();
        })
        $(document).on('click', '.enter-group', function(){
            location.href = "detail.gr?gno=" + $(this).siblings().eq(0).val();
        })

    	// 목록에 나오는 리스트 누르면 해당 그룹방으로 갈 수 있음
        $('.nav-group-list').click(function(){
            location.href = "detail.gr?gno=" + $(this).children().eq(0).val();
        })
    </script>
    </body>
</html>
