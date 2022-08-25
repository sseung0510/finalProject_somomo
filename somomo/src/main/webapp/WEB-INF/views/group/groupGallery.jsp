<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <!----------- CSS --------------->
    <link rel="stylesheet" href="resources/css/groupHeader.css?ver=1.0.9">
    <link rel="stylesheet" href="resources/css/style2.css?ver=1.1.4">
    <link rel="stylesheet" href="resources/css/groupLeft.css?ver=1.0.5">
    <link rel="stylesheet" href="resources/css/groupRight.css?ver=1.1.1">
    <!----------- 아이콘 CSS 링크 ------->
    <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css">
    <script src="https://kit.fontawesome.com/567fbbaed5.js" crossorigin="anonymous"></script>
    <!----------- 아이콘 CSS 링크 version 2------->
    <!-- Boxicons CSS -->
    <link href='https://unpkg.com/boxicons@2.1.1/css/boxicons.min.css' rel='stylesheet'>
    <!-- jquery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <title>소모모 </title> 
</head>


<style>

.container {
	max-width: 800px;
	margin: 0 auto;
}

.heading {
	font-size: 52px;
	font-weight: 500;
	line-height: 1.5;
	text-align: center;
	padding-bottom: 20px;
	color: #1a1a1a;
}


.gallery {
	display: flex;
	flex-wrap: wrap;
	margin: -16px -16px;
}

.gallery-item {
  	width: 158px;
  	height : 158px;
	margin: 16px;
	box-shadow: 5px 7px 7px rgba(0, 0, 0, 0.4);
	overflow: hidden;
	cursor : pointer;
}

.gallery-image {
	display: block;
	width: 100%;
	height: 100%;
	object-fit: cover;
	transition: transform 400ms ease-out;
}

.gallery-image:hover {
	transform: scale(1.15);
}
	
</style>


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
            
            <div class="container">

    <h1 class="heading">Gallery</h1>
    
    <div class="gallery">
  

  
  
  
    </div>
  
  </div>
  
            
            
            
            
            
        </div>

        <div class="main-right">
            <jsp:include page="groupDetailCommon/rightSidebar.jsp"/>
        </div>

    </div>
    
    
    <script>
    
    $(function(){
		groupGalleryAttachmentList();
	})
	
	
	function groupGalleryAttachmentList(){
		
		$.ajax({
			url:"groupGalleryAttachmentList.gr",
			data:{
				groupNo : '${g.groupNo}'
			}, success: function(data){
				var result="";
				for(var i in data){
					  
					console.log(data[i].changeName);
			
					result +=  '<div class="gallery-item">'
                    	   + 	 '<img class="gallery-image" src='+ data[i].changeName + '>'
                 		   +   '</div>';
                 		   
				}
				$('.gallery').append(result);
				
				
			}, error:function(){
				alert("ajax 통신 실패");
			}
		})
	}
    
    
    </script>

</body>
</html>