<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!---------------------- 글쓰기 Modal 창 --------------------->
<div id = "writePopup" class="popup-outer ">
    <div class="popup-box">
        <i id="close" class='bx bx-x close'></i>
        <div class="write-form-header">
            <h1 class="write-form-title">글쓰기</h1>
        </div>

        <form action="insertBoard.gr" method="post" enctype="multipart/form-data">

            <!-- 히든으로 넘겨줘야할 정보 -->
            <input type="hidden" name="boardWriter" value="${loginUser.userId}">
            <input type="hidden" name="groupNo" value="${g.groupNo}">
            <!-- 공지사항 체크되면  N으로 바꿔서 보내기-->
            <input type="hidden" id="boardType" name="boardType" value="B">
            <input type="hidden" id="boardTitle" name="boardTitle" value="${loginUser.userId}">
            
                <div class="textarea">
                <!-- contenteditable 사용하기 -->
                <div id="editor" contenteditable="true">
                    
                </div>
            </div>
            
            
                <textarea name="boardContent" id="boardContent" style="display: none;"></textarea>
                
                
             <div class="grid">
				<div class="form-wrap">
					<div class="form-element">
				      	
				        <input type="file" name="file1" id="file-1" accept="image/*">
				        <label for="file-1" id="file-1-preview">
				        	<img id="preview" src="resources/img/addImage.png" >
				        </label>
				     </div>
				     <div class="imageRemoveBtn"><i class="uil uil-trash-alt"></i><span>삭제</span></div>
				</div>
				<div class="form-wrap">
					<div class="form-element">
				     	
				        <input type="file" name="file2" id="file-2" accept="image/*">
				        <label for="file-2" id="file-2-preview">
				        	<img id="preview" src="resources/img/addImage.png" >
				        </label>
				    </div>
				    <div class="imageRemoveBtn"><i class="uil uil-trash-alt"></i><span>삭제</span></div>
				</div>
				<div class="form-wrap">
					<div class="form-element">
				    	<input type="file" name="file3"  id="file-3" accept="image/*">
				        <label for="file-3" id="file-3-preview">
				        	<img id="preview" src="resources/img/addImage.png" >
				        </label>
				    </div>
				    <div class="imageRemoveBtn"><i class="uil uil-trash-alt"></i><span>삭제</span></div>
				</div>
				<div class="form-wrap">
					<div class="form-element">
				    	<input type="file" name="file4" id="file-4" accept="image/*">
				        <label for="file-4" id="file-4-preview">
				        	<img id="preview" src="resources/img/addImage.png" >
				        </label>
				     </div>
				     <div class="imageRemoveBtn"><i class="uil uil-trash-alt"></i><span>삭제</span></div>
				</div>
			    
			    <!-- 기존 파일 정보 -->
			    <div class="origin-area" style="display:none;">
				    <input type="hidden" name="origin" id="origin-1" data-fno="" data-filename="" value="">
				    <input type="hidden" name="origin" id="origin-2" data-fno="" data-filename="" value="">
				    <input type="hidden" name="origin" id="origin-3" data-fno="" data-filename="" value="">
				    <input type="hidden" name="origin" id="origin-4" data-fno="" data-filename="" value="">
			    </div>
		    </div>
            

            <!--  <ul class="toolbarList" >
                <li>
                    <input id="img-selector" type="file" name ="file1" accept="image/*">
                    <i class="uil uil-image-download" id="btn-image"></i>
                </li>
                <li><i class="uil uil-paperclip"></i></li>
                <li><i class="uil uil-map-marker"></i></li>
                <li><i class="uil uil-clipboard-notes"></i></li>
                
            </ul>
            -->
            <!-- 로그인 유저가 관리자일때 -->
            <!-- <label for="selectNotice"><input type="checkbox" name="selectNotice">공지사항</label></li> -->

            <div class="button">
                <button id="submit" onclick="getContent();" class="send">게시</button>
            </div>
        </form>

    </div>
</div>

