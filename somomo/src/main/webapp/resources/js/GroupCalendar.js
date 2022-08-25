
document.addEventListener('DOMContentLoaded', function() {
		  $(function () {
		  				
		  				
		                var request = $.ajax({
		                    url: "selectCalendarEvents.gr", 
		                    data : {
		                    
		                    calendarNo : ${c.calendarNo}
		                    
		                    },
		                    
		                });
		  
		  request.done(function (data) {
		                   console.log(data); // log 로 데이터 찍어주기.
		                    
		                 
					
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
		     console.log(moment(date).format('YYYY-MM-DD'));
		    
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
		
		