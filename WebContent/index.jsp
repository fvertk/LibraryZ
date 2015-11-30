<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Library Z</title>
	<LINK REL=STYLESHEET
      HREF="style.css"
      TYPE="text/css">
      
  <style type="text/css">
  body 
  {
    font-color: white;
    background-color: #CCCCFF
  }
  </style>
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
</center>

</body>
</html>