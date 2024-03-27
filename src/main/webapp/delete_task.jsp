<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    response.setHeader("Cache-Control","no-store");
    response.setHeader("Pragma","no-cache"); 
    response.setHeader ("Expires", "0"); //prevents caching at the proxy server
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Delete Task</title>
    <script>
        // Function to display an alert box with a message
        function showAlert(message) {
            alert(message);
            // Redirect back to the previous page after displaying the alert
            window.history.back();
        }
    </script>
</head>
<body>
<%
    // Get parameters from the request
    String employeeId = request.getParameter("employee_id");
    String date = request.getParameter("date");
    String startTime = request.getParameter("start_time");
    String endTime = request.getParameter("end_time");
    String taskName = request.getParameter("task_name");

    Connection conn = null;
    PreparedStatement pstmt = null;
    
    try {
        // Establish database connection
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/employee_time_track", "root", "6303");
        
        // Prepare SQL statement for deleting the task
        String sql = "DELETE FROM tasks WHERE employee_id=? AND date=? AND start_time=? AND end_time=? AND task_name=?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, employeeId);
        pstmt.setString(2, date);
        pstmt.setString(3, startTime);
        pstmt.setString(4, endTime);
        pstmt.setString(5, taskName);
        
        // Execute the delete statement
        int rowsAffected = pstmt.executeUpdate();
        
        // Check if the task was successfully deleted
        if (rowsAffected > 0) {
            out.println("<script>showAlert('Task deleted successfully!');</script>");
        } else {
            out.println("<script>showAlert('Failed to delete task. Please try again.');</script>");
        }
    } catch (ClassNotFoundException | SQLException e) {
        e.printStackTrace();
        out.println("<script>showAlert('Error occurred while deleting task: " + e.getMessage() + "');</script>");
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
