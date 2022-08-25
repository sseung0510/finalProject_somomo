<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  

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
                	<c:if test="${loginUser.userId eq m.userId and m.userRank eq '관리자'}"> 
                		<a onclick="settingForm();"><span class="profile-member-setting">
                               <!-- 방장인경우에만 그룹 설정 버튼 활성화 -->
                               
                               <i class="uil uil-cog"></i>그룹 설정</span>
                           </a>    
                	</c:if>
                	<c:if test="${loginUser.userId eq m.userId and m.userRank eq '일반회원'}">
                		<a onclick="exitForm();"><span class="profile-member-setting">
                			<i class="fa-solid fa-door-closed">그룹 탈퇴</i></span>
                		</a>
                	</c:if>
                </c:forEach>
            </div>
            <div class="profile-button">
                <div class="button-layer"></div>
                <button >글쓰기</button>
            </div>
        </div>
    </div>



   <!-- 세팅페이지로 넘어감 : 그룹방 번호 숨겨주기 위해 post로 보냈습니다.-->
    <form id="settingForm" method="post">
        <input type="hidden" name="groupNo" value="${g.groupNo}">
    </form>
    
    <form id="exitForm" method="get">
        <input type="hidden" name="groupNo" value="${g.groupNo}">
        <input type="hidden" name="userId" value="${loginUser.userId}">
    </form>
    
    <script>
        function settingForm(){
            $('#settingForm').attr('action', 'setting.gr').submit();
        }
        
        function exitForm(){
            $('#exitForm').attr('action', 'exit.gr').submit();
        }
        	
        
        
        
        
   	</script>