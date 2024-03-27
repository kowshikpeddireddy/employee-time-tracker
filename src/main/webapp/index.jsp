<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<title>Employer Tracking</title>
<link rel="stylesheet" href="styles.css">
</head>
    <link rel="stylesheet" type="text/css" href="./css/index.css">

<body>
<div class="container">
    <header>
        <h1>Employer Tracking</h1>
        <p>Welcome to our platform for managing employee data efficiently.</p>
    </header>
    <main>
        <section class="hero">
            <div class="hero-text">
                <h2>Track, Manage, <br> Optimize.</h2>
                <p>Efficiently monitor your employees and streamline your workforce.</p>
                <div style="display:flex;">
                
                <a href="admin_login.jsp" class="btn">Admin Login</a>
                 <a href="EmployeeLogin.jsp" class="btn">User Login</a>
                
                </div>
                
            </div>
            <div class="hero-image">
                <!-- Placeholder for the image -->
<img src="./img/Visual data-rafiki.png" alt="Hero Image" style="
    height: 75vh;
">            </div>
        </section>
        <section class="features">
            <h2>Key Features</h2>
            <div class="feature">
<img src="./img/4901359.jpg" alt="Feature Icon" style="
    max-width: 12vh;
">                <div class="feature-text">
                    <h3>Real-time Tracking</h3>
                    <p>Monitor employee activities and performance in real-time.</p>
                </div>
            </div>
            <div class="feature">
                <div class="feature-icon">
                <img style="
    max-width: 12vh;" src="./img/download.jpg" alt="Feature Icon"  style="
    max-width: 12vh;"></div>
                <div class="feature-text">
                    <h3>Data Analytics</h3>
                    <p>Analyze employee data to make informed decisions and optimize operations.</p>
                </div>
            </div>
            <div class="feature">
                <div class="feature-icon">
                <img src="./img/reports-removebg-preview.png" alt="Feature Icon"  style="
    max-width: 12vh;" ></div>
                <div class="feature-text">
                    <h3>Custom Reports</h3>
                    <p>Generate custom reports tailored to your organization's needs.</p>
                </div>
            </div>
        </section>
    </main>
    <footer>
        <p>&copy; 2024 Employer Tracking. All rights reserved.</p>
    </footer>
</div>
</body>
</html>
