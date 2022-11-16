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

%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>회원가입</title>
	</head>

	<body>
		<h1>회원가입</h1>
		
		<form action="<%=request.getContextPath()%>/insert/insertMemberAction.jsp" method="post">
			<table>
				<tr>
					<td>ID</td>
					<td><input type="text" name="memberId"></td>
				</tr>
				<tr>
					<td>PW</td>
					<td><input type="password" name="memberPw"></td>
				</tr>
				<tr>
					<td>이름</td>
					<td><input type="text" name="memberName"></td>
				</tr>
			</table>
			<button type="submit">회원가입</button>
		</form>
		
	</body>
</html>