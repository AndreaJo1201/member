<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>

<%
	
	if(request.getParameter("msg") != null) {
		String msg = request.getParameter("msg");
		out.println("<script>alert('"+msg+"');</script>");
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
		<%
			if(session.getAttribute("result") != null) {
		%>
				<div>로그인 상태에서 보이는 페이지</div>
				<div><%=session.getAttribute("result") %></div>
		<%		
			} else {
		%>
				<div>로그인 안한 상태에서 보이는 페이지</div>
				<div><%=session.getAttribute("result") %></div>
		<%
			}	
		%>
	</body>
</html>