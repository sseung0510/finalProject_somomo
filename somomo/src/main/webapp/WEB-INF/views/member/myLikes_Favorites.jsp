<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<!----------- CSS --------------->
	<link rel="stylesheet" href="resources/css/feedstyle2.css?ver=1.1.7">
</head>




<style>





.filters-content {
  margin: 2px;
  background-color: #f2f2f2;
  padding: 7px;
  border-radius: 5px;
  display: flex;
  justify-content: space-between;
  column-gap: 5px;
}

.filters-button {
  width: 100%;
  border: none;
  outline: none;
  padding: 10px;
  font-weight: 500;
  border-radius: 10px;
  cursor: pointer;
  background-color: transparent;
  transition: 0.3s;
}

.filters-button:hover {
  background-color: white;
}




/* 좋아요와 찜 보여주기 */
.filters [data-content] {
  display: none;
}

.filters-active[data-content] {
  display: flex;
}

.filter-tab-active {
  background-color: white;
}




</style>



<body>

	 <section class="filters container">
    <!--=============== 필터 탭 ===============-->
    <ul class="filters-content">
        <button class="filters-button filter-tab-active" data-target="#likes">
           Likes
        </button>
        <button class="filters-button" data-target="#favorites">
            Favorites
        </button>
    </ul>

    <div class="filters-sections">
        <!--=============== 좋아요 ===============-->
        <div class="likes-content filters-active" data-content id="likes">
          
          <div class="like-list">
				
		  </div>

        </div>

        <!--=============== 찜 ===============-->
        <div class="favorites-content" data-content id="favorites">
            
            <div class="favorite-list">
				
			</div>
        </div>
    </div>
    
    
    
    
     
</section>
  



<!-- 
	<div class="main-outer">
		<div class="likes">
			<div class="like-header"><h2>Likes</h2></div>
			<div class="like-list">
				
			</div>
		</div>

		<div class="favorites">
			<div class="favorite-header"><h2>Favorites</h2></div>
			<div class="favorite-list">
				
			</div>
		</div>
	</div>
	 -->
	
	<script>
		$(function(){
			likeList();
			favoriteList();
		})
		
		
		function likeList(){
			//console.log("${loginUser.userId}");
			$.ajax({
				url:"likeList.me",
				data:{
					userId:"${loginUser.userId}"
				}, success: function(data){
					console.log(data);
					var ok="";
					for(var i in data){
						 ok += '<div class="likeAll">'
							 + 		'<input type="hidden" class="boardNo" value="'+data[i].boardNo+'">'
							 + 		'<div class="goBoard">'
							 + 			'<div class="like-list-img">'
							 + 				'<img src="'+data[i].profileImg+'" alt="">'
							 +			'</div>'
							 + 			'<div class="like-list-content">'
							 + 				'<div class="like-list-title">'+data[i].boardTitle+'</div>'
							 + 			'</div>'
							 + 		'</div>'
							 + 		'<div class="like-list-btn"><img class="likeY" src="resources/img/heart-on.png"></div>'
							 + '</div>';
					}
					$('.like-list').html(ok);
				}, error:function(){
					console.log("좋아요 리스트 불러오기 실패");
				}
			})
		}
		
		function favoriteList(){
			$.ajax({
				url:"favoriteList.me",
				data:{
					userId:"${loginUser.userId}"
				}, success: function(data){
					//console.log(data+"asdf");
					var ok="";
					for(var i in data){
						 ok += '<div class="likeAll">'
							 + 		'<input type="hidden" class="boardNo" value="'+data[i].boardNo+'">'
							 + 		'<div class="goBoard">'
							 + 			'<div class="favorite-list-img">'
							 + 				'<img src="'+data[i].profileImg+'" alt="">'
							 +			'</div>'
							 + 			'<div class="favorite-list-content">'
							 + 				'<div class="favorite-list-title">'+data[i].boardTitle+'</div>'
							 + 			'</div>'
							 + 		'</div>'
							 + 		'<div class="favorite-list-btn"><img class="likeY" src="resources/img/star-on.png"></div>'
							 + '</div>';
					}
					$('.favorite-list').html(ok);
				}, error:function(){
					console.log("좋아요 리스트 불러오기 실패");
				}
			})
		}
		
		$(document).on('click', '.likeY', function(){
	
			var $inputBoard = $(this).parents('.likeAll').children().eq(0).val();
			
			$.ajax({
				url:"UnlikeY.me",
				data:{
					boardNo:$inputBoard,
					userId: '${loginUser.userId}'
				}, success : function(result){
					if(result=="success"){
						likeList();
						favoriteList();
					}
				}, error : function(){
					console.log("좋아요 취소 실패")	
				}
			})
		})
	
		$(document).on("click", '.goBoard', function(){
       		var boardNo = $('.likeAll').children().eq(0).val();
       		console.log(boardNo);
       		location.href = "detail.fd?boardNo=" + boardNo;
       	});
	</script>
	
	
	<script>
	
	// 좋아요 찜 탭 JS
	const tabs = document.querySelectorAll('[data-target]'),
	      tabContents = document.querySelectorAll('[data-content]')

	tabs.forEach(tab =>{
	    tab.addEventListener('click', () =>{
	        const target = document.querySelector(tab.dataset.target)

	        tabContents.forEach(tc =>{
	            tc.classList.remove('filters-active')
	           
	        })
	        target.classList.add('filters-active')
			
			
	        tabs.forEach(t =>{
	            t.classList.remove('filter-tab-active')
	            
	        })
	        tab.classList.add('filter-tab-active')
	         
	    })
	})

	
	
	
	</script>
	
	
	
	
</body>
</html>