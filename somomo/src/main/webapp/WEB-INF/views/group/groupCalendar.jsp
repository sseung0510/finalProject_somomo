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
    <link rel="stylesheet" href="resources/css/groupRight.css?ver=1.1.4">
    <link rel="stylesheet" href="resources/css/calendar.css">
    <link rel="stylesheet" href="resources/css/calendar.main.css">
    <!----------- 아이콘 CSS 링크 ------->
    <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css">
    <script src="https://kit.fontawesome.com/567fbbaed5.js" crossorigin="anonymous"></script>
    <!----------- 아이콘 CSS 링크 version 2------->
    <!-- Boxicons CSS -->
    <link href='https://unpkg.com/boxicons@2.1.1/css/boxicons.min.css' rel='stylesheet'>


	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="resources/js/calendar.main.js"></script>
    <script src="resources/js/ko.js"></script>
    
    
    
    <!-- Moment 라이브러리 -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment-with-locales.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/locale/ko.min.js"></script>
    
    <!-- DatePicker -->


    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/flatpickr/4.2.3/flatpickr.css">
    <link rel="stylesheet" href="resources/css/flatpickr.css?ver=1.0.4"> 
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
                             <!-- 
                                <ul class="event-link">
                                  
                                    <li><a href="" id="deleteEvent">삭제하기</a></li>
                                    <li><a href="">게시글에 올리기</a></li>
                                    <li><a href="">주소 복사</a></li>
                                	 
                                </ul>
                                -->
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
    
    
    
    <!-- 
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
	<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script> -->
	
	
	
	<script>

		$(function(){
			calendarEventList();
		})

		function calendarEventList(){
				$.ajax({
					url:"calendarEventListEntire.gr",
					data:{
						groupNo : "${c.groupNo}"
					}, success: function(data){
						console.log(data);
						var result="";
						var diff =[];
						var somomo =[];
						var now = new Date();
						var year = now.getFullYear(); // 현재연도
						var month = now.getMonth()+1; // 월
						var day = now.getDate(); // 일
						for(var i in data){
						
							diff[i] = data[i].startDate.substr(0,10);
							somomo[i] = diff[i].split('-');
							
							var stDate = new Date(somomo[i][0],somomo[i][1],somomo[i][2]);
							var endDate = new Date(year, month, day);
							var btMs =  stDate.getTime()-endDate.getTime();
							var btDay = btMs / (1000*60*60*24); // 차이 일수로 계산
							if(btDay <= 14 && btDay >= 0) {
								
								/*
								data[i].title
								var somomoDay = moment(diff[i]).format("Do");
								var momoDay = moment(diff[i]).format('dddd');
								*/
								
							result += '<ul>'
								   +  	'<li>'
								   + 		 '<a>'
								   +  			'<div class="eventCont">' + moment(diff[i]).format('dddd')
								   +  			'<span>' + moment(diff[i]).format("Do") + '</span>'
								   +  			'</div>'
								   +  			'<div class="cont">'
								   +  			'<strong>' + data[i].title + '</strong>'
								   +  			'</div>'
								   +  		'</a>'
								   +  	'</li>'
								   +  '</ul>'
						
							
							}
							
						
							
						
						}
						
						
						$('.schedule-body').append(result);
						
						
						
					}, error:function(){
						alert("ajax 통신 실패");
					}
				})
			}
	
