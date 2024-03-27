<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Objects" %> <!-- Import for Objects class -->
<%
    // Check if session exists
    if (Objects.isNull(session.getAttribute("adminUsername"))) {
        // Redirect to customerlogin.jsp if session does not exist
        response.sendRedirect("admin_login.jsp");
        return; // Stop further execution of the JSP
    }

    // Check if the refresh flag is not set in the session
    if (session.getAttribute("refreshed") == null) {
        // Set the refresh flag in the session
        session.setAttribute("refreshed", true);
        // Refresh the page after 1 second
        response.setHeader("Refresh", "1");
    }
%>

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
    <title>Admin Dashboard</title>
    <link rel="stylesheet" type="text/css" href="./css/admin_dashboard.css">

</head>
<body>
<img src="./img/3556960-removebg-preview.png"style="
    height: 100vh;
">    <div class="container">
        <h2>Admin Dashboard</h2>

        <form action="ViewTasksServlet" method="get">
            <label for="employeeId">Enter Employee ID:</label>
            <input type="text" id="employeeId" name="employeeId" required>
            <label for="timePeriod">Select Time Period:</label>
            <select id="timePeriod" name="timePeriod">
                <option value="daily">Daily</option>
                <option value="weekly">Weekly</option>
                <option value="monthly">Monthly</option>
            </select>
            <br><br>
            <input type="submit" value="View Tasks">
        </form>
    </div>
</body>
</html>
