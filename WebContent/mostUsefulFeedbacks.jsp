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

String bindex = request.getParameter("bindex");
String nVal = request.getParameter("nVal");
int nValInt = Integer.parseInt(nVal);

if((String)session.getAttribute("u_uname") != null)
{
	out.println("Logged in: " + (String)session.getAttribute("u_uname"));
}
%>

<center>
<%@ include file="/navbar.jsp" %>
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
	
	String sql = "";
	String resultstr="";
	ResultSet rs; 
	int count = 1;

	
		sql = "SELECT DISTINCT O.uname_reviewer, O.bindex FROM usefulness O WHERE O.bindex = "
				+ bindex + " ORDER BY (SELECT avg(score) FROM usefulness O2 WHERE O2.bindex = O.bindex"
				+ " AND O.uname_reviewer = O2.uname_reviewer) DESC";
		rs = stmt.executeQuery(sql);	
		
		%><h2>Top <%=nValInt %> Most Useful Feedbacks for Book:</h2><br><%
		while(rs.next() && count <= nValInt )
		{
			%>
			<%=count%>. <a href="currentbook.jsp?bindex=<%=rs.getString(1)%>"><%=rs.getString(1)%></a><br>
			<%
			count++;
		}
	
	
	rs.close();
	stmt.close();
	con.close();
	
	%>
	<br><br>
	Return to <a href = "currentbook.jsp?bindex=<%=bindex%>">book info.</a>


</center>
</body>
</html>