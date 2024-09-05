<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*, myclgproject.DBConnect" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Retrieve Faculty Courses</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .container {
            width: 50%;
            padding: 20px;
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        .form-group {
            margin: 20px 0;
        }
        label, select, input[type="text"] {
            display: block;
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        button {
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        button:hover {
            background-color: #0056b3;
        }
    </style>
    <script>
        function hideButton(buttonId) {
            var button = document.getElementById(buttonId);
            if (button) {
                button.style.display = 'none';
            }
        }
        function submitFormAndHideButton() {
            var form = document.getElementById('facultyForm');
            form.submit();
            hideButton('retrieveButton');
        }
    </script>
</head>
<body>
    <div class="container">
        <h1>Retrieve Faculty Courses</h1>
        <form method="post" id="facultyForm">
            <div class="form-group">
                <label for="fid">Faculty ID:</label>
                <input type="text" id="fid" name="fid" required>
            </div>
            <button type="button" id="retrieveButton" onclick="submitFormAndHideButton()">Retrieve My Class</button>
        </form>
        <br>
        <%
            String fid = request.getParameter("fid");
            if (fid != null && !fid.isEmpty()) {
                Connection con = null;
                PreparedStatement ps = null;
                ResultSet rs = null;
                List<String> combinedOptions = new ArrayList<>();
                try {
                    con = DBConnect.connect();

                    // Updated query to use correct column names
                    String query = "SELECT sec, sub FROM faculty WHERE fid = ?";
                    ps = con.prepareStatement(query);
                    ps.setString(1, fid);
                    rs = ps.executeQuery();

                    while (rs.next()) {
                        String section = rs.getString("sec");
                        String subject = rs.getString("sub");
                        // Combine section and subject for the dropdown
                        combinedOptions.add(section + " - " + subject);
                    }

                    if (!combinedOptions.isEmpty()) {
        %>
                        <form action="YourNextServlet" method="post">
                            <div class="form-group">
                                <label for="combinedOptions">Select Option:</label>
                                <select id="combinedOptions" name="combinedOptions">
                                    <%
                                        for (String option : combinedOptions) {
                                    %>
                                        <option value="<%= option %>"><%= option %></option>
                                    <%
                                        }
                                    %>
                                </select>
                            </div>
                            <br>
                            <button type="submit">Proceed</button>
                        </form>
        <%
                        // Hide the retrieve button after data is retrieved and displayed
                        out.println("<script>document.getElementById('retrieveButton').style.display='none';</script>");
                    } else {
                        out.println("<p>No records found for Faculty ID: " + fid + "</p>");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<p>An error occurred: " + e.getMessage() + "</p>");
                } finally {
                    try {
                        if (rs != null) rs.close();
                        if (ps != null) ps.close();
                        if (con != null) con.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            }
        %>
    </div>
</body>
</html>
