<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.*" %>

<%
	if(session.getAttribute("loginMemberId") == null) {
		//로그인을 안하고 페이지로 강제 접속시
		String msg = "비 정상적인 접속입니다.";
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?&msg="+URLEncoder.encode(msg,"UTF-8"));
		return;
	}

	String memberId = request.getParameter("memberId");
	String memberName = request.getParameter("memberName");
	String memberPw = request.getParameter("memberPw");
	
	if(request.getParameter("memberName") == null||
			request.getParameter("memberName").equals("")||
			request.getParameter("memberId")==null||
			request.getParameter("memberId").equals("")||
			request.getParameter("memberPw")==null||
			request.getParameter("memberPw").equals("")){
				String msg = "빈칸을 입력해주세요.";
				response.sendRedirect(request.getContextPath()+"/delete/deleteMemberForm.jsp?&msg="+URLEncoder.encode(msg,"UTF-8"));
			return;
		}
	
	String Driver = "org.mariadb.jdbc.Driver";
	Class.forName(Driver);
	
	String url = "jdbc:mariadb://localhost:3306/gdj58";
	String user = "root";
	String userPw = "java1234";
	Connection conn = DriverManager.getConnection(url, user, userPw);
	
	String pwSql = "SELECT member_pw memberPw FROM member WHERE member_id LIKE ? AND member_pw LIKE PASSWORD(?)";
	PreparedStatement pwStmt = conn.prepareStatement(pwSql);
	pwStmt.setString(1, (String)(session.getAttribute("loginMemberId")));
	pwStmt.setString(2, memberPw);
	
	ResultSet pwRs = pwStmt.executeQuery();
	
	if(pwRs.next()) {
		String deleteSql = "DELETE FROM member WHERE member_id LIKE ? AND member_pw LIKE PASSWORD(?)";
		PreparedStatement deleteStmt = conn.prepareStatement(deleteSql);
		deleteStmt.setString(1,(String)(session.getAttribute("loginMemberId")));
		deleteStmt.setString(2, memberPw);
		
		int row = deleteStmt.executeUpdate();
		if(row == 1) {
			System.out.println("delete complete!");
			String msg = "삭제완료";
			session.invalidate();
			response.sendRedirect(request.getContextPath()+"/loginForm.jsp?&msg="+URLEncoder.encode(msg,"UTF-8"));
		} else {
			String msg = "실패";
			response.sendRedirect(request.getContextPath()+"/memberOne.jsp?&msg="+URLEncoder.encode(msg,"UTF-8"));
		}
	} else {
		String msg = "비밀번호가 틀렸습니다.";
		response.sendRedirect(request.getContextPath()+"/delete/deleteMemberForm.jsp?&msg="+URLEncoder.encode(msg,"UTF-8"));
	}
	
%>
