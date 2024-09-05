<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.Connection, java.sql.Statement, java.sql.ResultSet, java.util.List, java.util.ArrayList" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="myclgproject.DBConnect" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>View Feedback</title>
    <style>
        /* Your existing styles */
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
            width: 500px;
            height: 400px;
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
                <form action="HOD_view_FOF.jsp" method="get">
                    <div class="container">
                        <%
                            String department = request.getParameter("department");
                            if (department != null && !department.isEmpty()) {
                                Connection con = null;
                                Statement stmt = null;
                                ResultSet rs = null;
                                try {
                                    con = DBConnect.connect();
                                    String query = "SELECT fac_name, fac_id FROM " + department;
                                    stmt = con.createStatement();
                                    rs = stmt.executeQuery(query);
                                    List<String> combinedOptions = new ArrayList<>();
                                    while (rs.next()) {
                                        String fac_name = rs.getString("fac_name");
                                        String fac_id = rs.getString("fac_id");
                                        combinedOptions.add(fac_name + " - " + fac_id);
                                    }
                        %>
                        <input type="hidden" name="department" value="<%= department %>">
                        <label for="combined" style="font-size:20px">Select Faculty - ID:</label><br><br>
                        <select id="combined" name="combined" onchange="this.form.submit()">
                            <option value="">- - - - - - - Select - - - - - - -</option>
                            <%
                                for (String option : combinedOptions) {
                            %>
                            <option value="<%= option %>" <%= request.getParameter("combined") != null && request.getParameter("combined").equals(option) ? "selected" : "" %>><%= option %></option>
                            <%
                                }
                            %>
                        </select>
                        <%
                                } catch (Exception e) {
                                    e.printStackTrace();
                                    out.println("<p>An error occurred: " + e.getMessage() + "</p>");
                                } finally {
                                    try { if (rs != null) rs.close(); } catch (Exception e) { e.printStackTrace(); }
                                    try { if (stmt != null) stmt.close(); } catch (Exception e) { e.printStackTrace(); }
                                    try { if (con != null) con.close(); } catch (Exception e) { e.printStackTrace(); }
                                }
                            } else {
                                out.println("<p>Department not provided.</p>");
                            }
                        %>
                    </div>
                </form>
                
                <%
                    String fid = request.getParameter("combined");
                    if (fid != null && !fid.isEmpty() && !fid.equals("")) {
                        String facultyId = fid.split(" - ")[1];
                        Connection con = null;
                        PreparedStatement ps = null;
                        ResultSet rs = null;
                        try {
                            con = DBConnect.connect();
                            String query = "SELECT sec, sub FROM faculty WHERE fid = ?";
                            ps = con.prepareStatement(query);
                            ps.setString(1, facultyId);
                            rs = ps.executeQuery();
                            List<String> sectionSubjectOptions = new ArrayList<>();
                            while (rs.next()) {
                                String section = rs.getString("sec");
                                String subject = rs.getString("sub");
                                sectionSubjectOptions.add(section + " - " + subject);
                            }
                %>
                <form action="Feedback_Calculate" method="post"><br><br>
                    <input type="hidden" name="fid" value="<%= facultyId %>">
                    <label for="sectionSubject" style="font-size:20px">Select Section - Subject:</label><br><br>
                    <select id="sectionSubject" name="combined">
                        <option>- - - - - - - Select - - - - - - -</option>
                        <option value="All">All</option>
                        <%
                            for (String option : sectionSubjectOptions) {
                        %>
                        <option value="<%= option %>"><%= option %></option>
                        <%
                            }
                        %>
                    </select>
                    <br>
                    <button type="submit" class="but">Submit</button>
                </form>
                <%
                        } catch (Exception e) {
                            e.printStackTrace();
                            out.println("<p>An error occurred: " + e.getMessage() + "</p>");
                        } finally {
                            try { if (rs != null) rs.close(); } catch (Exception e) { e.printStackTrace(); }
                            try { if (ps != null) ps.close(); } catch (Exception e) { e.printStackTrace(); }
                            try { if (con != null) con.close(); } catch (Exception e) { e.printStackTrace(); }
                        }
                    }
                %>
            </center>
        </div>
    </div>
</body>
</html>