</script>
	
	
	
    <script>

    document.addEventListener('DOMContentLoaded', function() {
    		  $(function () {
    		  				
    		  				
    		                var request = $.ajax({
    		                    url: "selectCalendarEvents.gr", 
    		                    data : {
    		                    
    		                    calendarNo : ${c.calendarNo}
    		                    
    		                    },
    		                    
    		                });
    		  
    		  request.done(function (data) {
    		                   //console.log(data); // log 로 데이터 찍어주기.
    		                    
    		                 
    					
    		  var calendarEl = document.getElementById('calendar');
    		  var calendar = new FullCalendar.Calendar(calendarEl, {
    		
    		    customButtons: {
    		      myCustomButton: {
    		        text: '일정 만들기',
    		        click: function() {	
    		          eventPopup();
    		        }
    		      }
    		    },
    		    headerToolbar: {
    		    
    		      left: 'prev,next,today',
    		      center: 'title',
    		      right: 'myCustomButton',
    		    },
    		
    		
    		    initialView: 'dayGridMonth',
    		    locale : 'ko',
    		    editable: true,
    		    dayMaxEvents: true,
    		    selectable: true, // 이건필요함
    		    selectMirror: false,
    		    select: function(arg) {
    		      //console.log(arg); // 선택한 인자의 객체가 생성됨
    		      // console.log(arg.endStr); // 이런식으로 allDay endStr 등을 빼 올 수 있다 이제 이거를 eventPopup에 전달해줘야 한다
    		      // 정확히 말하면 eventPopup 창에 input 태그 value 값에 전달해 줘야 한다.
    		
    		      var startDate = arg.startStr;
    		
    		      // end 날짜가 자꾸 하루 더 늦게 나와서 -1 을 해야 한다
    		      var d = arg.end;
    		
    		      var endDate = d.getFullYear() + "-" + ((d.getMonth() + 1) > 9 ? (d.getMonth() + 1).toString() : "0" + (d.getMonth() + 1)) + "-" + ((d.getDate() > 9 ? d.getDate().toString() : "0" + d.getDate().toString())-1);
    		      // console.log(endDate)
    		      // var endDate = arg.endStr;
    		      arg.allDay = false; // 시간은 자유롭게 선택하게 false로 준다
    		      $('#startDate').attr('value' , startDate);
    		      $('#endDate').attr('value' , endDate);
    		      eventPopup();
    		      
    		
    		      },
    		
    		        eventClick: function(arg) {
    		          
    		           
    		            var koreaday =  moment(arg.event.start).format("Do");
    		      		var day = moment(arg.event.start).format('dddd')
    		      		var startDay = moment(arg.event.start).format('LLL');
    		      		var endDay = moment(arg.event.end).format('LLL');
    		      		var memo = arg.event.id;
    					var eventId = arg.event.groupId;
    		      	
    		      		console.log(eventId);
    		            eventListPopup();
    		            
    		            if(endDay == "Invalid date"){
    		            	endDay = "";
    		            }
    		           
    		           	$('.contWrap .title').text(arg.event.title);
    		           	$('.day .date').text(koreaday);
    		           	$('.day .week-color').text(day);
    		           	$('.memo').text(memo);
    		           	$('.eventId').text(eventId);
    		           	$('.startDay').text(startDay + " - " + endDay);
    		           	
    		           	
                
            		},
            		
    		    events: data
    		    
    		    
    		  });
    		  calendar.render();
    		});

     			request.fail(function( jqXHR, textStatus ) {
                    alert( "정보 불러오는데 실패~ " + textStatus );
                });
            });
            	
     
        });


    		// 버튼 눌렀을 때 모달창 띄워주기
    		function eventPopup(){
    		    const f = new writeEventPopup();
    		    f.show();
    		}


    		// 모달창 JS
    		
    		let writeEventPopup = function() {
    		
    		
    		 // 기본값 세팅
    		  if($('#startDate').val() == '') {
    		    var date = new Date();
    		    
    		    $("#startDate").attr('value', moment(date).format('YYYY-MM-DD'));
    		  }
    		 
    		  this.popup = $('#eventwritePopup');
    		
    		  this.show = ()=>{
    		    this.popup.css('display', 'flex');
    		    this.popup.addClass("lyWrap");
    		}
    		
    		var hide = ()=>{
    		  this.popup.removeClass("lyWrap");
    		  this.popup.css('display', 'none');
    		}
    		
    		this.closeButton = $("#eventwritePopup #event-close")
    		    this.closeButton.click(()=>{
    		
    		        hide();
    		        $('form').each(function(){
    		        	$('#startTimePicker').val('');
    		        	$('#endTimePicker').val('');
    		          this.reset();
    		        })
    		
    		    })
    		
    		
    		}
    		
    		$("#startDate").flatpickr({
    		  'monthSelectorType' : 'static',
    		  dateFormat: "Y-m-d",
    		  locale: 'ko'
    		});
    		
    		$("#endDate").flatpickr({
    		  'monthSelectorType' : 'static',
    		  dateFormat: "Y-m-d",
    		  locale: 'ko'
    		});
    		
    		$("#startTimePicker").flatpickr({
    		  enableTime: true,
    		  noCalendar: true,
    		  time_24hr: true,
    		  dateFormat: "H:i",
    		});
    		
    		$("#endTimePicker").flatpickr({
    		  enableTime: true,
    		  noCalendar: true,
    		  time_24hr: true,
    		  dateFormat: "H:i",
    		});
    		

    		// 하루종일 버튼 눌렀을 떄 시간설정 disabled 해주기
    		
    		    var count = 0;
    		    $("#checkbox").click(function(){
    		      if(count==0){
    		        
    		        
    		        $('#startTimePicker').attr("disabled", "disabled");
    		        $('#endTimePicker').attr("disabled", "disabled");
    		        
    		        $('#startTimePicker').css("opacity", "0.5");
    		        $('#endTimePicker').css("opacity", "0.5");
    		        count=1;
    		      }
    		      else{
    		        $('#startTimePicker').attr("disabled", false);
    		        $('#endTimePicker').attr("disabled", false);
    		
    		        $('#startTimePicker').css("opacity", "1");
    		        $('#endTimePicker').css("opacity", "1");
    		        count=0;
    		      }
    		  });



    		   //yyyy-mm-dd 포맷 날짜 생성
    		 
    		
    		  function currentDate() {
    		    var d = new Date();
    		    return d.getFullYear() + "-" + ((d.getMonth() + 1) > 9 ? (d.getMonth() + 1).toString() : "0" + (d.getMonth() + 1)) + "-" + (d.getDate() > 9 ? d.getDate().toString() : "0" + d.getDate().toString());
    		}
    		
    		
    		
    		
    		
    		// 유효성 검사
    		
    		vaildateForm = () => {
    		
    		  if($('#title').val() == '') {
    		    alert('제목을 입력해주세요');
    		    $('#title').focus();
    		    return false;
    		  }
    		  if($('#memo').val() == '') {
    		  	alert('일정설명을 입력해주세요');
    		  	$('#memo').focus();
    		  	return false;
    		  }
    		  
    		  var date1 = new Date($('#startDate').val());
    		  var date2 = new Date($('#endDate').val());
    		  var datesTime = $('#startTimePicker').val().substr(0,2);
    		  var dateeTime = $('#endTimePicker').val().substr(0,2);
    		  console.log(datesTime[0]);
    		  if(date1 > date2) {
    			  alert('종료시간은 시작시간 이후여야 합니다. 다시 설정해주세요');
    			  $('#endDate').val($('#startDate').val());
    			  return false;
    		  }else if(date1 == date2){
    			  if(datesTime > dateeTime){
    				  alert('종료시간은 시작시간 이후여야 합니다. 다시 설정해주세요');
   					  return false;
    			  }
    			  return true;
    		  }
    		  
    		  
    		  return true;
    		}
    		
    		
    		

    		// 이벤트 버튼 눌렀을 때
    		// 일정 상세내용 JS
    		
    		
    		function eventListPopup(){
    		
    		  this.popup = $('#eventListPopup');
    		
    		  this.popup.css('display', 'flex');
    		  this.popup.addClass("lyWrap");
    		
    		  
    		
    		}
    		
    		
    		// 다른 화면 클릭 했을 떄 닫히게 하기

    		$(document).mouseup(function (e){
    		
    		  var container = $("#eventListPopup");
    		  
    		  if( container.has(e.target).length === 0)
    		  
    		  container.hide();
    		  
    		  });
    		
    		
    		const eventControll = document.querySelector('.event');
    		const dropdownEvent = eventControll.querySelector('.event-link');
    		/*
    		eventControll.addEventListener('click', function() {
    		    dropdownEvent.classList.toggle('show');
    		})
    		
    		window.addEventListener('click', function(e){
    		
    		  if(e.target !== eventControll) {
    		      if(e.target !== dropdownEvent) {
    		          if(dropdownEvent.classList.contains('show')) {
    		            dropdownEvent.classList.remove('show');
    		          }
    		      }
    		  }
    		})
    		*/
    		
    
    </script>
</body>
</html>