package myclgproject;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Feedback_Calculate")
public class Feedback_Calculate extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String fid = request.getParameter("fid");
        String combined = request.getParameter("combined");
        String section = null;
        String subject = null;
        String query = null;
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        // Check if "All" is selected
        if (!"All".equals(combined)) {
            // Split combined into section and subject
            String[] parts = combined.split(" - ");
            if (parts.length == 2) {
                section = parts[0];
                subject = parts[1];
            }
        }

        Connection conn = null;

        try {
            con = DBConnect.connect();
            conn = DBConnect.connect();
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            String qu = "SELECT fname FROM faculty WHERE fid = ?";
            ps = con.prepareStatement(qu);
            ps.setString(1, fid);
            rs = ps.executeQuery();
            if (!rs.next()) {
                out.println("<html><body><h3>No faculty found with ID " + fid + "</h3></body></html>");
                return;
            }

            String facultyName = rs.getString("fname");
            rs.close(); // Close the ResultSet

            // Define the units and categories you want to count
            String[] questions = {"q1", "q2", "q3", "q4", "q5", "q6", "q7", "q8", "q9", "q10", "q11", "q12", "q13", "q14", "q15"};
            String[] categories = {"5", "4", "3", "2", "1"};

            // Create a map to store counts for each unit and category
            Map<String, Map<String, Integer>> questionsCategoryCounts = new HashMap<>();
            Map<String, Integer> categoryTotals = new HashMap<>();
            Map<String, Integer> categoryCounts = new HashMap<>();

            // Initialize totals and counts for categories
            for (String category : categories) {
                categoryTotals.put(category, 0);
                categoryCounts.put(category, 0);
            }

            // Loop through units and categories to retrieve counts
            for (String unit : questions) {
                Map<String, Integer> categoryCountsForUnit = new HashMap<>();

                for (String category : categories) {
                    if (!"All".equals(combined)) {
                        query = "SELECT COUNT(*) FROM answers WHERE sec = ? AND fid = ? AND " + unit + " = ?;";
                    } else {
                        query = "SELECT COUNT(*) FROM answers WHERE fid = ? AND " + unit + " = ?;";
                    }
                    PreparedStatement st = con.prepareStatement(query);

                    if (!"All".equals(combined)) {
                        st.setString(1, section);
                        st.setString(2, fid);
                        st.setString(3, category);
                    } else {
                        st.setString(1, fid);
                        st.setString(2, category);
                    }
                    ResultSet rst = st.executeQuery();

                    if (rst.next()) {
                        int count = rst.getInt(1);
                        categoryCountsForUnit.put(category, count);

                        // Update totals and counts
                        categoryTotals.put(category, categoryTotals.get(category) + count);
                        categoryCounts.put(category, categoryCounts.get(category) + 1);
                    }
                }

                questionsCategoryCounts.put(unit, categoryCountsForUnit);
            }

            // Calculate averages
            Map<String, Double> categoryAverages = new HashMap<>();
            for (String category : categories) {
                int total = categoryTotals.get(category);
                int count = categoryCounts.get(category);
                double average = (count == 0) ? 0 : (double) total / count;
                categoryAverages.put(category, average);
            }

            // Calculate weighted average rating
            int totalResponses = 0;
            int totalScore = 0;
            for (String category : categories) {
                int categoryValue = Integer.parseInt(category);
                int count = categoryTotals.get(category);
                totalResponses += count;
                totalScore += count * categoryValue;
            }
            double weightedAverageRating = (totalResponses == 0) ? 0 : (double) totalScore / totalResponses;
            double percentage = weightedAverageRating / 5 * 100;

            out.println("<html><head><title>Pie Charts</title><style>");
            out.println("#div1{color: black;text-align: center;float: left;margin-left: 100px;}");
            out.println("#div2{margin-left: 130px;float: left;}");
            out.println("#header .label {font-weight: bold;font-size: 25px;}");
            out.println("#header .value {font-size: 18px;}");
            out.println("table {width: 35%;border-collapse: collapse;margin: auto;font-size: 17px;}");
            out.println("table, th, td {border: 2px solid black;}");
            out.println("th, td {padding: 8px;text-align: center;}");
            out.println("th {background-color: #f2f2f2;}</style>");
            out.println("<body><br><br>");
            out.println("<div id='content' style='border: 2px solid black; padding: 20px; margin: 2px 50px 50px 50px;'>");
            out.println("<div id=\"div2\">");
            out.println("<img src=\"vvitlogo.jpg\" style=\"width:120px;height:120px;\">");
            out.println("</div>");
            out.println("<div id=\"div1\">");
            out.println("<center>");
            out.println("<h1>Vasireddy Venkatadri Institute of Technology</h1>");
            out.println("<h5>Approved by AICTE - Permanently Affiliated to JNTUK - ISO 9001-2015 Certified<br>Accredited by NAAC with 'A'Grade - B.Tech ECE,MECH,CSE,EEE & IT are accredited by NBA</h5>");
            out.println("</center>");
            out.println("</div>");
            out.println("<div>");
            out.println("<center><img src=\"nba.jpg\" style=\"width:100px;height:100px;\"><img src=\"naac.jpg\" style=\"width:100px;height:100px;\"></center><br><br><br><br>");
            out.println("<div id=\"div3\">");
            out.println("<div id=\"header\">");

            out.println("<center><div><span class='label'>Faculty ID: </span> <span class='value'> " + fid + "</span></div><br>");
            
            out.println("<div><span class='label'>Faculty Name:  </span> <span class='value'>  " + facultyName + "</span></div><br>");
            
            out.println("<div><span class='label'>Section and Subject:  </span> <span class='value'>" + combined + "</span></div></center><br><br>");
            
            out.println("<center><div><span class='value'>Faculty Rating: </span> <span class='label'>" + String.format("%.2f", weightedAverageRating) + "</span></div></center><br>");
            out.println("<center><div><span class='value'>Percentage: </span> <span class='label'>" + String.format("%.2f", percentage) + "</span></div></center><br>");
            
            out.println("</div>");
            out.println("<table border='1'>");
            out.println("<tr><th>Questions</th><th>Excellent</th><th>Very Good</th><th>Good</th><th>Average</th><th>Poor</th></tr>");

            for (String unit : questions) {
                out.println("<tr><td>" + unit + "</td>");

                Map<String, Integer> categoryCountsForUnit = questionsCategoryCounts.get(unit);

                for (String category : categories) {
                    out.println("<td>" + categoryCountsForUnit.getOrDefault(category, 0) + "</td>");
                }

                out.println("</tr>");
            }

            out.println("</table></center>");
            
            out.println("<br><br><center><button onclick='downloadPDF()' style='margin-top: 20px; padding: 10px 20px; font-size: 16px; background-color: #007bff; color: white; border: none; border-radius: 5px; cursor: pointer;'>Download as PDF</button></center><br><br>");

            // Add scripts for Google Charts and PDF generation
            out.println("<script type='text/javascript' src='https://www.gstatic.com/charts/loader.js'></script>");
            out.println("<script type='text/javascript' src='https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js'></script>");
            out.println("<script type='text/javascript' src='https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.4.0/jspdf.umd.min.js'></script>");
            out.println("<script type='text/javascript'>");
            out.println("google.charts.load('current', {'packages':['corechart']});");
            out.println("google.charts.setOnLoadCallback(drawCharts);");
            out.println("function drawCharts() {");

            // Create the data table for the pie chart
            out.println("var data = google.visualization.arrayToDataTable([");
            out.println("['Category', 'Average'],");
            out.println("['Excellent (5)', " + categoryAverages.get("5") + "],");
            out.println("['Very Good (4)', " + categoryAverages.get("4") + "],");
            out.println("['Good (3)', " + categoryAverages.get("3") + "],");
            out.println("['Average (2)', " + categoryAverages.get("2") + "],");
            out.println("['Poor (1)', " + categoryAverages.get("1") + "]");
            out.println("]);");

            // Set chart options
            out.println("var options = {");
            out.println("title: 'Feedback Averages',");
            out.println("is3D: false,");  // Use 2D pie chart
            out.println("};");

            // Instantiate and draw the chart
            out.println("var chart = new google.visualization.PieChart(document.getElementById('piechart'));");
            out.println("chart.draw(data, options);");
            out.println("}");
            out.println("</script>");

            // Add a div to display the pie chart, centered using CSS
            out.println("<div style='display: flex; justify-content: center; align-items: center; height: 500px;'>");
            out.println("<div id='piechart' style='width: 900px; height: 500px;'></div>");
            out.println("</div>");
            
         

            // Add the script for downloading the content as a PDF
            out.println("<script type='text/javascript'>");
            out.println("function downloadPDF() {");
            out.println("    document.querySelector('button').style.display = 'none';");
            out.println("const { jsPDF } = window.jspdf;");
            out.println("html2canvas(document.body).then(canvas => {");
            out.println("const imgData = canvas.toDataURL('image/png');");
            out.println("const pdf = new jsPDF('p', 'mm', 'a4');");
            out.println("const imgProps = pdf.getImageProperties(imgData);");
            out.println("const pdfWidth = pdf.internal.pageSize.getWidth();");
            out.println("const pdfHeight = (imgProps.height * pdfWidth) / imgProps.width;");
            out.println("pdf.addImage(imgData, 'PNG', 0, 0, pdfWidth, pdfHeight);");
            out.println("pdf.save('feedback.pdf');");
            out.println("document.querySelector('button').style.display = 'block';");
            out.println("});");
            out.println("}");
            out.println("</script>");

        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            out.println("An error occurred: " + e.getMessage());
        }
    }
}
