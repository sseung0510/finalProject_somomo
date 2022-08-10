<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

 			<!---------------------- 글쓰기 Modal 창 --------------------->
	 <div id = "writePopup" class="popup-outer ">
                    <div class="popup-box">
                      <i id="close" class='bx bx-x close'></i>
                        <div class="write-form-header">
                           <h1 class="write-form-title">글쓰기</h1>
                        </div>
                        <div class="textarea">
                            <!-- contenteditable 사용하기 -->
                            <div id="editor" contenteditable="true">

                            <p class="editor-placeholder">새로운 소식을 남겨보세요
                                <br> 공개그룹에 남긴 글은 누구나 볼 수 있습니다
                            </p> 
                            </div>
                        </div>

                        <ul class="toolbarList">
                            <li><input id="img-selector" type="file" accept="image/*"><i class="uil uil-image-download" id="btn-image"></i></li>
                            <li><i class="uil uil-paperclip"></i></li>
                            <li><i class="uil uil-map-marker"></i></li>
                            <li><i class="uil uil-clipboard-notes"></i></li>
                        </ul>

                        <div class="button">
                            <button id="submit" class="send">게시</button>
                        </div>
                       
                    </div>
                </div>

</body>
</html>