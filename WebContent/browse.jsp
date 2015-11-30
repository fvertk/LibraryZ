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
	String titleS = request.getParameter("titleS");
	String titleANDOR = request.getParameter("titleANDOR");
	String authorS = request.getParameter("authorS");
	String authorANDOR = request.getParameter("authorANDOR");
	String subjectS = request.getParameter("subjectS");
	String subjectANDOR = request.getParameter("subjectANDOR");
%>

<%
if((String)session.getAttribute("u_fname") != null)
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
	
	String sql = "";
	String resultstr="";
	ResultSet rs; 
	int i;
	//query="Select * from books where "+attrName+"='"+attrValue+"'";
	
	// Search if title was searched for, but not the others.
	if (!(titleS.equals("")) && (authorS.equals("")) && (subjectS.equals("")))
	{
		sql="SELECT * FROM books B WHERE B.name='" + titleS + "'";
	}
	// Search if author was searched for, but not the others.
	else if ((titleS.equals("")) && !(authorS.equals("")) && (subjectS.equals("")))
	{
		sql="SELECT * FROM books B WHERE B.author_last='" + authorS + "'";
	}
	// Search if subjet was searched for, but not the others.
	else if ((titleS.equals("")) && (authorS.equals("")) && !(subjectS.equals("")))
	{
		sql="SELECT * FROM books B WHERE B.subject='" + subjectS + "'";
	}
	// Else if title AND author were searched for
	else if (!(titleS.equals("")) && !(authorS.equals("")) && (subjectS.equals("")))
	{
		// If both title or author had AND next to it, then we'll do a conjunctive search.
		if (titleANDOR.equals("AND") && authorANDOR.equals("AND"))
		{
			sql="SELECT * FROM books B WHERE B.name='" + titleS + "' AND B.author_last='" + authorS + "'";
		}
		// If both have OR set as options, that means that we're searching for either. 
		else if (titleANDOR.equals("OR") && authorANDOR.equals("OR"))
		{
			sql="SELECT * FROM books B WHERE B.name='" + titleS + "' OR B.author_last='" + authorS + "'";
		}
		else
		{
			sql="SELECT * FROM books B WHERE B.name='" + titleS + "' OR B.author_last='" + authorS + "'";
		}
	}
	
	// Else if title AND subject were searched for
		else if (!(titleS.equals("")) && (authorS.equals("")) && !(subjectS.equals("")))
		{
			// If both title or subject had AND next to it, then we'll do a conjunctive search.
			if (titleANDOR.equals("AND") && subjectANDOR.equals("AND"))
			{
				sql="SELECT * FROM books B WHERE B.name='" + titleS + "' AND B.subject='" + subjectS + "'";
			}
			// If both have OR set as options, that means that we're searching for either. 
			else if (titleANDOR.equals("OR") && subjectANDOR.equals("OR"))
			{
				sql="SELECT * FROM books B WHERE B.name='" + titleS + "' OR B.subject='" + subjectS + "'";
			}
			else
			{
				sql="SELECT * FROM books B WHERE B.name='" + titleS + "' OR B.subject='" + subjectS + "'";
			}
		}
	
		// Else if author AND subject were searched for
				else if (!(titleS.equals("")) && (authorS.equals("")) && !(subjectS.equals("")))
				{
					// If both title or subject had AND next to it, then we'll do a conjunctive search.
					if (authorANDOR.equals("AND") && subjectANDOR.equals("AND"))
					{
						sql="SELECT * FROM books B WHERE B.author_last='" + authorS + "' AND B.subject='" + subjectS + "'";
					}
					// If both have OR set as options, that means that we're searching for either. 
					else if (authorANDOR.equals("OR") && subjectANDOR.equals("OR"))
					{
						sql="SELECT * FROM books B WHERE B.author_last='" + authorS + "' OR B.subject='" + subjectS + "'";
					}
					else
					{
						sql="SELECT * FROM books B WHERE B.author_last='" + authorS + "' OR B.subject='" + subjectS + "'";
					}
				}
	// Else if title AND author AND subject were searched for
	else if (!(titleS.equals("")) && !(authorS.equals("")) && !(subjectS.equals("")))
	{		
		// If all title, author, and subject had AND next to it, then we'll do a conjunctive search.
		if (titleANDOR.equals("AND") && authorANDOR.equals("AND") && subjectANDOR.equals("AND"))
		{
			sql="SELECT * FROM books B WHERE B.name='" + titleS 
					+ "' AND B.author_last='" + authorS + "'"
			        + "' AND B.subject='" + subjectS + "'";
		}
		// If all title, author, and subject had OR next to it, then we'll do a OR search.
		if (titleANDOR.equals("AND") && authorANDOR.equals("AND") && subjectANDOR.equals("AND"))
		{
			sql="SELECT * FROM books B WHERE B.name='" + titleS 
					+ "' OR B.author_last='" + authorS + "'"
			        + "' OR B.subject='" + subjectS + "'";
		}
		
		// If title has OR set as its option 
		else if (titleANDOR.equals("OR") && authorANDOR.equals("AND") && subjectANDOR.equals("AND"))
		{
			sql="SELECT * FROM books B WHERE (B.author_last='" + authorS 
					+ "' AND B.subject='" + subjectS + "')"
			        + "' OR B.name='" + titleS + "'";
		}
		// If author has OR set as its option 
		else if (titleANDOR.equals("AND") && authorANDOR.equals("OR") && subjectANDOR.equals("AND"))
		{
			sql="SELECT * FROM books B WHERE (B.subject='" + subjectS 
					+ "' AND B.name='" + titleS + "')"
			        + "' OR B.author_last='" + authorS + "'";
		}
		// If title has OR set as its option 
		else if (titleANDOR.equals("AND") && authorANDOR.equals("AND") && subjectANDOR.equals("OR"))
		{
			sql="SELECT * FROM books B WHERE (B.author_last='" + authorS 
					+ "' AND B.name='" + titleS + "')"
			        + "' OR B.subject='" + subjectS + "'";
		}
		
		// The rest of the options are irrelevant to the system, so they do a basic OR query. 
		else
		{
			sql="SELECT * FROM books B WHERE B.author_last='" + authorS 
					+ "' OR B.name='" + titleS + "'"
			        + "' OR B.subject='" + subjectS + "'";
		}
	}
	else
	{
		sql = "SELECT * FROM books B";
	}
	
	rs = stmt.executeQuery(sql);
	
	
	while(rs.next()){%>
	<form method="post" action="order.jsp?bindex=<%=rs.getString(1)%>">
	Title: <a href = currentbook.jsp?bindex=<%=rs.getString(1)%>><%=rs.getString(2)%></a><br>
	Author: <%=rs.getString(4)%> <%=rs.getString(3)%><br>
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
	<option value="year">Year (earliest to latest)</option>
	<option value="rating">Rating (high to low)</option>
	<option value="tRating">Trusted Rating (high to low)</option>
	<option value="quantity">Quantity (high to low)</option>
	<input type="submit" value="Sort"/>
</select>
</form>

</center>

</body>
</html>