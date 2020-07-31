<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dto.Product"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="dbconn.jsp" %>
<%
	String id = request.getParameter("id");
	
	if(id==null||id.trim().equals("")){
		response.sendRedirect("products.jsp");
		return;
	}
	
	String sql = "select * from product where p_id=?";
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setString(1,id);
	ResultSet rs = pstmt.executeQuery();
	
	Product product = null;
	if(rs.next()){
		product = new Product();
		product.setProductId(id);
		product.setPname(rs.getString("p_name"));
		product.setUnitPrice(rs.getInt("p_unitPrice"));
		product.setDescription(rs.getString("p_description"));
		product.setCategory(rs.getString("p_category"));
		product.setManufacturer(rs.getString("p_manufacturer"));
		product.setUnitsInStock(rs.getLong("p_unitsInStock"));
		product.setCondition(rs.getString("p_condition"));
		product.setFilename(rs.getString("p_fileName"));
	}
	
	if(product==null){
		response.sendRedirect("exceptionNoProductId.jsp");
	}
	
	ArrayList<Product> list = (ArrayList<Product>)session.getAttribute("cartlist");
	if(list==null){
		System.out.println("세션에 cartlist정보가 없음, 새로 만듬");
		list = new ArrayList<Product>();
		product.setQuantity(1);
		list.add(product);
		session.setAttribute("cartlist",list);
	}else{
		System.out.println("세션에 cartlist정보가 있음!");
		int count = 0;
		for(int i=0;i<list.size();i++){
			if(list.get(i).getProductId().equals(id)){
				count++;
				int orderQuantity = list.get(i).getQuantity()+1;
				list.get(i).setQuantity(orderQuantity);
			}
		}
		if(count==0){
			product.setQuantity(1);
			list.add(product);
		}
		session.setAttribute("cartlist",list);
	}
	
	if(pstmt!=null)pstmt.close();
	if(con!=null)con.close();
	response.sendRedirect("product.jsp?id="+id);
%>