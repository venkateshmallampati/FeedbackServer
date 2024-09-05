package myclgproject;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/SurveyFormServlet")
public class SurveyFormServlet extends HttpServlet {

  private static final long serialVersionUID = 1L;

  
/*  private static final String DB_URL = "jdbc:mysql://localhost:3306/exitsurvey";
  private static final String DB_USER = "root";
  private static final String DB_PASSWORD = "";*/

  @Override
  protected void doPost(HttpServletRequest request, HttpServletResponse response)
          throws ServletException, IOException {
      Connection connection = null;
      PreparedStatement preparedStatement = null;
      ResultSet resultSet = null;

      
      try {
          
      	String name = request.getParameter("Name");
          String id = request.getParameter("id");
          String duration = request.getParameter("Duration");
          String ps = request.getParameter("Ps");
          String pgp = request.getParameter("pgp");
          String Q1 = request.getParameter("Q1");
          String Q2= request.getParameter("Q2");
          String Q3 = request.getParameter("Q3");
          String Q4 = request.getParameter("Q4");
          String Q5 = request.getParameter("Q5");
          String Q6= request.getParameter("Q6");
          String Q7 = request.getParameter("Q7");
          String Q8 = request.getParameter("Q8");
          String Q9 = request.getParameter("Q9");
          String Q10 = request.getParameter("Q10");
          String Q11 = request.getParameter("Q11");
          String Q12 = request.getParameter("Q12");
          String Q13 = request.getParameter("Q13");
          String Q14 = request.getParameter("Q14");
          String Q15 = request.getParameter("Q15");
          String Q16 = request.getParameter("Q16");
          String Q17 = request.getParameter("Q17");
          String Q18 = request.getParameter("Q18");
          String Q19 = request.getParameter("Q19");
          String Q20 =request.getParameter("Q20");           
          
          connection=DBConnect.connect();

          
          String sql1 = "INSERT INTO survey_responses (name, id, duration, ps, pgp,Q1,Q2,Q3,Q4,Q5,Q6,Q7,Q8,Q9,Q10,Q11,Q12,Q13,Q14,Q15,Q16,Q17,Q18,Q19,exp ) VALUES (?, ?, ?, ?, ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
          preparedStatement = connection.prepareStatement(sql1);

          
          preparedStatement.setString(1, name);
          preparedStatement.setString(2, id);
          preparedStatement.setString(3, duration);
          preparedStatement.setString(4, ps);
          preparedStatement.setString(5, pgp);
          preparedStatement.setString(6, Q1);
          preparedStatement.setString(7, Q2);
          preparedStatement.setString(8, Q3);
          preparedStatement.setString(9, Q4);
          preparedStatement.setString(10, Q5);
          preparedStatement.setString(11, Q6);
          preparedStatement.setString(12, Q7);
          preparedStatement.setString(13, Q8);
          preparedStatement.setString(14, Q9);
          preparedStatement.setString(15, Q10);
          preparedStatement.setString(16, Q11);
          preparedStatement.setString(17, Q12);
          preparedStatement.setString(18, Q13);
          preparedStatement.setString(19, Q14);
          preparedStatement.setString(20, Q15);
          preparedStatement.setString(21, Q16);
          preparedStatement.setString(22, Q17);
          preparedStatement.setString(23, Q18);
          preparedStatement.setString(24, Q19);
          preparedStatement.setString(25, Q20);

          
          preparedStatement.executeUpdate();
          
          response.setContentType("text/html");
          PrintWriter out1 = response.getWriter();
          out1.println("<center>\r\n"
          		+ "<img src=\"completed.jpg\" style=\"height:400px\">\r\n"
          		+ "<h1><i><p>successfully comepleted </p></i></h1>\r\n"
          		+ "</center>\r\n");
          
          
          

      } catch (ClassNotFoundException | SQLException e) {
          
          response.setContentType("text/html");
          PrintWriter out = response.getWriter();
          out.println("Error: " + e.getMessage());
          e.printStackTrace();
          
         
      } finally {
          
          try {
              if (preparedStatement != null) 
                  preparedStatement.close();
              
              if (connection != null) 
                  connection.close();
              
          } catch (SQLException e) {
              e.printStackTrace();}
      }
}
}
