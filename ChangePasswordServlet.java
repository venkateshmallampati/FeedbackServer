package myclgproject;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ChangePasswordServlet")
public class ChangePasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String userId = request.getParameter("userId");
        String newPassword = request.getParameter("newPassword");

        Connection con = null;
        PreparedStatement ps = null;

        try {
            con = DBConnect.connect(); // Assuming DBConnect.connect() returns a valid DB connection
            String updateQuery = "UPDATE faculty_login_table SET fac_pwd = ? WHERE fac_id = ?";

            ps = con.prepareStatement(updateQuery);
            ps.setString(1, newPassword);
            ps.setString(2, userId);

            int rowsUpdated = ps.executeUpdate();

            response.setContentType("text/html");
            PrintWriter out = response.getWriter();

            if (rowsUpdated > 0) {
                out.println("<html><body><center><img src=\"completed.jpg\" style=\"height:400px\"><h3>Password updated successfully!</h3></center></body></html>");
            } else {
                out.println("<html><body><center><h3>User ID not found or password update failed!</h3></center></body></html>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            out.println("<html><body><center><h3>An error occurred: " + e.getMessage() + "</h3></center></body></html>");
        } finally {
            try {
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
