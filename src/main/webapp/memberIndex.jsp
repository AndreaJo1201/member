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
	//1.
	if(session.getAttribute("loginMemberId") == null) {
		//로그인을 안하고 페이지로 강제 접속시
		String msg = "비 정상적인 접속입니다.";
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?&msg="+URLEncoder.encode(msg,"UTF-8"));
		return;
	}

	String Driver = "org.mariadb.jdbc.Driver";
	Class.forName(Driver);
	
	String url = "jdbc:mariadb://localhost:3306/gdj58";
	String user = "root";
	String userPw = "java1234";
	Connection conn = DriverManager.getConnection(url, user, userPw);
	
	String sql = "SELECT member_name memberName FROM member WHERE member_id LIKE ?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1, (String)(session.getAttribute("loginMemberId")));
	ResultSet rs = stmt.executeQuery();
	
	Member member = new Member();
	
	if(rs.next()) {
		member.memberName = rs.getString("memberName");
	}
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>

	<body>
		<div><%=(String)(session.getAttribute("loginMemberId"))+"<--id / name -->"+member.memberName%>님 반갑습니다.</div>
		<h1>멤버 페이지 입니다.</h1>
		<a href="<%=request.getContextPath()%>/memberOne.jsp">My Page</a>
		<a href="<%=request.getContextPath()%>/logout.jsp">Logout</a>
		<a href="<%=request.getContextPath()%>/delete/deleteMemberForm.jsp">회원탈퇴</a>
	</body>
</html>