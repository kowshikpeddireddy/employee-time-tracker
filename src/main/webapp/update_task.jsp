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
    <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate">
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Expires" content="0">
    <title>Update Task</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/8.0.1/normalize.min.css">
    <link rel="stylesheet" type="text/css" href="./css/update_task.css">
</head>
<body>
    <div class="container">
        <h2>Update Task</h2>
        <form action="update_task_process.jsp" method="post">
            <div class="form-group">
                <label for="taskName">Task Name:</label>
                <input type="text" id="taskName" name="task_name" value="<%= request.getParameter("task_name") %>" required>
            </div>

            <div class="form-group">
                <label for="endTime">End Time:</label>
                <input type="time" id="endTime" name="end_time" value="<%= request.getParameter("end_time") %>" required>
            </div>

            <div class="form-group">
                <label for="description">Description:</label>
                <textarea id="description" name="description" required><%= request.getParameter("description") %></textarea>
            </div>

            <div class="form-group">
                <label for="duration">Duration (hours):</label>
                <input type="text" id="duration" name="duration" value="<%= request.getParameter("duration") %>" required>
            </div>

            <div class="form-group">
                <input type="hidden" name="employee_id" value="<%= request.getParameter("employee_id") %>">
                <input type="hidden" name="date" value="<%= request.getParameter("date") %>">
                <input type="hidden" name="start_time" value="<%= request.getParameter("start_time") %>">
                <input type="submit" value="Update Task">
            </div>
        </form>
    </div>
</body>
</html>
