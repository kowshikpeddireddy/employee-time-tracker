<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Objects" %> <!-- Import for Objects class -->
<%
    // Check if session exists
    if (Objects.isNull(session.getAttribute("employeeId"))) {
        // Redirect to customerlogin.jsp if session does not exist
        response.sendRedirect("EmployeeLogin.jsp");
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
    <title>Dashboard</title>
    <link rel="stylesheet" type="text/css" href="./css/dashboard.css">

</head>
<body>
<div class="container">
    <h2>Welcome to Dashboard</h2>
    
    <h3>Employee Details:</h3>
    <p>Employee ID: ${sessionScope.employeeId}</p>
    <p>Name: ${sessionScope.name}</p>
    <p>Role: ${sessionScope.role}</p>
    <p>Project: ${sessionScope.project}</p>
    
    <h3>Add Task</h3>
    <a href="addTask.jsp">Add Task</a>
    <a href="view.jsp">View Task</a>
    <a href="viewTasks.jsp">Edit Task</a>
    
    <% 
        // Check for error and success parameters in URL
        String error = request.getParameter("error");
        String success = request.getParameter("success");
        if (error != null && error.equals("overlap")) {
    %>
        <!-- Display overlapping task error message -->
        <div id="errorModal" class="modal">
            <div class="modal-content">
                <span class="close">&times;</span>
                <p>There was an overlap in the task timing. Please choose a different timing.</p>
            </div>
        </div>
        <script>
            document.getElementById("errorModal").style.display = "block";
            // Close the modal when the close button is clicked
            document.getElementsByClassName("close")[0].onclick = function() {
                document.getElementById("errorModal").style.display = "none";
            }
        </script>
    <% } else if (success != null && success.equals("true")) { %>
        <!-- Display success message -->
        <div id="successModal" class="modal">
            <div class="modal-content">
                <span class="close">&times;</span>
                <p>Task added successfully!</p>
            </div>
        </div>
        <script>
            document.getElementById("successModal").style.display = "block";
            // Close the modal when the close button is clicked
            document.getElementsByClassName("close")[0].onclick = function() {
                document.getElementById("successModal").style.display = "none";
            }
        </script>
    <% } %>
</div>
</body>
</html>
