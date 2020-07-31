<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="dbconn.jsp" %>
<jsp:useBean id="product" class="dto.Product"/>
<%
	request.setCharacterEncoding("utf-8");

	String filename = "";
	String realFolder = "/resources/images";
	int maxSize = 5*1024*1024;
	String encType = "utf-8";
	
	MultipartRequest multi = new MultipartRequest(request,getServletContext().getRealPath(realFolder),maxSize,encType,
			new DefaultFileRenamePolicy());
	
	String productId = multi.getParameter("productId");
	String name = multi.getParameter("pname");
	String unitPrice = multi.getParameter("unitPrice");
	String description = multi.getParameter("description");
	String category = multi.getParameter("category");
	String manufacturer = multi.getParameter("manufacturer");
	String unitsInStock = multi.getParameter("unitsInStock");
	String condition = multi.getParameter("condition");
	
	Integer price;	
	if(unitPrice.isEmpty()){
		price = 0;
	}else{
		price = Integer.valueOf(unitPrice);
	}	
	long stock;	
	if(unitsInStock.isEmpty()){
		stock = 0;
	}else{
		stock = Long.valueOf(unitsInStock);
	}	
	Enumeration files = multi.getFileNames();
	String fname = (String)files.nextElement();
	String fileName = multi.getFilesystemName(fname);
	
	String sql = "select * from product where p_id=?";
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setString(1, productId);
	ResultSet rs = pstmt.executeQuery();
	if(rs.next()){
		if(fileName!=null){
			sql = "update product set p_name=?,p_unitPrice=?,p_description=?,p_category=?,p_manufacturer=?,p_unitsInStock=?,p_condition=?,p_fileName=? where p_id=?";
			pstmt = con.prepareStatement(sql);		
			pstmt.setString(1,name);
			pstmt.setInt(2,price);
			pstmt.setString(3,description);
			pstmt.setString(4,category);
			pstmt.setString(5,manufacturer);
			pstmt.setLong(6,stock);
			pstmt.setString(7,condition);
			pstmt.setString(8,fileName);
			pstmt.setString(9,productId);
			
			pstmt.executeUpdate();
		}else{
			sql = "update product set p_name=?,p_unitPrice=?,p_description=?,p_category=?,p_manufacturer=?,p_unitsInStock=?,p_condition=? where p_id=?";
			pstmt = con.prepareStatement(sql);	
			pstmt.setString(1,name);
			pstmt.setInt(2,price);
			pstmt.setString(3,description);
			pstmt.setString(4,category);
			pstmt.setString(5,manufacturer);
			pstmt.setLong(6,stock);
			pstmt.setString(7,condition);
			pstmt.setString(8,productId);
			
			pstmt.executeUpdate();
		}
	}
	if(rs!=null)rs.close();
	if(pstmt!=null)pstmt.close();
	if(con!=null)con.close();

	response.sendRedirect("./editProduct.jsp?edit=update");
%>