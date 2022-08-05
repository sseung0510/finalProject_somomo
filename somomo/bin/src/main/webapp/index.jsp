<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<!-- 파비콘 -->
        <link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/img/web_favicon.png" type="image/x-icon">
		<link rel="icon" href="${pageContext.request.contextPath}/resources/img/web_favicon.png" type="image/x-icon">
		<title>소모모 - 소소한 모임 모여라!</title>
	</head>
	<body>
		<jsp:include page="WEB-INF/views/member/login.jsp"></jsp:include>
	</body>
</html>