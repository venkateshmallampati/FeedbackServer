<%@ page import="java.sql.*" %>
<%@ page import="myclgproject.DBConnect" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add New Faculty</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }
        .container {
            width: 1000px;
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
        .form-group label {
            width: 250px;
            margin-right: 10px;
        }
        .form-group input[type="text"], 
        .form-group input[type="number"], 
        .form-group select {
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            width: 100%;
            max-width: 400px;
        }
        button {
            padding: 10px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            width: 350px; 
        }
        button:hover {
            background-color: #0056b3;
        }
        .message {
            text-align: center;
            margin-top: 20px;
            font-size: 18px;
        }
        .add-subject-section {
            margin-bottom: 20px;
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
                select {
            margin-top:10px;
            margin-left:10px;
            padding: 5px;
            color: green;
        }
    </style>
      <script>
        function addSubjectSection() {
            var container = document.getElementById("subjectSectionContainer");
            var div = document.createElement("div");
            div.className = "add-subject-section";
            div.innerHTML = `
                <label for="sub">Subject:</label>
                <input type="text" name="sub" required>
                <label for="year">Year:</label>
                <select name="year" required>
                    <option value="">Select Year</option>
                    <option value="1">1</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                    <option value="4">4</option>
                </select>
                <label for="semester">Semester:</label>
                <select name="semester" required>
                    <option value="">Select Semester</option>
                    <option value="1">1</option>
                    <option value="2">2</option>
                </select>
                <label for="section">Section:</label>
                <select name="section" required>
                    <option value="">Select Section</option>
                    <option value="A">A</option>
                    <option value="B">B</option>
                    <option value="C">C</option>
                </select>
                <label for="branch">Branch:</label>
                <select name="branch" required>
                <option>--select--</option>
                <option value="CSE">CSE</option>
                <option value="ECE">ECE</option>
                <option value="CIV">CIVIl</option>
                <option value="ME">MECH</option>
                <option value="EEE">EEE</option>
                <option value="it">IT</option>
                <option value="cic">CIC</option>
                <option value="aid">AID</option>
                <option value="csm">CSM</option>
                <option value="cso">CSO</option>
                </select>
            `;
            container.appendChild(div);
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
            <h2>Add New Faculty</h2>
            <form action="Add_New_Faculty.jsp" method="post">
            <center>
                <div class="form-group">
                    <label for="fname">Faculty Name:</label>
                    <input type="text" id="fname" name="fname" required>
                </div>
                <div class="form-group">
                    <label for="fid">Faculty ID:</label>
                    <input type="text" id="fid" name="fid" required>
                </div>
                <div class="form-group">
                    <label for="acc_year">Academic Year (Ex: 20xy-20za):</label>
                    <input type="text" id="acc_year" name="acc_year" required>
                </div>
                </center>
                <div id="subjectSectionContainer">
                    <div class="add-subject-section">
                                            <label for="sub">Subject:</label>
                    <input type="text" name="sub" required>

                    <label for="year">Year:</label>
                    <select name="year" required>
                        <option value="">Select Year</option>
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                    </select>

                    <label for="semester">Semester:</label>
                    <select name="semester" required>
                        <option value="">Select Semester</option>
                        <option value="1">1</option>
                        <option value="2">2</option>
                    </select>

                    <label for="section">Section:</label>
                    <select name="section" required>
                        <option value="">Select Section</option>
                        <option value="A">A</option>
                        <option value="B">B</option>
                        <option value="C">C</option>
                        <!-- Add more sections as needed -->
                    </select>

                    <label for="branch">Branch:</label>
                    <select name="branch" required>
                        <option>--select--</option>
                                    <option value="CSE">CSE</option>
                                    <option value="ECE">ECE</option>
                                    <option value="CIV">CIVIl</option>
                                    <option value="ME">MECH</option>
                                    <option value="EEE">EEE</option>
                                    <option value="it">IT</option>
                                    <option value="cic">CIC</option>
                                    <option value="aid">AID</option>
                                    <option value="csm">CSM</option>
                                    <option value="cso">CSO</option>
                    </select>
                    </div>
                </div>
                <center>
                    <button type="button" onclick="addSubjectSection()">Add Another Subject and Section</button><br><br>
                    <button type="submit">Add Faculty</button>
                </center>
            </form>

            <div class="message">
            <% 
                if ("POST".equalsIgnoreCase(request.getMethod())) {
                    String fname = request.getParameter("fname");
                    String fid = request.getParameter("fid");
                    String acc_year = request.getParameter("acc_year");
                    String[] subjects = request.getParameterValues("sub");
                    String[] years = request.getParameterValues("year");
                    String[] semesters = request.getParameterValues("semester");
                    String[] sections = request.getParameterValues("section");
                    String[] branches = request.getParameterValues("branch");

                    Connection con = null;
                    PreparedStatement psFaculty = null;
                    PreparedStatement psSubjectSection = null;

                    try {
                        con = DBConnect.connect();
                        con.setAutoCommit(false);

                        for (int i = 0; i < subjects.length; i++) {
                            String queryFaculty = "INSERT INTO faculty (fname, fid, sub, sec, acc_year) VALUES (?, ?, ?, ?, ?)";
                            String yearSemesterSectionBranch = years[i] + "_" + semesters[i] + "_" + branches[i] + "_" + sections[i];
                            psFaculty = con.prepareStatement(queryFaculty);
                            psFaculty.setString(1, fname);
                            psFaculty.setString(2, fid);
                            psFaculty.setString(3, subjects[i]);
                            psFaculty.setString(4, yearSemesterSectionBranch);
                            psFaculty.setString(5, acc_year);
                            psFaculty.executeUpdate();
                        }

                        con.commit();
                        response.sendRedirect("last.html");
                    } catch (Exception e) {
                        if (con != null) try { con.rollback(); } catch (SQLException ignore) {}
                        e.printStackTrace();
                        out.println("<h2>An error occurred: " + e.getMessage() + "</h2>");
                    } finally {
                        try {
                            if (psFaculty != null) psFaculty.close();
                            if (psSubjectSection != null) psSubjectSection.close();
                            if (con != null) con.close();
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }
                }
            %>
            </div>
        </div>
        <br><br><br>
    </div>
</body>
</html>
