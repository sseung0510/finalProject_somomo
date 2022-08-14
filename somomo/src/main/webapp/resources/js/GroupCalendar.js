document.addEventListener('DOMContentLoaded', function() {
  
  
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
      console.log(arg); // 선택한 인자의 객체가 생성됨
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
        if (confirm('정말 삭제하시겠습니까?')) {
          arg.event.remove()
        }
      },
    events: [      
            {
              title: '그룹방 개설★',
              start: currentDate(),
              color : 'pink',
              textColor : 'black'
            }
          ]
  });
  calendar.render();
});

// 버튼 눌렀을 때 모달창 띄워주기
function eventPopup(){
    const f = new writeEventPopup();
    f.show();
}


// 모달창 JS

let writeEventPopup = function() {
 
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

// $(document).ready(function () {

//   var i=0;
//   $("button").click(function () {

//      if(i==0){
//          $(this).css("background-color", "#FFF");
//          i=1;
//      }
//      else{
//          $(this).css("background-color", "#000"); 
//          i=0; 
//      }
//   });
// });


  



// $(document).ready(function(){
//   $('#calendar').fullCalendar({
//     header {
//       'left'
//     }
//   })
// });









// document.addEventListener('DOMContentLoaded', function() {


  // var PlanInsertPopup = function(element){
  //   this.title = "title";
  
  //   this.calendar = undefined;
  //   this.arg = undefined;

  //   this.show = (cal, arg)=>{
  //       this.calendar = cal;
  //       this.arg = arg;
  //       console.log(JSON.stringify(arg.start))
  //   }

  //   this.onOk = ()=>{
  //     console.log(this.calendar);
  //     this.calendar.addEvent({
  //             title: this.title,
  //             start: new Date(2020,8, 11,10,10,10 ),
  //             end: this.arg.end,
  //             allDay: this.arg.allDay,
  //           });
  //   }
  // }

  // var calendarEl = document.getElementById('calendar');

  // var insertPopup = new PlanInsertPopup();


  // var calendar = new FullCalendar.Calendar(calendarEl, {
  //   headerToolbar: {
  //     left: 'prev,next today',
  //     center: 'title',
  //     right: 'dayGridMonth'
  //   },
  //   locale : 'ko',

  //   navLinks: true, // can click day/week names to navigate views
  //   selectable: true, // 이건필요함
  //   selectMirror: false,
  //   select: function(arg) {
      // insertPopup.show(calendar, arg);
      // insertPopup.onOk();
      // calendar.unselect()
  //   },
//     eventClick: function(arg) {
//     console.log("BBBBB : " + typeof(arg));
//     console.log(arg);
//         arg.event.remove()
//     },
//     editable: true,
//     dayMaxEvents: true, // allow "more" link when too many events
//     events: [      
//       {
//         title: 'Birthday Party',
//         start: '2020-09-13T07:00:00'
//       },
//       {
//         title: 'Click for Google',
//         url: 'http://google.com/',
//         start: '2020-09-28'
//       }
//     ]
//   });

//   calendar.render();
// });

