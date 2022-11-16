<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%@ page import ="java.util.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "vo.*" %>
<%@page import="java.net.*"%>

<%
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	
	String Driver = "org.mariadb.jdbc.Driver";
	Class.forName(Driver);
	
	String url = "jdbc:mariadb://localhost:3306/gdj58";
	String user = "root";
	String userPw = "java1234";
	Connection conn = DriverManager.getConnection(url, user, userPw);
	
	String sql = "SELECT * FROM MEMBER WHERE member_id=? AND member_pw=PASSWORD(?)";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1,memberId);
	stmt.setString(2,memberPw);
	
	ResultSet rs = stmt.executeQuery();
	
	String msg = null;
	String result = null;
	
	if(rs.next()) {
			msg = "로그인 성공";
			result = "success";
	
		if(result.equals("success")) {
			session.setAttribute("result","success");
		}
	} else {
		msg ="로그인 실패";
	}
	
	
	response.sendRedirect(request.getContextPath()+"/loginCheck.jsp?&msg="+URLEncoder.encode(msg,"UTF-8"));
%>
