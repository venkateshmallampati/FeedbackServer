<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Change Password</title>
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
        .login-box {
            width: 400px;
            height: 350px;
            padding: 10px;
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: #ffffff;
            text-align: center;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2);
        }
        .login-box img {
            width: 100px;
            height: 100px;
            margin-bottom: 20px;
        }
        .login-box input,
        .login-box select {
            width: 50%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .login-box button {
            width: 50%;
            padding: 10px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .error {
            color: red;
        }
    </style>
    <script>
        function validateForm() {
            var userId = document.getElementById("userId").value;
            var newPassword = document.getElementById("newPassword").value;
            var confirmNewPassword = document.getElementById("confirmNewPassword").value;
            var errorText = document.getElementById("errorText");

            if (newPassword !== confirmNewPassword) {
                errorText.textContent = "New Password and Confirm Password do not match.";
                return false;
            }

            if (newPassword === userId) { // Assuming old password is same as userId for this example
                errorText.textContent = "New Password should not match the old password.";
                return false;
            }

            // You can add more password validation rules here

            return true;
        }
    </script>
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
    <center>
   <form id="loginForm" action="ChangePasswordServlet" method="post" onsubmit="return validateForm()">

        <div class="login-box">
            
            <h2>Change Password</h2>
            <div id="studentFields"><br/>
                <table>
                    <tr>
                        <td><label for="userId">User ID:</label></td>
                        <td><input type="text" id="userId" name="userId" required><br></td>
                    </tr>
                    <tr>
                        <td><label for="newPassword">New Password:</label></td>
                        <td><input type="password" id="newPassword" name="newPassword" required><br></td>
                    </tr>
                    <tr>
                        <td><label for="confirmNewPassword">Confirm New Password:</label></td>
                        <td><input type="password" id="confirmNewPassword" name="confirmNewPassword" required><br></td>
                    </tr>
                </table>
            </div>
            <br/>
            <button type="submit">Update</button>
            <p id="errorText" class="error"></p>
        </div>
    </form>
    </center>
</body>
</html>
