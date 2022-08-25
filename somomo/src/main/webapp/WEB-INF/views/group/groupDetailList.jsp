<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://kit.fontawesome.com/cbcad42a26.js" crossorigin="anonymous"></script>
    <c:choose>
        <c:when test="${empty grList}">
            <div class="empty-content">
                <div class="group-board">
                    <i class="uil uil-clipboard-alt"></i>
                </div>
                <div class="board-text">
                    <h3>그룹게시판</h3>
                    <small>첫 게시글을 작성해보세요  <br>
                                나와 멤버가 쓴 글이 여기에 표시됩니다.</small>
                </div>
            </div>
        </c:when>
        <c:otherwise>

            <c:forEach var="gr" items="${grList}">
                <div class="feed-outer">
                    <div class="feed-top">
                        <div class="feed-profile">
                            <input type="hidden" name="boardNo" value="${gr.boardNo}">
                                <c:choose>
                                    <c:when test="${gr.profileImg ne null}">
                                        <img src="${gr.profileImg}">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="resources/img/member/profile_img.png">
                                    </c:otherwise>
                                </c:choose>
                            <div>
                                <p>${gr.boardWriter}</p>
                                <small>${gr.createDate}</small>  
                            </div>
                        </div>
                        <!--<li class="updateForm" data-bno="${gr.boardNo}"><a>글 수정</a></li>  -->
                        <c:if test="${loginUser.userId eq gr.boardWriter}">
                        	<ul>
	                        	<i class="fa-solid fa-x deleteForm" data-bno="${gr.boardNo}" style="font-size:20px;"></i>
                        	</ul>
                        </c:if>
                        <!--<div class="form-icon">
                            <i class='bx bx-dots-vertical-rounded feed'>
                                <ul class="feed-link">
                                   
                                    <li><a href="">공지로 등록</a></li>
                                </ul>
                            </i>
                        </div>  -->
                    </div>
       
            <!-- ------게시물 내용---- -->
                    <div class="feed-content">
                            <p>${gr.boardContent}</p>
                            <c:if test="${not empty atList}">
                                <c:forEach var="at" items="${atList}">
                                    <c:if test="${at.boardNo eq gr.boardNo}">
                                        <img src="${at.changeName}" style="width:48%; height:200px; border-radius: 10px; margin: 2px 0;">
                                    </c:if>
                                </c:forEach>
                            </c:if>
                    </div>
            
            <!-- ---좋아요, 댓글 ---- -->
                    <div class="postCount">
                        <div class="postCountLeft">
                            <span class="likeCountBtn"><img src="./resources/img/redheart.png">좋아요
                                <span class="likeCount${gr.boardNo}">${gr.countLike}</span> <!-- 총 좋아요 개수 -->
                            </span>
                            
            
                            <span class="commentCountBtn" data-rno="${gr.boardNo}">댓글
                                <span class="commentCount${gr.boardNo}">${gr.countReply}</span>
                                <i class="uil uil-angle-up"></i> 
                            </span>
                        </div>
                        <div class="postCountRight">
                            <c:choose>
                                    <c:when test="${empty gr.likeCheck}">
                                        <span class="likeBtn" data-bno="${gr.boardNo}">
                                            <img class="likeN" src="resources/img/heart-off.png">
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="likeBtn" data-bno="${gr.boardNo}">
                                            <img class="likeY" src="resources/img/heart-on.png">
                                        </span>
                                    </c:otherwise>
                                </c:choose>
                        </div>
                    </div>
            
            
            <!-----댓글------>
            
                    <div class="reply-area">
                        <div class="reply-input-area">
                            <textarea id="replyContent${gr.boardNo}" placeholder="댓글을 입력해주세요..." rows="1"></textarea>
                            <span class="replyBtn" data-rno="${gr.boardNo}">작성</span>
                        </div>
                            <!-- ajax 댓글 목록 출력 부분 -->
                            <div class="commentBox">
                                <div class="commentWrap commnetWrap${gr.boardNo}"></div>
                            </div>
                            
                            
                    </div>
                </div>
                
                <form action="" method="post" id="deleteGroupForm">
			   		<input type="hidden" name="boardNo" value="">
			   		<input type="hidden" name="groupNo" value="${gr.groupNo}">
			   	</form>
				
				
            </c:forEach>
        </c:otherwise>
    </c:choose>

