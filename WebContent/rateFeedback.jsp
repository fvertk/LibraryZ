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
String usefulness = request.getParameter("usefulness");
session.setAttribute("usefulness", usefulness);

String bindex = request.getParameter("bindex");
String user_review = request.getParameter("user_review");

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
	if (!(user_review.equals((String)session.getAttribute("u_uname"))))
	{
		%>
		Your rating of <%=usefulness %>/2 usefulness has been received for <%=user_review %>'s review on book <%=bindex %>.
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
			sql = "INSERT INTO usefulness (bindex, uname_reviewer, uname_useful, score) VALUES ("
					+ bindex + ", '"
					+ user_review+ "', '"
					+ (String)session.getAttribute("u_uname") + "', "
					+ usefulness + ")";
			stmt.executeUpdate(sql);
			
			stmt.close();
			con.close();
	}
	else
	{
		%>
		Sorry, you cannot rate your own feedback.
		<%
	}

}
else
{
	%>
	Sorry, you must be logged in to rate other users.
	<%
}
%>

</center>

</body>
</html>