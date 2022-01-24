<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>/sample/admin page</h1>
	
	<p>principal: <sec:authentication property="principal"/> <!-- 기본적으로 security가 제공 -->
	<p>MemberVO: <sec:authentication property="principal.member"/> <!-- 여기부턴 customizing -->
	<p>사용자 이름: <sec:authentication property="principal.member.userName"/>
	<p>사용자 아이디: <sec:authentication property="principal.username"/>
	<p>사용자 권한 리스트: <sec:authentication property="principal.member.authList"/>
	
	<p><a href="/customLogout">로그아웃</a>
</body>
</html>