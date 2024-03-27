<%
    response.setHeader("Cache-Control","no-store");
    response.setHeader("Pragma","no-cache"); 
    response.setHeader ("Expires", "0"); //prevents caching at the proxy server
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Login</title>
    <link rel="stylesheet" type="text/css" href="./css/admin_login.css">

</head>
<body>
	<img src="./img/3893692-removebg-preview.png">
    <div class="login-container">
        <h2>Admin Login</h2>
        <%-- Display error message if login failed --%>
        <%
            String error = request.getParameter("error");
            if (error != null && error.equals("invalid")) {
        %>
            <div class="error-message">Invalid username or password. Please try again.</div>
        <% } else if (error != null && error.equals("db")) { %>
            <div class="error-message">Database error. Please try again later.</div>
        <% } %>
        <form class="login-form" action="AdminLoginServlet" method="post">
            <input type="text" name="username" placeholder="Username" required>
            <input type="password" name="password" placeholder="Password" required>
            <input type="submit" value="Login">
        </form>
    </div>
</body>
</html>
