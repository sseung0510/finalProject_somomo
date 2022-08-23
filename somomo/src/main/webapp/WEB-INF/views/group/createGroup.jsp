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
    <link rel="stylesheet" href="resources/css/default.css?ver=1.0.0">
    <link rel="stylesheet" href="resources/css/header.css?ver=1.0.3">
    <link rel="stylesheet" href="resources/css/createGroup.css?ver=1.1.5">
    <!----------- 아이콘 CSS 링크 ------->
    <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css">
    <script src="https://kit.fontawesome.com/567fbbaed5.js" crossorigin="anonymous"></script>
    <!----------- 아이콘 CSS 링크 version 2------->
    <!-- jquery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <title>그룹을 만들어 보아요</title>
</head>
<body>
    <div class="center">

        <div class="wrapper">
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
        
        <main>
            <section>
                <div>
                    <form action="insert.gr" enctype="multipart/form-data" method="post">
                        <input type="hidden" name="userId" value="${loginUser.userId}">
                        <input type="hidden" name="userRank" value="A">
    
                        <br><br>
    
                        <div class="category-outer">

                            <div class="container">
                                <span class="choose">Region Category</span>
    
                                    <div class="dropdown">
                                        <div class="select">
                                            <span>지역을 선택해 주세요</span>
                                            <i class="fa fa-chevron-left"></i>
                                        </div>
                                        <input type="hidden" name="regionNo" required>
                                        <ul class="dropdown-menu">
                                            <c:forEach var="r" items="${rList}">
                                                <li data-no="${r.regionNo}">${r.regionName}</li>
                                            </c:forEach>
                                        </ul>
                                    </div>
    
                                <span class="msg"></span>
                            </div>
    
                            <div class="container">
                                <span class="choose">Group Category</span>
    
                                    <div class="dropdown">
                                        <div class="select">
                                            <span>그룹 범주를 선택해 주세요</span>
                                            <i class="fa fa-chevron-left"></i>
                                        </div>
                                        <input type="hidden" name="categoryNo" required>
                                        <ul class="dropdown-menu">
                                            <c:forEach var="c" items="${cList}">
                                                <li data-no="${c.categoryNo}">${c.categoryName}</li>
                                            </c:forEach>
                                        </ul>
                                    </div>
    
                                <span class="msg"></span>
                            </div>
                        </div>
    
                        <br>

                        <div class="groupName-sheet">
                            <label for="">GROUP</label><br>
                            <input id="groupName" name="groupName" required type="text" placeholder="그룹명을 입력하세요">
                        </div>
    
                        <div class="img-sheet">
                            <div class="main-img">
                                <span>
                                    <img id="groupImg" alt="그룹대표이미지" src="" alt="">
                                    <input type="hidden" name= "groupImg" value="">
                                </span>
                            </div>
                            
                            <div class="img-list">
                                <div class="head">
                                    <h3>그룹을 대표할 사진을 선택하세요</h3>
                                </div>
                                <ul class="list">
                                    <li><img id="userImg" src="resources/img/addImg.png" alt=""></li><!-- 이친구는 사용자가 등록 할 수 있는 사진 -->
                                    <!-- 아래 사진들은 사이트에서 기본적으로 제공해주는 사진들 -->
                                    <li>
                                        <img class="defaultImg" src="resources/img/group/defaultGroupImg/sample_group_img1.jpg" alt="" >
                                        <div class="middle display-none"><i class="fa-solid fa-check"></i></div>
                                    </li>
                                    <li>
                                        <img class="defaultImg" src="resources/img/group/defaultGroupImg/sample_group_img2.jpg" alt="" >
                                        <div class="middle display-none"><i class="fa-solid fa-check"></i></div>
                                    </li>
                                    <li>
                                        <img class="defaultImg" src="resources/img/group/defaultGroupImg/sample_group_img3.png" alt="" >
                                        <div class="middle display-none"><i class="fa-solid fa-check"></i></div>
                                    </li>
                                    <li>
                                        <img class="defaultImg" src="resources/img/group/defaultGroupImg/sample_group_img4.jpg" alt="" >
                                        <div class="middle display-none"><i class="fa-solid fa-check"></i></div>
                                    </li>
                                    <li>
                                        <img id="me" class="defaultImg" src="resources/img/group/defaultGroupImg/sample_group_img5.jpg" alt="" >
                                        <div class="middle display-none"><i class="fa-solid fa-check"></i></div>
                                    </li>
                                    <li>
                                        <img class="defaultImg" src="resources/img/group/defaultGroupImg/sample_group_img6.jpg" alt="" >
                                        <div class="middle display-none"><i class="fa-solid fa-check"></i></div>
                                    </li>
                                    <li>
                                        <img class="defaultImg" src="resources/img/web_logo.jpg" alt="" >
                                        <div class="middle display-none"><i class="fa-solid fa-check"></i></div>
                                    </li>
                                </ul>
                            </div>
                        </div>
                        <input type="file" name="upfile" id="upfile" onchange="loadImg(this);">
    
                        <div class="groupDesc-sheet">
                            <textarea name="groupDetail" id="groupDetail" placeholder="생성할 그룹에 관한 간단한 설명을 적어주세요" required></textarea>
                        </div>
    
                        <div class="groupType-sheet">
                            <div class="head">
                                <h4>그룹 공개</h4>
                            </div>
                            
                            <div class="content">
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
                                </div>
                                <div class="content-row">
                                    <div class="content-row__btn">
                                        <input name="groupType" value="C" type="radio" id="private">
                                        <label for="private">비공개 그룹</label>
                                    </div>
                                    <div class="content-row__desc">그룹과 게시글이 공개되지 않습니다. 초대를 통해서만 가입할 수 있습니다.</div>
                                </div>
                            </div>
    
                            <div id="question-modal" class="modal">
                                <!-- Modal content -->
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <div class="header-content">
                                            <span>가입 질문</span>
                                        </div>
                                    </div>
                                    
                                    <div class="modal-body">
                                        <textarea name="applyQuestion" class="applyQuestion" placeholder="가입 질문을 작성하세요."></textarea>
                                    </div>
                                    <div class="modal-foot">
                                        <button type="button" disabled class="confirm-modal">확인</button>
                                    </div>
                                </div>
                            </div>
                            
                        </div>
    
                        <div class="button-area">
                            <button type="reset">취소</button>
                            <button class="" type="submit" onclick="setDefaultImg()">완료</button>
                        </div>
                    </form>
    
                </div>
    
            </section>
    
        </main>
    </div>

    <script>
        // 그룹 공개 타입 : Default == A(공개)
        $('#public-toAll').prop('checked', true);

        // 사용자가 업로드 할 수 있는 input은 숨김
        $('#upfile').hide();

        $('#userImg').click(function(){
            $('#upfile').click();
        })

        // groupImg : 미리보기 이미지, defaultImgs : 사이트에서 제공하는 기본 이미지들 
        const groupImg = $('#groupImg');
        const defaultImgs = $('.defaultImg');

        $(function(){ 
            // 이미지의 경로를 담아줄 arr 생성
            let imgArr = [];

            // each를 사용해서 기본 이미지의 src값들을 뽑아 배열에 push : ImgArr 배열에 각각 담김
            defaultImgs.each(function(){
                imgArr.push($(this).attr('src'));
            })

            //랜덤 이미지를 뽑기위한 Math.random : 랜덤한 수를 발생시켜 imgArr의 인덱스에 접근
            const randomImgSrc = imgArr[Math.floor(Math.random()*imgArr.length)];
            
            // 그룹이미지 미리보기 영역의 src속성의 값으로 randomImgSrc의 값을 대입
            groupImg.attr('src', randomImgSrc);

            // 선택된 기본 이미지 focus
            defaultImgs.each(function(){
                if($(this).attr('src') == $('#groupImg').attr('src')){
                    $(this).siblings().removeClass('display-none');
                }
            })

        })

        // 페이지가 로드된 이후 제공되는 이미지중 다른 이미지를 선택 할 시에 미리보기 보여줌
        defaultImgs.click(function(){
            const imgSrc = $(this).attr('src');
            $('#groupImg').attr('src', imgSrc);

            $(this).siblings().removeClass('display-none');

            defaultImgs.each(function(){
                if($(this).attr('src') != $('#groupImg').attr('src')){
                    $(this).siblings().addClass('display-none');
                }
            })

            // 만약 사용자가 upfile을 지정한 이후(input에 사진의 정보가 있을때) 라면 input 비워주기
            $('#upfile').val('');
        })

        // 사용자가 선택한 사진 미리보기 영역에 출력
        function loadImg(inputFile){
            
            if(inputFile.files.length == 1){
                const reader = new FileReader();

                reader.readAsDataURL(inputFile.files[0]);

                reader.onload = function(e){
                    groupImg.attr('src', e.target.result);
                }
            }
        }

        const img = document.getElementById('groupImg');

        observer = new MutationObserver((changes) => {
            changes.forEach(change => {
                if(change.attributeName.includes('src')){
                    
                    defaultImgs.each(function(){
                        if($(this).attr('src') != $('#groupImg').attr('src')){
                            $(this).siblings().addClass('display-none');
                        }
                    })

                }
            });
        });
        observer.observe(img, {attributes : true});
    </script>

    <script>
        // 가입 인사 작성 모달
        const modal = $('.modal');

        $('.content-row__btn #public').click(function(){
            modal.fadeIn(300);                                          // 가입 모달 열기
            if($('.applyQuestion').val().trim().length == 0){
                $('.confirm-modal').prop('disabled', true);
            }
            $('body').css({'overflow' : 'hidden', 'height' : '100%'});
        })
        
        $('.applyQuestion').keyup(function(){
            if($('.applyQuestion').val().trim().length > 0){
                $('.confirm-modal').prop('disabled', false);
            }
            else{
                $('.confirm-modal').prop('disabled', true);
            }
        })

        $('.confirm-modal').click(function(){
            modal.fadeOut(300);
            $('body').css({'overflow':'auto'});
        })

        $('.content-row__btn #private, .content-row__btn #public-toAll').click(function(){
            $('.applyQuestion').val("");
            console.log($('.applyQuestion').val());
        })
    </script>



    <script>
        function setDefaultImg(){
            $("input[name=groupImg]").val($("#groupImg").attr('src')) // 경로
        }
    </script>

    <script>
        // 드롭다운
        /*Dropdown Menu*/
    $('.dropdown').click(function () {
        $(this).attr('tabindex', 1).focus();
        $(this).toggleClass('active');
        $(this).find('.dropdown-menu').slideToggle(300);
    });
    $('.dropdown').focusout(function () {
        $(this).removeClass('active');
        $(this).find('.dropdown-menu').slideUp(300);
    });
    $('.dropdown .dropdown-menu li').click(function () {
        // console.log($(this).attr('data-no'));
        // console.log($(this).parent().siblings('input[type=hidden]'));
        $(this).parents('.dropdown').find('span').text($(this).text());
        $(this).parent().siblings('input[type=hidden]').val($(this).attr('data-no'));

    });
    </script>

    <script>
        $('#private').click(function(){
            if(confirm("비공개 그룹은 초대코드를 통해서만 멤버를 가입시킬 수 있습니다.")){
                return true;
            } 
            else{
                return false;
            }
        })
    </script>

</body>
</html>
