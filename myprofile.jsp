<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile</title>
    <link rel="stylesheet" href="Myprofilestyles.css"> <!-- Link to the CSS file -->
</head>
<body>
    <div class="container">
        <h2>My Profile</h2>

        <%
            String username = (String) session.getAttribute("username");
            String email = (String) session.getAttribute("email");
        %>

        <p><strong>Username:</strong> <%= username != null ? username : "Not set" %></p>
        <p><strong>Email:</strong> <%= email != null ? email : "Not set" %></p>
        
        <div class="button-container">
            <a href="UserHome.jsp" class="button">Back to Product List</a>
            <a href="uorders.jsp" class="button">View Orders</a>
        </div>
    </div>
</body>
</html>
