
// 선택자 정의

const container = document.querySelector(".main-middle"),
      writeBtn = document.querySelector(".profile-button button");
      cancelBtn = document.querySelectorAll("#close");
      
// 글쓰기 버튼 클릭했을 떄 active 클래스 추가
writeBtn.addEventListener("click", ()=>{
    container.classList.add("active");
})

// id 속성이 close인거 클릭하면 닫히게 하기
cancelBtn.forEach(e => {
    e.addEventListener("click", () =>{
        container.classList.remove("active");
    })
});



// 피드 DROPDOWN

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




