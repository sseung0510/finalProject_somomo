
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

// 글쓰기 버튼 클릭했을 떄 active 클래스 추가
writeBtn.addEventListener("click", ()=>{
    var w = new writePopup();
    w.show();
})




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

// 글쓰기 Modal 창에서 focus 되는 순간 <p> 태그 없애주기

    $('#editor').on('focus',function(){
        $('.editor-placeholder').css('display','none');
    })


// 글쓰기 Modal 창에서 Image 태그 클릭 스크립트


    
    const btnImage = document.getElementById('btn-image');
    const imageSelector = document.getElementById('img-selector');
    
    btnImage.addEventListener('click', function () {
        imageSelector.click();
    });

    imageSelector.addEventListener('change', function (e) {
        const files = e.target.files;
        if (!!files) {
            insertImageDate(files[0]);
        }
    });

    function focusEditor() {
        editor.focus({preventScroll: true});
    }
    
    function insertImageDate(file) {
        const reader = new FileReader();
        reader.addEventListener('load', function (e) {
            focusEditor();
            document.execCommand('insertImage', false, `${reader.result}`);
        });
        reader.readAsDataURL(file);
    }




