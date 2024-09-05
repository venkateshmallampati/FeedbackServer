<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Admin</title>
  <style>
           #navigation {
            text-align: center;
            background-color: rgba(255, 255, 255, 0.8);
            padding: 10px;
        }

        #navigation a {
            margin: 0 10px;
            padding: 10px 20px;
            border-radius: 3px;
            color: white;
            background: linear-gradient(45deg, #FF6969, #D80032);
            text-decoration: none;
            transition: background-color 0.3s;
        }

        #navigation a:hover {
            background-color: #FF4D4D;
        }
  
   body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            background-image: url("vvit_drone_blur.png");
             background-repeat: no-repeat;
            background-size: cover;
        }
        
    .navbar {
      margin-bottom: 0;
      border-radius: 0;
    }
    #container text-center{
    background-color: #7BD3EA;
    
    }
    footer {
      background-color: #f2f2f2;
      padding: 25px;
    }
    td {
            padding: 10px; 
        }
    body {
   
     background-color:#9EB8D9;
      background-repeat: no-repeat;
      background-size: cover;
      background-position: center;
    }


    .jumbotron {
      background-color: rgba(255, 255, 255, 0.7); /* Add a semi-transparent white background to the jumbotron */
    }
    #hh{
    color:black;
    }
  </style>
</head>
<body>
<div class="jumbotron">
  <div class="container text-center">
    <table align="center">
      <tr>
        <td><img src="vvitlogo.jpg" style="width:75px;height:100px;"></td>
        <td align="center">
          <h2 id="hh">Vasireddy Venkatadri Institute of Technology</h2>
          <h6>Approved by AICTE - Permanently Affiliated to JNTUK - ISO 9001-2015 Certified<br>Accredited by NAAC with 'A'Grade - B.Tech ECE,MECH,CSE,EEE & IT are accredited by NBA</h6>
        </td>
        <td><img src="nba.jpg" style="width:75px;height:100px;"></td>
        <td><img src="naac.jpg" style="width:75px;height:100px;"></td>
      </tr>
    </table>
  </div>
</div>
<div id="navigation">
    <a href="Add_New_Faculty.jsp">Add Faculty</a>
    <a href="Delete_Faculty.jsp">Delete Faculty</a>
    <a href="Add_Department.jsp">Add Department</a>
    <a href="delete_department.jsp">Delete Department</a>
    
    <br>
    <br>
</div>

<h1 align="center"></h1>

<table align="center" cellpadding="50">
  <tr>
    <td >
      <a href="Admin_view_FOF.jsp">
        <img src="view_feedback_on_faculty.png" width="300" height="300"><br>
      <h2 align="center" style="color:white;">Feedback On Faculty</h2>
      </a>
    </td>

    <td>
      <a href="View_CAS_FB.jsp">
        <img src="view_course_survey_image.png" width="300" height="300"><br>
        <h2 align="center" style="color:white;">Course End Survey</h2>
      </a>
    </td>

    <td>
      <a href="eslast.html">
        <img src="exit.png"  width="300" height="300"><br>
        <h2 align="center" style="color:white;">Exit Survey</h2>
      </a>
    </td>
  </tr>
</table>

<br><br><br><br><br><br><br><br><br><br><br><br>

<!-- Add your footer if needed -->

</body>
</html>
