<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="fd-board">
   <div class="fd-board-top">
	   <a href="#" class="tag btnBoardTypeM">모임모집</a>&nbsp;
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
							<li><a class="updateMeetBoard">수정</a></li>
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
			<c:choose>
				<c:when test="${fb.countMember lt fb.meetTotal}">
					<b class="gather">모집중&nbsp;</b>
				</c:when>
				<c:otherwise>
					<b>모집마감&nbsp;</b>
				</c:otherwise>
			</c:choose>
			${fb.boardTitle}
		</div>
		<div class="content fdm">
			<% pageContext.setAttribute("newLine", "\n"); %>
			<p id="content">${fn:replace(fb.boardContent, newLine, '<br/>')}</p>
		</div>
		<div class="meet-info fdm" style="padding:5px;">
			<div><img src="resources/img/test1.jpg" width="100%"></div>
			<div class="fdm">
				 📆 ${fb.meetPlace} | ${fb.meetDate}<br>
				👉${fb.meetCondition}<br>
				💬${fb.countMember}/${fb.meetTotal}명 참여
			</div>
		</div>
	</div>
	<div style="margin-top:20px;">
		<span class="likeBtn">
			<img class="likeN" src="resources/img/star-off.png">
		</span>
		<span class="countLike">찜${fb.countLike}개</span>
	</div>
	<div class="fdm">${fb.countMember}명 참여중</div>
	
	<div class="joinChatBtn">
		<c:choose>
			<c:when test="${fb.countMember lt fb.meetTotal}">
				<button type="button" class="btnPink" onclick="checkJoinCondition();">모임 참여 신청</button>
			</c:when>
			<c:otherwise>
				<button type="button" class="btnDisabled" disabled>마감되었습니다</button>
			</c:otherwise>
		</c:choose>
	</div>
</div>