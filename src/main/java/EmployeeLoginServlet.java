import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.*;

@WebServlet("/EmployeeLoginServlet")
public class EmployeeLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String employeeId = request.getParameter("employee_id");
        String password = request.getParameter("password");
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            // Get connection from DatabaseConnection class
            conn = DatabaseConnection.getConnection();
            
            String sql = "SELECT * FROM Employee WHERE employee_id = ? AND password = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, employeeId);
            pstmt.setString(2, password);
            
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                // Employee exists with provided credentials
                // Retrieve employee details
                int empId = rs.getInt("employee_id");
                String name = rs.getString("name");
                String role = rs.getString("role");
                String project = rs.getString("project");
                
                // Store employee details in session
                HttpSession session = request.getSession();
                session.setAttribute("employeeId", empId);
                session.setAttribute("name", name);
                session.setAttribute("role", role);
                session.setAttribute("project", project);
                
                // Redirect to dashboard
                response.sendRedirect("dashboard.jsp");
            } else {
                // Invalid credentials, redirect back to login page with error message
                response.sendRedirect("EmployeeLogin.jsp?error=1");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
