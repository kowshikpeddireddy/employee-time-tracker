import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.*;

@WebServlet("/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet resultSet = null;

        try {
        	conn = DatabaseConnection.getConnection();
            
            String sql = "SELECT * FROM admin WHERE username = ? AND password = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            pstmt.setString(2, password);

            resultSet = pstmt.executeQuery();

            if (resultSet.next()) {
                // Admin credentials are correct, redirect to admin dashboard
                HttpSession session = request.getSession();
                session.setAttribute("adminUsername", username);
                response.sendRedirect("admin_dashboard.jsp");
            } else {
                // Admin credentials are incorrect, redirect back to login page with error message
                response.sendRedirect("admin_login.jsp?error=invalid");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle database errors
            response.sendRedirect("admin_login.jsp?error=db");
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
