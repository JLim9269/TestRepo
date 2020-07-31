<%@page import="java.sql.DriverManager"%>
<%@page import="java.util.Properties"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.io.File"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Connection con = null;
	try {
		Class.forName("com.mysql.jdbc.Driver");
		String path = "/dbconnection.properties";
		String realPath = application.getRealPath(path);
		File file = new File(realPath);
		FileReader read = new FileReader(file);
		Properties props = new Properties();
		props.load(read);
		con = DriverManager.getConnection("jdbc:mysql://localhost:3306/WebMarketDB?useSSL=false",props);
	}catch(Exception e) {
		e.printStackTrace();
	}
%>