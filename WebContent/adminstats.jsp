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
	%>
	Choose which stats you would like: 
	<br><br>
	
	<form name="adminstatsForm" method="post" action="adminstatsDisplay.jsp">
	Stats:<select name = "statsType" id="statsType">
	<option value="mpBooks">Most Popular Books</option>
	<option value="mpAuthors">Most Popular Authors</option>
	<option value="mpSubjects">Most Popular Subjects</option>
	</select>
	<br>
	Set your "m" value:
	<input type="text" name="mVal" id="mVal" value="5" size=5px></input>
	<input type="submit" value="Get Stats">
	</form>
	
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