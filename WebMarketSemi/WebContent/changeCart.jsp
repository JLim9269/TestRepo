<%@page import="java.util.List"%>
<%@page import="dao.ProductRepository"%>
<%@page import="dto.Product"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String id = request.getParameter("id");
	int qty = Integer.parseInt(request.getParameter("qty"));
	
	ArrayList<Product> list = (ArrayList<Product>)session.getAttribute("cartlist");
	if(list==null){
		System.out.println("세션에 cartlist정보가 없음,새로만듦");
		list = new ArrayList<Product>();
		session.setAttribute("cartlist", list);
	}
	
	Product goodsQnt = new Product();
	for(int i=0;i<list.size();i++){
		goodsQnt = list.get(i);
		if(goodsQnt.getProductId().equals(id)){
			goodsQnt.setQuantity(qty);
		}
	}

	response.sendRedirect("./cart.jsp");
%>
</body>
</html>