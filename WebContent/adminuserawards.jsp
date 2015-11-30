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
String mVal = request.getParameter("mVal");
int mValInt = Integer.parseInt(mVal);

if((String)session.getAttribute("u_uname") != null)
{
	out.println("Logged in: " + (String)session.getAttribute("u_uname"));
}
%>

<center>
<%@ include file="/navbar.jsp" %>
<br>

<%
   
if (session.getAttribute("u_uname").equals("admin"))
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
	int count = 1;
	//query="Select * from books where "+attrName+"='"+attrValue+"'";
	
	sql="SELECT DISTINCT(T.uname_trusted) FROM trusts T ORDER BY "
			+ "((SELECT COUNT(*) FROM trusts T2 WHERE T.trustVal = 1 AND T2.uname_trusted = T.uname_trusted)" 
			+" - (SELECT COUNT(*) FROM trusts T3 WHERE T.trustVal = 0 AND T3.uname_trusted = T.uname_trusted)) DESC";
	rs = stmt.executeQuery(sql);

	%> 
	<h2>Most Trusted Users (Trusted - Not-Trusted Counts):</h2>
	<br>
	<%
	while(rs.next() && count <= mValInt)
	{
		%>
		<%=count %>. <%=rs.getString(1)%><br>
		<%
		count++;
	}
	
	
	int count2 = 1;
	//query="Select * from books where "+attrName+"='"+attrValue+"'";
	
	sql="SELECT DISTINCT(U.uname_useful) FROM usefulness U ORDER BY "
			+ "(SELECT avg(score) FROM usefulness U2 WHERE U2.uname_useful = U.uname_useful) DESC";
	rs = stmt.executeQuery(sql);

	%> 
	<h2>Most Trusted Users (Trusted - Not-Trusted Counts):</h2>
	<br>
	<%
	while(rs.next() && count2 <= mValInt)
	{
		%>
		<%=count2 %>. <%=rs.getString(1)%><br>
		<%
		count2++;
	}
	
	rs.close();
	stmt.close();
	con.close();
	
}
else
{
	
	out.print("Admin login failed. Please try again.");
    %>
	Admin Login:
		<form method="post" action = "adminhub.jsp">
		<table>
		<tr><td><label for="Username">Username</label></td>
		    <td><input type="text" size="20" name="username" id="username" value=""/></td></tr>
		<tr><td><label for="Password">Password</label></td>
		    <td><input type="password" size="20" name="password" id="password"/></td></tr>
		    
		<tr><td colspan="2"><input type="submit" value="Submit"/></td></tr>
		</table>
		</form>
		
	<% 
}
%>

</center>
</body>
</html>