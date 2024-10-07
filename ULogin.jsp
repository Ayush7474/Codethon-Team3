<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
</head>
<body>
	<h1>User Login</h1>
	<form action="LoginServlet" method="post">
	 <label for="uname">Username</label>
     <input type="text" placeholder="Enter Username" id="username" name="username" required>
        
     <label for="psw">Password</label>
     <input type="password" placeholder="Enter Password" id="password" name="password" required>
     
      <button class="submit" type="submit">Login</button><br>
      <span>Don't have an account? <a href="USignup.jsp" class="signup">Sign Up</a></span>
      </form>
</body>
</html>
