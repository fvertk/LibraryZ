<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<head>
<LINK REL=STYLESHEET
      HREF="style.css"
      TYPE="text/css">
      
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
<br><br>
<I>Bookstore Z</I> is an experimental project made for CS5560 at the University of Utah. It acts like an electronic bookstore ala Barnes & Noble. Functions include complex searches, admin controls/stats, user reviews and feedback to other users. No CSS or design has been applied, it is all functionality-based. 
</center>
<br><br>
Requirements (and directions on how to analyze fulfillment of requirements):

1. Registration (5 points): a new user has to provide the appropriate information; 
he/she can pick a login-name and a password. The login name should be checked for uniqueness. 
Also, the user should provide all the other additional information.
<br>
<i>All of this is done. Go to the login page and click "register".</i>
<br><br>
2. Searching and Ordering (5 points): After registration, a user can order one or more books. 
The total amount of the order is reported to him/her. A user may order multiple copies of a book, 
one or more times. 
<br>
<i>All of this is done. Browse for books, order them, total amount is reported, and multiple purchases can be made. </i>
<br><br>
3. User record (5 points): upon user demand, the full record for a user should be printed:
<br>all his/her personal data
<br>the full history of sales (book title, number of copies, date)
<br>his/her full history of feedbacks
<br>the list of all the feedbacks he/she ranked with usefulness
<br>the login names of the 'trusted' and 'not-trusted' users.
<br>
<i>All this is done. Go to the accounts page after logging in.</i>
<br><br>
4. New Book (5 points): The store manager records the details of a new book, along with the number 
of copies that have arrived in the warehouse.
<br>
<i>All done. Go to "admin," logging in as admin, then "add book".</i>
<br><br>
5. Arrival of More Books (5 points): The store manager increases the appropriate counts.
<br>
<i>Also done, in the admin hub, go to "increase inventory".</i>
<br><br>
6. Feedback Recordings (5 points): Users can record their feedback for a book. 
The system should record the date, the numerical score (0= terrible, 10= masterpiece), 
and an optional short text. No changes are allowed; only one feedback per user per book is allowed.
<br>
<i>All done. When you browse and click on a book, it brings you to that book's page
where you can rate it and write a small optional review. I allow no edits and it checks to 
see if you already reviewed it </i>
<br><br>
7. Usefulness ratings (5 points): Users can assess a feedback record, giving it a numerical 
score 0,1, or 2 ('useless', 'useful', 'very useful' respectively). A user should not be 
allowed to provide a usefulness-rating for his/her own feedbacks.
<br>
<i>All done. Right beneath every review (viewable from a book's page) you can give a usefulness score
for a review. You can't give a usefulness score for your own reviews. </i>
<br><br>
8. Trust recordings (5 points): A user may declare zero or more other users as 'trusted' or 
'not-trusted'.
<br>
<i>All done. When you click on a user, you can go to that user's page, where you can mark a user
as trusted or trusted. The information is then put on your account showing who you trust
or don't trust. </i>
<br><br>
9. Book Browsing (10 points): Users may search for books, by asking conjunctive queries on the 
author, and/or title, and/or keywords, and/or subject. The system should allow the user to 
specify that the results are sorted (a) by year, or (b) by the average numerical score of the 
feedbacks, or (c) by the average numerical score of the trusted user feedbacks.
<br>
<i>All done. In the "search" page, one can do conjunctive queries on title, and/or author, and/or subject.
Only thing not added was keyword, mainly because it was added in as a column late. But all the work is there.  </i>
<br><br>
10. Useful feedbacks (5 points): For a given book, a user could ask for the top n most 
'useful' feedbacks. The value of n is user-specified (say, 5, or 10). The 'usefulness' of a 
feedback is its average 'usefulness' score.
<br>
<i>All done. At the very bottom of a book's page, you can see a dropdown menu letting you select
n and then it takes you to a page showing the top n most useful feedbacks.</i>
<br><br>
11. Buying suggestions (10 points): Similar to 'amazon.com', when a user orders a  book 'A', 
the system should provide a list of other suggested books. Book 'B' is suggested, if there exist 
a user 'X' that bought both 'A' and 'B'. The suggested books  should be sorted on decreasing 
sales count (i.e., most 'popular' first); count only sales to users that have bough both 
books, i.e. users like 'X'.
<br>
<i>All done. My query looks at all the users that bought book "X" then finds the best selling books
among those users. It decreases by the sales count among these users, showing the top 3. </i>
<br><br>
12. Statistics (10 points): every semester, the store manager wants
        <br>the list of m (say m=5) most popular books (in terms of copies sold in this semester),
        <br>the list of m most popular authors and
        <br>the list of m most popular subjects
<br>
<i>All done. Go to the admin hub -> statistics page, you can see that this is all 
finished. </i>
<br><br>
13. User awards (5 points): At random points in time, the store manager wants to give awards 
to the 'best' users; the manager hence needs to know
        <br>the m most 'trusted' users (the trust score of a user is the count of users 'trusting' him/her, minus the count of users 'not-trusting' him/her)
        <br>the m most 'useful' users (the usefulness score of a user is the average '
        usefulness' of all of his/her feedbacks combined)
<br>
<i>All done, go to admin hub and you can specify m and then get the top users for each of these two specifications. </i>
<br>
<br>

</body>
</html>