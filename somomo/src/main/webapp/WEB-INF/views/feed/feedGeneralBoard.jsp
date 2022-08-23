<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="fd-board">
	<div class="fd-board-top">
		<a href="#" class="tag btnBoardTypeG">일반글</a>&nbsp;
	    <a href="#" class="tag btnRegionNo">${fb.regionName}</a>
  		</div>
	<table class="fd-board-writer-date">
		<tr>
			<td rowspan="2" class="profileImg-area">
				<c:choose>
					<c:when test="${fb.profileImg ne null}">
						<img class="profileImg" src="${fb.profileImg}" style="width:100%;">
					</c:when>
					<c:otherwise>
						<img class="profileImg" src="resources/img/member/profile_img.png" style="width:100%;">
					</c:otherwise>
				</c:choose>
			</td>
			<td><div class="fd-board-nickname"><strong>${fb.nickname}</strong></div></td>
			<c:if test="${loginUser.userId eq fb.boardWriter}">
				<td align="right">
					<div class="form-icon">
						<i class='bx bx-dots-vertical-rounded feed'>
						<ul class="feed-link">
							<li><a class="updateGeneralBoard">수정</a></li>
							<li><a class="checkDelete">삭제</a></li>
						</ul>
						</i>
					</div>
				</td>
			</c:if>
		</tr>
		<tr><td class="fd-board-date"><div class="fd-board-nickname">${fb.boardDate}</div></td></tr>
	</table>
	<div class="fd-board-contents fdm">
		<div class="title">
			${fb.boardTitle}
		</div>
		<div class="content fdm">
			<% pageContext.setAttribute("newLine", "\n"); %>
			<p id="content">${fn:replace(fb.boardContent, newLine, '<br/>')}</p>
			<c:if test="${not empty fatList}">
				<c:forEach var="fat" items="${fatList}">
					<div class="slide fade-1">
						<img src="${fat.changeName}" style="width:100%">
					</div>	
				</c:forEach>
				  <c:if test ="${ fatList.size() != 1 }">
				  		<a class="prev" onclick="changeSlide(-1)">&#10094;</a>
  								<a class="next" onclick="changeSlide(1)">&#10095;</a>
				  </c:if>
				  <br>
				  <div style="text-align:center;">
					  <c:forEach var="fat" items="${fatList}" varStatus="status">
		
					      <span class="dot" onclick="currentSlide(${status.index+1})"></span>
					     
					   </c:forEach>
				  </div>
				 
			</c:if>
			
		</div>
	</div>
	<div style="margin-top:20px;">
		<span class="likeBtn">
			<img class="likeN" src="resources/img/heart-off.png">
		</span>
		<span class="countLike">좋아요${fb.countLike}개</span>
	</div>
	
	<div class="reply-area">
		<div id="replyCount">댓글 0개</div>
        <div class="reply-input-area">
        	<textarea id="replyContent" placeholder="댓글을 입력해주세요..." rows="1" style="resize: none;" ></textarea>
            	<button id="replyBtn" onclick="insertReply();">작성</button>
      	 </div>
      	 
      	 <!-- ajax 댓글 목록 출력 부분 -->
      	 <div class="reply-content-area">

      	 </div>
	</div>
</div>