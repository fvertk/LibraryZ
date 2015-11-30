<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Library Z- Login</title>
<link rel="stylesheet" href="style.css">

  <style type="text/css">
  body 
  {
    background-color: #CCCCFF
  }
  </style>
</head>

<body>
<center>
<%@ include file="/navbar.jsp" %>

<H3><h2>Please Log In:</h2></H3>
<br>(debug login = hpotter, pass = hhh)<br>
(debug login = htruman, pass = pass)<br>
(debug login = zadams, pass = pass)<br>
<form method="post" action = "welcome.jsp">
<table>
<tr><td><label for="Username">Username</label></td>
    <td><input type="text" size="20" name="username" id="username" value=""/></td></tr>
<tr><td><label for="Password">Password</label></td>
    <td><input type="password" size="20" name="password" id="password"/></td></tr>
    
<tr><td colspan="2"><input type="submit" value="Submit"/></td></tr>
</table>
</form>
No account? Register <a href="register.jsp">here.</a> 

</center>
</body>
</html>