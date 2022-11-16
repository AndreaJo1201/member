<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%@ page import ="java.util.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "vo.*" %>
<%@page import="java.net.*"%>

<%
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	String memberName = request.getParameter("memberName");
	
	if(request.getParameter("memberName") == null||
		request.getParameter("memberName").equals("")||
		request.getParameter("memberId")==null||
		request.getParameter("memberId").equals("")||
		request.getParameter("memberPw")==null||
		request.getParameter("memberPw").equals("")){
			String msg = "빈칸입력";
			response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp?&msg="+URLEncoder.encode(msg,"UTF-8"));
		return;
	}
	
	String Driver = "org.mariadb.jdbc.Driver";
	Class.forName(Driver);
	
	String url = "jdbc:mariadb://localhost:3306/gdj58";
	String user = "root";
	String userPw = "java1234";
	Connection conn = DriverManager.getConnection(url, user, userPw);
	
	String sql = "SELECT member_id  memberId FROM member WHERE member_id LIKE ?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1,memberId);
	ResultSet rs = stmt.executeQuery();
	if(rs.next()){
		String msg = "id 중복, 다른 id 사용";
		response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp?&msg="+URLEncoder.encode(msg,"UTF-8"));
		
		rs.close();
		stmt.close();
		conn.close();
		return;
	}
	
	String insSql ="INSERT INTO member(member_id, member_pw, member_name) VALUES (?, PASSWORD(?), ?)";
	PreparedStatement insStmt = conn.prepareStatement(insSql);
	insStmt.setString(1,memberId);
	insStmt.setString(2,memberPw);
	insStmt.setString(3,memberName);
	
	//ResultSet rs = insStmt.executeQuery();
	
	String msg = null;
	String result = null;
	
	int row = insStmt.executeUpdate();
	
	if(row == 1) {
		msg = "회원가입 성공";
		result = "success";
		
		session.setAttribute("result", "success");
	} else {
		msg = "회원가입 실패";
	}
	
	rs.close();
	stmt.close();
	conn.close();
	
	response.sendRedirect(request.getContextPath()+"/loginForm.jsp?&msg="+URLEncoder.encode(msg,"UTF-8"));
%>
