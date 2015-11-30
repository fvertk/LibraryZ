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

String statsType = request.getParameter("statsType");
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
	
	String sql = "";
	String resultstr="";
	ResultSet rs; 
	int count = 1;
	
	if (statsType.equals("mpBooks"))
	{
		sql = "SELECT B.name, B.id FROM books B ORDER BY (SELECT COUNT(*) FROM orders O WHERE B.name = O.title) DESC";
		rs = stmt.executeQuery(sql);	
		
		%><h2>Top <%=mValInt %> Most Popular Books:</h2><br><%
		while(rs.next() && count <= mValInt )
		{
			%>
			<%=count%>. <a href="currentbook.jsp?bindex=<%=rs.getString(2)%>"><%=rs.getString(1)%></a><br>
			<%
			count++;
		}
	}
	else if(statsType.equals("mpAuthors"))
	{
		sql = "SELECT B.author_last, B.author_first, B.name, B.id FROM books B ORDER BY (SELECT COUNT(*) FROM orders O WHERE B.name = O.title) DESC";
		rs = stmt.executeQuery(sql);
		%><h2>Top <%=mValInt %> Most Popular Authors:</h2><br><%
		while(rs.next() && count <= mValInt )
		{
			%>
			<%=count%>. <a href="currentbook.jsp?bindex=<%=rs.getString(4)%>"><%=rs.getString(2)%> <%=rs.getString(1)%></a><br>
			<%
			count++;
		}		
	}
	else if(statsType.equals("mpSubjects"))
	{
		sql = "SELECT DISTINCT B.subject, B.name, B.id FROM books B ORDER BY (SELECT COUNT(*) FROM orders O WHERE B.name = O.title) DESC";
		rs = stmt.executeQuery(sql);		
		
		%><h2>Top <%=mValInt %> Most Popular Subjects:</h2><br><%
		while(rs.next() && count <= mValInt )
		{
			%>
			<%=count%>. <a href="currentbook.jsp?bindex=<%=rs.getString(3)%>"><%=rs.getString(1)%></a><br>
			<%
			count++;
		}
	}
	else
	{
		out.println("ACK");
		sql = "SELECT B.name, B.id FROM books B ORDER BY (SELECT COUNT(*) FROM orders O WHERE B.name = O.title) DESC";
		rs = stmt.executeQuery(sql);	
		
		%><h2>Top <%=mValInt %> Most Popular Books:</h2><br><%
		while(rs.next() && count <= mValInt )
		{
			%>
			<%=count%>. <a href="currentbook.jsp?bindex=<%=rs.getString(2)%>"><%=rs.getString(1)%></a><br>
			<%
			count++;
		}
	}
	rs.close();
	stmt.close();
	con.close();
	
	%>
	<br><br>
	Return to <a href = "adminhub.jsp">admin hub.</a>
	<%
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