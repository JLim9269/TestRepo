<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%
	String id = request.getParameter("id");
%>
<sql:setDataSource var="dataSource" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3306/WebMarketDB" user="root" password="1234"/>
<c:catch var="except">
<sql:query var="resultSet" dataSource="${dataSource}">
	select * from member where id=?;
	<sql:param value="<%=id%>"/>
</sql:query>
</c:catch>
<c:if test="${empty except}">
	<c:forEach var="row" items="${resultSet.rows}">
		<script>
			alert("아이디가 중복 입니다.");
			opener.newMember.id.value="";
			opener.newMember.id.focus();
			window.close();
		</script>
	</c:forEach>
	<script>
		alert("사용 가능한 아이디 입니다.")
		opener.newMember.id.readOnly = true;
		opener.newMember.password.focus();
		self.close();
	</script>
</c:if>