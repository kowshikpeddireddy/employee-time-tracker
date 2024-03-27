import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.*;
import java.time.LocalDate;

@WebServlet("/ViewTasksServlet")
public class ViewTasksServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String timePeriod = request.getParameter("timePeriod");
        int employeeId = Integer.parseInt(request.getParameter("employeeId")); // Assuming you have the employeeId in session

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet resultSet = null;
        
        try {
            // Get connection from DatabaseConnection class
            conn = DatabaseConnection.getConnection();
            
            // Query tasks based on the selected time period
            String sql = "SELECT task_name, duration FROM Tasks WHERE employee_id = ? AND date >= ?";
            
            // Set start date based on the selected time period
            LocalDate startDate = null;
            if (timePeriod.equals("daily")) {
                startDate = LocalDate.now();
            } else if (timePeriod.equals("weekly")) {
                startDate = LocalDate.now().minusDays(7);
            } else if (timePeriod.equals("monthly")) {
                startDate = LocalDate.now().minusDays(30);
            }
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, employeeId);
            pstmt.setDate(2, java.sql.Date.valueOf(startDate));
            
            resultSet = pstmt.executeQuery();
            
            // Set tasks data as a request attribute
            request.setAttribute("tasksResultSet", resultSet);
            
            // Forward the request to the JSP file
            RequestDispatcher dispatcher = request.getRequestDispatcher("/view.jsp");
            dispatcher.forward(request, response);
            
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "SQL error occurred.");
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Invalid employee ID format.");
        } finally {
            try {
                if (resultSet != null) resultSet.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
