
// 선택자 정의

const container = document.querySelector(".main-middle"),
      writeBtn = document.querySelector(".profile-button button");
      cancelBtn = document.querySelectorAll("#close");
      
var writePopup = function(){
    
    var hide = ()=>{
        this.popup.removeClass("active");
    }

    this.popup = $("#writePopup")
    this.content = $("#writePopup textarea")
    this.submitButton = $("#writePopup #submit")
    this.submitButton.click(()=>{
        
        // TODO: ajax로 데이터 주고 받자!!!!


        hide();
        $("#writePopup #editor").empty();
    });

    this.closeButton = $("#writePopup #close")
    this.closeButton.click(()=>{

        hide();
        $("#writePopup #editor").empty();
    })



    this.show = ()=>{
        this.popup.addClass("active");
    }
   
}

var updatePopup = function(){
    
    var hide = ()=>{
        this.popup.removeClass("active");
    }

    this.popup = $("#updatePopup")
    this.content = $("#updatePopup textarea")
    this.submitButton = $("#updatePopup #submit")
    this.submitButton.click(()=>{
        
        // TODO: ajax로 데이터 주고 받자!!!!


        hide();
        $("#updatePopup #UpdateEditor").empty();
    });

    this.closeButton = $("#updatePopup #close")
    this.closeButton.click(()=>{

        hide();
        $("#updatePopup #UpdateEditor").empty();
    })



    this.show = ()=>{
        this.popup.addClass("active");
    }
   
}

// 글쓰기 버튼 클릭했을 떄 active 클래스 추가
writeBtn.addEventListener("click", ()=>{
    var w = new writePopup();
    w.show();
})

		// updateBtn.addEventListener("click", ()=>{
		// 	var w = new writePopup();
		// 	w.show();
		// })

// 피드 DROPDOWN
/*
const feed = document.querySelector('.feed');
const dropdownFeed = feed.querySelector('.feed-link');

feed.addEventListener('click', function() {
    dropdownFeed.classList.toggle('show');
})

// 윈도우 화면에서 다른곳 클릭했을 때 닫히게 하기

window.addEventListener('click', function(e){

    if(e.target !== feed) {
        if(e.target !== dropdownFeed) {
            if(dropdownFeed.classList.contains('show')) {
                dropdownFeed.classList.remove('show');
            }
        }
    }
})

*/




