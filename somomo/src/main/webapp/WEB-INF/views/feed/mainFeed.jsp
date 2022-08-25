<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <!----------- CSS --------------->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/feedstyle.css?ver=1.1.2">
    <!----------- 아이콘 CSS 링크 ------->
    <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css">
    <!----------- 아이콘 CSS 링크 version 2------->
    <!-- Boxicons CSS -->
    <link href='https://unpkg.com/boxicons@2.1.1/css/boxicons.min.css' rel='stylesheet'>
    <!-- 카카오맵  -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/kakaomap.css">
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d76ad31ca1bc9ec945f62ad35d36701c&libraries=services"></script>
	<!-- jquery -->
 	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
 	
	<!-- Bootstrap-->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>

    <title>메인 페이지</title>
    
    
    <style>
    
    	body.dark {
	    -ms-overflow-style: none; /* IE and Edge */
	    scrollbar-width: none; /* Firefox */
		}
		body.dark::-webkit-scrollbar {
		    display: none; /* Chrome, Safari, Opera*/
		}
    
	    .close:hover {
		
		opacity : 1!important;
			
		}	
    </style>
    
</head>
<body>

	<!--------------------- 왼쪽 사이드 바 ------------------------>
	<jsp:include page="feedCommon/feed_leftSidebar.jsp" />
	<!--------------------- 왼쪽 사이드 바 끝 ------------------------>

	<!----------- 헤더 , 메인 컨텐츠 ---------->
	<section class="main-content">
		<!------- 헤더 --------->
		<div class="top">
			<i class="uil uil-bars sidebar-toggle"></i>

			<div class="search-box">
            	<i class="uil uil-search"></i>
            	<form action="search.fd" method="get">
                	<input type="text" placeholder="검색" name="keyword">
                </form>
            </div>
		</div>
        <!------- 헤더 끝--------->



		<!------ 메인 피드----------->
        <div class="main-feed">
        
             <!----------------------------- 버튼 ------------------------------------->
			<div class="edit-navigation">
				<div class="menuToggle">
					<i class="uil uil-edit"></i>
					<div class="menu">
						<ul>
							<li><button type="button" class="btn btn-primary" onclick="openModal('G');">일반글</button></li>
							<li><button type="button" class="btn btn-primary" onclick="openModal('M');">모임모집</button></li>
						</ul>
					</div>
				</div>
			</div>
			<script>
				function openModal(bType){
					if(bType == 'G'){
						$('#enrollBoardModal').find('form').trigger('reset');
						//fileReset(1);
						$('#enrollBoardModal').modal('toggle');
					}
					else{
						$('#enrollMeetBoardModal').find('form').trigger('reset');
						$('#enrollMeetBoardModal').modal('toggle');
						// 모달창에서 카카오맵이 일부만 뜨는 문제 해결
						setTimeout(function(){
							map.relayout();
							map.setCenter(new kakao.maps.LatLng(37.566826, 126.9786567));	
						}, 500);
					}
				}
				// 글쓰기 버튼 Toggle javascript
				const menu = document.querySelector('.menuToggle');
				menu.addEventListener('click', function() {
					menu.classList.toggle('active');
				});
       		</script>
           	
			<!-----------글 목록 띄워지는 공간----------->
           	<div class="fd-board-area">

       
           	</div>

		</div>
        
        <form action="" method="post" id="postForm">
        	<input type="hidden" name="boardNo" value="">
        </form>
        
        <script>
	    	$(function(){
	    		
	    		let currentPage = ${pi.currentPage};
	    		//let currentPage = 1 ;
	    		
	    		selectFeedList(currentPage);
	    		
	    		// 무한스크롤 이벤트 처리
				$(window).on('scroll', function(){
					if(${pi.maxPage eq 0}){
						return; // 등록된 게시글이 없을 경우 종료
					}
					
					// 현재 스크롤바 위치 값 (맨 위로 올릴 경우 $(window).scrollTop(0))
					// 스크롤 위치에 따라 변하는 값
					let scrollTop = $(window).scrollTop(); 
					
					// 현재 보고 있는 브라우저 창의 높이
					let windowHeight = $(window).height();
					
					// jsp, html 등 문서의 높이
					// windowHeight 보다 documentHeight가 길면 스크롤이 생김
					let documentHeight = $(document).height();
					
					// 스크롤이 바닥에 닿았을 때
					let isBottom = scrollTop + windowHeight + 5 >= documentHeight;
					//console.log('바닥인가?' + isBottom);
					if(isBottom){
						// 현재가 마지막 페이지일 경우
						if(currentPage == ${pi.maxPage}){
							console.log('종료');
							return; // 종료
						}
						
						currentPage++; // 다음 페이지 요청
						
						// 다음페이지 가져오기
						selectFeedList(currentPage);
					}
				});
				
	    	});
        
        	function selectFeedList(currentPage){
        		
        		console.log("요청페이지:" + currentPage);
        		
        		$.ajax({
        			url : 'list.fd',
        			method : 'POST',
        			data : {
        				userId : '${loginUser.userId}',
        				currentPage : currentPage,
        				boardLimit : '${pi.boardLimit}',
        				boardType : '${boardType}',
        				regionNo : '${regionNoList}',
        				keyword : '${keyword}'
        			},
        			success : function(data){
        				// 응답된 문자열은 html형식(feed/ajaxFeedList.jsp에 응답내용 있음)
						$('.fd-board-area').append(data);

						// 게시글 내용 클릭 시 상세페이지로 이동
		            	$('.fd-board-contents').click(function(){
		            		//let bno = $(this).closest('div[class="fd-board"]').find('input[name="boardNo"]').val();
		            		let boardNo = $(this).parent().find('input[name="boardNo"]').val();
		            		location.href = "detail.fd?boardNo=" + boardNo;
		            	});
						
						// 게시글 삭제
						$('.checkDelete').click(function(){
			        		if(confirm("삭제하시겠습니까?")){
			    				let bno = $(this).closest('div[class="fd-board"]').find('input[name="boardNo"]').val();
			    				$('#postForm input[name="boardNo"]').val(bno);
			    				$('#postForm').attr('action', 'delete.fd').submit();
			    			}
						});
						
						// 좋아요 버튼 클릭 시 ajax로 변경
						$('.likeBtn').click(function(){	
							changeLike(this);
							
						});
       				}
        		});
			}
 
        	
        	function changeLike(likeImg){
        		
        		let bno = $(likeImg).data('bno');
        		let boardType = $(likeImg).data('btype');

				// 기존에 좋아요 안 눌렀을 경우 => 좋아요 등록
        		if($(likeImg).children('img').hasClass('likeN')){ 
        			
        			//console.log('좋아요 등록');
            		
        			$.ajax({
            			url : 'insertLike.fd',
            			method : 'POST',
            			data : { 
            				userId : '${loginUser.userId}',
            				boardNo : bno
            			},
            			success : function(result){
            				
            				if(result == 'success'){
            					if(boardType == 'G'){ // 일반글이었을 경우
            						$(likeImg).html('<img class="likeY" src="resources/img/heart-on.png">');
            					}
            					else{ // 모임모집글이었을 경우
            						$(likeImg).html('<img class="likeY" src="resources/img/star-on.png">');
            					}
            				}
            			},
            			error : function(){
            				//console.log('에러');
            			}
            		});
            	}
        		
        		// 기존에 좋아요 눌렀을 경우 => 좋아요 취소
        		else{ 
        			
        			//console.log('좋아요 취소');
        			
            		$.ajax({
            			url : 'deleteLike.fd',
            			data : { 
            				boardNo : bno,
            				userId : '${loginUser.userId}'
            			},
            			success : function(result){
            				
            				if(result == 'success'){
            					
            					if(boardType == 'G'){ // 일반글이었을 경우
            						$(likeImg).html('<img class="likeN" src="resources/img/heart-off.png">');
            					}
            					else{ // 모임모집글이었을 경우
            						$(likeImg).html('<img class="likeN" src="resources/img/star-off.png">');
            					}
            				}
            			},
            			error : function(){
            				//console.log('에러');
            			}
            		});
        		}

        	}
        	

        </script>
            
	    <!--------------------- Modal 창 --------------------->
	            
	    <!------- 일반글 작성 모달 ------->
		<div class="modal fade" id="enrollBoardModal">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
					    
					<div class="modal-header">
						<h4 class="modal-title w-100 text-center">일반게시글</h4>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>
								
					<div class="modal-body">
						<form action="insertG.fd" method="post" enctype="multipart/form-data">
							<input type="hidden" name="boardWriter" value="${loginUser.userId}">
							<input type="hidden" name="boardType" value="G">
									
							<div><b>지역</b></div>
							<select name="regionNo" class="custom-select" style="width:200px;" required>
								<option value="">지역선택</option>
								<c:forEach var="r" items="${rList}">
									<option value="${r.regionNo}">${r.regionName}</option>
								</c:forEach>
							</select>
							
							<div class="md"><b>제목</b></div>
							<input type="text" name="boardTitle" class="form-control" maxlength="50" placeholder="제목을 입력해주세요" required></textarea>
							
							<div class="md"><b>내용</b></div>
							<textarea name="boardContent" class="form-control" rows="8" placeholder="내용을 입력해주세요" style="resize: none;" required></textarea>
							
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

							<div class="md">
								<button type="submit" class="btnPink">글작성</button>
							</div>
						</form>
					</div>				
					
				</div>
			</div>
		</div>
		
		<script>
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
		
		
	    <!------- 모임모집글 작성 모달 ------->
		<div class="modal fade" id="enrollMeetBoardModal">
			<div class="modal-dialog modal-dialog-centered modal-xl">
				<div class="modal-content">
					    
					<div class="modal-header">
						<h4 class="modal-title w-100 text-center">모집게시글</h4>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>
								
					<div class="modal-body">
						<div class="md-left">
							<div class="map_wrap">
							    <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>
							
							    <div id="menu_wrap" class="bg_white">
							        <div class="option">
							            <div>
						                   	 키워드 : <input type="text" value="KH종로" id="keyword" size="15"> 
						                    <input type="button" id="searchBtn" onclick="searchPlaces()" value="검색">
							            </div>
							        </div>
							        <hr>
							        <ul id="placesList"></ul>
							        <div id="pagination"></div>
							    </div>
							</div>
						</div>
						
						<div class="md-right">
							<form action="insertM.fd" method="post">
								<input type="hidden" name="boardWriter" value="${loginUser.userId}">
								<input type="hidden" name="boardType" value="M">
										
								<div><b>지역</b></div>
								<select name="regionNo" class="custom-select" style="width:150px;" required>
									<option value="">지역선택</option>
									<c:forEach var="r" items="${rList}">
										<option value="${r.regionNo}">${r.regionName}</option>
									</c:forEach>
								</select>
								
								<div class="md"><b>제목</b></div>
								<input type="text" name="boardTitle" class="form-control" maxlength="50" placeholder="제목을 입력해주세요" required></textarea>
								
								<div class="md"><b>내용</b></div>
								<textarea name="boardContent" class="form-control" rows="8" placeholder="내용을 입력해주세요" style="resize: none;" required></textarea>
		
										
								<div class="md"><b>모임날짜</b></div>
								<input type="datetime-local" id="dateTimeLocal" name="meetDate" class="form-control" required>
								
								<div class="md"><b>모임장소</b></div>
								<input type="text" name="meetPlace" id="mMeetPlace" class="form-control" placeholder="장소선택" required></textarea>
								<input type="hidden" name="longitude" id="mapx" value="">
								<input type="hidden" name="latitude" id="mapy" value="">

								<div class="md"><b>모임인원</b></div>
								<input type="number" name="meetTotal" min="2" max="10" class="form-control" style="width:120px;" value="2">
								
								<div class="md"><b>모집성별</b></div>
								<input type="radio" id="any" name="meetGender" value="A" checked>
								<label for="any">누구나</label>&nbsp;
								<input type="radio" id="onlyM"name="meetGender" value="M">
								<label for="onlyM">남성만</label>&nbsp;
								<input type="radio" id="onlyF" name="meetGender" value="F">
								<label for="onlyF">여성만</label>
						
								<div class="md"><b>모집나이</b></div>
								<input type="radio" name="meetAge" id="anyAge" value="A" checked>
								<label for="anyAge">누구나</label>&nbsp;
								<input type="radio" name="meetAge" id="selectAge" value="selectAge">
								<label for="selectAge">직접입력</label>
								
								<div class="row" id="selectAge-area" style="display:none">
									<div class="col-sm-3">
										<input type="number" min="15" class="selAge form-control" id="minAge" name="minAge" style="width:100px;" value="15">
									</div>
									~
									<div class="col-sm-3">
										<input type="number" class="selAge form-control" id="maxAge" name="maxAge" style="width:100px;" value="15">
									</div>
								</div>
								
								<div class="md">
									<button type="submit" class="btnPink">글작성</button>
								</div>
							</form>
						</div>
					</div>				
							
				</div>
			</div>
		</div>
			
		<script>
           	$(function(){
           		
            	// 모임날짜 현재날짜부터 선택 가능하게 처리
                let today = new Date(Date.now() - new Date().getTimezoneOffset() * 60000).toISOString().substring(0, 16);
                $('#dateTimeLocal').attr('min', today);
                $('#dateTimeLocal').val(today);
           		
           		// 장소선택칸 클릭하면 카카오맵 검색창으로 focus
			    $('#mMeetPlace').click(function(){
			    	$('#keyword').focus();
			    });
                
           		// 모집나이 클릭 이벤트 처리
           		$('input:radio[name=meetAge]').click(function(){
           			if($('input[name=meetAge]:checked').val() == 'selectAge'){ // 모집나이>직접입력 선택했을 경우
           				$('#selectAge-area').attr('style', 'display:"";'); // 나이 입력 칸 보이게
           				$('.selAge').attr('required', true); // 나이 입력 필수
           			}
           			else{ // 모집나이>누구나 선택했을 경우
           				$('#selectAge-area').attr('style', 'display:none;'); // 나이 입력 칸 안 보이게
           				$('.selAge').attr('required', false); // 나이 입력 필수 x
           			}
           		});
           		
           		// 최대나이가 입력된 최소나이 이상이 되게끔 처리
				$('#minAge').on('focus keyup input', function(){
           			let minAge = $(this).val();
           			
           			if($('#maxAge').val() < minAge){
           				$('#maxAge').val(minAge);
           			}
           			$('#maxAge').attr('min', minAge);	
           		});
           		
           	});
		</script>
			
        <!------ 메인 피드 끝----------->
        
    <!----------- 헤더 , 메인 컨텐츠 끝---------->        
    </section>

    <!------ 오른쪽 사이드 바 --------->
    <div class="right-sidebar">
		<jsp:include page="feedCommon/feed_rightSidebar.jsp" />
    </div>
    <!-- 오른쪽 사이드 바 끝-->
	
	<script src="${pageContext.request.contextPath}/resources/js/feed.js?ver=1.1.0"></script>
	
	<!-- 카카오맵 js-->
	<script>
		setTimeout(function(){ map.relayout(); }, 0);
		// 마커를 담을 배열입니다
		var markers = [];
	
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = {
		        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
		        level: 3 // 지도의 확대 레벨
		    };  
	
		// 지도를 생성합니다    
		var map = new kakao.maps.Map(mapContainer, mapOption); 
		map.relayout();
		// 장소 검색 객체를 생성합니다
		var ps = new kakao.maps.services.Places();  
	
		// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
		var infowindow = new kakao.maps.InfoWindow({zIndex:1});
	
		// 키워드로 장소를 검색합니다
		searchPlaces();
	
		// 키워드 검색을 요청하는 함수입니다
		function searchPlaces() {
	
		    var keyword = document.getElementById('keyword').value;
	
		    if (!keyword.replace(/^\s+|\s+$/g, '')) {
		        alert('키워드를 입력해주세요!');
		        return false;
		    }
	
		    // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
		    ps.keywordSearch( keyword, placesSearchCB); 
		}
	
		// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
		function placesSearchCB(data, status, pagination) {
		    if (status === kakao.maps.services.Status.OK) {
	
		        // 정상적으로 검색이 완료됐으면
		        // 검색 목록과 마커를 표출합니다
		        displayPlaces(data);
	
		        // 페이지 번호를 표출합니다
		        displayPagination(pagination);
	
		    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
	
		        alert('검색 결과가 존재하지 않습니다.');
		        return;
	
		    } else if (status === kakao.maps.services.Status.ERROR) {
	
		        alert('검색 결과 중 오류가 발생했습니다.');
		        return;
	
		    }
		}
	
		// 검색 결과 목록과 마커를 표출하는 함수입니다
		function displayPlaces(places) {
	
		    var listEl = document.getElementById('placesList'), 
		    menuEl = document.getElementById('menu_wrap'),
		    fragment = document.createDocumentFragment(), 
		    bounds = new kakao.maps.LatLngBounds(), 
		    listStr = '';
		    
		    // 검색 결과 목록에 추가된 항목들을 제거합니다
		    removeAllChildNods(listEl);
	
		    // 지도에 표시되고 있는 마커를 제거합니다
		    removeMarker();
		    
		    for ( var i=0; i<places.length; i++ ) {
	
		        // 마커를 생성하고 지도에 표시합니다
		        var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
		            marker = addMarker(placePosition, i), 
		            itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다
	
		        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
		        // LatLngBounds 객체에 좌표를 추가합니다
		        bounds.extend(placePosition);
	
		        // 마커와 검색결과 항목에 mouseover 했을때
		        // 해당 장소에 인포윈도우에 장소명을 표시합니다
		        // mouseout 했을 때는 인포윈도우를 닫습니다
		        (function(marker, title) {
		            kakao.maps.event.addListener(marker, 'mouseover', function() {
		                displayInfowindow(marker, title);
		            });
	
		            kakao.maps.event.addListener(marker, 'mouseout', function() {
		                infowindow.close();
		            });
	
		            <%--
		            	!!!!!!!!!클릭이벤트 추가!!!!!!!!!
		            	지도의 마커 클릭 시 장소명, 위도, 경도 저장
		            --%>
		            kakao.maps.event.addListener(marker, 'click', function(mouseEvent) {
		            	$('#mMeetPlace').val(title); // 장소명
		            	$('#mMeetPlace').attr('readonly', 'true');
		            	$('#mapx').val(this.getPosition().Ma);
		            	$('#mapy').val(this.getPosition().La);
		            });
		            <%-- 추가 끝 --%>
		            
		            itemEl.onmouseover =  function () {
		                displayInfowindow(marker, title);
		            };
	
		            itemEl.onmouseout =  function () {
		                infowindow.close();
		            };
		        })(marker, places[i].place_name);
	
		        fragment.appendChild(itemEl);
		        
		    }
	
		    // 검색결과 항목들을 검색결과 목록 Element에 추가합니다
		    listEl.appendChild(fragment);
		    menuEl.scrollTop = 0;
	
		    // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
		    map.setBounds(bounds);
		}
	
		// 검색결과 항목을 Element로 반환하는 함수입니다
		function getListItem(index, places) {
	
		    var el = document.createElement('li'),
		    itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
		                '<div class="info">' +
		                '   <h5>' + places.place_name + '</h5>';
	
		    if (places.road_address_name) {
		        itemStr += '    <span>' + places.road_address_name + '</span>' +
		                    '   <span class="jibun gray">' +  places.address_name  + '</span>';
		    } else {
		        itemStr += '    <span>' +  places.address_name  + '</span>'; 
		    }
		                 
		      itemStr += '  <span class="tel">' + places.phone  + '</span>' +
		                '</div>';           
	
		    el.innerHTML = itemStr;
		    el.className = 'item';
	
		    return el;
		}
	
		// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
		function addMarker(position, idx, title) {
		    var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
		        imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
		        imgOptions =  {
		            spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
		            spriteOrigin : new kakao.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
		            offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
		        },
		        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
		            marker = new kakao.maps.Marker({
		            position: position, // 마커의 위치
		            image: markerImage 
		        });
	
		    marker.setMap(map); // 지도 위에 마커를 표출합니다
		    markers.push(marker);  // 배열에 생성된 마커를 추가합니다
	
		    return marker;
		}
	
		// 지도 위에 표시되고 있는 마커를 모두 제거합니다
		function removeMarker() {
		    for ( var i = 0; i < markers.length; i++ ) {
		        markers[i].setMap(null);
		    }   
		    markers = [];
		}
	
		// 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
		function displayPagination(pagination) {
		    var paginationEl = document.getElementById('pagination'),
		        fragment = document.createDocumentFragment(),
		        i; 
	
		    // 기존에 추가된 페이지번호를 삭제합니다
		    while (paginationEl.hasChildNodes()) {
		        paginationEl.removeChild (paginationEl.lastChild);
		    }
	
		    for (i=1; i<=pagination.last; i++) {
		        var el = document.createElement('a');
		        el.href = "#";
		        el.innerHTML = i;
	
		        if (i===pagination.current) {
		            el.className = 'on';
		        } else {
		            el.onclick = (function(i) {
		                return function() {
		                    pagination.gotoPage(i);
		                }
		            })(i);
		        }
	
		        fragment.appendChild(el);
		    }
		    paginationEl.appendChild(fragment);
		}
	
		// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
		// 인포윈도우에 장소명을 표시합니다
		function displayInfowindow(marker, title) {
		    var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';
	
		    infowindow.setContent(content);
		    infowindow.open(map, marker);
		}
	
		 // 검색결과 목록의 자식 Element를 제거하는 함수입니다
		function removeAllChildNods(el) {   
		    while (el.hasChildNodes()) {
		        el.removeChild (el.lastChild);
		    }
		}
	</script>
</body>
</html>