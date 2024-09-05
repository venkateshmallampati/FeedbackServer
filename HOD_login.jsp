<%@ page import="java.sql.*" %>
<%@ page import="myclgproject.DBConnect" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="style.css">
    <title>Faculty Login</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            background-image: url("vvit.jpg");
            background-repeat: no-repeat;
            background-size: cover;
        }

        #header h5 {
            font-size: 16px;
            color: #666;
        }

        #logo {
            float: left;
            margin-left: 20px;
        }

        #accreditation {
            padding-left: 20px;
            float: right;
            margin-right: 20px;
        }

        tr {
            display: table-row;
            vertical-align: inherit;
            border-color: inherit;
        }

        @keyframes pulse {
            0% {
                transform: scale(1);
            }
            50% {
                transform: scale(1.1);
            }
            100% {
                transform: scale(1);
            }
        }

        h1 {
            animation: pulse 2s infinite;
        }

        table {
            border-collapse: separate;
            text-indent: initial;
            white-space-collapse: collapse;
            text-wrap: wrap;
            line-height: normal;
            font-weight: normal;
            font-size: Large;
            font-style: normal;
            color: black;
            text-align: start;
            border-spacing: 2px;
            font-variant: normal;
        }

        input[type=submit] {
            width: 100%;
            padding: 12px 20px;
            margin: 8px 0;
            display: inline-block;
            border-radius: 4px;
            box-sizing: border-box;
            background-color: #FF7F50;
            color: white;
            border: none;
            cursor: pointer;
        }

        input[type=text], input[type=password] {
            width: 100%;
            padding: 12px 20px;
            margin: 8px 0;
            display: inline-block;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        input[type=text]:focus, input[type=password]:focus {
            border-color: #FF7F50;
            outline: none;
        }
    </style>
</head>
<body>
    <div>
        <table align="center">
            <tr>
                <td><img src="vvitlogo.jpg" style="width:150px; height:120px;"></td>
                <td align="center">
                    <h2 style="font-size: 24px;">Vasireddy Venkatadri Institute of Technology</h2>
                    <h6 style="font-size: 12px;">Approved by AICTE - Permanently Affiliated to JNTUK - ISO 9001-2015 Certified<br>Accredited by NAAC with 'A' Grade - B.Tech ECE, MECH, CSE, EEE & IT are accredited by NBA</h6>
                </td>
                <td><img src="nba.jpg" style="width:150px; height:100px;"></td>
                <td><img src="naac.jpg" style="width:150px; height:100px;"></td>
            </tr>
        </table>
    </div>

    <br/>
    <br/>
    <br/>
    <br/>

    <div style="text-align:center;">
        <div style="background-color:white;box-shadow: 1px 1px 1px 1px;width: 400px;height: 300px;margin: auto;padding: 20px;">
            <form action="HOD_login.jsp" method="post">
                <h1>HOD Login</h1><br>
                <table>
                    <tr>
                        <td>HOD Id:</td>
                        <td><input type="text" name="fid" required></td>
                    </tr>
                    <tr>
                        <td>Password:</td>
                        <td><input type="password" name="pwd" required></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td><input type="submit" value="Login"></td>
                    </tr>
                </table>
            </form>
            <div class="message">
            <% 
                if ("POST".equalsIgnoreCase(request.getMethod())) {
                    String fid = request.getParameter("fid");
                    String pwd = request.getParameter("pwd");

                    Connection con = null;
                    PreparedStatement ps = null;
                    ResultSet rs = null;

                    try {
                        con = DBConnect.connect();

                        String query = "SELECT department FROM hod WHERE id = ? AND password = ?";
                        ps = con.prepareStatement(query);
                        ps.setString(1, fid);
                        ps.setString(2, pwd);
                        rs = ps.executeQuery();

                        // Use the implicit session object directly
                        if (rs.next()) {
                            String department = rs.getString("department");
                            session.setAttribute("department", department);
                            request.getRequestDispatcher("HOD_options.jsp").forward(request, response);
                        } else {
                            out.println("<h2>Invalid ID or password. Please try again.</h2>");
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                        out.println("<h2>An error occurred: " + e.getMessage() + "</h2>");
                    } finally {
                        try {
                            if (rs != null) rs.close();
                            if (ps != null) ps.close();
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
