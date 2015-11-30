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
String rating = request.getParameter("rating");
String bindex = request.getParameter("bindex");
String review = request.getParameter("review");

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
			Statement stmtCheck;
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
				stmtCheck = con.createStatement();
			} 
			catch(Exception e) 
			{
				out.print("Connection Error!");
				
				System.err.println("Unable to open oracle jdbc connection. The error is as follows,\n");
			    		System.err.println(e.getMessage());
				throw(e);
			}
			
			String check = "";
			ResultSet rs;
			check = "SELECT * FROM reviews WHERE bindex=" + bindex + " AND uname='" + (String)session.getAttribute("u_uname") + "'";
			rs = stmtCheck.executeQuery(check);
			
			int count = 0;
			while(rs.next())
			{
				count++;
			}
			
			if (count == 0)
			{
				%>
				Your rating of <%=rating %>/10 has been received for book <%=bindex %>.
				<%	
			
				String sql = "";
				sql = "INSERT INTO reviews (bindex, uname, rating, review) VALUES ("
						+ bindex + ", '"
						+ (String)session.getAttribute("u_uname") + "', "
						+ rating + ", '"
						+ review + "')";
				stmt.executeUpdate(sql);
			}
			else
			{
				%>
				You cannot review the same item twice. 
				<%
			}
			
			stmtCheck.close();
			stmt.close();
			con.close();

}
else
{
	%>
	Sorry, you must be logged in to review books.
	<%
	
	
}
%>

</center>

</body>
</html>