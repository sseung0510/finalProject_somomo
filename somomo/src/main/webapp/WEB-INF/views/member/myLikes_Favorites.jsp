<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<!----------- CSS --------------->
	<link rel="stylesheet" href="resources/css/feedstyle2.css?ver=1.0.5">
</head>
<body>
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
								 + '<input type="hidden" value="'+data[i].boardNo+'">'
								 + '<div class="like-list-img">'
								 + '<img src="'+data[i].profileImg+'" alt=""></div>'
								 + '<div class="like-list-content">'
								 + '<div class="like-list-title">'+data[i].boardTitle+'</div>'
								 + '<div class="like-list-btn"><img class="likeY" src="resources/img/heart-on.png"></div>'
								 + '</div>'
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
					console.log(data+"asdf");
					var ok="";
					for(var i in data){
							 ok += '<div class="likeAll">'
								 + '<input type="hidden" class="boardNo" value="'+data[i].boardNo+'">'
								 + '<div class="favorite-list-img">'
								 + '<img src="'+data[i].profileImg+'" alt=""></div>'
								 + '<div class="favorite-list-content">'
								 + '<div class="favorite-list-title">'+data[i].boardTitle+'</div>'
								 + '<div class="favorite-list-btn"><img class="likeY" src="resources/img/star-on.png"></div>'
								 + '</div>'
								 + '</div>';
						console.log(data[i].boardNo);
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
	
		$(document).on("click", '.likeAll', function(){
       		var boardNo = $(this).children().eq(0).val();
       		console.log(boardNo);
       		location.href = "detail.fd?boardNo=" + boardNo;
       	});
	</script>
	
	
	
	
	
	
	
</body>
</html>