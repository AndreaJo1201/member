<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%@ page import ="java.util.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "vo.*" %>
<%@page import="java.net.*"%>

<%
	if(request.getParameter("memberId")==null||
	request.getParameter("memberId").equals("")||
	request.getParameter("memberPw")==null||
	request.getParameter("memberPw").equals("")){
		String msg = "빈칸입력";
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?&msg="+URLEncoder.encode(msg,"UTF-8"));
	return;
	}
	
	Member member = new Member();
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	
	String Driver = "org.mariadb.jdbc.Driver";
	Class.forName(Driver);
	
	String url = "jdbc:mariadb://localhost:3306/gdj58";
	String user = "root";
	String userPw = "java1234";
	Connection conn = DriverManager.getConnection(url, user, userPw);
	
	String sql = "SELECT member_id FROM MEMBER WHERE member_id=? AND member_pw=PASSWORD(?)";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1,memberId);
	stmt.setString(2,memberPw);
	
	ResultSet rs = stmt.executeQuery();
	
	String msg = "로그인 실패";
	
	String tagetPage = "/loginForm.jsp?&msg=";
	
	if(rs.next()) {
		//로그인 성공
		tagetPage = "/memberIndex.jsp?&msg=";
		
		//로그인 성공했다는 값을 저장 -> session
		msg = "로그인 성공";
		session.setAttribute("loginMemberId", rs.getString("member_id"));
		
	}
	
	rs.close();
	stmt.close();
	conn.close();
	response.sendRedirect(request.getContextPath()+"/memberIndex.jsp");

	
	
	response.sendRedirect(request.getContextPath()+tagetPage+URLEncoder.encode(msg,"UTF-8"));
%>
