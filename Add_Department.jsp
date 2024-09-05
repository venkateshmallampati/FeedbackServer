<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<%@ page import="myclgproject.DBConnect" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="style.css">
    <title>Create Department Table and Add Faculty</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            padding: 20px;
        }

        .container {
            width: 50%;
            margin: auto;
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }

        h2 {
            color: #333;
        }

        input[type=text] {
            width: 100%;
            padding: 10px;
            margin: 5px 0 15px 0;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        button {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 10px 20px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            margin: 4px 2px;
            cursor: pointer;
            border-radius: 4px;
        }

        button:hover {
            background-color: #45a049;
        }

        .form-group {
            margin-bottom: 15px;
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
        p{
          color: green;
        }
        #error{
        color: red;
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
        <br><br>
    <div class="container">
        <h2>Create Department and Add Faculty</h2>

        <form method="post" action="">
            <div class="form-group">
                <label for="departmentName">Department Name:</label>
                <input type="text" id="departmentName" name="departmentName" required>
            </div>

            <center><button type="submit" name="createTable">Create Table</button></center>
        </form>
        <%
            String departmentName = request.getParameter("departmentName");
            String departmentName2 = request.getParameter("departmentName2");
            String facultyName = request.getParameter("facultyName");
            String facultyId = request.getParameter("facultyId");

            // Handle creating the table
            if (request.getParameter("createTable") != null) {
                if (departmentName != null && !departmentName.isEmpty()) {
                    Connection con = null;
                    Statement stmt = null;

                    try {
                    	con = DBConnect.connect();
                    	stmt = con.createStatement();

                    	// Escape special characters and handle spaces in table names
                    	String safeDepartmentName = departmentName.replaceAll("[^a-zA-Z0-9]", "_");

                    	DatabaseMetaData dbMetaData = con.getMetaData();
                    	ResultSet tables = dbMetaData.getTables(null, null, safeDepartmentName, null);

                    	if (tables.next()) {
                    	    // Table already exists
                    	    out.println("<p id='error'>Table '" + safeDepartmentName + "' already exists.</p>");
                    	} else {
                    	    // Table does not exist, proceed with creation
                    	    String createTableQuery = "CREATE TABLE " + safeDepartmentName +
                    	            " (id VARCHAR(20), facultyName VARCHAR(255))";

                    	    stmt.executeUpdate(createTableQuery);
                    	    out.println("<p>Table '" + safeDepartmentName + "' created successfully.</p>");
                    	}



                    } catch (Exception e) {
                        e.printStackTrace();
                        out.println("<p>An error occurred: " + e.getMessage() + "</p>");
                    } finally {
                        try {
                            if (stmt != null) stmt.close();
                            if (con != null) con.close();
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }
                } else {
                    out.println("<p>Department name cannot be empty.</p>");
                }
            }
            %>
        <form method="post" action="">
            <div class="form-group">
                <label for="departmentName2">Department Name:</label>
                <input type="text" id="departmentName2" name="departmentName2" required>
            </div>
            <div class="form-group">
                <label for="facultyName">Faculty Name:</label>
                <input type="text" id="facultyName" name="facultyName" required>
            </div>
            <div class="form-group">
                <label for="facultyId">Faculty ID:</label>
                <input type="text" id="facultyId" name="facultyId" required>
            </div>

            <center><button type="submit" name="addFaculty">Add Faculty</button></center>
        </form>

        
        <%
            // Handle adding faculty
            if (request.getParameter("addFaculty") != null) {
                if (departmentName2 != null && !departmentName2.isEmpty() &&
                    facultyName != null && !facultyName.isEmpty() &&
                    facultyId != null && !facultyId.isEmpty()) {

                    Connection con = null;
                    PreparedStatement ps = null;

                    try {
                    	con = DBConnect.connect();

                    	// Escape special characters in the table name
                    	String safeDepartmentName2 = departmentName2.replaceAll("[^a-zA-Z0-9]", "_");

                    	// SQL query to check if the faculty already exists in the department table
                    	String checkFacultyQuery = "SELECT * FROM " + safeDepartmentName2 + " WHERE id = ? AND facultyName = ?";
                    	ps = con.prepareStatement(checkFacultyQuery);
                    	ps.setString(1, facultyId);
                    	ps.setString(2, facultyName);

                    	ResultSet rs = ps.executeQuery();

                    	if (rs.next()) {
                    	    // Faculty already exists
                    	    out.println("<p id='error'>Faculty '" + facultyName + "' with ID '" + facultyId + "' already exists in table '" + safeDepartmentName2 + "'.</p>");
                    	} else {
                    	    // Faculty does not exist, proceed with the insertion
                    	    String insertFacultyQuery = "INSERT INTO " + safeDepartmentName2 + " (id, facultyName) VALUES (?, ?)";
                    	    ps = con.prepareStatement(insertFacultyQuery);
                    	    ps.setString(1, facultyId);
                    	    ps.setString(2, facultyName);

                    	    int rowsAffected = ps.executeUpdate();

                    	    if (rowsAffected > 0) {
                    	        out.println("<p>Faculty '" + facultyName + "' added successfully to table '" + safeDepartmentName2 + "'.</p>");
                    	    } else {
                    	        out.println("<p id='error'>Failed to add faculty.</p>");
                    	    }
                    	}


                    } catch (Exception e) {
                        e.printStackTrace();
                        out.println("<p id='error'>An error occurred: " + e.getMessage() + "</p>");
                    } finally {
                        try {
                            if (ps != null) ps.close();
                            if (con != null) con.close();
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }
                } else {
                    out.println("<p id='error'>All fields are required to add faculty.</p>");
                }
            }
        %>
    </div>
</body>
</html>
