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

<!-- 그룹방 정보 -->
    <div>
        <div class="group-profile">
            <div class="main-images">
                <img src="${g.groupImg}">
            </div>
            <div class="profile-details">
                <span class="group-name"><strong>${g.groupName}</strong></span>
                <p>${g.groupDetail}</p>
            </div>
            <div class="profile-member">      
                <span class="profile-member-number">멤버: ${g.memberCount}명</span>
                
                <c:forEach var="m" items="${mList}">
                    <c:if test="${m.userRank eq '관리자'}">
                        <c:if test="${loginUser.userId eq m.userId}">
                            <a onclick="settingForm();"><span class="profile-member-setting">
                                <!-- 방장인경우에만 그룹 설정 버튼 활성화 -->
                                <i class="uil uil-cog"></i>그룹 설정</span>
                            </a>                    	
                        </c:if>
                    </c:if>
                </c:forEach>
            </div>
            <div class="profile-button">
                <div class="button-layer"></div>
                <button >글쓰기</button>
            </div>
        </div>
    </div>

</body>
</html>