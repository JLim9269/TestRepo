<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%
	request.setCharacterEncoding("utf-8");
	String id = request.getParameter("id");
	String password = request.getParameter("password");
	String name = request.getParameter("name");
	String gender = request.getParameter("gender");
	String birthyy = request.getParameter("birthyy");
	String birthmm = request.getParameter("birthmm");
	String birthdd = request.getParameter("birthdd");
	String birth = birthyy+"/"+birthmm+"/"+birthdd;
	String mail1 = request.getParameter("mail1");
	String mail2 = request.getParameter("mail2");
	String email = mail1+"@"+mail2;
	String phone = request.getParameter("phone");
	String postcode = request.getParameter("postcode");
	String address = request.getParameter("address");
	String detailAddress = request.getParameter("detailAddress");
	String extraAddress = request.getParameter("extraAddress");
	
	Date currentDateTime = new Date(System.currentTimeMillis());
	java.sql.Date sqlDate = new java.sql.Date(currentDateTime.getTime());
	Timestamp timestamp = new Timestamp(currentDateTime.getTime());
%>
<!DOCTYPE html><html><head><meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<sql:setDataSource var="dataSource" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3306/WebMarketDB" user="root" password="1234"/>
<c:catch var="except">
<sql:update dataSource="${dataSource}" var="resultSet">
	insert into member values(?,?,?,?,?,?,?,?,?,?,?,?);
	<sql:param value="<%=id%>"/>
	<sql:param value="<%=password%>"/>
	<sql:param value="<%=name%>"/>
	<sql:param value="<%=gender%>"/>
	<sql:param value="<%=birth%>"/>
	<sql:param value="<%=email%>"/>
	<sql:param value="<%=phone%>"/>
	<sql:param value="<%=postcode%>"/>
	<sql:param value="<%=address%>"/>
	<sql:param value="<%=detailAddress%>"/>
	<sql:param value="<%=extraAddress%>"/>
	<sql:param value="<%=timestamp%>"/>
</sql:update>
</c:catch>
<c:if test="${empty except}">
	<c:if test="${resultSet>0}">
		<c:redirect url="resultMember.jsp?msg=1"/>
	</c:if>
</c:if>
</body>
</html>