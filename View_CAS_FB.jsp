<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*, java.util.ArrayList" %>
<%@ page import="myclgproject.DBConnect" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Student View</title>
<style>
    table, tb {
        margin-left: auto; 
        margin-right: auto;
        font-size: 18px;
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
        height: 500px;
        background-color: ghostwhite;
        border: 1px solid;
    }

    .but {
        padding: 10px 20px; 
        background-color: cornflowerblue; 
        border-radius: 10px;
        margin-top: 25px;
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
<script>
    function hideButton(buttonId) {
        var button = document.getElementById(buttonId);
        if (button) {
            button.style.display = 'none';
        }
    }
    function submitFormAndHideButton() {
    	retrieveButton.style.display = 'none';
        var form = document.getElementById('courseSurveyForm');
        form.submit();
    }
    
</script>
</head>
<body background="vvit.jpg" >
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
    <div id="div3">
        <center>
            <h2 align="center" style="padding: 15px;text-decoration: underline;">Course End Survey</h2>
            <form  method="post" id="courseSurveyForm">
                <table align="center">
                    <tr>
                        <td>Academic Year:</td>
                        <td>
                            <select name="academicyear" id="academicyear" required>
                                <option value="">--select--</option>
                                <option value="1819">2018-2019</option>
                                <option value="1920">2019-2020</option>
                                <option value="2021">2020-2021</option>
                                <option value="2122">2021-2022</option>
                                <option value="2223">2022-2023</option>
                                <option value="2324">2023-2024</option>
                                <option value="2425">2024-2025</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>Year:</td>
                        <td>
                            <select name="year" id="year" required>
                                <option value="">--select--</option>
                                <option value="4">4</option>
                                <option value="3">3</option>
                                <option value="2">2</option>
                                <option value="1">1</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>Semester:</td>
                        <td>
                            <select name="sem" id="sem" required>
                                <option value="">--select--</option>
                                <option value="2">2</option>
                                <option value="1">1</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>Department:</td>
                        <td>
                            <select name="branch" id="branch" required>
                                <option value="">--select--</option>
                                <option value="CSE">CSE</option>
                                <option value="ECE">ECE</option>
                                <option value="CIVIL">CIVIL</option>
                                <option value="MECH">MECH</option>
                                <option value="EEE">EEE</option>
                                <option value="it">IT</option>
                                <option value="CIC">CIC</option>
                                <option value="AID">AID</option>
                                <option value="CSM">CSM</option>
                                <option value="CSO">CSO</option>
                            </select>
                        </td>
                    </tr>
                </table>
                <button type="button" id="retrieveButton" onclick="submitFormAndHideButton()" class="but">Retrieve Subjects</button>
            </form>
            <br>
            <%
                String academicYear = request.getParameter("academicyear");
                String year = request.getParameter("year");
                String semester = request.getParameter("sem");
                String branch = request.getParameter("branch");

                if (academicYear != null && !academicYear.isEmpty() &&
                    year != null && !year.isEmpty() &&
                    semester != null && !semester.isEmpty() &&
                    branch != null && !branch.isEmpty()) {

                    Connection con = null;
                    PreparedStatement ps = null;
                    ResultSet rs = null;
                    ArrayList<String> subjectsList = new ArrayList<>();
                    try {
                        con = DBConnect.connect();

                        // SQL query to retrieve subjects based on the selected criteria
                        String query = "SELECT subject1, subject2, subject3, subject4, subject5 FROM subs WHERE  year = ? AND sem = ? AND branch = ?";
                        ps = con.prepareStatement(query);
                        ps.setString(1, year);
                        ps.setString(2, semester);
                        ps.setString(3, branch);

                        rs = ps.executeQuery();

                        while (rs.next()) {
                            String[] subjects = {
                                rs.getString("subject1"),
                                rs.getString("subject2"),
                                rs.getString("subject3"),
                                rs.getString("subject4"),
                                rs.getString("subject5")
                            };
                            for (String subject : subjects) {
                                if (subject != null && !subject.isEmpty()) {
                                    subjectsList.add(subject);
                                }
                            }
                        }

                        if (!subjectsList.isEmpty()) {
            %>
                            <form action="Find" method="post">
                                <input type="hidden" name="academicyear" value="<%= academicYear %>">
                                <div class="form-group">
                                    <label for="subjects">Select Subject:</label>
                                    <select id="subjects" name="subjects">
                                        <%
                                            for (String subject : subjectsList) {
                                        %>
                                            <option value="<%= subject %>"><%= subject %></option>
                                        <%
                                            }
                                        %>
                                    </select>
                                </div>
                                <br>
                                <button type="submit" class="but">Proceed</button>
                            </form>
            <%
                        } else {
                            out.println("<p>No subjects found for the selected criteria.</p>");
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
        </center>
    </div>
</div>
</body>
</html>

