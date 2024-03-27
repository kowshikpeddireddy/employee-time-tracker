<%
    response.setHeader("Cache-Control","no-store");
    response.setHeader("Pragma","no-cache"); 
    response.setHeader ("Expires", "0"); //prevents caching at the proxy server
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employee Login</title>
    <link rel="stylesheet" type="text/css" href="./css/EmployeeLogin.css">

</head>
<body>
		<img src="./img/3893692-removebg-preview.png">
	
    <div class="container">
        <h2>Employee Login</h2>
        <form action="EmployeeLoginServlet" method="post">
            <label for="employee_id">Employee ID:</label>
            <input type="text" id="employee_id" name="employee_id" required><br><br>
            
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required><br><br>
            
            <input type="submit" value="Login">
        </form>
    </div>
</body>
</html>
