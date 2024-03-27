<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.time.LocalDate, java.time.format.DateTimeFormatter" %>
<%
    response.setHeader("Cache-Control","no-store");
    response.setHeader("Pragma","no-cache"); 
    response.setHeader ("Expires", "0"); //prevents caching at the proxy server
%>
<!DOCTYPE html>
<html>
<head>
    <title>Employee Tasks</title>
    <!-- Add your CSS styles here -->
        <link rel="stylesheet" type="text/css" href="./css/viewTasks.css">


</head>
<body>
   
    <!-- Display tasks for today in a table -->
    <div class="container">
        <h3>Employee Tasks for Today</h3>
        <table border="1">
            <tr>
                <th>Task Name</th>
                <th>Date</th>
                <th>Start Time</th>
                <th>End Time</th>
                <th>Description</th>
                <th>Duration</th>
                <th>Actions</th>
            </tr>
            <% 
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/employee_time_track", "root", "6303");
                    String employeeId = session.getAttribute("employeeId").toString(); // Get employee_id from session
                    LocalDate today = LocalDate.now();
                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                    String todayString = today.format(formatter);
                    PreparedStatement pstmt = con.prepareStatement("SELECT * FROM Tasks WHERE employee_id = ? AND date = ?");
                    pstmt.setString(1, employeeId);
                    pstmt.setString(2, todayString);
                    ResultSet rs = pstmt.executeQuery();
                    while (rs.next()) {
            %>
            <tr>
                <td><%= rs.getString("task_name") %></td>
                <td><%= rs.getDate("date") %></td>
                <td><%= rs.getTime("start_time") %></td>
                <td><%= rs.getTime("end_time") %></td>
                <td><%= rs.getString("description") %></td>
                <td><%= rs.getDouble("duration") %></td>
                <td style="display: flex;">
                    <a href="update_task.jsp?employee_id=<%= rs.getInt("employee_id") %>&date=<%= rs.getString("date") %>&start_time=<%= rs.getString("start_time") %>&task_name=<%= rs.getString("task_name") %>&end_time=<%= rs.getString("end_time") %>&description=<%= rs.getString("description") %>&duration=<%= rs.getString("duration") %>">
                        <button class="update-button">Update</button>
                    </a>
                    <a href="delete_task.jsp?employee_id=<%= rs.getInt("employee_id") %>&date=<%= rs.getString("date") %>&start_time=<%= rs.getString("start_time") %>&end_time=<%= rs.getString("end_time") %>&task_name=<%= rs.getString("task_name") %>" onclick="return confirm('Are you sure?')">
                        <button class="delete-button">Delete</button>
                    </a>
                </td>
            </tr>
            <% 
                    }
                    con.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>
        </table>
    </div>
</body>
</html>
