<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html><html><head><meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	Connection con = null;
	try{
		Context init = new InitialContext();
		Context ctx = (Context)init.lookup("java:comp/env");
		DataSource ds = (DataSource)ctx.lookup("jdbc/MysqlDB");
		con = ds.getConnection();
	}catch(Exception e){
		out.print("데이터베이스 연결에 실패했습니다.<br>");
		out.print("SQLException:"+e.getMessage());
	}
%>
</body>
</html>