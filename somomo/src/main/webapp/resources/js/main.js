// 선택자 정의

const body = document.querySelector("body"),
      sidebar = body.querySelector("nav");
      sidebarToggle = body.querySelector(".sidebar-toggle");


// 왼쪽 바 아이콘 클릭했을 떄 클래스 close 추가

sidebarToggle.addEventListener("click", () => {
    sidebar.classList.toggle("close");
})


// 프로필 DROPDOWN

const profile = document.querySelector('.profile');
const dropdownProfile = profile.querySelector('.profile-link');

profile.addEventListener('click', function() {
    dropdownProfile.classList.toggle('show');
})

// 윈도우 화면에서 다른곳 클릭했을 때 닫히게 하기

window.addEventListener('click', function(e){

    if(e.target !== profile) {
        if(e.target !== dropdownProfile) {
            if(dropdownProfile.classList.contains('show')) {
                dropdownProfile.classList.remove('show');
            }
        }
    }
})


// Dark Mode 

const modeToggle = body.querySelector(".mode-toggle");



// 다크모드 클릭한 순간 localStorage에 저장하여  유지되게 하기

modeToggle.addEventListener("click", () =>{
	body.classList.toggle("dark");
    if(body.classList.contains("dark")){
        localStorage.setItem("mode", "dark");
    }else{
        localStorage.setItem("mode", "light");
    }
});

let getMode = localStorage.getItem("mode");
if(getMode && getMode ==="dark"){
    body.classList.toggle("dark");
}
