<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:choose>
	<c:when test="${empty fList}">
		등록된 게시글이 없습니다.
	</c:when>
	<c:otherwise>
		<c:forEach var="f" items="${fList}">
			<c:choose>
		
				<c:when test="${f.boardType eq 'G'}">
					<div class="fd-board">
						<input type="hidden" name="boardNo" value="${f.boardNo}">
						<%------- 상단 태그 ---------%>
						<div class="fd-board-top">
							<a href="#" class="tag btnBoardTypeG">일반글</a>&nbsp;
							<a href="#" class="tag btnRegionNo">${f.regionName}</a>
						</div>
						<%------- 작성자 프로필, 날짜, 수정/삭제버튼  ---------%>
						<table class="fd-board-writer-date">
							<tr>
								<td rowspan="2" class="profileImg-area"><img class="profileImg" src="resources/img/test1.jpg" style="width:100%;"></td>
								<td>${f.nickname}</td>
								<td align="right">
									<div class="dropdown">
										<i class='bx bx-dots-vertical-rounded dropdown-toggle' data-toggle="dropdown">
											<div class="dropdown-menu">
												<a class="dropdown-item" href="#">수정</a>
												<a class="dropdown-item checkDelete">삭제</a>
												<a class="dropdown-item" href="#">신고(미정)</a>
											</div>
										</i>
									</div>
								</td>
							</tr>
							<tr><td class="fd-board-date">${f.boardDate}</td></tr>
						</table>
						<%------- 내용 ---------%>
						<div class="fd-board-contents fdm">
							<div class="title">${f.boardTitle}</div>
							<div class="content fdm">
								<p>${f.boardContent}</p>
								<c:if test="${not empty fatList}">
									<c:forEach var="fat" items="${fatList}">
										<c:if test="${fat.boardNo eq f.boardNo}">
											<img src="${fat.changeName}" style="width:100%; height:200px;">
										</c:if>
									</c:forEach>
								</c:if>
							</div>
						</div>
						<%------- 하단 댓글,좋아요버튼  --------%>
						<div class="fd-board-bottom fdm">
							<table style="width:100%">
								<tr>
									<td>댓글 ${f.countReply}개</td>
									<td align="right">
										<c:choose>
											<c:when test="${empty f.likeCheck}">
												<span class="likeBtn" data-bno="${f.boardNo}" data-btype="${f.boardType}">
													<img class="likeN" src="resources/img/heart-off.png">
												</span>
											</c:when>
											<c:otherwise>
												<span class="likeBtn" data-bno="${f.boardNo}" data-btype="${f.boardType}">
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
						<input type="hidden" name="boardNo" value="${f.boardNo}">
		           		<div class="fd-board-top">
		           			<a href="#" class="tag btnBoardTypeM">모임모집</a>&nbsp;
		           			<a href="#" class="tag btnRegionNo">${f.regionName}</a>
		           		</div>
			        	<table class="fd-board-writer-date">
							<tr>
								<td rowspan="2" class="profileImg-area"><img class="profileImg" src="resources/img/test1.jpg" style="width:100%;"></td>
								<td>${f.nickname}</td>
								<td align="right">
									<div class="dropdown">
										<i class='bx bx-dots-vertical-rounded dropdown-toggle' data-toggle="dropdown">
											<div class="dropdown-menu">
												<a class="dropdown-item" href="#">수정</a>
												<a class="dropdown-item checkDelete">삭제</a>
												<a class="dropdown-item" href="#">신고(미정)</a>
											</div>
										</i>
									</div>
								</td>
							</tr>
							<tr><td class="fd-board-date">${f.boardDate}</td></tr>
						</table>
						<div class="fd-board-contents fdm">
							<div class="title">
								<c:choose>
									<c:when test="${f.countMember lt f.meetTotal}">
										<b>모집중&nbsp;</b>
									</c:when>
									<c:otherwise>
										<b>모집마감&nbsp;</b>
									</c:otherwise>
								</c:choose>
								${f.boardTitle}
							</div>
							<div class="meet-info fdm">
								👉${f.meetPlace} | ${f.meetDate}<br>
								👉${f.meetCondition}<br>
								👉${f.countMember}/${f.meetTotal}명 참여
							</div>
							<div class="content fdm">
								<p>${f.boardContent}</p>
							</div>
						</div>
						<div class="fd-board-bottom">
							<table style="width:100%">
								<tr>
									<td></td>
									<td align="right">
										<c:choose>
											<c:when test="${empty f.likeCheck}">
												<span class="likeBtn" data-bno="${f.boardNo}" data-btype="${f.boardType}">
													<img class="likeN" src="resources/img/star-off.png">
												</span>
											</c:when>
											<c:otherwise>
												<span class="likeBtn" data-bno="${f.boardNo}" data-btype="${f.boardType}">
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