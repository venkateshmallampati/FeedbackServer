<%@ page import="java.sql.*" %>
<%@ page import="myclgproject.DBConnect" %>
<!DOCTYPE html>
<html>
<head>
    <title>Delete Faculty</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }
        .container {
            width: 500px;
            margin: 0 auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin-top: 50px;
        }
        h2 {
            text-align: center;
        }
        form {
            display: flex;
            flex-direction: column;
        }
        .form-group {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }
        label {
            margin-right: 10px;
            width: 150px;
        }
        input[type="text"] {
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            width: calc(100% - 160px); /* Adjust width based on label width and margins */
        }
        
        .message {
            text-align: center;
            margin-top: 20px;
            font-size: 18px;
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
        .but {
            padding: 8px 16px; /* Reduced padding */
            background-color: cornflowerblue;
            border-radius: 8px; /* Slightly smaller border radius */
            margin-top: 20px; /* Adjusted margin */
            color: white;
            border: none;
            font-size: 14px; /* Reduced font size */
            width:200px
        }
        .but:hover {
            background-color: darkblue;
        }
    </style>
    <script type="text/javascript">
        function confirmDeletion(event) {
            var confirmation = confirm("Are you sure you want to delete this faculty?");
            if (!confirmation) {
                event.preventDefault(); // Prevent the form submission if the user clicks "Cancel"
            }
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
        <br>
        <br>
        <div class="container">
            <h2>Delete Faculty</h2>
            <form action="Delete_Faculty.jsp" method="post" onsubmit="confirmDeletion(event)">
                <div class="form-group">
                    <label for="fid">Faculty ID:</label>
                    <input type="text" id="fid" name="fid" required>
                </div>

                <center><button type="submit" class="but">Delete Faculty</button></center>
            </form>

            <div class="message">
            <% 
                if ("POST".equalsIgnoreCase(request.getMethod())) {
                    String fid = request.getParameter("fid");

                    Connection con = null;
                    PreparedStatement psCheck = null;
                    PreparedStatement psDelete = null;
                    ResultSet rs = null;

                    try {
                        con = DBConnect.connect();
                        con.setAutoCommit(false);

                        // Check if the faculty ID exists
                        String queryCheckFaculty = "SELECT 1 FROM faculty WHERE fid = ?";
                        psCheck = con.prepareStatement(queryCheckFaculty);
                        psCheck.setString(1, fid);
                        rs = psCheck.executeQuery();

                        if (rs.next()) {
                            // Faculty ID exists, proceed with deletion
                            String queryDeleteFaculty = "DELETE FROM faculty WHERE fid = ?";
                            psDelete = con.prepareStatement(queryDeleteFaculty);
                            psDelete.setString(1, fid);
                            psDelete.executeUpdate();

                            con.commit();
                            out.println("<h2>Faculty with ID " + fid + " has been successfully deleted.</h2>");
                        } else {
                            // Faculty ID does not exist
                            out.println("<h2>No faculty found with ID " + fid + ".</h2>");
                        }
                    } catch (Exception e) {
                        if (con != null) try { con.rollback(); } catch (SQLException ignore) {}
                        e.printStackTrace();
                        out.println("<h2>An error occurred: " + e.getMessage() + "</h2>");
                    } finally {
                        try {
                            if (rs != null) rs.close();
                            if (psCheck != null) psCheck.close();
                            if (psDelete != null) psDelete.close();
                            if (con != null) con.close();
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }
                }
            %>
            </div>
        </div>
    </div>
</body>
</html>
