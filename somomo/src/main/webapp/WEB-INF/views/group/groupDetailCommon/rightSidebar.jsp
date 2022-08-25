<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  

<!------------------ 메인 컨텐츠 오른쪽 -------------->
<div>

	<div class="banner">
		<div class="member-banner">
			<h2 class="tit">관리자</h2>
		</div>	
		<div class="horizontal-line"></div>
		<c:forEach var="m" items="${mList}">
			<c:if test="${m.userRank eq '관리자' }">
				<div class="member-list">
					<ul class="member-profile">
						<li><a>
							<span><img src="${m.profileImg}"></span>
							<span class="member-detail">
								<strong class="text">${m.nickname}</strong>
							</span>
						</a></li>
					</ul>
				</div>                		
			</c:if>
		</c:forEach>
		<div class="member-banner">
			<h2 class="tit">멤버</h2>
			<div class="memberWrap">
				<a href="">모두보기</a>
			</div>
		</div>
		<div class="horizontal-line"></div>
		<div class="scroll">
			<c:forEach var="m" items="${mList}">
				<c:if test="${m.userRank eq '일반회원' }">
					<div class="member-list">
						<ul class="member-profile">
							<li><a>
								<span><img src="${m.profileImg}"></span>
								<span class="member-detail">
									<strong class="text">${m.nickname}</strong>
								</span>
							</a></li>
						</ul>
					</div>                		
				</c:if>
			</c:forEach>
		</div>
		
		
		
		
		<div class="eventSchedule-wrap">
			<div class="eventSchedule">
				<h2 class="eventtit"><i class="uil uil-schedule"></i>다가오는 일정</h2>
				<div class="schedule-body">
					
				</div>
			</div>
		</div>
	</div>
</div>



