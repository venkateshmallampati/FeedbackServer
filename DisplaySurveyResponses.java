package myclgproject;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/DisplaySurveyResponses")
public class DisplaySurveyResponses extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final String DB_URL = "jdbc:mysql://localhost:3306/mydatabase";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            // Retrieve data from the database and generate pie chart
            generatePieChart(response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            out.println("Error: " + e.getMessage());
        }
    }

    // Define a method to retrieve survey response data and generate pie chart
    private void generatePieChart(HttpServletResponse response) throws SQLException, IOException {
        Map<String, Integer> counts = new HashMap<>();

        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "SELECT * FROM survey_responses";
            try (PreparedStatement preparedStatement = connection.prepareStatement(sql);
                 ResultSet resultSet = preparedStatement.executeQuery()) {

                // Loop through the result set and populate counts
                while (resultSet.next()) {
                    for (int i = 1; i <= 19; i++) {
                        String option = resultSet.getString("Q" + i);
                        counts.put(option, counts.getOrDefault(option, 0) + 1);
                    }
                }
            }
        } catch (SQLException e) {
            throw e; // Rethrow the exception for handling in the calling method
        }

        // Generate the pie chart HTML
        generateChart(response, counts);
    }

    // Define a method to generate the pie chart HTML
    private void generateChart(HttpServletResponse response, Map<String, Integer> counts)
            throws IOException {
        PrintWriter out = response.getWriter();
        out.println("<!DOCTYPE html>");
        out.println("<html>");
        out.println("<head>");
        out.println("<title>Survey Responses</title>");
        out.println("<script type='text/javascript' src='https://www.gstatic.com/charts/loader.js'></script>");
        out.println("<script type='text/javascript'>");
        out.println("google.charts.load('current', {'packages':['corechart']});");
        out.println("google.charts.setOnLoadCallback(drawChart);");
        out.println("function drawChart() {");

        out.println("var data = new google.visualization.DataTable();");
        out.println("data.addColumn('string', 'Response');");
        out.println("data.addColumn('number', 'Count');");
        out.println("data.addRows([");
        for (Map.Entry<String, Integer> entry : counts.entrySet()) {
            out.println("['" + entry.getKey() + "', " + entry.getValue() + "],");
        }
        out.println("]);");

        out.println("var options = {");
        out.println("title: 'Survey Responses',");
        out.println("width: 800,");
        out.println("height: 600,");
        out.println("titleTextStyle: {");
        out.println("color: 'black',");
        out.println("fontSize: 40");
        out.println("},");
        out.println("pieSliceTextStyle: {");
        out.println("fontSize: 15");
        out.println("}");
        out.println("};");
        out.println("var chart = new google.visualization.PieChart(document.getElementById('piechart'));");
        out.println("chart.draw(data, options);");

        out.println("}");
        out.println("</script>");
        out.println("</head>");
        out.println("<body background='vvit.jpg'><center>");
        out.println("<div id='piechart' ></div>");
        out.println("</center></body>");
        out.println("</html>");
    }
}
