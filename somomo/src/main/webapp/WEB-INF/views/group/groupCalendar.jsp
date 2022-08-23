<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
 <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <!----------- CSS --------------->
    <link rel="stylesheet" href="resources/css/groupHeader.css?ver=1.0.9">
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



    <script src="resources/js/calendar.main.js"></script>
    <script src="resources/js/ko.js"></script>
    
    
    
    <!-- Momoent 라이브러리 -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment-with-locales.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/locale/ko.min.js"></script>
    
    <!-- DatePicker -->

    <!-- 
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/flatpickr/4.2.3/flatpickr.css">
    <link rel="stylesheet" href="resources/css/flatpickr.css?ver=1.0.4"> 
     <script src="https://cdnjs.cloudflare.com/ajax/libs/flatpickr/4.2.3/flatpickr.js"></script>
    <script src="https://npmcdn.com/flatpickr/dist/l10n/ko.js"></script>
-->
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

            <div id='calendar' style="margin-left : 30px">
               
                
            </div>
            
            
            
              <!-- 캘린더 event 모달 창 -->

            <div class="event-list-outer" id="eventListPopup">
                <div class="event-list-box">
                     <div class="event-list-header">
                        <span class="day">
                            <strong class="date"></strong>
                            <span class="week-color"></span>
                        </span>
                        <div class="contWrap">
                            <h2 class="title"></h2>
                            <div class="startDay">
                            </div>
                             <div class=eventName>
	                        	<span>작성자 : </span>
	                        	<span class="eventId"></span>
                        	</div>
                        </div>
                        <div class="event-icon">
                            <i class='bx bx-dots-vertical-rounded event'>
                                <ul class="event-link">
                                    <li><a href="" id="deleteEvent">삭제하기</a></li>
                                    <li><a href="">게시글에 올리기</a></li>
                                    <li><a href="">주소 복사</a></li>
                                </ul>
                            </i>
                         </div>
                       
                     </div>

                     <div class="memo">

                    </div>


                </div>
            </div>

            
			
            <!-------------- 캘린더 모달 창 ------------->
        <form action="insertCalendarEvent.gr" method="post" id="calendarEventForm" onsubmit="return vaildateForm()">
        	<input type="hidden" name="groupNo" value="${c.groupNo}">
        	<input type="hidden" name="calendarNo" value="${c.calendarNo}">
        	<input type="hidden" name="userId" value="${loginUser.userId}">
            <div class="event-popup-outer" id="eventwritePopup">
                <div class="event-popup-box" id="eventpopupBox">
                    <i id="event-close" class='bx bx-x close'></i>
                    <header class="eventHeader">
                        <h1 class="title">일정만들기</h1>
                        
                    </header>
                    <div class="eventBody" id="eventBody">
                        <div class="eventContentWrap">
                            <div class="textInputArea">
                                <input type="text" name="title" placeholder="일정제목" id="title">
                            </div>
                            <div class="textInputArea-2">
                                <textarea name="memo"
                                placeholder="일정설명"
                                id="memo"
                                maxlength="1500" ></textarea>
                            </div>
                            <div class="infoWrap">
                                <div class="flexList">
                                    <div class="labelText">시작&nbsp&nbsp&nbsp:</div>
                                    <input type="text" id="startDate" placeholder="날짜설정" class="input" name="startDate">
                                    <i class="uil uil-calendar-alt"></i>
                                    <input type="text" id="startTimePicker" placeholder="시간설정" name="startTime">
                                </div>

                                <div class="flexList">
                                    <div class="labelText">종료&nbsp&nbsp&nbsp:</div>
                                    <input type="text" id="endDate" placeholder="날짜설정" class="input" name="endDate">
                                    <i class="uil uil-calendar-alt"></i>
                                    <input type="text" id="endTimePicker" placeholder="시간설정" name="endTime">
                                </div>

                                <div class="allDay-check">
                                    <input type="checkbox" id="checkbox" name="allDay"/>
                                    <label for="checkbox"></label>
                                    <span>하루종일</span>
                                </div>

                                <div class="colorSelect">
                                    <h2>글자 색</h2>
                                    <ul class="textColorList">
                                        <li class="item skin1">
                                            <label for="textColorskin1" class="uCheck">
                                                <input name="textColor" value="black" type="radio" id="textColorskin1" class="checkInput">
                                                <span class="fakeCheck skin1"></span>
                                            </label>
                                        </li>
                                        <li class="item skin2">
                                            <label for="textColorskin2" class="uCheck">
                                                <input name="textColor" value="gainsboro" type="radio" id="textColorskin2" class="checkInput">
                                                <span class="fakeCheck skin2"></span>
                                            </label>
                                        </li>
                                        <li class="item skin3">
                                            <label for="textColorskin3" class="uCheck">
                                                <input name="textColor" value="burlywood" type="radio" id="textColorskin3" class="checkInput">
                                                <span class="fakeCheck skin3"></span>
                                            </label>
                                        </li>
                                        <li class="item skin4">
                                            <label for="textColorskin4" class="uCheck">
                                                <input name="textColor" value="khaki" type="radio" id="textColorskin4" class="checkInput">
                                                <span class="fakeCheck skin4"></span>
                                            </label>
                                        </li>
                                        <li class="item skin5">
                                            <label for="textColorskin5" class="uCheck">
                                                <input name="textColor" value="red" type="radio" id="textColorskin5" class="checkInput">
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
                                                <input name="color" value="black" type="radio" id="colorskin1" class="checkInput" >
                                                <span class="fakeCheck b-skin1"></span>
                                            </label>
                                        </li>
                                        <li class="item skin2">
                                            <label for="colorskin2" class="uCheck">
                                                <input name="color" value="pink" type="radio" id="colorskin2" class="checkInput">
                                                <span class="fakeCheck b-skin2"></span>
                                            </label>
                                        </li>
                                        <li class="item skin3">
                                            <label for="colorskin3" class="uCheck">
                                                <input name="color" value="turquoise" type="radio" id="colorskin3" class="checkInput">
                                                <span class="fakeCheck b-skin3"></span>
                                            </label>
                                        </li>
                                        <li class="item skin4">
                                            <label for="colorskin4" class="uCheck">
                                                <input name="color" value="gold" type="radio" id="colorskin4" class="checkInput">
                                                <span class="fakeCheck b-skin4"></span>
                                            </label>
                                        </li>
                                        <li class="item skin5">
                                            <label for="colorskin5" class="uCheck">
                                                <input name="color" value="red" type="radio" id="colorskin5" class="checkInput">
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
    
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
	<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
    <script src="resources/js/GroupCalendar.js"></script>
</body>
</html>