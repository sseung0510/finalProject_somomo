<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <!----------- CSS --------------->
    <link rel="stylesheet" href="resources/css/header.css?ver=1.0.0">
    <link rel="stylesheet" href="resources/css/createGroup.css?ver=1.0.2">
    <!----------- 아이콘 CSS 링크 ------->
    <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css">
    <script src="https://kit.fontawesome.com/567fbbaed5.js" crossorigin="anonymous"></script>
    <!----------- 아이콘 CSS 링크 version 2------->
    <!-- jquery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <meta charset="UTF-8">
    <title>소모모 - 그룹 정보 변경</title>
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
                        <input id="groupName" name="groupName" required type="text" placeholder="그룹명을 입력하세요" value="${g.groupName}">
                    </div>

                    <div class="img-sheet">
                        <div class="main-img">
                            <span>
                                <img id="groupImg" alt="그룹대표이미지" src="${g.groupImg}" alt="">
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
                                    <img class="defaultImg" src="resources/img/group/defaultGroupImg/sample_group_img1.jpeg" alt="" >
                                    <div class="middle">선택됨</div>
                                </li>
                                <li>
                                    <img class="defaultImg" src="resources/img/group/defaultGroupImg/sample_group_img2.jpeg" alt="" >
                                    <div class="middle">선택됨</div>
                                </li>
                                <li>
                                    <img class="defaultImg" src="resources/img/group/defaultGroupImg/sample_group_img3.jpeg" alt="" >
                                    <div class="middle">선택됨</div>
                                </li>
                                <li>
                                    <img class="defaultImg" src="resources/img/group/defaultGroupImg/sample_group_img4.jpeg" alt="" >
                                    <div class="middle">선택됨</div>
                                </li>
                                <li>
                                    <img class="defaultImg" src="resources/img/group/defaultGroupImg/sample_group_img5.jpeg" alt="" >
                                    <div class="middle">선택됨</div>
                                </li>
                                <li>
                                    <img class="defaultImg" src="resources/img/group/defaultGroupImg/sample_group_img6.jpeg" alt="" >
                                    <div class="middle">선택됨</div>
                                </li>
                                <li>
                                    <img class="defaultImg" src="resources/img/web_logo.jpg" alt="" >
                                    <div class="middle">선택됨</div>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <input type="file" name="upfile" id="upfile" onchange="loadImg(this);">

                    <div class="groupDesc-sheet">
                        <textarea name="groupDetail" id="groupDetail" placeholder="생성하신 그룹에 관한 간단한 설명을 적어주세요" required>${g.groupDetail }</textarea>
                    </div>

                    <div class="groupType-sheet">
                        <div class="head">
                            <h4>그룹 공개</h4>
                        </div>
                        
                        <div class="content">
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

                    <div class="button-area">
                        <button type="reset">취소</button>
                        <button class="" type="submit">완료</button>
                    </div>
                </form>
            </div>
        </section>
    </main>

    <script>
        // 그룹의 현재 설정들을 초기 값으로 설정해주기
        // 1) 그룹 타입
        $('input[name="groupType"]').each(function(){
            if($(this).val() == '${g.groupType}'){
                $(this).prop('checked', 'true');
            }
        })

        // 2) 지역/ 그룹카테고리
        $('#regionNo').val(${g.regionNo});
        $('#categoryNo').val(${g.categoryNo});


        console.log($('#groupImg').attr('src'));

        $('.defaultImg').each(function(){
            if($(this).attr('src') == '${g.groupImg}'){
                $(this).addClass('selectedImg');
            }
        })

    </script>

</body>
</html>