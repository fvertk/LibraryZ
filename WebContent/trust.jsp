<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import= "java.sql.*" %>    

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

</head>

<body>

<%
String user_trusted = request.getParameter("user_trusted");
String trustVal = request.getParameter("trustVal");

if((String)session.getAttribute("u_uname") != null)
{
	out.println("Logged in: " + (String)session.getAttribute("u_uname"));
}
%>
<center>
<%@ include file="/navbar.jsp" %>

<br><br>
<%
if((String)session.getAttribute("u_uname") != null)
{
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
			
			ResultSet rs;
			String sqlCheck = "SELECT * FROM trusts WHERE uname_trusted ='"
					+ user_trusted + "' AND uname_truster= '"
					+ (String)session.getAttribute("u_uname") + "'";
			rs = stmt.executeQuery(sqlCheck);
			
			int count = 0;
			while(rs.next())
			{
				count++;
			}
			
			if (count == 0)
			{
				%>
				You have set user "<%=user_trusted %>"" to "<%=trustVal %>" for trusted value.
				<%	
				
				String sql = "";
				sql = "INSERT INTO trusts (uname_trusted, uname_truster, trustVal) VALUES ('"
						+ user_trusted + "', '"
						+ (String)session.getAttribute("u_uname") + "', "
						+ trustVal + ")";
				stmt.executeUpdate(sql);
			}
			else
			{
				%>
				You have already put this user in your trust/non-trust groups. 
				<%
			}

			stmt.close();
			con.close();

}
else
{
	%>
	Sorry, you must be logged in to trust or non-trust users.
	<%
}
%>

</center>

</body>
</html>