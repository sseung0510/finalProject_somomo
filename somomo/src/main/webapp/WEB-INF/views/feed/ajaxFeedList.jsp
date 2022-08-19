<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:choose>
	<c:when test="${empty fbList}">
		등록된 게시글이 없습니다.
	</c:when>
	<c:otherwise>
		<c:forEach var="fb" items="${fbList}">
			<c:choose>
		
				<c:when test="${fb.boardType eq 'G'}">
					<div class="fd-board">
						<input type="hidden" name="boardNo" value="${fb.boardNo}">
						<%------- 상단 태그 ---------%>
						<div class="fd-board-top">
							<a href="#" class="tag btnBoardTypeG">일반글</a>&nbsp;
							<a href="#" class="tag btnRegionNo">${fb.regionName}</a>
						</div>
						<%------- 작성자 프로필, 날짜, 수정/삭제버튼  ---------%>
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
						<%------- 내용 ---------%>
						<div class="fd-board-contents fdm">
							<div class="title">${fb.boardTitle}</div>
							<div class="content fdm">
								<p>${fb.boardContent}</p>
								<c:if test="${not empty fatList}">
									<c:forEach var="fat" items="${fatList}">
										<c:if test="${fat.boardNo eq fb.boardNo}">
											<img src="${fat.changeName}">
										</c:if>
									</c:forEach>
								</c:if>
							</div>
						</div>
						<%------- 하단 댓글,좋아요버튼  --------%>
						<div class="fd-board-bottom fdm">
							<table style="width:100%">
								<tr>
									<td>댓글 ${fb.countReply}개</td>
									<td align="right">
										<c:choose>
											<c:when test="${empty fb.likeCheck}">
												<span class="likeBtn" data-bno="${fb.boardNo}" data-btype="${fb.boardType}">
													<img class="likeN" src="resources/img/heart-off.png">
												</span>
											</c:when>
											<c:otherwise>
												<span class="likeBtn" data-bno="${fb.boardNo}" data-btype="${fb.boardType}">
													<img class="likeY" src="resources/img/heart-on.png">
												</span>
											</c:otherwise>
										</c:choose>
									</td>
								</tr>
							</table>
						</div>
					</div>
				</c:when>
				
				
				<c:otherwise>
					<div class="fd-board">
						<input type="hidden" name="boardNo" value="${fb.boardNo}">
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
							<div class="meet-info fdm">
								📆${fb.meetPlace} | ${fb.meetDate}<br>
								👉${fb.meetCondition}<br>
								💬${fb.countMember}/${fb.meetTotal}명 참여
							</div>
							<div class="content fdm">
								<p>${fb.boardContent}</p>
							</div>
						</div>
						<div class="fd-board-bottom">
							<table style="width:100%">
								<tr>
									<td></td>
									<td align="right">
										<c:choose>
											<c:when test="${empty fb.likeCheck}">
												<span class="likeBtn" data-bno="${fb.boardNo}" data-btype="${fb.boardType}">
													<img class="likeN" src="resources/img/star-off.png">
												</span>
											</c:when>
											<c:otherwise>
												<span class="likeBtn" data-bno="${fb.boardNo}" data-btype="${fb.boardType}">
													<img class="likeY" src="resources/img/star-on.png">
												</span>
											</c:otherwise>
										</c:choose>
									</td>
								</tr>
							</table>
						</div>
		           	</div>
				</c:otherwise>
				
			</c:choose>
		</c:forEach>
	
	</c:otherwise>
</c:choose>