<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import= "java.sql.*" %>    

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

  <style type="text/css">
  body 
  {
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

<%
   String bindex = request.getParameter("bindex");
%>

<br><br>
<h1>Book Details: </h1>
<br>
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
	
	String sql;
	String resultstr="";
	ResultSet rs; 
	int i;
	//query="Select * from books where "+attrName+"='"+attrValue+"'";
	
	sql="SELECT * FROM books WHERE id=" + bindex;
	rs = stmt.executeQuery(sql);
	%>
	
	<form method="post" action="rateFinish.jsp?bindex=<%=bindex%>">
	<%
	while(rs.next()){%>
	
	Title: <%=rs.getString(2)%><br>
	Author: <%=rs.getString(4)%> <%=rs.getString(3)%><br>
	Quantity: <%=rs.getString(5)%><br>
	Price: $<%=rs.getString(6)%><br>
	Subject: <%=rs.getString(7)%><br>
	Year: <%=rs.getString(8)%><br>
	Sales: <%=rs.getString(9)%><br>
	Format: <%=rs.getString(10)%><br>
	Keywords: <%=rs.getString(11)%><br>
	Edition: <%=rs.getString(12)%><br>
	Rate: <select name="rating">
  		<option value="1">1 - Terrible</option>
  		<option value="2">2</option>
  		<option value="3">3</option>
  		<option value="4">4</option>
  		<option value="5">5</option>
  		<option value="6">6</option>
  		<option value="7">7</option>
  		<option value="8">8</option>
  		<option value="9">9</option>
  		<option value="10">10 - Masterpiece</option>
	</select><br>
	Review (200 chars):<input type="text" name="review"></input>
	<%} %>
	<input type="submit" value="Submit Review"/>
	</form><br><br>
	
	<br>
	<% rs.close();
	stmt.close();
	con.close();
%>
User ratings: 
<br><br>
<%
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

//query="Select * from books where "+attrName+"='"+attrValue+"'";

sql="SELECT * FROM reviews WHERE bindex=" + bindex;
rs = stmt.executeQuery(sql);
%>


<%
while(rs.next())
{	
	%>
	<form method="post" action="rateFeedback.jsp?user_review=<%=rs.getString(3)%>&bindex=<%=bindex%>">
	User: <a href=userAccount.jsp?userViewed=<%=rs.getString(3)%>><%=rs.getString(3)%></a><br>
	Rating: <%=rs.getString(4)%><br>
	Review: <%=rs.getString(5)%><br>
	<select name="usefulness">
		<option value="0">Useless</option>
		<option value="1">Useful</option>
		<option value="2">Very Useful</option>
	</select>
	<input type="submit" value="Rate Feedback"/>
	</form><br><br>
<%} %>


<%
rs.close();
stmt.close();
con.close();
%>
<br>
Get n most useful feedbacks: <br>
<form method="post" action="mostUsefulFeedbacks.jsp?bindex=<%=bindex%>">
How many? (define n):
<input type="text" name="nVal" id="nVal" value="5" size=5px></input>
<input type="submit" value="Get feedbacks!"/>

</form>

</center>
<script type="text/javascript">
  resetForm(document.autoSelectForm);
</script>

</body>
</html>