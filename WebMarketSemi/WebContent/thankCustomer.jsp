<%@page import="java.util.Date"%>
<%@page import="dto.Product"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.net.URLDecoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="dbconn.jsp" %>
<!DOCTYPE html><html><head><meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"href="./resources/css/bootstrap.min.css">
</head>
<body>
<%
	String shipping_cartId = "";
	String shipping_name = "";
	String shipping_shippingDate = "";
	String shipping_country = "";
	String shipping_zipCode = "";
	String shipping_addressName = "";
	
	Cookie[] cookies = request.getCookies();
	
	if(cookies!=null){
		for(int i=0;i<cookies.length;i++){
			Cookie thisCookie = cookies[i];
			String n = thisCookie.getName();
			if(n.equals("Shipping_cartId")){
				shipping_cartId = URLDecoder.decode(thisCookie.getValue(),"utf-8");
			}
			if(n.equals("Shipping_name")){
				shipping_name = URLDecoder.decode(thisCookie.getValue(),"utf-8");
			}
			if(n.equals("Shipping_shippingDate")){
				shipping_shippingDate = URLDecoder.decode(thisCookie.getValue(),"utf-8");
			}
			if(n.equals("Shipping_country")){
				shipping_country = URLDecoder.decode(thisCookie.getValue(),"utf-8");
			}
			if(n.equals("Shipping_zipCode")){
				shipping_zipCode = URLDecoder.decode(thisCookie.getValue(),"utf-8");
			}
			if(n.equals("Shipping_addressName")){
				shipping_addressName = URLDecoder.decode(thisCookie.getValue(),"utf-8");
			}
		}
	}
	
	//오늘의 과제
	//sale 테이블, delivery 테이블에 저장, 날짜 2020/07/22
	//rollback?commit?
			
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
	String today = sdf.format(Calendar.getInstance().getTime());
	//Date date = new Date();
	//String today = sdf.format(date);
	String productId = "";
	int unitPrice = 0;
	int saleQty = 0;
	String sql = "";
	PreparedStatement pstmt = null;
	
	con.setAutoCommit(false);	
	try{
		ArrayList<Product> cartList = (ArrayList<Product>)session.getAttribute("cartlist");
		/* if(cartList==null)cartList = new ArrayList<Product>(); */
		for(int i=0;i<cartList.size();i++){
			Product product = cartList.get(i);
			productId = product.getProductId();
			unitPrice = product.getUnitPrice();
			saleQty = product.getQuantity();
			
			sql = "insert into sale(saledate,sessionId,productId,unitprice,saleqty) values(?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,today);
			pstmt.setString(2,shipping_cartId);
			pstmt.setString(3,productId);
			pstmt.setInt(4,unitPrice);
			pstmt.setInt(5,saleQty);
			
			pstmt.executeUpdate();
		}
		
		sql = "insert into delivery(sessionId,name,deliverydate,nation,zipcode,address) values(?,?,?,?,?,?)";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1,shipping_cartId);
		pstmt.setString(2,shipping_name);
		pstmt.setString(3,shipping_shippingDate);
		pstmt.setString(4,shipping_country);
		pstmt.setString(5,shipping_zipCode);
		pstmt.setString(6,shipping_addressName);
		
		int result = pstmt.executeUpdate();
		if(result>0)con.commit();
	}catch(Exception e){
		con.rollback();
	}finally{
		con.setAutoCommit(true);
		if(pstmt!=null)pstmt.close();
		if(con!=null)con.close();
	}
%>
<jsp:include page="menu.jsp"/>
<div class="jumbotron">
	<div class="container">
		<h1 class="display-3">주문 완료</h1>
	</div>
</div>
<div class="container">
	<h2 class="alert alert-danger">주문해 주셔서 감사합니다.</h2>
	<p>주문은 <%=shipping_shippingDate%>에 배송될 예정입니다.
	<p>주문번호: <%=shipping_cartId%>
</div>
<div class="container">
	<p><a href="./products.jsp"class="btn btn-secondary">&laquo;상품목록</a>
</div>
<%
	session.invalidate();
	
	for(int i=0;i<cookies.length;i++){
		Cookie thisCookie = cookies[i];
		String n = thisCookie.getName();
		if(n.equals("Shipping_cartId")){thisCookie.setMaxAge(0);}
		if(n.equals("Shipping_name")){thisCookie.setMaxAge(0);}
		if(n.equals("Shipping_shippingDate")){thisCookie.setMaxAge(0);}
		if(n.equals("Shipping_country")){thisCookie.setMaxAge(0);}
		if(n.equals("Shipping_zipCode")){thisCookie.setMaxAge(0);}
		if(n.equals("Shipping_addressName")){thisCookie.setMaxAge(0);}
		
		response.addCookie(thisCookie);
	}
%>
<jsp:include page="footer.jsp"/>
</body>
</html>