import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.*;

@WebServlet("/AdminDashboardServlet")
public class AdminDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String employeeId = request.getParameter("employeeId");

        

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet resultSet = null;

        try {
        	conn = DatabaseConnection.getConnection();

            // Prepare SQL statement to retrieve user activity based on employee ID
            String sql = "SELECT task_name, date, start_time, end_time, description, duration FROM Tasks WHERE employee_id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, employeeId);

            // Execute the query
            resultSet = pstmt.executeQuery();

            // Set the result set as a request attribute to be accessed in the JSP
            request.setAttribute("userActivityResultSet", resultSet);

            // Forward the request to the admin_dashboard.jsp for displaying user activity
            RequestDispatcher dispatcher = request.getRequestDispatcher("admin_dashboard.jsp");
            dispatcher.forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle errors
            response.sendRedirect("error.jsp");
        } finally {
            // Close resources in the finally block
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
