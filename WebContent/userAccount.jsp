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
String userViewed = request.getParameter("userViewed");

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
	
	getInfoSQL = "SELECT * FROM customers WHERE login='" + userViewed + "'";
	rs = stmt.executeQuery(getInfoSQL);
	
	while(rs.next())
	{
	
	session.setAttribute("userViewed_fname", rs.getString(2));
	session.setAttribute("userViewed_lname", rs.getString(3));
	session.setAttribute("userViewed_uname", rs.getString(4));
	}	
	
	rs.close();
	stmt.close();
	con.close();
}
else
{

		%>
		<meta HTTP-EQUIV='REFRESH' content='0; url=login.jsp'>
		<% 
}


if((String)session.getAttribute("u_uname") != null)
{
	out.println("Logged in: " + (String)session.getAttribute("u_uname"));
}
%>
<center>
<%@ include file="/navbar.jsp" %>

<br>
<h1>User Account: </h1>
<br><br>
Name: 
<%   
   out.println((String)session.getAttribute("userViewed_fname") + " ");
   out.println((String)session.getAttribute("userViewed_lname") + "<br/>");
%>
Username:
<%
   out.println((String)session.getAttribute("userViewed_uname") + "<br/>");
%>
<br>
<h2>Purchase History: </h2>
<br>
<%
if((String)session.getAttribute("userViewed_uname") != null)
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
	
	String sql;
	String resultstr="";
	ResultSet rs; 
	int i;
	//query="Select * from books where "+attrName+"='"+attrValue+"'";
	
	sql="SELECT * FROM books B, orders O WHERE B.name = O.title AND O.uname='" + (String)session.getAttribute("userViewed_uname")+ "'";
	rs = stmt.executeQuery(sql);

	while(rs.next()){%>
	
	Title: <%=rs.getString(2)%><br>
	Author: <%=rs.getString(3)%><br><br>
	<%} %>	
	<br>
	<% rs.close();
	stmt.close();
	con.close();
}
%>
<br>
<h2>Review History:</h2>
<%
if((String)session.getAttribute("userViewed_uname") != null)
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
	String resultstr="";
	ResultSet rs2; 
	int i;
	//query="Select * from books where "+attrName+"='"+attrValue+"'";
	
	sql="SELECT * FROM reviews WHERE uname='" + (String)session.getAttribute("userViewed_uname")+ "'";
	rs2 = stmt.executeQuery(sql);

	while(rs2.next())
	{
		String bName = "";
		ResultSet bNameRS;
		String bNameString = "";
		String bAuthorString = "";
		bName="SELECT * FROM books WHERE id=" + rs2.getString(2);
		bNameRS = stmt2.executeQuery(bName);
		

		while(bNameRS.next())
		{
			bNameString = bNameRS.getString(2);
			bAuthorString = bNameRS.getString(3);	
		}
		
		%>
		Title: <a href= "currentbook.jsp?bindex=<%=rs2.getString(2)%>"><%=bNameString%></a><br>
		Rating: <%=rs2.getString(4)%><br>
		Review: <%=rs2.getString(5)%><br>
		<br><br>
  <% } %>	
		
		<br>
		<% 
		rs2.close();
		stmt.close();
		con.close();
}
%>


<br><br>
<h2>Other Reviews Marked Useful History:</h2>
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
	ResultSet rs; 
	int i;
	//query="Select * from books where "+attrName+"='"+attrValue+"'";
	
	sql="SELECT * FROM usefulness WHERE uname_useful='" + (String)session.getAttribute("userViewed_uname")+ "'";
	rs = stmt.executeQuery(sql);

	while(rs.next()){%>
	
	User: <%=rs.getString(3)%><br>
	Book Title: <%=rs.getString(2)%><br>
	Rating: <%=rs.getString(5)%> <br><br>
	<%} %>	
	<br>
	<% rs.close();
	stmt.close();
	con.close();
}
%>
<br><br>
<a href="trust.jsp?user_trusted=<%=userViewed%>&trustVal=1">TRUSTED USER</a>
<br>
<a href="trust.jsp?user_trusted=<%=userViewed%>&trustVal=0">NON-TRUSTED USER</a>
   


</center>
</body>
</html>