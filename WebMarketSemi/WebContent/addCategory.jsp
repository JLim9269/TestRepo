<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form action="processAddCategory.jsp"method="post">
	<p>카테고리명:<input type="text"name="categoryName">
	<p>카테고리설명:<input type="text"name="description">
	<p><input type="submit"value="등록"><input type="reset"value="취소">
</form>
</body>
</html>