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
	String Driver = "org.mariadb.jdbc.Driver";
	Class.forName(Driver);
	
	String url = "jdbc:mariadb://localhost:3306/gdj58";
	String user = "root";
	String userPw = "java1234";
	Connection conn = DriverManager.getConnection(url, user, userPw);
	
	String sql = "SELECT member_id memberId, member_name memberName FROM member WHERE member_id LIKE ?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1,(String)(session.getAttribute("loginMemberId")));
	
	ResultSet rs = stmt.executeQuery();
	
	Member member = null;
	
	if(rs.next()){
		member = new Member();
		member.memberId = rs.getString("memberId");
		member.memberName = rs.getString("memberName");
	}
	

%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>회원정보 수정</title>
	</head>

	<body>
		<h1>회원정보 수정</h1>
		
		<form action="<%=request.getContextPath()%>/update/updateMemberAction.jsp" method="post">
			<table>
				<tr>
					<td>ID</td>
					<td><input type="text" name="memberId" value="<%=member.memberId %>"></td>
				</tr>
				
				<tr>
					<td>이름</td>
					<td><input type="text" name="memberName" value="<%=member.memberName %>"></td>
				</tr>
				
				<tr>
					<td>비밀번호</td>
					<td><input type="password" name="memberPw" value="" placeholder="비밀번호 수정 불가"></td>
				</tr>
			</table>
			<button type="submit">수정</button>
		
		</form>
	</body>
</html>