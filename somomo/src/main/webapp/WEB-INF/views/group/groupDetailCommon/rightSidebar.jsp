<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>


        <!------------------ 메인 컨텐츠 오른쪽 -------------->
        <div class="main-right">
            <div class="banner">
            	<div class="member-banner">
                	<h2 class="tit">관리자</h2>
           		</div>
				<c:forEach var="gm" items="${mList}">
					<c:if test="${gm.userRank eq '관리자' }">
		                <div class="member-list">
		                    <ul class="member-profile">
		                        <li><a>
		                            <span><img src="../src/img/study.png"></span>
		                            <span class="member-detail">
		                                <strong class="text">${gm.nickname}</strong>
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
                <c:forEach var="gm" items="${mList}">
					<c:if test="${gm.userRank eq '일반회원' }">
		                <div class="member-list">
		                    <ul class="member-profile">
		                        <li><a>
		                            <span><img src="../src/img/study.png"></span>
		                            <span class="member-detail">
		                                <strong class="text">${gm.nickname}</strong>
		                            </span>
		                        </a></li>
		                    </ul>
		                </div>                		
					</c:if>
				</c:forEach>
            </div>
        </div>

</body>
</html>