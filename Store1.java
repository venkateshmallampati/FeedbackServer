package myclgproject;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/Store1")
public class Store1 extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection con = null;
        try {
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            con = DBConnect.connect();

            HttpSession session = request.getSession();
            String rollno = (String) session.getAttribute("rollno");
            String academicyear = (String) session.getAttribute("academicyear");
            String year =(String) session.getAttribute("year");
            String sem = (String) session.getAttribute("sem");
            
            String branch = (String) session.getAttribute("branch");
            int subjectCounter = Integer.parseInt(request.getParameter("subjectCounter"));
 // Assuming subjectCounter is passed
            
            // Retrieve answers from the form
            String[] answers = new String[5]; // Assuming there are 5 questions
            for (int i = 0; i < 5; i++) {
                String answer = request.getParameter("answer" + (i + 1));
                answers[i] = answer; // Store the answer or an empty string if not provided
            }
            String query ="INSERT INTO subjects"+academicyear+" (rollno,subject ,co1, co2, co3, co4, co5) VALUES (?, ?, ?, ?, ?, ?,?)";
            
            PreparedStatement Stmt1 = con.prepareStatement(query); 
            
            
            String[] subjects = (String[]) session.getAttribute("subjects");
            
            // Set parameters for each subject's statement
            Stmt1.setString(1, rollno);
            
            Stmt1.setString(2, subjects[subjectCounter]);
            // Set feedback values for each subject
            for (int i = 1; i <=5 ; i++) {
                Stmt1.setString(i + 2, request.getParameter("answer" + i));                
            }

            Stmt1.executeUpdate();
            if (subjectCounter == 5) {
                // If it's the last subject, redirect to success page
                response.sendRedirect("last.html");
            } else {
                // If there are more subjects, redirect to the questionnaire page for the next subject
                response.sendRedirect("Coursenew?rollno=" +rollno +
                		               "&acadmicyear="+academicyear+
                                       "&year=" + year +
                                       "&sem=" + sem +
                                       "&branch=" + branch +
                                       "&subjectCounter=" + (subjectCounter + 1)); // Increment subjectCounter
            }

            
        }catch (Exception e) {
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            out.println("Error: " + e.getMessage());
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
            

	}



}
