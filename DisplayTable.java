package myclgproject;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/DisplayTable")
public class DisplayTable extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final String DB_URL = "jdbc:mysql://localhost:3306/mydatabase";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = ""; // Update with your actual database password

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    private void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // Load the MySQL JDBC driver
            try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                 PreparedStatement preparedStatement = connection.prepareStatement("SELECT * FROM survey_responses");
                 ResultSet resultSet = preparedStatement.executeQuery()) {

                response.setContentType("text/html");
                PrintWriter out = response.getWriter();

                out.println("<html><head><style>"
                            + "table { border-collapse: collapse; width: 100%; }"
                		    +".btn-submit {background-color: #007bff; color: #fff; border: none; padding: 10px 15px; cursor: pointer;border-radius: 5px font-size: 16px;  transition: background-color 0.3s ease;}"
                            +".btn-submit:hover {background-color: #0056b3;}"
                            + "th, td { text-align: left; padding: 8px; }"
                            + "th { background-color: #f2f2f2; }"
                            + "tr:nth-child(even) { background-color: #f2f2f2; }"
                            + "</style></head><body>");
                out.println("<table>");
                out.println("<tr><th>Name</th><th>ID</th><th>Duration</th><th>Placement Status</th><th>PG plans</th><th>Q1</th><th>Q2</th><th>Q3</th><th>Q4</th><th>Q5</th><th>Q6</th><th>Q7</th><th>Q8</th><th>Q9</th><th>Q10</th><th>Q11</th><th>Q12</th><th>Q13</th><th>Q14</th><th>Q15</th><th>Q16</th><th>Q17</th><th>Q18</th><th>Q19</th><th>Q20</th></tr>");

                while (resultSet.next()) {
                    out.println("<tr>");
                    out.println("<td>" + resultSet.getString("name") + "</td>");
                    out.println("<td>" + resultSet.getString("id") + "</td>");
                    out.println("<td>" + resultSet.getString("Duration") + "</td>");
                    out.println("<td>" + resultSet.getString("Ps") + "</td>");
                    out.println("<td>" + resultSet.getString("pgp") + "</td>");
                    out.println("<td>" + resultSet.getString("Q1") + "</td>");
                    out.println("<td>" + resultSet.getString("Q2") + "</td>");
                    out.println("<td>" + resultSet.getString("Q3") + "</td>");
                    out.println("<td>" + resultSet.getString("Q4") + "</td>");
                    out.println("<td>" + resultSet.getString("Q5") + "</td>");
                    out.println("<td>" + resultSet.getString("Q6") + "</td>");
                    out.println("<td>" + resultSet.getString("Q7") + "</td>");
                    out.println("<td>" + resultSet.getString("Q8") + "</td>");
                    out.println("<td>" + resultSet.getString("Q9") + "</td>");
                    out.println("<td>" + resultSet.getString("Q10") + "</td>");
                    out.println("<td>" + resultSet.getString("Q11") + "</td>");
                    out.println("<td>" + resultSet.getString("Q12") + "</td>");
                    out.println("<td>" + resultSet.getString("Q13") + "</td>");
                    out.println("<td>" + resultSet.getString("Q14") + "</td>");
                    out.println("<td>" + resultSet.getString("Q15") + "</td>");
                    out.println("<td>" + resultSet.getString("Q16") + "</td>");
                    out.println("<td>" + resultSet.getString("Q17") + "</td>");
                    out.println("<td>" + resultSet.getString("Q18") + "</td>");
                    out.println("<td>" + resultSet.getString("Q19") + "</td>");
                    out.println("<td>" + resultSet.getString("exp") + "</td>");
                    out.println("</tr>");
                }
                out.println("</table><br>");

                // Adding a button to redirect to DisplaySurveyResponses page
                out.println("<br><center><a href=\"DisplaySurveyResponses\"><button class='btn-submit'> Survey Report </button></a></center>");

                out.println("</body></html>");
            }
        } catch (ClassNotFoundException | SQLException e) {
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            out.println("Error: " + e.getMessage());
            e.printStackTrace();
        }
    }
}

