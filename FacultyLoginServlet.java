package myclgproject;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/FacultyLoginServlet")
public class FacultyLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        HttpSession session = request.getSession();

        try {
            conn = DBConnect.connect();
            
            int faculty_id = Integer.parseInt(request.getParameter("fid"));
            String user_pwd = request.getParameter("pwd");

            String query = "SELECT * FROM faculty_login_table WHERE fac_id = ? AND fac_pwd = ?";
            pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, faculty_id);
            pstmt.setString(2, user_pwd);

            rs = pstmt.executeQuery();

            if (rs.next()) {
            	session.setAttribute("fid",faculty_id);
                session.setAttribute("fname", rs.getString("fac_name"));
                request.getRequestDispatcher("faculty_display.jsp").forward(request, response);
            } else {
                response.getWriter().println("Invalid credentials. Please try again.");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("An error occurred: " + e.getMessage());
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) { e.printStackTrace(); }
            try { if (pstmt != null) pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
        }
    }
}
