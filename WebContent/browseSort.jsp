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
	String sortVal = request.getParameter("sortVal");
	String sql = request.getParameter("sql");
	String sql2 = request.getParameter("sql");
	
	
%>

<%
if((String)session.getAttribute("u_uname") != null)
{
	out.println("Logged in: " + (String)session.getAttribute("u_uname"));
}
%>
<center>
<%@ include file="/navbar.jsp" %>

<br><br>
Available books:
<br><br>
<%
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
	
	String resultstr="";
	String sqlSort = "";
	ResultSet rs; 
	int i;
	
	if (sortVal.equals("year"))
	{
		out.println("Ordered by year:");
		%><br><br><%
		sql2= sql2 + " ORDER BY year";
	}
	else if (sortVal.equals("quantity"))
	{
		out.println("Ordered by quantity:");
		%><br><br><%
		sql2= sql2 + " ORDER BY quantity DESC";
	}
	else if (sortVal.equals("rating"))
	{
		out.println("Ordered by ratings (highest to lowest)):");
		%><br><br><%
		sql2= sql2 + " ORDER BY (select avg(rating) FROM reviews R WHERE R.bindex = B.id) DESC";
	}
	else if (sortVal.equals("trustedRating"))
	{
		out.println("Ordered by ratings by trusted users (highest to lowest)):");
		%><br><br><%
		sql2= sql2 + " ORDER BY (select avg(rating) FROM reviews R WHERE R.bindex = B.id) DESC";
	}
	else
	{
		sql2 = sql2 + " ORDER BY year";
	}
	
	
	rs = stmt.executeQuery(sql2);
	%>
	
	
<%
	while(rs.next()){%>
	<form method="post" action="order.jsp?bindex=<%=rs.getString(1)%>">
	Title: <a href = currentbook.jsp?bindex=<%=rs.getString(1)%>><%=rs.getString(2)%></a><br>
	Author: <%=rs.getString(3)%><br>
	Quantity: <%=rs.getString(5)%><br>
	Price: $<%=rs.getString(6)%><br>
	Subject: <%=rs.getString(7)%><br>
	Year: <%=rs.getString(8)%><br>
	<input type="submit" value="Order"/>
	</form><br><br>
	<%} %>
	
	<br>
	<% rs.close();
	stmt.close();
	con.close();	
%>

<form method="post" action="browseSort.jsp">
	Sort results by: 
	<input type="text" name="sql" id="sql" style="display: none;" value="<%=sql %>"/>
	<select name=sortVal id="sortVal">
	<option value="year">Year</option>
	<option value="rating">Rating</option>
	<option value="tRating">Trusted Rating</option>
	<option value="quantity">Quantity</option>
	<input type="submit" value="Sort"/>
</select>
</form>

</center>

<script type="text/javascript">
  resetForm(document.autoSelectForm);
</script>

</body>
</html>