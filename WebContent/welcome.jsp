<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import= "java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<head>
<LINK REL=STYLESHEET
      HREF="style.css"
      TYPE="text/css">
</head>

<body>
<%

String u_uname = request.getParameter("username");
session.setAttribute("u_uname", u_uname);
String u_pass = request.getParameter("password");
session.setAttribute("u_pass", u_pass);

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
	
	String getInfoSQL;
	ResultSet rs;
	
	getInfoSQL = "SELECT * FROM customers WHERE login='" + (String)session.getAttribute("u_uname") + "'";
	rs = stmt.executeQuery(getInfoSQL);
	
	while(rs.next())
	{
	
		session.setAttribute("u_fname", rs.getString(2));
		session.setAttribute("u_lname", rs.getString(3));
		session.setAttribute("u_uname", rs.getString(4));
	}	
	
	rs.close();
	stmt.close();
	con.close();
}


if((String)session.getAttribute("u_uname") != null)
{
	out.println("Logged in: " + (String)session.getAttribute("u_uname"));
}
%>
<center>
<%@ include file="/navbar.jsp" %>
<br><br>
<%
if (("admin").equals((String)session.getAttribute("u_uname")))
{	
	%>
	You are logged in as admin. <a href="adminhub.jsp">Go to the admin hub.</a>
	<%
}
else
{
	%>
	Welcome, <%out.print((String)session.getAttribute("u_uname"));%>!
	<br>
	You are logged in. <a href="account.jsp">Go to your account.</a>
	<%
}
%>

</center>
</body>
</html>