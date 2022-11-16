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
			response.sendRedirect(request.getContextPath()+"/update/updateMemberForm.jsp?&msg="+URLEncoder.encode(msg,"UTF-8"));
		return;
	}
	
	String Driver = "org.mariadb.jdbc.Driver";
	Class.forName(Driver);
	
	String url = "jdbc:mariadb://localhost:3306/gdj58";
	String user = "root";
	String userPw = "java1234";
	Connection conn = DriverManager.getConnection(url, user, userPw);
	
	String sql = "SELECT member_id  memberId FROM member WHERE member_id LIKE ? AND member_pw LIKE PASSWORD(?)";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1,memberId);
	stmt.setString(2,memberPw);
	ResultSet rs = stmt.executeQuery();
	if(rs.next()){
		if(memberId.equals(session.getAttribute("loginMemberId"))) {
			rs.close();
			stmt.close();
		} else {
			String msg = "중복된 ID입니다. 다른 ID를 사용해주세요.";
			
			rs.close();
			stmt.close();
			conn.close();
			response.sendRedirect(request.getContextPath()+"/update/updateMemberForm.jsp?&msg="+URLEncoder.encode(msg,"UTF-8"));
			return;
		}
		
	} else {
		sql = "SELECT member_id memberId FROM member WHERE member_id LIKE ?";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1,memberId);
		rs = stmt.executeQuery();
		if(rs.next()) {
			String msg = "중복된 ID입니다. 다른 ID를 사용해주세요.";
			
			rs.close();
			stmt.close();
			conn.close();
			response.sendRedirect(request.getContextPath()+"/update/updateMemberForm.jsp?&msg="+URLEncoder.encode(msg,"UTF-8"));
			
			return;
		} else {
			rs.close();
			stmt.close();
		}
		
	}
	
	
	String pwSql = "SELECT member_pw memberPw FROM member WHERE member_id LIKE ? AND member_pw LIKE PASSWORD(?)";
	PreparedStatement pwStmt = conn.prepareStatement(pwSql);
	pwStmt.setString(1, (String)(session.getAttribute("loginMemberId")));
	pwStmt.setString(2, memberPw);
	
	ResultSet pwRs = pwStmt.executeQuery();
	if(pwRs.next()) {
		String updateSql = "UPDATE member SET member_id = ?, member_name = ? WHERE member_id LIKE ? AND member_pw LIKE PASSWORD(?)";
		PreparedStatement updateStmt = conn.prepareStatement(updateSql);
		updateStmt.setString(1, memberId);
		updateStmt.setString(2, memberName);
		updateStmt.setString(3, (String)(session.getAttribute("loginMemberId")));
		updateStmt.setString(4, memberPw);
		
		int row = updateStmt.executeUpdate();
		if(row == 1) {
			System.out.println("update complete!");
			String msg = "수정완료";
			session.setAttribute("loginMemberId", memberId);
			response.sendRedirect(request.getContextPath()+"/memberOne.jsp?&msg="+URLEncoder.encode(msg,"UTF-8"));
		} else {
			String msg = "실패";
			response.sendRedirect(request.getContextPath()+"/memberOne.jsp?&msg="+URLEncoder.encode(msg,"UTF-8"));
		}
	} else {
		String msg = "비밀번호가 틀렸습니다.";
		response.sendRedirect(request.getContextPath()+"/update/updateMemberForm.jsp?&msg="+URLEncoder.encode(msg,"UTF-8"));
	}
	

%>