<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import= "java.sql.*" %>    

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

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
<br>
<center>
<%@ include file="/navbar.jsp" %>
<br><br>


<form name="autoSelectForm" action="browse.jsp" method="post">
	Title:<input type="text" name= "titleS"></input>
	<select name="titleANDOR">
	<option value="AND">AND</option>
	<option value="OR">OR</option>
	</select><br>
	Author (last name):<input type="text" name= "authorS"></input>
	<select name="authorANDOR">
	<option value="AND">AND</option>
	<option value="OR">OR</option>
	</select><br>
	Subject:
	<select name="subjectS">
		<option value=""></option>
		<option value="Fantasy">Fantasy</option>
		<option value="SciFi">SciFi</option>
		<option value="Classic">Classic</option>
	</select>
	<select name="subjectANDOR">
	<option value="AND">AND</option>
	<option value="OR">OR</option>
	</select><br>
	<input type="submit" value="Search">
</form>
</center>

</body>
</html>