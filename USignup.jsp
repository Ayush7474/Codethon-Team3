<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sign up</title>
</head>
<body>
<h1>User Sign up</h1>
	<form action="signupInfoServlet" method="post">
		<label for="username">Username:</label>
		<input type="text" id="username" name="username" required>
		
		<label for="password">Password:</label>
        <input type="password" id="password" name="password" required>
        
        <label for="email">Email:</label>
        <input type="text" id="email" name="email" required>
        
        <label for="mobile">Mobile:</label>
        <input type="text" id="mobile" name="mobile" required>
        
        <button type="submit" class="btn">Sign Up</button>
	</form>

</body>
</html>
