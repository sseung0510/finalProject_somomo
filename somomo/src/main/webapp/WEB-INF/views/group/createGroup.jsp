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
    <link rel="stylesheet" href="resources/css/createGroup.css?ver=1.0.0">
    <!----------- 아이콘 CSS 링크 ------->
    <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css">
    <script src="https://kit.fontawesome.com/567fbbaed5.js" crossorigin="anonymous"></script>
    <!----------- 아이콘 CSS 링크 version 2------->
    <!-- jquery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <title>그룹을 만들어 보아요</title>
</head>
<body>
    <div class="wrapper">
        <header>
            <div class="logo-name">
                <div class="logo-image">
                    <a href="index.html"><img src="resources/img/logo.jpg" alt=""></a>
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
                    <div class="category-sheet">
                        <label for="regionNo">지역 선택</label>
                        <select name="regionNo" id="regionNo">
                            <option value="1">서울</option>
                            <option value="2">경기도</option>
                            <option value="3">인천</option>
                            <option value="4">대전</option>
                            <option value="5">대구</option>
                            <option value="6">광주</option>
                            <option value="7">부산</option>
                            <option value="8">울산</option>
                            <option value="9">세종</option>
                            <option value="10">강원</option>
                            <option value="11">충북</option>
                            <option value="12">충남</option>
                            <option value="13">경북</option>
                            <option value="14">경남</option>
                            <option value="15">전북</option>
                            <option value="16">전남</option>
                            <option value="17">제주</option>
                            <option value="18">전체지역</option>
                        </select>

                        <label for="categoryNo">그룹 카테고리</label>
                        <select name="categoryNo" id="categoryNo">
                            <option value="1">개발</option>
                            <option value="2">스터디</option>
                            <option value="3">운동/취미</option>
                            <option value="4">기타</option>
                        </select>
                    </div>

                    <br><br>

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
                        
                        <script>
                            function setDefaultImg(){
                                $("input[name=groupImg]").val($("#groupImg").attr('src')) // 경로
                                // alert($("input[name=groupImg]").val());  // 출력
                            }
                        </script>
                        
                        
                        <div class="img-list">
                            <div class="head">
                                <h3>그룹을 대표할 사진을 선택하세요</h3>
                            </div>
                            <ul class="list">
                                <li><img id="userImg" src="resources/img/addImg.png" alt=""></li><!-- 이친구는 사용자가 등록 할 수 있는 사진 -->
                                <!-- 아래 사진들은 사이트에서 기본적으로 제공해주는 사진들 -->
                                <li><img class="defaultImg" src="resources/img/group/defaultGroupImg/sample_group_img1.jpeg" alt="" ></li>
                                <li><img class="defaultImg" src="resources/img/group/defaultGroupImg/sample_group_img2.jpeg" alt="" ></li>
                                <li><img class="defaultImg" src="resources/img/group/defaultGroupImg/sample_group_img3.jpeg" alt="" ></li>
                                <li><img class="defaultImg" src="resources/img/group/defaultGroupImg/sample_group_img4.jpeg" alt="" ></li>
                                <li><img class="defaultImg" src="resources/img/group/defaultGroupImg/sample_group_img5.jpeg" alt="" ></li>
                                <li><img class="defaultImg" src="resources/img/group/defaultGroupImg/sample_group_img6.jpeg" alt="" ></li>
                                <li><img class="defaultImg" src="resources/img/web_logo.jpg" alt="" ></li>
                            </ul>
                        </div>
                    </div>
                    <input type="file" name="upfile" id="upfile" onchange="loadImg(this);">
                    <script>
                        // 페이지가 로드되면 랜덤으로 그룹이미지 지정
                        const groupImg = $('#groupImg');
                        const defaultImgs = $('.defaultImg');

                        $(function(){
                            
                            // 이미지의 경로를 담아줄 arr 생성
                            let imgArr = [];

                            // forEach를 사용해서 imgArr 배열에 기본이미지의 src push
                            defaultImgs.each(function(){
                                imgArr.push($(this).attr('src'));
                            })

                            // 배열에서 난수를 발생시키고 배열의 길이만큼 곱한뒤 floor처리로 소수점아래 버려줌 => 랜덤 src 생성
                            const randomImgSrc = imgArr[Math.floor(Math.random()*imgArr.length)];
                            
                            // 그룹이미지 미리보기 영역의 src속성의 값으로 생성한 랜덤 src 추가
                            groupImg.attr('src', randomImgSrc);
                        })
                        

                        // 페이지가 로드된 이후 사용자가 제공되는 이미지중 다른 이미지를 선택할시에 미리보기 보여줌
                        $('.defaultImg').click(function(){
                            const imgSrc = $(this).attr('src');
                            $('#groupImg').attr('src', imgSrc);

                            // 만약 사용자가 upfile을 지정한 이후(input에 사진의 정보가 있을때) 라면 input 비워주기
                            $('#upfile').val('');
                        })

                        // 사용자가 선택한 사진 미리보기 영역에 출력
                        function loadImg(inputFile){
                            
                            if(inputFile.files.length == 1){
                                const reader =new FileReader();

                                reader.readAsDataURL(inputFile.files[0]);

                                reader.onload = function(e){
                                    groupImg.attr('src', e.target.result);
                                }
                            }
                        }

                        // Input태그는 숨겨준다
                        $('#upfile').hide();
                        $('#userImg').click(function(){
                            $('#upfile').click();
                        })
                    </script>

                    <div class="groupDesc-sheet">
                        <textarea name="groupDetail" id="groupDetail" placeholder="생성하신 그룹에 관한 간단한 설명을 적어주세요" required></textarea>
                    </div>

                    <div class="groupType-sheet">
                        <div class="head">
                            <h4>그룹 공개</h4>
                        </div>
                        
                        <div class="content">
                            <div class="content-row">
                                <div class="content-row__btn">
                                    <input name="groupType" value="" type="radio" id="private">
                                    <label for="private">비공개 그룹</label>
                                </div>
                                <div class="content-row__desc">그룹과 게시글이 공개되지 않습니다. 초대를 통해서만 가입할 수 있습니다.</div>
                            </div>
                            <div class="content-row">
                                <div class="content-row__btn">
                                    <input name="groupType" value="B" type="radio" id="public">
                                    <label for="public">그룹명 공개 밴드</label> 
                                </div>
                                <div class="content-row__desc">누구나 그룹을 검색으로 찾아 그룹 소개를 볼 수 있지만, 게시글은 멤버만 볼 수 있습니다.</div>
                            </div>
                            <div class="content-row">
                                <div class="content-row__btn">
                                    <input name="groupType" value="A" type="radio" id="public-toAll">
                                    <label for="public-toAll">공개 밴드</label>
                                </div>
                                <div class="content-row__desc">누구나 그룹을 검색해 찾을 수 있고, 그룹 소개와 게시글을 볼 수 있습니다.</div>
                            </div>
                        </div>
                    </div>

                    <div class="button-area">
                        <button type="reset">취소</button>
                        <button class="" type="submit" onclick="setDefaultImg();">완료</button>
                    </div>
                </form>

            </div>

        </section>

    </main>

</body>
</html>