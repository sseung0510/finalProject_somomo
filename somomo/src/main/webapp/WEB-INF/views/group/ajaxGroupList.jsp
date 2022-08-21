<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:choose>
    <c:when test="${empty gList}">
        등록된 그룹이 없습니다.
    </c:when>
    <c:otherwise>
        <c:forEach var="g" items="${gList}">
            <div class="group">
                <div data-gno="${g.groupNo}" class="group-main">
                    <input type="hidden" class="groupNo" value="${g.groupNo}">
                    <input type="hidden" class="question" value="${fn:replace(g.applyQuestion, newLine, '<br/>')}">
                    <div class="group-header">
                        <img src="${g.groupImg}" alt="" />
                    </div>
                    <div class="group-body">
                        <span class="tag tag-${g.categoryNo}">${g.categoryName}</span>
                        <h4>${g.groupName}</h4>
                        <div class="group-info">
                            <span class="group-member">멤버 ${g.memberCount}명</span>
                            <span class="group-type">${g.groupTypeStr}</span>
                        </div>
                    </div>
                </div>
                <div class="group-foot">
                    <c:choose>
                        <c:when test="${g.myGroup eq 'Y'}">
                            <div class="group-btn">
                                <button data-gno="${g.groupNo}" class="enter-group">그룹 방문</button>
                            </div>
                        </c:when>
                        <c:when test="${g.applying eq 'A'}">
                            <div class="group-btn">
                                <input type="hidden" value="${g.groupNo}">
                                <button class="cancel-apply">승인 대기</button>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="group-btn">
                                <input type="hidden" class="groupType" value="${g.groupType}">
                                <button class="apply">그룹 가입</button>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </c:forEach>
    </c:otherwise>
</c:choose>
