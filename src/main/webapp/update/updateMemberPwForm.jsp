<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%@ page import ="java.util.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "vo.*" %>
<%@page import="java.net.*"%>

<%
	
	if(request.getParameter("msg") != null) {
		String msg = request.getParameter("msg");
		out.println("<script>alert('"+msg+"');</script>");
	}

	if(session.getAttribute("loginMemberId") == null) {
		//로그인을 안하고 페이지로 강제 접속시
		String msg = "비 정상적인 접속입니다.";
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?&msg="+URLEncoder.encode(msg,"UTF-8"));
		return;
	}
	
%>

<%

%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>비밀번호 수정</title>
	</head>

	<body>
		<h1>비밀번호 수정</h1>
	</body>
	
			<form action="<%=request.getContextPath()%>/update/updateMemberPwAction.jsp" method="post">
			<table>
			
				<tr>
					<td>현재 비밀번호</td>
					<td><input type="password" name="memberPw" value="" placeholder="현재 비밀번호"></td>
				</tr>
				
				<tr>
					<td>변경할 비밀번호</td>
					<td><input type="password" name="changeMemberPw" value="" placeholder="변경할 비밀번호"></td>
				</tr>
				
				<tr>
					<td>비밀번호 확인</td>
					<td><input type="password" name="changeMemberPw2" value="" placeholder="변경할 비밀번호 확인"></td>
				</tr>
				
			</table>
			<button type="submit">수정</button>
		
		</form>
</html>