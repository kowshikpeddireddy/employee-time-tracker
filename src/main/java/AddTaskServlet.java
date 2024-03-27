import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.*;

@WebServlet("/AddTaskServlet")
public class AddTaskServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String taskName = request.getParameter("taskType");
        String date = request.getParameter("date");
        String startTime = request.getParameter("startTime");
        String endTime = request.getParameter("endTime");
        String description = request.getParameter("description");
        int employeeId = Integer.parseInt(request.getParameter("employeeId")); // Parse employeeId from request parameter
        String duration = request.getParameter("duration"); // Get duration from request parameter
        
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
        	conn = DatabaseConnection.getConnection();
            
            // Check if there are any existing tasks that overlap with the specified start and end times
            String checkOverlapSql = "SELECT COUNT(*) FROM Tasks WHERE employee_id = ? AND date = ? AND ((start_time < ? AND end_time > ?) OR (start_time < ? AND end_time > ?) OR (start_time >= ? AND end_time <= ?))";
            PreparedStatement checkOverlapStmt = conn.prepareStatement(checkOverlapSql);
            checkOverlapStmt.setInt(1, employeeId);
            checkOverlapStmt.setString(2, date);
            checkOverlapStmt.setString(3, endTime);
            checkOverlapStmt.setString(4, startTime);
            checkOverlapStmt.setString(5, endTime);
            checkOverlapStmt.setString(6, startTime);
            checkOverlapStmt.setString(7, endTime);
            checkOverlapStmt.setString(8, taskName);

            ResultSet resultSet = checkOverlapStmt.executeQuery();
            resultSet.next(); // Move cursor to the first row
            int count = resultSet.getInt(1); // Get the count of overlapping tasks
            
            if (count > 0) {
                // Overlapping task found, redirect back to dashboard with error message
                response.sendRedirect("dashboard.jsp?error=overlap");
                return; // Exit from the method
            }
            
            // No overlapping task found, proceed with adding the task
            
            String sql = "INSERT INTO Tasks (employee_id, task_name, date, start_time, end_time, description, duration) VALUES (?,?, ?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, employeeId); // Set employeeId in the prepared statement
            pstmt.setString(2, taskName);
            pstmt.setString(3, date);
            pstmt.setString(4, startTime);
            pstmt.setString(5, endTime);
            pstmt.setString(6, description);
            pstmt.setString(7, duration); // Set duration in the prepared statement

            int rowsAffected = pstmt.executeUpdate();
            
            if (rowsAffected > 0) {
                // Task added successfully, redirect back to dashboard
                response.sendRedirect("dashboard.jsp?success=true");
            } else {
                // Error adding task, redirect back to dashboard with error message
                response.sendRedirect("dashboard.jsp?error=1");
            }
        } catch (SQLException | NumberFormatException e) {
            e.printStackTrace();
            // Handle errors
            response.sendRedirect("dashboard.jsp?error=1");
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
