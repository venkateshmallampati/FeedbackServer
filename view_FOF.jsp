<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet, java.util.List, java.util.ArrayList" %>
<%@ page import="myclgproject.DBConnect" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>View Feedback</title>
    <style>
        table {
            margin: auto;
            width: 100%;
            border-collapse: collapse;
            font-size: 18px;
        }

        th, td {
            padding: 12px 15px;
            text-align: left;
            border: 1px solid #ddd;
        }

        th {
            background-color: #f4f4f4;
            color: #333;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        input[type=text], [type=file], [type=password] {  
            width: 100%;
            padding: 12px 20px;
            margin: 0px 10px;
            display: inline-block;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        #div1 {
            color: black;
            text-align: center;
            float: left;
            margin-left: 150px;
        }

        #div2 {
            margin-left: 150px;
            float: left;
        }

        #div3 {
            margin: auto;
            text-align: center;
            color: black;
            width: 450px;
            height: 350px;
            background-color: ghostwhite;
            border: 1px solid;
        }

        .but {
            padding: 10px 20px; 
            background-color: cornflowerblue; 
            border-radius: 10px;
            margin-top: 30px;
            color: white;
            border: none;
            cursor: pointer;
        }

        h1 {
            font-family: Arial, Helvetica, sans-serif;
            margin: 10px 0;
            font-size: 36px;
        }

        h5 {
            font-family: Arial, Helvetica, sans-serif;
            margin: 10px 0;
            font-size: 16px;
        }

        select {
            margin-top: 10px;
            margin-left: 40px;
            padding: 5px;
            color: green;
        }
    </style>
</head>
<body background="vvit.jpg">
<div id="div2">
    <img src="vvitlogo.jpg" style="width:120px;height:120px;">
</div>
<div id="div1">
    <center>
        <h1>Vasireddy Venkatadri Institute of Technology</h1>
        <h5>Approved by AICTE - Permanently Affiliated to JNTUK - ISO 9001-2015 Certified<br>Accredited by NAAC with 'A'Grade - B.Tech ECE, MECH, CSE, EEE & IT are accredited by NBA</h5>
    </center>
</div>
<div>
    <center>
        <img src="nba.jpg" style="width:100px;height:100px;">
        <img src="naac.jpg" style="width:100px;height:100px;">
    </center>
    <br>
    <br>
    <div id="div3">
        <center>
            <h2 align="center" style="padding: 15px;text-decoration: underline;">Feedback On Faculty</h2><br>
            <form action="Feedback_Calculate" method="post">
                <div class="container">
                    
                    <%
                        String fid = request.getParameter("fid");
                        if (fid != null && !fid.isEmpty()) {
                            Connection con = null;
                            PreparedStatement ps = null;
                            ResultSet rs = null;
                            try {
                                con = DBConnect.connect();

                                // Query to retrieve sections and subjects for the given fid
                                String query = "SELECT sec, sub FROM faculty WHERE fid = ?";
                                ps = con.prepareStatement(query);
                                ps.setString(1, fid);
                                rs = ps.executeQuery();

                                // List to store combined section and subject
                                List<String> combinedOptions = new ArrayList<>();
                                
                                while (rs.next()) {
                                    String section = rs.getString("sec");
                                    String subject = rs.getString("sub");
                                    combinedOptions.add(section + " - " + subject);
                                }
                    %>
                    <input type="hidden" name="fid" value="<%= fid %>">
                    <label for="combined" style="font-size:20px">  Select Section - Subject:</label><br><br>
                    <select id="combined" name="combined">
                        <option >- - - - - - -  Select  - - - - - - - </option>
                        <option value="All">All</option>
                        <%
                            for (String option : combinedOptions) {
                        %>
                            <option value="<%= option %>"><%= option %></option>
                        <%
                            }
                        %>
                    </select>

                    <br>
                    <button type="submit" class="but">Submit</button>
                    <%
                            } catch (Exception e) {
                                e.printStackTrace();
                                out.println("<p>An error occurred: " + e.getMessage() + "</p>");
                            } finally {
                                try { if (rs != null) rs.close(); } catch (Exception e) { e.printStackTrace(); }
                                try { if (ps != null) ps.close(); } catch (Exception e) { e.printStackTrace(); }
                                try { if (con != null) con.close(); } catch (Exception e) { e.printStackTrace(); }
                            }
                        } else {
                            out.println("<p>Faculty ID not provided.</p>");
                        }
                    %>
                </div>
            </form>
        </center>
    </div>
</div>
</body>
</html>
