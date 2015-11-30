<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import= "java.sql.*" %>    

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<LINK REL=STYLESHEET
      HREF="style.css"
      TYPE="text/css">
      
</head>

<body>

<%
String bindex = request.getParameter("bindex");
session.setAttribute("bindex", bindex);
String bNameString = "";
String bPriceString = "";

if((String)session.getAttribute("u_uname") != null)
{
	out.println("Logged in: " + (String)session.getAttribute("u_uname"));
}
%>
<center>
<%@ include file="/navbar.jsp" %>

<br><br>
<h1>Your order history:</h1>
<br>
<%
if((String)session.getAttribute("u_uname") != null)
{
	Statement stmt;
	Connection con;
	try
	{
	 	String userName = "5530s12u54";
			String password = "ojaqitsa";
	    	String url = "jdbc:mysql://georgia.eng.utah.edu/5530s12db54";
	        Class.forName ("com.mysql.jdbc.Driver").newInstance ();
			con = DriverManager.getConnection (url, userName, password);
	
		stmt = con.createStatement();
	} 
	catch(Exception e) 
	{
		out.print("Connection Error!");
		
		System.err.println("Unable to open oracle jdbc connection. The error is as follows,\n");
	    		System.err.println(e.getMessage());
		throw(e);
	}
	
	String updateQ;
	updateQ = "UPDATE books SET quantity = (quantity-1) WHERE id=" + (String)session.getAttribute("bindex");
	stmt.executeUpdate(updateQ);
	
	String updateQ2;
	updateQ2 = "UPDATE books SET sales = (sales+1) WHERE id=" + (String)session.getAttribute("bindex");
	stmt.executeUpdate(updateQ2);
	
	String getBName = "";
	ResultSet bNameRS; 
	getBName = "SELECT * FROM books WHERE id=" + (String)session.getAttribute("bindex");
	bNameRS = stmt.executeQuery(getBName);
	
	while(bNameRS.next())
	{
		bNameString = bNameRS.getString(2);
		bPriceString = bNameRS.getString(6);
	}
	
	String makeO;
	makeO = "INSERT INTO orders (uname, title, price) VALUES ('" 
		    + (String)session.getAttribute("u_uname") + "', '" 
		    + bNameString + "', " 
		    + bPriceString + ");";
	stmt.executeUpdate(makeO);
	
	String sql;
	String resultstr="";
	ResultSet rs; 
	int i = 0;
	
	sql="SELECT * FROM books B, orders O WHERE B.name = O.title AND O.uname='" + (String)session.getAttribute("u_uname")+ "'";
	rs = stmt.executeQuery(sql);

	while(rs.next()){
		if (i == 0)
		{
			%><h2>This Purchase:</h2> <br><br> <%
		}
	
	%>
	
	Title: <%=rs.getString(2)%><br>
	Author: <%=rs.getString(3)%><br>
	Price: $<%=rs.getString(6)%><br><br>
	<%
	if (i == 0)
	{
		%><h2>Previous Purchases:</h2> <br><br> <%
	}
	
	i++; %>
	<%} %>	
	<br>
	<% rs.close();
	stmt.close();
	con.close();
}
%>
<br>
<h2>OTHER SUGGESTED BUYS:</h2>
<br>
<%
%>
<%
if((String)session.getAttribute("u_uname") != null)
{
	Statement stmt;
	Statement stmt2;
	Connection con;
	try
	{
	 	String userName = "5530s12u54";
			String password = "ojaqitsa";
	    	String url = "jdbc:mysql://georgia.eng.utah.edu/5530s12db54";
	        Class.forName ("com.mysql.jdbc.Driver").newInstance ();
			con = DriverManager.getConnection (url, userName, password);
	
		//DriverManager.registerDriver (new oracle.jdbc.driver.OracleDriver());
		stmt = con.createStatement();
		stmt2 = con.createStatement();
	} 
	catch(Exception e) 
	{
		out.print("Connection Error!");
		
		System.err.println("Unable to open oracle jdbc connection. The error is as follows,\n");
	    		System.err.println(e.getMessage());
		throw(e);
	}
	
	String sql;
	String sql2 = "";
	ResultSet rs; 
	
	int i =0;
	//query="Select * from books where "+attrName+"='"+attrValue+"'";
	
	
	sql="SELECT DISTINCT O.title FROM orders O ORDER BY " 
	+ "(SELECT COUNT(*) FROM orders O2 WHERE O2.title = O.title AND EXISTS "
	+ "(SELECT * FROM orders O3 WHERE title = '"
	+ bNameString + "' AND O2.uname = O3.uname)) DESC";
	
	String buyer = "";
	
	rs = stmt.executeQuery(sql);

	int count = 0;
	while(rs.next() && count<3)
	{
		if (!rs.getString(1).equals(bNameString))
		{
			count++;
			%>
			<%=rs.getString(1) %><br>
			<%
		}
	}
	
	rs.close();
	
	stmt.close();
	stmt2.close();
	con.close();
}

%>

</center>

</body>
</html>