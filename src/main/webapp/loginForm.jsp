<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.*" %>


<%
	
	if(request.getParameter("msg") != null) {
		String msg = request.getParameter("msg");
		out.println("<script>alert('"+msg+"');</script>");
	}
%>

<%
	//1. 로그인이 되어있을경우 접근불가
	if(session.getAttribute("loginMemberId") != null) {
		response.sendRedirect(request.getContextPath()+"/memberIndex.jsp");
	}
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>LOGIN</title>
	</head>

	<body>
		<h1>로그인</h1>
		<form action="<%=request.getContextPath() %>/loginAction.jsp" method="post">
		
			<table>
			
				<tr>
					<td>회원아이디</td>
					<td><input type="text" name="memberId"></td>
				</tr>
				
				<tr>
					<td>회원비밀번호</td>
					<td><input type="password" name="memberPw"></td>
				</tr>

			</table>
			<button type="submit">로그인</button>
		</form>
		
		<div>
			<a href="<%=request.getContextPath()%>/insertMemberForm.jsp">회원가입</a>
		</div>
		
		
	</body>
</html>