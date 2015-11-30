<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Out of Eight - Login</title>
<link rel="stylesheet" href="style.css">
</head>

<body>
<center>
<%@ include file="/navbar.jsp" %>

<H3><h2>To register, fill out form:</h2></H3>

<form method="post" action = "registerFinish.jsp">
<table>
<tr><td><label for="first_name">First Name:</label></td>
    <td><input type="text" size="20" name="first_name" id="first_name" value=""/></td></tr>
<tr><td><label for="last_name">Last Name:</label></td>
    <td><input type="text" size="20" name="last_name" id="last_name" value=""/></td></tr>
<tr><td><label for="username">Username:</label></td>
    <td><input type="text" size="20" name="username" id="username" value=""/></td></tr>
<tr><td><label for="Password">Password:</label></td>
    <td><input type="password" size="20" name="password" id="password"/></td></tr>
<tr><td><label for="ccnum">Credit Card #:</label></td>
    <td><input type="ccnum" size="20" name="ccnum" id="ccnum"/></td></tr>
<tr><td><label for="address">Address:</label></td>
    <td><input type="address" size="20" name="address" id="address"/></td></tr>
<tr><td><label for="phone">Phone #:</label></td>
    <td><input type="phone" size="20" name="phone" id="phone"/></td></tr>
    
<tr><td colspan="2"><input type="submit" value="Submit"/></td></tr>
</table>
</form>
</center>
</body>
</html>