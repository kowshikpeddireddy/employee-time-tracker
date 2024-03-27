<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*"%>
<%
    response.setHeader("Cache-Control","no-store");
    response.setHeader("Pragma","no-cache"); 
    response.setHeader ("Expires", "0"); //prevents caching at the proxy server
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Task Process</title>
    <style> 
        
    </style>
</head>
<body>
<%
    String employee_id = request.getParameter("employee_id");
    String date = request.getParameter("date");
    String start_time = request.getParameter("start_time");
    String task_name = request.getParameter("task_name");
    String end_time = request.getParameter("end_time");
    String description = request.getParameter("description");
    String duration = request.getParameter("duration");

    Connection conn = null;
    PreparedStatement pstmt = null;
    
    try {
        // Establish database connection
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/employee_time_track", "root", "6303");
        
        // Check for overlapping tasks
        String checkOverlapSql = "SELECT COUNT(*) FROM tasks WHERE employee_id = ? AND date = ? AND ((start_time < ? AND end_time > ?) OR (start_time < ? AND end_time > ?) OR (start_time >= ? AND end_time <= ?)) AND task_name != ?";
        pstmt = conn.prepareStatement(checkOverlapSql);
        pstmt.setString(1, employee_id);
        pstmt.setString(2, date);
        pstmt.setString(3, end_time);
        pstmt.setString(4, start_time);
        pstmt.setString(5, end_time);
        pstmt.setString(6, start_time);
        pstmt.setString(7, start_time);
        pstmt.setString(8, end_time);
        pstmt.setString(9, task_name);
        
        ResultSet overlapResult = pstmt.executeQuery();
        overlapResult.next();
        int overlapCount = overlapResult.getInt(1);
        
        // If there are overlapping tasks, display an error message
        if (overlapCount > 0) {
            out.println("<h2>Error: There are overlapping tasks. Please adjust the task time.</h2>");
            return;
        }
        
        // Prepare SQL statement for updating the task
        String sql = "UPDATE tasks SET end_time=?, description=?, duration=? WHERE employee_id=? AND date=? AND start_time=? AND task_name=?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, end_time);
        pstmt.setString(2, description);
        pstmt.setString(3, duration);
        pstmt.setString(4, employee_id);
        pstmt.setString(5, date);
        pstmt.setString(6, start_time);
        pstmt.setString(7, task_name);
        
        // Execute the update statement
        int rowsAffected = pstmt.executeUpdate();
        
        // Check if the task was successfully updated
        if (rowsAffected > 0) {
            out.println("<h2>Task updated successfully!</h2>");
        } else {
            out.println("<h2>Failed to update task. Please try again.</h2>");
        }
    } catch (ClassNotFoundException | SQLException e) {
        e.printStackTrace();
        out.println("<h2>Error occurred while updating task: " + e.getMessage() + "</h2>");
    } finally {
        // Close resources
        try {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
</body>
</html>
