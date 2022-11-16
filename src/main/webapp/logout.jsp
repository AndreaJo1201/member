<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>

<%
	session.invalidate(); // 세션 삭제 후 새로 생성하기
	response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
%>
