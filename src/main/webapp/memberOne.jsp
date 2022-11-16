<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
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
%>

<%

%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>

	<body>
		<h1>내 정보</h1>
		<a href="<%=request.getContextPath()%>/update/updateMemberPwForm.jsp">비밀번호 수정</a>
		<!-- updateMemberPwAction.jsp 비밀번호만 수정 가능 -->
		<!-- 수정전 비밀번호와 변경할 비밀번호 입력 -->
		
		<a href="<%=request.getContextPath()%>/update/updateMemberForm.jsp">개인정보 수정</a>
		<!-- updateMemberAction.jsp 비밀번호는 수정되면 안되며, id와 name만 수정, 단! id는 중복확인 -->
		
		<a href="<%=request.getContextPath()%>/delete/deleteMemberForm.jsp">회원탈퇴</a>
		<!-- deleteMemberAction.jsp 비밀번호를 입력받아 확인 후 데이터 삭제 처리, 세션 초기화 -->
		
		
	</body>
</html>