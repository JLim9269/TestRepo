<%@page import="java.sql.PreparedStatement"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="dbconn.jsp"%>
<%
	String id = request.getParameter("id");

	String sql = "delete from product where p_id=?";
	con.setAutoCommit(false);
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setString(1,id);
	
	int result = pstmt.executeUpdate();
	if(result>0)con.commit();
	if(result==0)con.rollback();
	con.setAutoCommit(true);
	
	if(pstmt!=null)pstmt.close();
	if(con!=null)con.close();
	
	response.sendRedirect("./editProduct.jsp?edit=delete");
%>