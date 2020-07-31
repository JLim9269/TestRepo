<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="dbconn.jsp"%>
<%
	request.setCharacterEncoding("utf-8");
	
	String categoryName = request.getParameter("categoryName");
	String description = request.getParameter("description");
	
	String sql = "insert into category(categoryName,description) values(?,?)";
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setString(1,categoryName);
	pstmt.setString(2,description);
	
	pstmt.executeUpdate();
	
	if(pstmt!=null)pstmt.close();
	if(con!=null)con.close();
	
	response.sendRedirect("./products.jsp");
%>