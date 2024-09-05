<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.SQLException, java.sql.ResultSet, java.sql.DatabaseMetaData" %>
<%@ page import="myclgproject.DBConnect" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Delete Department Table</title>
    <style>
        .container {
            width: 50%;
            margin: auto;
            text-align: center;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 10px;
            background-color: #f9f9f9;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .container h1 {
            font-size: 24px;
            margin-bottom: 20px;
        }

        .container label {
            font-size: 18px;
            display: block;
            margin-bottom: 10px;
        }

        .container input[type="text"] {
            width: 80%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .container button {
            padding: 10px 20px;
            background-color: cornflowerblue;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .container button:hover {
            background-color: darkblue;
        }

        .message {
            margin-top: 20px;
            font-size: 18px;
        }

        .error {
            color: red;
        }

        .success {
            color: green;
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
    </style>
    <script>
        function confirmDeletion() {
            return confirm("Are you sure you want to delete this table?");
        }
    </script>
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
        <br><br>
    <div class="container">
        <h1>Delete Department Table</h1>
        <form method="post" onsubmit="return confirmDeletion();">
            <label for="deptName">Department Name:</label>
            <input type="text" id="deptName" name="deptName" required><br>
            <center><button type="submit">Delete Table</button></center>
        </form>
        <div class="message">
            <%
                String status = request.getParameter("status");
                if (status != null) {
                    if ("success".equals(status)) {
                        out.println("<p class='success'>Table deleted successfully.</p>");
                    } else if ("failed".equals(status)) {
                        out.println("<p class='error'>Failed to delete table. Table may not exist.</p>");
                    } else if ("error".equals(status)) {
                        out.println("<p class='error'>An error occurred while deleting the table.</p>");
                    }
                }

                if ("POST".equalsIgnoreCase(request.getMethod())) {
                    String deptName = request.getParameter("deptName");
                    String tableName = deptName.replace(" ", "_"); // Convert department name to table name format

                    Connection con = null;
                    PreparedStatement ps = null;
                    ResultSet rs = null;

                    try {
                        con = DBConnect.connect();

                        // Check if the table exists
                        DatabaseMetaData dbMetaData = con.getMetaData();
                        rs = dbMetaData.getTables(null, null, tableName, null);

                        if (rs.next()) {
                            // Table exists, proceed with deletion
                            String deleteTableQuery = "DROP TABLE " + tableName;
                            ps = con.prepareStatement(deleteTableQuery);
                            ps.executeUpdate();
                            response.sendRedirect("delete_department.jsp?status=success");
                        } else {
                            // Table does not exist
                            response.sendRedirect("delete_department.jsp?status=failed");
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                        response.sendRedirect("delete_department.jsp?status=error");
                    } finally {
                        try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                        try { if (ps != null) ps.close(); } catch (SQLException e) { e.printStackTrace(); }
                        try { if (con != null) con.close(); } catch (SQLException e) { e.printStackTrace(); }
                    }
                }
            %>
        </div>
    </div>
</body>
</html>
