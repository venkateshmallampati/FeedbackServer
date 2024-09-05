<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Questions</title>
    <style>
		body{
			background-color: rgb(240, 186, 142);
		}
		#div3{
			border:2px solid;
			width:900px;
			background-color:pink;
			}

			label,input[type="radio"] {
			font-size:19px;
        width:16px; /* Adjust the width */
        height: 16px; /* Adjust the height */
        margin-right: 5px; /* Add some spacing between radio buttons */
    }
			
#div1{

color: black;
text-align: center;
float: left;
}

#div2
{
margin-left: 150px;
float: left;
}
#h2{margin-left:150px}
h5{margin-left:150px}

    </style>
</head>
<body>
<center><br><br>
<div id="div2">
				<img src="vvitlogo.jpg" style="width:120px;height:120px;">
				</div>
<div id="div1">
<h1 id="h2" >Vasireddy Venkatadri Institute of Technology</h1>
<h5>Approved by AICTE - Permanently Affiliated to JNTUK - ISO 9001-2015 Certified<br>Accredited by NAAC with 'A'Grade - B.Tech ECE,MECH,CSE,EEE & IT are accredited by NBA</h5>
</div>
<div>
<center><img src="nba.jpg" style="width:100px;height:100px;">
<img src="naac.jpg" style="width:100px;height:100px;"></center><br>
<br>
<br>
    <div id="div3">
    <form action="Store1" method="POST">
        <%
         
        String[] subjects = (String[])session.getAttribute("subjects");
        
        int subjectCounter = 0; // Initialize to a default value
        String subjectCounterParam = request.getParameter("subjectCounter");
        if (subjectCounterParam != null && !subjectCounterParam.isEmpty()) {
            subjectCounter = Integer.parseInt(subjectCounterParam);
        }
        
        if (subjects != null && subjectCounter >= 0 && subjectCounter < subjects.length) {
    %>
    <br><h1 id="h1" style="padding: 15px;text-decoration: underline;"> <%= subjects[subjectCounter] %></h1>
        <%
        String[] questions = (String[])request.getAttribute("questions");
        
        // Ensure questions array is not null and has at least 5 elements
        if (subjects != null && subjects.length >= 5 && questions != null && questions.length >= 5) {
            for (int i = 0; i < 5; i++) {
    %>
    <label> CO<%= i + 1 %>: <%= questions[i] %></label><br><br>
    
        <input type="radio" name="answer<%= i + 1 %>" value="poor"required><label for="answer<%= i + 1 %>">poor</label>
        <input type="radio" name="answer<%= i + 1 %>" value="average"required><label for="answer<%= i + 1 %>">average</label> 
        <input type="radio" name="answer<%= i + 1 %>" value="good"required><label for="answer<%= i + 1 %>">good</label>
        <input type="radio" name="answer<%= i + 1 %>" value="excellent"required><label for="answer<%= i + 1 %>">excellent</label>
        <br><br>
    <% 
            }
        } else {
            // Handle the case when questions array is null or does not have enough elements
            out.println("No questions available.");
        }
        }
    %>       
        <input type="hidden" name="subjectCounter" value="<%= subjectCounter %>">
         <br>
        <input type="submit" value="submit"  style=" font-size:20px; padding: 10px 15px; background-color:cornflowerblue; border-radius:10px">
     <br>
    </form>
    </div>
</body>
</html>
