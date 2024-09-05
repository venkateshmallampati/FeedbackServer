package myclgproject;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/Find")
public class Find extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Connection con = null;
        try {
            // Set response content type
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            con = DBConnect.connect();

            // Get subject parameter from request
            String subject = request.getParameter("subjects");
            String academicyear = request.getParameter("academicyear");
            if (academicyear == null || academicyear.isEmpty()) {
                out.println("Academic year not specified.");
                return;
            }


            // Define the units and categories you want to count
            String[] units = {"co1", "co2", "co3", "co4", "co5"};
            String[] categories = {"poor", "average", "good", "excellent"};

            // Create a map to store counts for each unit and category
            Map<String, Map<String, Integer>> unitCategoryCounts = new HashMap<>();

            // Loop through units and categories to retrieve counts
            for (String unit : units) {
                Map<String, Integer> categoryCounts = new HashMap<>();

                for (String category : categories) {
                    String query = "SELECT COUNT(*) FROM subjects" + academicyear + " WHERE subject = ? AND " + unit + " = ?;";
                    PreparedStatement st = con.prepareStatement(query);
                    st.setString(1, subject);
                    st.setString(2, category);

                    ResultSet rst = st.executeQuery();

                    if (rst.next()) {
                        int count = rst.getInt(1);
                        categoryCounts.put(category, count);
                    }
                }

                unitCategoryCounts.put(unit, categoryCounts);
            }

            // Generate HTML output
            out.println("<html><head><title>Pie Charts</title><style>");
            out.println("#div1{color: black;text-align: center;float: left;margin-left: 100px;}");
            out.println("#div2{margin-left: 130px;float: left;}");
            out.println("table {width: 30%;border-collapse: collapse;margin: auto;font-size: 18px;}");
            out.println("table, th, td {border: 2px solid black;}");
            out.println("th, td {padding: 15px;text-align: left;}");
            out.println("th {background-color: #f2f2f2;}</style>");
            out.println("<script type='text/javascript' src='https://www.gstatic.com/charts/loader.js'></script>");
            out.println("<script type='text/javascript' src='https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js'></script>");
            out.println("<script type='text/javascript' src='https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.4.0/jspdf.umd.min.js'></script>");
            out.println("<script type='text/javascript'>");
            out.println("google.charts.load('current', {'packages':['corechart']});");
            out.println("google.charts.setOnLoadCallback(drawCharts);");
            out.println("function drawCharts() {");

            // Define the order of units
            String[] units1 = {"co1", "co2", "co3", "co4", "co5"};

            // Loop through units and draw charts
            out.println("var options = {width: 400, height: 300};");
            out.println("var data;");
            for (int i = 0; i < units1.length; i++) {
                String unit = units1[i];
                out.println("data = google.visualization.arrayToDataTable([['Category', 'Count'],");
                Map<String, Integer> categoryCounts = unitCategoryCounts.get(unit);
                for (String category : categoryCounts.keySet()) {
                    out.println("['" + category + "', " + categoryCounts.get(category) + "],");
                }
                out.println("]);");
                out.println("var chart = new google.visualization.PieChart(document.getElementById('chart_" + unit + "'));");
                out.println("chart.draw(data, options);");
                out.println("chart.draw(data, {title: '" + unit + "', width: 400, height: 300,titleTextStyle: {fontSize: 20}});");

            }

            out.println("}");
            out.println("</script></head>");

            // Display divs for charts with headings
            out.println("<body><br><br>");
            out.println("<div id='content' style='border: 2px solid black; padding: 20px; margin:50px;'>");
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

            // Display the table
            out.println("<center><h1 style=\"text-decoration: underline;\">" + subject + "</h1><br>");
            out.println("<table border='1'>");
            out.println("<tr><th>Unit</th><th>Poor</th><th>Average</th><th>Good</th><th>Excellent</th></tr>");

            for (String unit : units) {
                out.println("<tr><td>" + unit + "</td>");

                Map<String, Integer> categoryCounts = unitCategoryCounts.get(unit);

                for (String category : categories) {
                    out.println("<td>" + categoryCounts.getOrDefault(category, 0) + "</td>");
                }

                out.println("</tr>");
            }

            out.println("</table></center>");

            // Provide the download option for the retrieved data
            out.println("<br><br><center><button onclick='downloadPDF()' style='margin-top: 20px; padding: 10px 20px; font-size: 16px; background-color: #007bff; color: white; border: none; border-radius: 5px; cursor: pointer;'>Download as PDF</button></center><br><br>");
            
            out.println("<script>");
            out.println("function downloadPDF() {");
            out.println("    // Hide the download button before capturing");
            out.println("    document.querySelector('button').style.display = 'none';");
            out.println("    html2canvas(document.getElementById('content')).then(canvas => {");
            out.println("        const imgData = canvas.toDataURL('image/png');");
            out.println("        const { jsPDF } = window.jspdf;");
            out.println("        const pdf = new jsPDF();");
            out.println("        pdf.addImage(imgData, 'PNG', 10, 10, 190, 0);");
            out.println("        pdf.save('page.pdf');");
            out.println("        // Show the button again after capturing");
            out.println("        document.querySelector('button').style.display = 'block';");
            out.println("    });");
            out.println("}");
            out.println("</script>");

            // Display divs for charts with headings
            out.println("<div style='display: flex; justify-content: center;'>");
            out.println("<div style='display:flex; flex-direction:row;'>");
            for (int i = 0; i < 3; i++) {
                String unit = units1[i];
                out.println("<div style='text-align: center;'>");
                out.println("<div id='chart_" + unit + "' style='width: 400px; height: 300px;'></div>");
                out.println("</div>");
            }
            out.println("</div>");
            out.println("</div>");
            out.println("<div style='display: flex; justify-content: center;'>");
            out.println("<div style='display:flex; flex-direction:row;'>");
            for (int i = 3; i < 5; i++) {
                String unit = units1[i];
                out.println("<div style='text-align: center;'>");
                out.println("<div id='chart_" + unit + "' style='width: 400px; height: 300px;'></div>");
                out.println("</div>");
            }
            out.println("</div>");
            out.println("</div>");
            out.println("</div>");
            out.println("</body></html>");

        } catch (Exception e) {
            // Log the exception for debugging purposes
            e.printStackTrace();
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            out.println("An error occurred: " + e.getMessage());
        } finally {
            // Close resources in a finally block
            if (con != null) {
                try {
                    con.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
