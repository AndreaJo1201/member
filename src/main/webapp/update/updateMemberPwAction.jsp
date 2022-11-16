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


	String memberPw = request.getParameter("memberPw");
	String changePw = request.getParameter("changeMemberPw");
	String changePwCheck = request.getParameter("changeMemberPw2");
	
	if(request.getParameter("memberPw") == null||
		request.getParameter("memberPw").equals("")||
		request.getParameter("changeMemberPw")==null||
		request.getParameter("changeMemberPw").equals("")||
		request.getParameter("changeMemberPw2")==null||
		request.getParameter("changeMemberPw2").equals("")){
			String msg = "빈칸을 입력해주세요.";
			response.sendRedirect(request.getContextPath()+"/update/updateMemberPwForm.jsp?&msg="+URLEncoder.encode(msg,"UTF-8"));
		return;
	}
	
	if(!request.getParameter("changeMemberPw").equals(request.getParameter("changeMemberPw2"))) {
		String msg = "변경할 비밀번호가 일치하지않습니다.";
		response.sendRedirect(request.getContextPath()+"/update/updateMemberPwForm.jsp?&msg="+URLEncoder.encode(msg,"UTF-8"));
		return;
	}

	String Driver = "org.mariadb.jdbc.Driver";
	Class.forName(Driver);
	
	String url = "jdbc:mariadb://localhost:3306/gdj58";
	String user = "root";
	String userPw = "java1234";
	Connection conn = DriverManager.getConnection(url, user, userPw);
	
	String sql = "SELECT member_id memberId, member_pw memberPw FROM member WHERE member_id LIKE ? AND member_pw LIKE PASSWORD(?)";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1, (String)(session.getAttribute("loginMemberId")) );
	stmt.setString(2, memberPw);
	ResultSet rs = stmt.executeQuery();
	if(rs.next()) {
		
		String updateSql = "UPDATE member SET member_pw = PASSWORD(?) WHERE member_id LIKE ?";
		PreparedStatement updateStmt = conn.prepareStatement(updateSql);
		updateStmt.setString(1,changePw);
		updateStmt.setString(2,(String)(session.getAttribute("loginMemberId")));
		
		int row = updateStmt.executeUpdate();
		if(row == 1) {
			String msg ="비밀번호 수정 완료, 다시 로그인 하십시오.";
			rs.close();
			stmt.close();
			session.invalidate();
			response.sendRedirect(request.getContextPath()+"/loginForm.jsp?&msg="+URLEncoder.encode(msg,"UTF-8"));
			return;
		}
		
	} else {
		String msg = "현재 비밀번호가 틀렸습니다.";
		
		rs.close();
		stmt.close();
		conn.close();
		response.sendRedirect(request.getContextPath()+"/update/updateMemberPwForm.jsp?&msg="+URLEncoder.encode(msg, "UTF-8"));
		
		return;
	}
	


%>
