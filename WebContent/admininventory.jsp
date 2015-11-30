<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
if((String)session.getAttribute("u_fname") != null)
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
	%>
	<br><br>
	Increase Inventory of Book:
	<br><br>
	<form method="post" action = "admininventoryI.jsp">
	<table>
	<tr><td><label for="title">Title:</label></td>
    <td><input type="text" size="20" name="title" id="title" value=""/></td></tr>
	<tr><td><label for="copies">Increase Inventory By:</label></td>
    <td><input type="copies" size="20" name="copies" id="copies"/></td></tr>
    <tr><td colspan="2"><input type="submit" value="Submit"/></td></tr>
	</table>
	</form>
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