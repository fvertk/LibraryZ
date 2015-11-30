<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import= "java.sql.*" %>   

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Out of Eight - Register Finish</title>
<link rel="stylesheet" href="style.css">
</head>

<body>

<center>
<%@ include file="/navbar.jsp" %>
<br>
Confirm the following: <br><br>
<%
   String u_fname = request.getParameter("first_name");
   session.setAttribute("u_fname", u_fname);
   String u_lname = request.getParameter("last_name");
   session.setAttribute("u_lname", u_lname);
   String u_uname = request.getParameter("username");
   session.setAttribute("u_uname", u_uname);
   String u_pass = request.getParameter("password");
   session.setAttribute("u_pass", u_pass);
   String ccnum = request.getParameter("ccnum");
   String phone = request.getParameter("phone");
   String address = request.getParameter("address");
   
   

   out.println("First Name : " + (String)session.getAttribute("u_fname") + "<br/>");
   out.println("Last Name: " + (String)session.getAttribute("u_lname") + "<br/>");
   out.println("Username: " + (String)session.getAttribute("u_lname") + "<br/>");
   out.println("Password: " + (String)session.getAttribute("u_pass") + "<br/>"); 
   out.println("Credit Card Number: " + ccnum + "<br/>"); 
   out.println("Phone Number: " + phone + "<br/>"); 
   out.println("Address: " + address + "<br/>"); 
%>

<%
	Statement stmt;
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
	} 
	catch(Exception e) 
	{
		out.print("Connection Error!");
		
		System.err.println("Unable to open oracle jdbc connection. The error is as follows,\n");
	    		System.err.println(e.getMessage());
		throw(e);
	}
	
	String sql;
	String resultstr="";
	int i;
	//query="Select * from books where "+attrName+"='"+attrValue+"'";
	
	sql="INSERT INTO customers (first_name, last_name, login, password, ccnum, address, phone) VALUES ('" 
	    + (String)session.getAttribute("u_fname") + "', '" 
	    +(String)session.getAttribute("u_lname") + "', '" 
	    + (String)session.getAttribute("u_uname") + "', '" 
	    + (String)session.getAttribute("u_pass") + "', '"
	    + ccnum + "', '"
	    + address + "', '"
	    + phone + "');";

	stmt.executeUpdate(sql);
	
	stmt.close();
	con.close();

	
%>

Go login <a href="login.jsp">here</a>.
</center>
</body>
</html>