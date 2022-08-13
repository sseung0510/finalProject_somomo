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
    <link rel="stylesheet" href="resources/css/header.css?ver=1.0.0">
    <link rel="stylesheet" href="resources/css/createGroup.css?ver=1.0.5">
    <!----------- 아이콘 CSS 링크 ------->
    <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css">
    <script src="https://kit.fontawesome.com/567fbbaed5.js" crossorigin="anonymous"></script>
    <!----------- 아이콘 CSS 링크 version 2------->
    <!-- jquery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <title>소모모 - ${g.groupName}</title>
</head>
<body>
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
                <form action="update.gr" enctype="multipart/form-data" method="post">
                    <input type="hidden" name="groupNo" value="${g.groupNo}">
                    <div class="category-sheet">
                        <label for="regionNo">지역 선택</label>
                        <select name="regionNo" id="regionNo">
                            <c:forEach var="r" items="${rList}">
                                <option value="${r.regionNo}">${r.regionName}</option>
                            </c:forEach>    
                        </select>

                        <label for="categoryNo">그룹 카테고리</label>
                        <select name="categoryNo" id="categoryNo">
                            <c:forEach var="c" items="${cList}">
                                <option value="${c.categoryNo}">${c.categoryName}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <br><br>

                    <div class="groupName-sheet">
                        <label for="">GROUP</label><br>
                        <input id="groupName" name="groupName" required type="text" placeholder="그룹명을 입력하세요" value="${g.groupName}">
                        <input type="hidden" id="originFile" name="originFile" value="${g.groupImg}">
                    </div>

                    <div class="img-sheet">
                        <div class="main-img">
                            <span>
                                <img id="groupImg" alt="그룹대표이미지" src="${g.groupImg}" alt="">
                                <input type="hidden" name= "groupImg" value="${g.groupImg}">
                            </span>
                        </div>
                        
                        <div class="img-list">
                            <div class="head">
                                <h3>그룹을 대표할 사진을 선택하세요</h3>
                            </div>
                            <ul class="list">
                                <li><img id="userImg" src="resources/img/addImg.png" alt=""></li>
                                <li>
                                    <img class="defaultImg" src="resources/img/group/defaultGroupImg/sample_group_img1.jpeg" alt="" >
                                    <div class="middle display-none"><i class="fa-solid fa-check"></i></div>
                                </li>
                                <li>
                                    <img class="defaultImg" src="resources/img/group/defaultGroupImg/sample_group_img2.jpeg" alt="" >
                                    <div class="middle display-none"><i class="fa-solid fa-check"></i></div>
                                </li>
                                <li>
                                    <img class="defaultImg" src="resources/img/group/defaultGroupImg/sample_group_img3.jpeg" alt="" >
                                    <div class="middle display-none"><i class="fa-solid fa-check"></i></div>
                                </li>
                                <li>
                                    <img class="defaultImg" src="resources/img/group/defaultGroupImg/sample_group_img4.jpeg" alt="" >
                                    <div class="middle display-none"><i class="fa-solid fa-check"></i></div>
                                </li>
                                <li>
                                    <img id="me" class="defaultImg" src="resources/img/group/defaultGroupImg/sample_group_img5.jpeg" alt="" >
                                    <div class="middle display-none"><i class="fa-solid fa-check"></i></div>
                                </li>
                                <li>
                                    <img class="defaultImg" src="resources/img/group/defaultGroupImg/sample_group_img6.jpeg" alt="" >
                                    <div class="middle display-none"><i class="fa-solid fa-check"></i></div>
                                </li>
                                <li>
                                    <img class="defaultImg" src="resources/img/web_logo.jpg" alt="" >
                                    <div class="middle display-none"><i class="fa-solid fa-check"></i></div>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <input type="file" name="reupfile" id="reupfile" onchange="loadImg(this);">

                    <div class="groupDesc-sheet">
                        <textarea name="groupDetail" id="groupDetail" placeholder="생성하신 그룹에 관한 간단한 설명을 적어주세요" required>${g.groupDetail}</textarea>
                    </div>

                    <div class="button-area">
                        <button type="reset">취소</button>
                        <button class="" type="submit" onclick="setDefaultImg();">완료</button>
                    </div>
                </form>

            </div>

        </section>

    </main>

    <script>
        // groupImg : 미리보기 이미지, defaultImgs : 사이트에서 제공하는 기본 이미지들 
        const groupImg = $('#groupImg');
        const defaultImgs = $('.defaultImg');

        // 그룹의 기존 설정 값 : 지역번호, 카테고리 번호, 그룹방 이름, 그룹방디테일, 그룹방 사진
        $('#regionNo').val(${g.regionNo});
        $('#categoryNo').val(${g.categoryNo});

        // 사용자가 업로드 할 수 있는 input은 숨김
        $('#reupfile').hide();
        $('#userImg').click(function(){
            $('#reupfile').click();
        })

        // 만약 그룹의 대표 이미지가 기본 이미지라면 저장된 이미지 표시
        defaultImgs.each(function(){
            if($(this).attr('src') == groupImg.attr('src')){
                $(this).siblings().removeClass('display-none');
            }
        })

        // 페이지가 로드된 이후 제공되는 이미지중 다른 이미지를 선택 할 시에 미리보기 보여줌
        defaultImgs.click(function(){
            const imgSrc = $(this).attr('src');
            groupImg.attr('src', imgSrc);

            $(this).siblings().removeClass('display-none');

            defaultImgs.each(function(){
                if($(this).attr('src') != $('#groupImg').attr('src')){
                    $(this).siblings().addClass('display-none');
                }
            })

            // 만약 사용자가 upfile을 지정한 이후(input에 사진의 정보가 있을때) 라면 input 비워주기
            $('#reUpfile').val('');
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
        function setDefaultImg(){
            $("input[name=groupImg]").val($("#groupImg").attr('src')) // 경로
        }
    </script>

</body>
</html>
