<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
 <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <!----------- CSS --------------->
    <link rel="stylesheet" href="resources/css/groupHeader.css?ver=1.0.6">
    <link rel="stylesheet" href="resources/css/style2.css?ver=1.1.5">
    <link rel="stylesheet" href="resources/css/groupLeft.css?ver=1.0.5">
    <link rel="stylesheet" href="resources/css/groupRight.css?ver=1.0.4">
    <link rel="stylesheet" href="resources/css/calendar.css">
    <link rel="stylesheet" href="resources/css/calendar.main.css">
    <!----------- 아이콘 CSS 링크 ------->
    <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css">
    <script src="https://kit.fontawesome.com/567fbbaed5.js" crossorigin="anonymous"></script>
    <!----------- 아이콘 CSS 링크 version 2------->
    <!-- Boxicons CSS -->
    <link href='https://unpkg.com/boxicons@2.1.1/css/boxicons.min.css' rel='stylesheet'>


    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="resources/js/ko.js"></script>
    <script src="resources/js/calendar.main.js"></script>
    
    
    <!-- DatePicker -->

    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/flatpickr/4.2.3/flatpickr.cstainers">
    <link rel="stylesheet" href="resources/css/flatpickr.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/flatpickr/4.2.3/flatpickr.js"></script>
    <script src="https://npmcdn.com/flatpickr/dist/l10n/ko.js"></script>

    <title>소모모</title> 
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
			
			
			
			  <!------------------ 캘린더 설정 ---------------------->

            <div id='calendar'>
               
                
            </div>


            <!-------------- 캘린더 모달 창 ------------->
        <form action="">
            <div class="event-popup-outer" id="eventwritePopup">
                <div class="event-popup-box" id="eventpopupBox">
                    <i id="event-close" class='bx bx-x close'></i>
                    <header class="eventHeader">
                        <h1 class="title">일정만들기</h1>
                        
                    </header>
                    <div class="eventBody" id="eventBody">
                        <div class="eventContentWrap">
                            <div class="textInputArea">
                                <input type="text" placeholder="일정제목" >
                            </div>
                            <div class="textInputArea-2">
                                <textarea 
                                placeholder="일정설명"
                                maxlength="1500" ></textarea>
                            </div>
                            <div class="infoWrap">
                                <div class="flexList">
                                    <div class="labelText">시작&nbsp&nbsp&nbsp:</div>
                                    <input type="text" id="startDate" placeholder="날짜설정" class="input" >
                                    <i class="uil uil-calendar-alt"></i>
                                    <input type="text" id="startTimePicker" placeholder="시간설정">
                                </div>

                                <div class="flexList">
                                    <div class="labelText">종료&nbsp&nbsp&nbsp:</div>
                                    <input type="text" id="endDate" placeholder="날짜설정" class="input">
                                    <i class="uil uil-calendar-alt"></i>
                                    <input type="text" id="endTimePicker" placeholder="시간설정">
                                </div>

                                <div class="allDay-check">
                                    <input type="checkbox" id="checkbox"/>
                                    <label for="checkbox"></label>
                                    <span>하루종일</span>
                                </div>

                                <div class="colorSelect">
                                    <h2>글자 색</h2>
                                    <ul class="textColorList">
                                        <li class="item skin1">
                                            <label for="textColorskin1" class="uCheck">
                                                <input name="textColor" value="skin1" type="radio" id="textColorskin1" class="checkInput">
                                                <span class="fakeCheck skin1"></span>
                                            </label>
                                        </li>
                                        <li class="item skin2">
                                            <label for="textColorskin2" class="uCheck">
                                                <input name="textColor" value="skin2" type="radio" id="textColorskin2" class="checkInput">
                                                <span class="fakeCheck skin2"></span>
                                            </label>
                                        </li>
                                        <li class="item skin3">
                                            <label for="textColorskin3" class="uCheck">
                                                <input name="textColor" value="skin3" type="radio" id="textColorskin3" class="checkInput">
                                                <span class="fakeCheck skin3"></span>
                                            </label>
                                        </li>
                                        <li class="item skin4">
                                            <label for="textColorskin4" class="uCheck">
                                                <input name="textColor" value="skin4" type="radio" id="textColorskin4" class="checkInput">
                                                <span class="fakeCheck skin4"></span>
                                            </label>
                                        </li>
                                        <li class="item skin5">
                                            <label for="textColorskin5" class="uCheck">
                                                <input name="textColor" value="skin5" type="radio" id="textColorskin5" class="checkInput">
                                                <span class="fakeCheck skin5"></span>
                                            </label>
                                        </li>
                                    </ul>
                                </div>


                                <div class="colorSelect">
                                    <h2>배경 색</h2>
                                    <ul class="colorList">
                                        <li class="item skin1">
                                            <label for="colorskin1" class="uCheck">
                                                <input name="color" value="skin1" type="radio" id="colorskin1" class="checkInput">
                                                <span class="fakeCheck b-skin1"></span>
                                            </label>
                                        </li>
                                        <li class="item skin2">
                                            <label for="colorskin2" class="uCheck">
                                                <input name="color" value="skin2" type="radio" id="colorskin2" class="checkInput">
                                                <span class="fakeCheck b-skin2"></span>
                                            </label>
                                        </li>
                                        <li class="item skin3">
                                            <label for="colorskin3" class="uCheck">
                                                <input name="color" value="skin3" type="radio" id="colorskin3" class="checkInput">
                                                <span class="fakeCheck b-skin3"></span>
                                            </label>
                                        </li>
                                        <li class="item skin4">
                                            <label for="colorskin4" class="uCheck">
                                                <input name="color" value="skin4" type="radio" id="colorskin4" class="checkInput">
                                                <span class="fakeCheck b-skin4"></span>
                                            </label>
                                        </li>
                                        <li class="item skin5">
                                            <label for="colorskin5" class="uCheck">
                                                <input name="color" value="skin5" type="radio" id="colorskin5" class="checkInput">
                                                <span class="fakeCheck b-skin5"></span>
                                            </label>
                                        </li>
                                    </ul>
                                </div>



                            </div>
                            <div class="buttonWrap">
                                <button>완료</button>
                            </div>
                        </div>
                    </div>
                    
                </div>
            </div>
        </form>

        </div>

        <div class="main-right">
            <jsp:include page="groupDetailCommon/rightSidebar.jsp"/>
        </div>

    </div>
    
    <!-- 세팅페이지에서 각각의 POST요청을 처리해주는 form태그와 script -->
    <form id="postForm" method="post">
		<input type="hidden" value="${g.groupNo}" name="groupNo"/>
    </form>	
    
    
    <script src="resources/js/GroupCalendar.js"></script>
</body>
</html>