<div id = "updatePopup" class="popup-outer ">
    <div class="popup-box">
        <i id="close" class='bx bx-x close'></i>
        <div class="write-form-header">
            <h1 class="write-form-title">수정하기</h1>
        </div>

        <form action="insertBoard.gr" method="post" enctype="multipart/form-data">

            <!-- 히든으로 넘겨줘야할 정보 -->
            <input type="hidden" name="boardNo" value="${gr.boardNo}">
            <input type="hidden" name="groupNo" value="${g.groupNo}">
            <!-- 공지사항 체크되면  N으로 바꿔서 보내기-->
            <input type="hidden" id="boardType" name="boardType" value="B">
            <input type="hidden" id="boardTitle" name="boardTitle" value="${loginUser.userId}">
            
                <div class="textarea">
                <!-- contenteditable 사용하기 -->
                <div id="updateEditor" contenteditable="true">
                    
                </div>
            </div>
            
            
                <textarea name="boardContent" id="groupBoardContent" style="display: none;"></textarea>
                
                
            <div class="grid">
				<div class="form-wrap">
					<div class="form-element">
				      	
				        <input type="file" name="file1" id="file-1" accept="image/*">
				        <label for="file-1" id="file-1-preview">
				        	<img id="preview" src="resources/img/addImage.png" >
				        </label>
				     </div>
				     <div class="imageRemoveBtn"><i class="uil uil-trash-alt"></i><span>삭제</span></div>
				</div>
				<div class="form-wrap">
					<div class="form-element">
				     	
				        <input type="file" name="file2" id="file-2" accept="image/*">
				        <label for="file-2" id="file-2-preview">
				        	<img id="preview" src="resources/img/addImage.png" >
				        </label>
				    </div>
				    <div class="imageRemoveBtn"><i class="uil uil-trash-alt"></i><span>삭제</span></div>
				</div>
				<div class="form-wrap">
					<div class="form-element">
				    	<input type="file" name="file3"  id="file-3" accept="image/*">
				        <label for="file-3" id="file-3-preview">
				        	<img id="preview" src="resources/img/addImage.png" >
				        </label>
				    </div>
				    <div class="imageRemoveBtn"><i class="uil uil-trash-alt"></i><span>삭제</span></div>
				</div>
				<div class="form-wrap">
					<div class="form-element">
				    	<input type="file" name="file4" id="file-4" accept="image/*">
				        <label for="file-4" id="file-4-preview">
				        	<img id="preview" src="resources/img/addImage.png" >
				        </label>
				     </div>
				     <div class="imageRemoveBtn"><i class="uil uil-trash-alt"></i><span>삭제</span></div>
				</div>
			    
			    <!-- 기존 파일 정보 -->
			    <div class="origin-area" style="display:none;">
				    <input type="hidden" name="origin" id="origin-1" data-fno="" data-filename="" value="">
				    <input type="hidden" name="origin" id="origin-2" data-fno="" data-filename="" value="">
				    <input type="hidden" name="origin" id="origin-3" data-fno="" data-filename="" value="">
				    <input type="hidden" name="origin" id="origin-4" data-fno="" data-filename="" value="">
			    </div>
		    </div>


            <!--  <ul class="toolbarList" >
                <li>
                    <input id="img-selector" type="file" name ="file1" accept="image/*">
                    <i class="uil uil-image-download" id="btn-image"></i>
                </li>
                <li><i class="uil uil-paperclip"></i></li>
                <li><i class="uil uil-map-marker"></i></li>
                <li><i class="uil uil-clipboard-notes"></i></li>
                
            </ul>
            -->
            <!-- 로그인 유저가 관리자일때 -->
            <!-- <label for="selectNotice"><input type="checkbox" name="selectNotice">공지사항</label></li> -->

            <div class="button">
                <button type="submit"  class="send">수정</button>
            </div>
        </form>

    </div>
</div>


<script>
    function getContent(){
        
        $('#boardContent').val($('#editor').html());

        //alert($('#boardContent').val());
    
    }
    
    // 첨부파일 삭제
    function fileReset(num){
        $('#file'+num).val('');
    }
    
    
 // 사진 삭제버튼 Default OFF
   	var fileInputList = $("input[type=file]");
   	var imageList = $("img#preview");
   	var remBtnList = $("div.imageRemoveBtn");
   	for(let i=0; i<fileInputList.length; i++){
   		fileInputList.eq(i).on("change", function(e){
			if(e.target.files.length == 0){
				return;
			}
			let file = e.target.files[0];
			let url = URL.createObjectURL(file);
			imageList.eq(i).attr("src", url)
			
			
			// 삭제버튼 ON
			remBtnList.eq(i).addClass("on")					
		});
   		
   		remBtnList.eq(i).on("click", function(){
   			remBtnList.eq(i).removeClass("on")
   			imageList.eq(i)[0].src = 'resources/img/addImage.png';
   			fileInputList.eq(i).val('');
   		});
   	}

</script>
