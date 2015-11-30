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

  <style type="text/css">
  body 
  {
    background-color: #CCCCFF
  }
  </style>

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
	<br><br>
	Add New Book:
	<br><br>
	<form method="post" action = "adminaddComplete.jsp">
	<table>
	<tr><td><label for="title">Title:</label></td>
    <td><input type="text" size="20" name="title" id="title" value=""/></td></tr>
	<tr><td><label for="author_last">Author Last Name:</label></td>
    <td><input type="author_last" size="20" name="author_last" id="author_last"/></td></tr>
    <tr><td><label for="author_first">Author First Name:</label></td>
    <td><input type="author_first" size="20" name="author_first" id="author_first"/></td></tr>
    <tr><td><label for="quantity">Quantity:</label></td>
    <td><input type="quantity" size="20" name="quantity" id="quantity"/></td></tr>
    <tr><td><label for="price">Price: </label></td>
    <td><input type="price" size="20" name="price" id="price"/></td></tr>
    <tr><td><label for="year">Year: </label></td>
    <td><input type="year" size="20" name="year" id="year"/></td></tr>
    <tr><td><label for="subject">Subject: </label></td>
    <td><select name="subject" id="subject">
    	<option value="fantasy">fantasy</option>
    	<option value="classic">classic</option>
    	<option value="scifi">scifi</option>
    	<option value="fiction">fiction</option>
    	<option value="nonfiction">nonfiction</option>
    </select>
    
    </td></tr>
    <tr><td><label for="edition">Edition: </label></td>
    <td><input type="edition" size="20" name="edition" id="edition"/></td></tr>
    <tr><td><label for="format">Format: </label></td>
    <td><select name="format" id="format">
    	<option value="paperback">paperback</option>
    	<option value="paperback">hardcover</option>
    	<option value="paperback">cassette</option>
    	<option value="paperback">cd</option>
    </select></td></tr>
    <tr><td><label for="keywords">Keywords: </label></td>
    <td><input type="keywords" size="30" name="keywords" id="keywords"/></td></tr>
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